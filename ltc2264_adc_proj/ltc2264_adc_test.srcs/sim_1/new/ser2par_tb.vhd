library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;


--------------------------------------------------------------------------------
entity ser2par_tb is
end entity ser2par_tb;

architecture sim of ser2par_tb is

  component tsc_ser2par is
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

  end component;

  constant  c_INVERT_MASK         : std_logic     := '0';
  signal  data_ser_p              : std_logic;
  signal  data_ser_n              : std_logic;
  signal  clk_par                 : std_logic;
  signal  clk_ser                 : std_logic;
  signal  rst                     : std_logic;
  signal  dlyce                   : std_logic;
  signal  dlyrst                  : std_logic;
  signal  bitslip                 : std_logic;
  signal  reg_10bit               : std_logic;
  signal  reg_invert              : std_logic;
  signal  data_par                : unsigned (13 downto 0);

signal clk_sys : std_logic; 
  -------------------------------
  -- OTHER CONSTANTS & SIGNALS --
  -------------------------------
  constant c_PER        : time := 4 ns;
  constant c_NR_BITS    : integer := 14;

begin

  reg_10bit   <= '1' when c_NR_BITS = 10 else '0';
  reg_invert  <= '0';

  -----------
  -- INPUT --
  -----------
  data_ser_n    <= not data_ser_p;

  inp_proc: process
    variable data_par : unsigned (13 downto 0);

  begin
    clk_par       <= '0';
    clk_ser       <= '0';
    data_ser_p    <= '0';
    rst           <= '1';
    wait for c_PER;

    rst           <= '0';
    wait for c_PER;

    while (true) loop
      data_par  := to_unsigned (7, 14);
      clk_par   <= '1';

      for i in 0 to c_NR_BITS-1 loop
        data_ser_p  <= data_par(i);
        wait for c_PER/4;
        clk_ser     <= not clk_ser;
        wait for c_PER/4;

        if (i = c_NR_BITS/2-1) then
          clk_par <= '0';
        end if;
      end loop;
    end loop;
  end process;


  ------------------
  -- DUT INSTANCE --
  ------------------
  inst_ser2par: tsc_ser2par
    port map (
      data_ser                  =>   data_ser_p,
      data_ser_dbg              => open,
      clk_sys                => clk_sys,
      rx_ready          => '1',
      clk_par                 => clk_par                 ,
      clk_ser                 => clk_ser                 ,
      rst                     => rst                     ,
      dlyce                   => dlyce                   ,
      dlyrst                  => dlyrst                  ,
      bitslip                 => bitslip                 ,
      reg_10bit               => reg_10bit               ,
      reg_invert              => reg_invert              ,
      data_par                => data_par
      );

end sim;
