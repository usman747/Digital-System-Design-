----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2021 09:31:17 PM
-- Design Name: 
-- Module Name: johnson_counter - rtl
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity johnson_counter is
--  Port ( );
port (
clk_i           : in  std_logic;
rst_i           : in  std_logic;
jc_out_o           : out std_logic_vector(3 downto 0));


end entity johnson_counter;

architecture rtl of johnson_counter is

signal temp_cont : std_logic_vector(3 downto 0) := (others => '0');
begin

process(clk_i) is
begin
 if rising_edge (clk_i) then
        if rst_i = '1' then
             temp_cont <= "0000";
        else
             temp_cont(3) <= not temp_cont(0);
             temp_cont(2) <= temp_cont(3);
             temp_cont(1) <= temp_cont(2);
             temp_cont(0) <= temp_cont(1);
        end if;
 end if;
end process;
jc_out_o <= temp_cont;
end rtl;
