-- use reg_10bit = '0' only in ltc2264_adc_test only
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;
--------------------------------------------------------------------------------
entity tsc_ser2par is
  port (
    data_ser : in std_logic;
    data_ser_dbg : out std_logic_vector(1 downto 0); 

    clk_par : in std_logic;
    clk_ser : in std_logic;
    clk_sys : in std_logic; 
    rx_ready : in std_logic;

    rst     : in std_logic;
    dlyce   : in std_logic; 
    dlyrst  : in std_logic; 
    bitslip : in std_logic;

    reg_10bit  : in std_logic;
    reg_invert : in std_logic;

    data_par : out unsigned (13 downto 0)
    );
end entity tsc_ser2par;


--------------------------------------------------------------------------------
architecture rtl of tsc_ser2par is

  signal rst_sync : std_logic := '1';

--  signal data_ser     : std_logic;
  signal data_ser_del : std_logic;

  signal bitslip_q    : std_logic := '0';
  signal bitslip_qq   : std_logic := '0';
  signal bitslip_req  : std_logic := '0';
  signal bitslip_even : std_logic := '0';

  signal iddr_q1 : std_logic;
  signal iddr_q2 : std_logic;

  signal data_1   : std_logic;
  signal data_2   : std_logic;
  signal data_2_q : std_logic;

  signal load_parallel : std_logic              := '0';
  signal shift_timer   : unsigned (6 downto 0)  := (others => '1');
  signal shift_data    : unsigned (13 downto 0) := (others => '0');

  signal data_par_outofphase : unsigned (13 downto 0);
  signal cb: std_logic; 
  signal data_ser_d : std_logic; 
   
begin

IDELAYE2_inst : IDELAYE2
generic map (
   CINVCTRL_SEL => "FALSE",          -- Enable dynamic clock inversion (FALSE, TRUE)
   DELAY_SRC => "IDATAIN",           -- Delay input (IDATAIN, DATAIN)
   HIGH_PERFORMANCE_MODE => "FALSE", -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
   IDELAY_TYPE => "VARIABLE",           -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
   IDELAY_VALUE => 0,                -- Input delay tap setting (0-31)
   PIPE_SEL => "FALSE",              -- Select pipelined mode, FALSE, TRUE
   REFCLK_FREQUENCY => 200.0,        -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
   SIGNAL_PATTERN => "DATA"          -- DATA, CLOCK input signal
)
port map (
   CNTVALUEOUT => open, -- 5-bit output: Counter value output
   DATAOUT => data_ser_d,         -- 1-bit output: Delayed data output
   C => clk_par,                     -- 1-bit input: Clock input
   CE => dlyce,                   -- 1-bit input: Active high enable increment/decrement input
   CINVCTRL => '0',       -- 1-bit input: Dynamic clock inversion input
   CNTVALUEIN => std_logic_vector(to_unsigned(0,5)),   -- 5-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Internal delay data input
   IDATAIN => data_ser,         -- 1-bit input: Data input from the I/O
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LD => '0',                   -- 1-bit input: Load IDELAY_VALUE input
   LDPIPEEN => '0',       -- 1-bit input: Enable PIPELINE register to load data input
   REGRST => dlyrst            -- 1-bit input: Active-high reset tap-delay input
);

