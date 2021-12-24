----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2021 12:13:39 PM
-- Design Name: 
-- Module Name: com_summation_op - rtl
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

entity com_summation_op is
 port ( 
 operands_i : in std_logic_vector(63 downto 0);
 sum_o : out std_logic_vector(10 downto 0)
 );
end com_summation_op;

architecture rtl of com_summation_op is

signal a_0 : std_logic_vector(7 downto 0);
signal a_1 : std_logic_vector(7 downto 0);
signal a_2 : std_logic_vector(7 downto 0);
signal a_3 : std_logic_vector(7 downto 0);
signal a_4 : std_logic_vector(7 downto 0);
signal a_5 : std_logic_vector(7 downto 0);
signal a_6 : std_logic_vector(7 downto 0);
signal a_7 : std_logic_vector(7 downto 0);
signal b_0 : std_logic_vector(8 downto 0);
signal b_1 : std_logic_vector(8 downto 0);
signal b_2 : std_logic_vector(8 downto 0);
signal b_3 : std_logic_vector(8 downto 0);
signal c_0 : std_logic_vector(9 downto 0);
signal c_1 : std_logic_vector(9 downto 0);

begin
a_0 <= operands_i(7 downto 0);
a_1 <= operands_i(15 downto 8);
a_2 <= operands_i(23 downto 16);
a_3 <= operands_i(31 downto 24);
a_4 <= operands_i(39 downto 32);
a_5 <= operands_i(47 downto 40);
a_6 <= operands_i(55 downto 48);
a_7 <= operands_i(63 downto 56);

b_0 <= (b"0" & a_0) + (b"0" & a_1); -- padding zeros because ideally the out and in of sum should be of same bits 
b_1 <= (b"0" & a_2) + (b"0" & a_3);
b_2 <= (b"0" & a_4) + (b"0" & a_5);
b_3 <= (b"0" & a_6) + (b"0" & a_7);

c_0 <= (b"0" & b_0) + (b"0" & b_1);
c_1 <= (b"0" & b_2) + (b"0" & b_3);

sum_o <= (b"0" & c_0)+(b"0" & c_1); 
--b_0 <= std_logic_vector(unsigned(a_0) + unsigned(a_1)); -- not using this because use ieee.std_logic_unsigned.all; above
--b_1 <= std_logic_vector(unsigned(a_2) + unsigned(a_3)); 
--b_2 <= std_logic_vector(unsigned(a_4) + unsigned(a_5)); 
--b_3 <= std_logic_vector(unsigned(a_6) + unsigned(a_7));

--c_0 <= std_logic_vector(unsigned(b_0) + unsigned(b_1)); 
--c_1 <= std_logic_vector(unsigned(b_2) + unsigned(b_3));  


end rtl;
