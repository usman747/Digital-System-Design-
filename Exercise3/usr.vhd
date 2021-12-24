----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2021 05:21:00 PM
-- Design Name: 
-- Module Name: usr - rtl
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity usr is
generic(
width : natural:= 8
);
port(
clk_i : in std_logic;
rst_i : in std_logic;
con_i : in std_logic_vector(1 downto 0);
data_in_i : in std_logic_vector(width-1 downto 0);
data_out_o : out std_logic_vector(width-1 downto 0)
);
end usr;

architecture rtl of usr is
    signal temp_reg : std_logic_vector(width-1 downto 0); --temporary register
begin
process (clk_i) is
begin
    if(rising_edge(clk_i)) then 
        if(rst_i='1') then 
            temp_reg <= (others => '0');
        else
            if(con_i="00") then
                temp_reg <= data_in_i; -- when control signal is 0, we perform parallel load 
                elsif(con_i="01") then
                    temp_reg <= std_logic_vector(shift_left(unsigned(data_in_i),1)); -- when control signal 1, perform left shift       
                else 
                    temp_reg <= std_logic_vector(shift_right(unsigned(data_in_i),1)); -- when control signal 1, perform left right
            end if;--control 01
        end if; --rst
    end if;--clk
end process;
data_out_o <= temp_reg;
end rtl;
