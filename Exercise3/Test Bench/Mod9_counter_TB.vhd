----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2021 07:04:54 PM
-- Design Name: 
-- Module Name: Mod9_counter_TB - Behavioral
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

entity Mod9_counter_TB is
--  Port ( );
end Mod9_counter_TB;

architecture rtl of Mod9_counter_TB is
component mod9_counter is 
port(
    clk_i           : in  std_logic;
    rst_i           : in  std_logic;
    count_out_o     : out std_logic_vector(3 downto 0)   
);
end component;

signal clk_s: std_logic:='0';
signal rst_s: std_logic:='0';
signal count_s: std_logic_vector(3 downto 0);

begin

uut : mod9_counter
port map
(
    clk_i => clk_s,
    rst_i => rst_s,
    count_out_o  => count_s
);

clk_process : process
begin
clk_s <= '0';
wait for 2ns;
clk_s <= '1';
wait for 2ns;
end process; 

main : process
begin
wait for 100ns;
rst_s <= '1';
wait for 20ns;
end process;


end rtl;
