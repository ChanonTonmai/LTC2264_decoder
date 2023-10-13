library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bitAlignment is
    Port ( clk, rst : in std_logic; 
           data : in unsigned(13 downto 0); 
           enable : in std_logic; 
           training_data : in unsigned(13 downto 0); 
           dlyce : out std_logic; 
           dlyrst : out std_logic; 
           bitslip : out std_logic;
           adone : out std_logic
    );
end bitAlignment;

architecture Behavioral of bitAlignment is


    signal training_done : std_logic; 
    signal enable_edge : std_logic; 
    signal cnt_align      : unsigned (3 downto 0) := (others => '0');
    signal cnt_steps      : unsigned ( 7 downto 0) := (others => '0');
    signal align_done       : std_logic := '0';
    type state_type is (idle, s_FINISH, s_WORD_ALIGN, s_TOGGLE); 
    signal state_reg : state_type; 
    
    
      -- Registers (start, end and mid of eye; ok and not ok)
  signal loc_eye_start    : unsigned (7 downto 0) := (others => '0');
  signal loc_eye_mid      : unsigned (7 downto 0) := (others => '0');
  signal loc_eye_end      : unsigned (7 downto 0) := (others => '0');
  signal loc_word         : unsigned (7 downto 0) := (others => '0');
  signal loc_ok           : std_logic := '0';
  signal loc_nok          : std_logic := '0';

  signal iserdes_sr       : unsigned (0 downto 0) := (others => '1');
  signal iserdes_dlyce    : unsigned (0 downto 0) := (others => '0');
  signal iserdes_dlyrst   : unsigned (0 downto 0) := (others => '1');
  signal iserdes_bitslip  : unsigned (0 downto 0) := (others => '0');

 type t_fsm_align is (s_IDLE, s_RESET_1, s_RESET_2, s_WORD_ALIGN, s_FINISH,
                        s_EYE_SAMPLE, s_EYE_CHECK, s_EYE_DELAY, s_EYE_CALC,
                        s_EYE_CENTER,
                        s_WRITE_START, s_WRITE_MID, s_WRITE_END, s_WRITE_WORD,
                        s_WRITE_OK);
  type t_eye_state is (s_FIND_EDGE_1, s_EDGE_1, s_FIND_EDGE_2);

  signal eye_state      : t_eye_state := s_FIND_EDGE_1;
  signal fsm_align      : t_fsm_align := s_IDLE;
  signal cnt_error      : unsigned ( 2 downto 0) := (others => '0');
  signal cnt_samples    : unsigned ( 3 downto 0) := (others => '0');
  signal data_curr      : unsigned (11 downto 0) :=(others => '0');
  signal data_prev      : unsigned (11 downto 0) :=(others => '0');
  signal data_stable    : std_logic := '0';
  signal reg_read_training : std_logic; 
