----------------------------------------------------------------------------------
-- Company: NARIT
-- Engineer: K. Chanon
-- 
-- Create Date: 10/11/2023 12:19:55 AM
-- Design Name: 
-- Module Name: adcDecodeLVDS - Behavioral
-- Project Name: LTC2264 decoder 
-- Target Devices: Zynq 7010
-- Tool Versions: Vivado 2020.1
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.vcomponents.all;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity adcDecodeLVDS is
    Port ( DCLK_p, DCLK_n, FCLK_p, FCLK_n     : in STD_LOGIC;
           Data1_p, Data1_n: in STD_LOGIC;
           
           rst : in std_logic;
           clk_sys : std_logic; -- 200MHz 
           clk_par : std_logic; 
           
           startTraining : std_logic; 
           
           data14bit : out std_logic_vector(13 downto 0);
           clk_par_dbg, clk_ser_dbg : out std_logic; 
           data1_bufg_dbg : out std_logic_vector(1 downto 0);
           bitslip_dbg : out std_logic;
           adone : out std_logic
          );
end adcDecodeLVDS;

architecture Behavioral of adcDecodeLVDS is
    signal dclk_bufg, data1_bufg, fclk_bufg    : std_logic;  
    
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
    
  component bitAlignment
      Port ( clk : in std_logic;
             rst : in std_logic; 
             data : in unsigned(13 downto 0); 
             enable : in std_logic;
             training_data : in unsigned(13 downto 0); 
             dlyce : out std_logic; 
             dlyrst : out std_logic; 
             bitslip : out std_logic;
             adone : out std_logic
      );
  end component;    
    
  signal rx_ready : std_logic;   
  signal dlyce0, dlyrst0, bitslip0 : std_logic; 
  signal data_par : unsigned(13 downto 0); 
    
begin
    data14bit <= std_logic_vector(data_par(13 downto 0));
    clk_par_dbg <= fclk_bufg;
    clk_ser_dbg <= dclk_bufg; 
    bitslip_dbg <= bitslip0; 
    IDELAYCTRL_inst : IDELAYCTRL
    port map (
       RDY => rx_ready,       -- 1-bit output: Ready output
       REFCLK => clk_sys, -- 1-bit input: Reference clock input
       RST => rst        -- 1-bit input: Active-High reset input. Asynchronous assert, synchronous deassert to
                         -- REFCLK.
    );
    
  inst_ser2par_data_0: tsc_ser2par
    port map (
        data_ser => data1_bufg, 
        data_ser_dbg => data1_bufg_dbg,
        clk_par => clk_par,
        clk_ser => dclk_bufg,
        clk_sys => clk_sys, 
        rx_ready => rx_ready, 
        rst     => '0',
        dlyce => dlyce0,  
        dlyrst => dlyrst0, 
        bitslip => bitslip0, 
        reg_10bit  => '0',
        reg_invert => '0',
        data_par => data_par
      );
  bitalign_data_0 :   bitAlignment
    port map ( 
        clk => clk_par,
        rst => '0',
        data => data_par, 
        enable => startTraining, 
        training_data => "00010001010101", 
        dlyce => dlyce0,  
        dlyrst => dlyrst0, 
        bitslip => bitslip0,
        adone => adone
    ); 

    BUFF1: IBUFDS
    generic map (
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => FALSE, 
        IOSTANDARD => "LVDS_25"
    )   
    port map (
        O => dclk_bufg, 
        I => DCLK_p, 
        IB => DCLK_n 
    );
    
    BUFF2: IBUFDS
    generic map (
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => FALSE, 
        IOSTANDARD => "LVDS_25"
    )   
    port map (
        O => fclk_bufg, 
        I => FCLK_p, 
        IB => FCLK_n 
    );
    
    BUFF3: IBUFDS
    generic map (
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => FALSE, 
        IOSTANDARD => "LVDS_25"
    )   
    port map (
        O => data1_bufg, 
        I => Data1_p, 
        IB => Data1_n 
    );
    
--    BUFF4: IBUFDS
--    generic map (
--        DIFF_TERM => TRUE,
--        IBUF_LOW_PWR => FALSE, 
--        IOSTANDARD => "LVDS_25"
--    )   
--    port map (
--        O => open, 
--        I => Data2_p, 
--        IB => Data2_n  
--    );

end Behavioral;