data_ser_del <= data_ser_d; 
data_ser_dbg <= iddr_q1 & iddr_q2; 

  -----------------------------------------
  -- DDR INPUT FLIPFLOPS: IDDR PRIMITIVE --
  -----------------------------------------
 IDDR_inst : IDDR
    generic map (
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
      INIT_Q1 => '0', 
      INIT_Q2 => '0', 
      SRTYPE => "SYNC"
      )
    port map (
      d  => data_ser_del,
      q1 => iddr_q1,
      q2 => iddr_q2,
      c  => clk_ser,
      r  => '0',
      s => '0', 
      CE => '1'
      );

  ----------------
  -- CONTROLLER --
  ----------------
  control_proc : process (clk_ser)
    variable ClkPipeline : std_logic_vector(2 downto 0);
  begin
    if rising_edge(clk_ser) then
      rst_sync <= rst;

      if (rst_sync = '1') then

        bitslip_q    <= '0';
        bitslip_qq   <= '0';
        bitslip_req  <= '0';
        bitslip_even <= '0';

        load_parallel <= '0';

        data_1   <= '0';
        data_2   <= '0';
        data_2_q <= '0';

        shift_timer         <= (others => '1');
        shift_data          <= (others => '0');
        data_par_outofphase <= (others => '0');
        data_par            <= (others => '0');

        ClkPipeline := (others => '0');

      else

        ------------------------------------------------------------------------
        -- RISING EDGE DETECTOR ON BITSLIP
        bitslip_q  <= bitslip;
        bitslip_qq <= bitslip_q;


        ------------------------------------------------------------------------
        -- ASSERT BITSLIP REQUEST
        -- The receiver sampled 2 bits per clock period. At the rising edge of
        -- clk_ser, these two bits are shifted into the shift_data shift reg.
        -- The actual bitslip shifts 2 bits at once (one clk_ser cycle slipped).
        -- Therefore, every other bitslip_request, the bitslip will not be
        -- executed. Instead bits 12 downto 1 instead of 11 downto 0 will be
        -- assigned to the parallel output.
        if (bitslip_q = '1' and bitslip_qq = '0') then
          if (bitslip_even = '0') then
            bitslip_even <= '1';
            bitslip_req  <= '1';
          else
            bitslip_even <= '0';
          end if;
        end if;


        ------------------------------------------------------------------------
        -- TIMER
        -- The timer will count the required number of clocks to receive one
        -- data word. At the end of a timer period, the data is copied from the
        -- shift register to the parallel data output.
        -- When a bitslip request is high, the timer will count one clock less
        -- in a timer period. This means that the word sampling window will move
        -- by 2 bits.
        load_parallel <= '0';
        shift_timer   <= '0' & shift_timer(shift_timer'high downto 1);


        if (reg_10bit = '1') then
          if (shift_timer (2 downto 0) = "001") then
            shift_timer   <= (others => '1');
            load_parallel <= '1';
          elsif (shift_timer (2 downto 0) = "011") then
            if (bitslip_req = '1') then
              shift_timer <= (others => '1');
              bitslip_req <= '0';
            end if;
          end if;
        else
          if (shift_timer (2 downto 0) = "001") then
            shift_timer   <= (others => '1');
            load_parallel <= '1';
          elsif (shift_timer (2 downto 0) = "011") then
            if (bitslip_req = '1') then
              shift_timer <= (others => '1');
              bitslip_req <= '0';
            end if;
          end if;
        end if;


        -- Safety measure to prevent lock-up situations
        if (shift_timer (2 downto 0) = "001") then
          shift_timer   <= (others => '1');
          load_parallel <= '1';
        end if;


        ------------------------------------------------------------------------
        -- SHIFT IN DATA
        data_1   <= iddr_q1 xor reg_invert;
        data_2   <= iddr_q2 xor reg_invert;
        data_2_q <= data_2;


        if (bitslip_even = '1') then
          shift_data <= data_2 &
                        data_1 &
                        shift_data(shift_data'high downto 2);
        else
          shift_data <= data_1 &
                        data_2_q &
                        shift_data(shift_data'high downto 2);
        end if;


        ------------------------------------------------------------------------
        -- COPY SHIFT REGISTER TO PARALLEL DATA OUTPUT
        if (load_parallel = '1') then
          if (reg_10bit = '1') then
            data_par_outofphase <= "0000" & shift_data (11 downto 2);
          else
            data_par_outofphase <= shift_data; 
--            shift_data(0) & shift_data(1) & 
--                                    shift_data(2) & shift_data(3) &
--                                    shift_data(4) & shift_data(5) &
--                                    shift_data(6) & shift_data(7) &
--                                    shift_data(8) & shift_data(9) &
--                                    shift_data(10) & shift_data(11) &
--                                    shift_data(12) & shift_data(13) ;
          end if;
        end if;

        -- Phase adjust towards rising edge of parallel clock
        if ClkPipeline(1) = '1' and ClkPipeline(2) = '0' then
          data_par <= data_par_outofphase;
        end if;
        ClkPipeline := ClkPipeline(1 downto 0) & clk_par;

      end if;
    end if;
  end process;

end rtl;
