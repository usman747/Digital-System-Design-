----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2021 02:57:42 PM
-- Design Name: 
-- Module Name: var_len_decoder - rtl
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity var_len_decoder is
--  Port ( );
port(
bits_i  : in std_logic_vector(3 downto 0);
symbols_o  : out std_logic_vector(2 downto 0);
length_o  : out std_logic_vector(2 downto 0)
);
end var_len_decoder;

architecture rtl of var_len_decoder is
begin
with bits_i select
symbols_o <= "100" when "1111",
            "011" when "1110",
            "010" when "110-",
            "001" when "10--",-- the "X" symbol for don't care was not working and output was going into others condition
            "000" when "0---",
            "111" when others;
        
with bits_i select
 length_o <= "100" when "1111",
            "100" when "1110",
            "011" when  "110-",
            "010" when  "10--",
            "001" when  "0---",
            "000" when others;


-- THE CODE BELOW IS WRONG, ONLY 1st and sometimes 2nd condition was executing...
-- I THINK BECAUSE OF "ELSE"...WHEN STATEMNET WAS EXECUTED IT DIDN'T CHECKED OTHERS 
-- INVESTIGATE ! ?

--    symbols_o <= "100" when bits_i = "1111" else  -- decoder works from prefix (MSB to LSb)
--                 "011" when bits_i = "1110" else  -- decoder works from prefix (MSB to LSb)
--                 "010" when bits_i = "110-" else  -- decoder works (MSB to LSb), so 0th bit don't care            
--                 "001" when bits_i = "10--" else              
--                 "000" when bits_i = "0---"; -- wasn't able to model the others condition 
                 
--     length_o <= "100" when bits_i = "1111" else   
--                 "100" when bits_i = "1110" else
--                 "011" when bits_i = "110-" else         
--                 "010" when bits_i = "10--" else           
--                 "001" when bits_i = "0---";       

end architecture rtl;
