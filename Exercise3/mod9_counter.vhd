----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2021 11:30:14 AM
-- Design Name: 
-- Module Name: mod9_counter - rtl
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod9_counter is
--  Port ( );
  port (
    clk_i           : in  std_logic;
    rst_i           : in  std_logic;
    count_out_o     : out std_logic_vector(3 downto 0));

end mod9_counter;



architecture rtl of mod9_counter is

signal count_temp : std_logic_vector(3 downto 0) :=(others => '0');

begin
    process(clk_i)
    begin
    if rising_edge (clk_i) then
        if rst_i = '1' then
            count_temp <= (others=>'0');
        else
--            if (count_temp = 8) then
              if (count_temp = std_logic_vector(TO_UNSIGNED(8,count_temp'length))) then --   USE THIS
                count_temp <= (others=>'0');
            else
              --count_temp <= count_temp + 1;
              count_temp <= std_logic_vector(unsigned(count_temp) + 1); -- USE THIS AS COOL LIB NOT ALLOWED MAYBE
            end if;
        end if;
    end if; 
    end process;
    count_out_o <= count_temp;
end rtl;
