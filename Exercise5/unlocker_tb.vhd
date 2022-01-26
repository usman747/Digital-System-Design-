----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2021 10:59:37 PM
-- Design Name: 
-- Module Name: unlocker_tb - rtl
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

entity unlocker_tb is
--  Port ( );
end unlocker_tb;

architecture rtl of unlocker_tb is
component unlocker is 
port(
    rst_i    : in  std_logic;
    clk_i    : in  std_logic;
    psw_i    : in  std_logic;
    unlock_o : out std_logic
);
end component unlocker; -- whether u write unlocker here or not doesn't matter

signal rst_i_s  : std_logic;
signal clk_i_s  : std_logic;
signal psw_i_s   : std_logic;
signal unlock_o_s  : std_logic;

begin
uut : unlocker
port map(
rst_i => rst_i_s,
clk_i => clk_i_s,
psw_i => psw_i_s,
unlock_o => unlock_o_s
);

clk_process : process
begin
clk_i_s <= '0';
wait for 1ns;
clk_i_s <= '1';
wait for 1ns;
end process; 

main_process : process
begin
rst_i_s <= '0';

psw_i_s <= '1';
wait for 1.5ns;

psw_i_s <= '1';
wait for 1.5ns;

psw_i_s <= '0';
wait for 1.5ns;

psw_i_s <= '1';
wait for 1.5ns;

psw_i_s <= '0';
wait for 1.5ns;


end process;


end rtl;
