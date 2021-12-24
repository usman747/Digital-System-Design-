----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2021 11:37:18 AM
-- Design Name: 
-- Module Name: gray_counter - rtl
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; --cool library 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gray_counter is
Port (
rst_i : in std_logic;
clk_i : in std_logic;
gray_out_o : out std_logic_vector(3 downto 0)
 );
end gray_counter;

architecture rtl of gray_counter is
    signal count : std_logic_vector(3 downto 0);
    signal gray : std_logic_vector(3 downto 0);
begin

    process(clk_i)
    begin
    if (rising_edge(clk_i))then 
        count <= count + 1;-- no error with plus although its STD_logic ..because of unsigned library
            if(rst_i='1') then
                count <= "0000";
            else
                gray(3) <= count(3); -- because the MSB is just copied in gray code pos 3(msb) 
                gray(2) <= count(3) xor count(2);  --bin pos 2,3 make gray pos 2. if same then 0, if diff 1
                gray(1) <= count(2) xor count(1); --bin pos 1,2 make gray pos 1. if same then 0, if diff 1
                gray(0) <= count(1) xor count(0);  --bin pos 0,1 make gray pos 0. if same then 0, if diff 1
            end if; --rst
    end if; --clk
    end process;
  gray_out_o <= gray;
end rtl;