begin
reg_read_training <= '0';
--state_dbg <= fsm_align; 
adone <= align_done; 
dlyce <=  iserdes_dlyce(0); 
dlyrst <= iserdes_dlyrst(0);
bitslip  <= iserdes_bitslip(0); 

 align_chan_proc: process (clk)
    variable sum    : unsigned (7 downto 0);
  begin
    if (clk'event and clk = '1') then
      if (rst = '1') then
        fsm_align         <= s_IDLE;
        eye_state         <= s_FIND_EDGE_1;
        cnt_align         <= (others => '0');
        align_done        <= '0';

        cnt_steps         <= (others => '0');
        cnt_error         <= (others => '0');
        cnt_samples       <= (others => '0');
        data_prev         <= (others => '0');
        data_stable       <= '0';

        iserdes_sr        <= (others => '1');
        iserdes_dlyce     <= (others => '0');
        iserdes_dlyrst    <= (others => '1');
        iserdes_bitslip   <= (others => '0');

        loc_eye_start     <= (others => '0');
        loc_eye_mid       <= (others => '0');
        loc_eye_end       <= (others => '0');
        loc_word          <= (others => '0');
        loc_ok            <= '0';
        loc_nok           <= '0';


      else
        -- DEFAULT VALUES
        iserdes_sr        <= (others => '0');
        iserdes_dlyrst    <= (others => '0');
        iserdes_dlyce     <= (others => '0');
        iserdes_bitslip   <= (others => '0');

        align_done        <= '0';




        -- FSM
        case fsm_align is
          --
          when s_IDLE =>
            if (enable = '1') then
              loc_eye_start <= to_unsigned(63,loc_eye_start'length);
              loc_eye_mid   <= to_unsigned(63,loc_eye_mid'length);
              loc_eye_end   <= to_unsigned(63,loc_eye_end'length);
              loc_word      <= to_unsigned(12,loc_word'length);
              loc_ok        <= '0';
              loc_nok       <= '0';

              fsm_align     <= s_RESET_1;
              cnt_align     <= (others => '1');

              cnt_steps     <= (others => '0');
            end if;


          --
          when s_RESET_1 =>
            -- Reset ISERDES module
            if (cnt_align = "1111") then
              iserdes_sr(0)      <= '1';
              iserdes_dlyrst(0)  <= '1';
            end if;

            if (cnt_align = 0) then
              fsm_align   <= s_EYE_SAMPLE;
              eye_state   <= s_FIND_EDGE_1;
              data_stable <= '1';
              data_prev   <= data_curr;
              cnt_samples <= (others => '1');
              cnt_error   <= (others => '0');
            else
              cnt_align   <= cnt_align - 1;
            end if;


          --
          when s_EYE_SAMPLE =>
            -- Make 'n' samples to check if data is stable and 
            -- the same as previous
            if (data_curr /= data_prev) then
              data_stable   <= '0';
            end if;

            if (cnt_samples = 0) then
              data_prev   <= data_curr;
              fsm_align   <= s_EYE_DELAY;
              cnt_align   <= (others => '1');
            else
              cnt_samples <= cnt_samples - 1;
            end if;


          --
          when s_EYE_DELAY =>
            -- Add 1 delay tap to ISERDES delay
            if (cnt_align = "1111") then
              iserdes_dlyce(0) <= '1';
            end if;

            if (cnt_align = 0) then
              fsm_align   <= s_EYE_CHECK;
            else
              cnt_align   <= cnt_align - 1;
            end if;


          --
          when s_EYE_CHECK =>
            -- Check if data was stable and take action
            fsm_align   <= s_EYE_SAMPLE;
            cnt_samples <= (others => '1');
            data_stable <= '1';

            cnt_steps   <= cnt_steps + 1;

            if (cnt_error /= 0) then
              cnt_error   <= cnt_error - 1;
            end if;

            if (cnt_steps = 63) then
              fsm_align <= s_EYE_CALC;

            elsif (cnt_error = 0) then
              case eye_state is
                --
                when s_FIND_EDGE_1 =>
                  if (data_stable = '0') then
                    eye_state   <= s_EDGE_1;
                    cnt_error   <= (others => '1');
                  end if;

                --
                when s_EDGE_1 =>
                  if (data_stable = '1') then
                    eye_state     <= s_FIND_EDGE_2;
                    cnt_error     <= (others => '1');
                    loc_eye_start <= cnt_steps;
                  end if;

                --
                when s_FIND_EDGE_2 =>
                  if (data_stable = '0') then
                    fsm_align   <= s_EYE_CALC;
                    loc_eye_end <= cnt_steps;
                  end if;

              end case;
            end if;


          --
          when s_EYE_CALC =>
            fsm_align   <= s_RESET_2;
            cnt_align   <= "1111";

            sum         := loc_eye_start + loc_eye_end;
            loc_eye_mid <= "00" & sum (6 downto 1);
            cnt_steps   <= "00" & sum (6 downto 1);


          --
          when s_RESET_2 =>
            -- Reset ISERDES module
            if (cnt_align = "1111") then
              iserdes_sr(0)      <= '1';
              iserdes_dlyrst(0)  <= '1';
            end if;

            if (cnt_align = 0) then
              fsm_align   <= s_EYE_CENTER;
              cnt_align   <= "1111";
            else
              cnt_align   <= cnt_align - 1;
            end if;


          --
          when s_EYE_CENTER =>
            -- Go to center of eye
            if (cnt_align = "1111") then
              iserdes_dlyce(0) <= '1';
            end if;

            if (cnt_align = 0) then
              if (cnt_steps = 0) then
                fsm_align   <= s_WORD_ALIGN;
                cnt_align   <= (others => '0');
                cnt_steps   <= (others => '0');
              else
                cnt_steps   <= cnt_steps - 1;
                cnt_align   <= "1111";
              end if;
            else
              cnt_align   <= cnt_align - 1;
            end if;


          --
          when s_WORD_ALIGN =>
            -- Match training word
            if (cnt_align = 0) then
              if (data = training_data) then
                if (reg_read_training = '1') then
                  fsm_align <= s_WRITE_START;
                else
                  fsm_align   <= s_FINISH;
                end if;

                loc_word    <= cnt_steps;
                loc_ok      <= '1';

              elsif (cnt_steps = 14) then
                if (reg_read_training = '1') then
                  fsm_align <= s_WRITE_START;
                else
                  fsm_align   <= s_FINISH;
                end if;

                loc_word    <= cnt_steps;
                loc_nok     <= '1';

              else
                iserdes_bitslip(0)   <= '1';
                cnt_align                   <= "1111";
                cnt_steps                   <= cnt_steps + 1;
              end if;
            else
              cnt_align   <= cnt_align - 1;
            end if;


          --
          when s_WRITE_START =>
--            fifo_din  <= loc_eye_start;
--            fifo_wen  <= '1';
            fsm_align <= s_WRITE_MID;


          --
          when s_WRITE_MID =>
--            fifo_din  <= loc_eye_mid;
--            fifo_wen  <= '1';
            fsm_align <= s_WRITE_END;


          --
          when s_WRITE_END =>
--            fifo_din  <= loc_eye_end;
--            fifo_wen  <= '1';
            fsm_align <= s_WRITE_WORD;


          --
          when s_WRITE_WORD =>
--            fifo_din  <= loc_word;
--            fifo_wen  <= '1';
            fsm_align <= s_WRITE_OK;


          --
          when s_WRITE_OK =>
--            fifo_din  <= "000000" & loc_nok & loc_ok;
--            fifo_wen  <= '1';
            fsm_align <= s_FINISH;


          --
          when s_FINISH =>
            fsm_align   <= s_IDLE;
            align_done  <= '1';

        end case;
      end if;
    end if;
  end process;
end Behavioral;
