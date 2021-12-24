----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2021 08:57:08 PM
-- Design Name: 
-- Module Name: full_addr - rtl
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

entity full_addr is
port (a_i     : in std_logic;
      b_i     : in std_logic;
      cin_i   : in std_logic;
      sum_o   : out std_logic;
      cout_o  : out std_logic 
);
end full_addr;


architecture rtl of full_addr is

signal temp : std_logic;

begin
temp <= a_i xor b_i;
sum_o <= temp xor cin_i;
cout_o <= (temp and cin_i) or (a_i and b_i);
end rtl;
