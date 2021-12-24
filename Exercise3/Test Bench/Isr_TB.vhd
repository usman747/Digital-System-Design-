----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2021 08:25:18 PM
-- Design Name: 
-- Module Name: isr_tb - rtl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Isr_TB is
--  Port ( );
end Isr_TB;

architecture rtl of Isr_TB is
component lsr is 
port(
    clk_i      : in  std_logic;
    rst_i      : in  std_logic;
    load_i     : in  std_logic;
    data_in_i  : in  std_logic_vector(7 downto 0);
    data_out_o : out std_logic_vector(7 downto 0)
);
end component;

signal clk_s: std_logic;
signal rst_s: std_logic;
signal load_s     : std_logic;
signal data_in_s  : std_logic_vector(7 downto 0);
signal data_out_s : std_logic_vector(7 downto 0);

begin

uut:lsr
port map
(
    clk_i => clk_s,
    rst_i => rst_s,
    data_in_i  => data_in_s,
    data_out_o  => data_out_s,
    load_i  => load_s
);

clk_process : process
begin
clk_s <= '0';
wait for 2ns;
clk_s <= '1';
wait for 2ns;
end process; 


main_process : process
begin
rst_s <= '0';
load_s <= '1';
data_in_s <= "00000101";

wait for 10ns;
load_s <= '0';

wait for 20ns;
load_s <= '1';

wait for 100ns;

end process;


end rtl;
