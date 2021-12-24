----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2021 10:16:32 PM
-- Design Name: 
-- Module Name: var_len_decoder_tb - rtl
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

entity var_len_decoder_tb is
--  Port ( );
end var_len_decoder_tb;

architecture rtl of var_len_decoder_tb is
component var_len_decoder is
port(
bits_i  : in std_logic_vector(3 downto 0);
symbols_o  : out std_logic_vector(2 downto 0);
length_o  : out std_logic_vector(2 downto 0)
);
end component;

signal bits_i_s  : std_logic_vector(3 downto 0);
signal symbols_o_s  : std_logic_vector(2 downto 0);
signal length_o_s  : std_logic_vector(2 downto 0);

begin
uut : var_len_decoder
port map(
bits_i => bits_i_s,
symbols_o => symbols_o_s,
length_o => length_o_s
);

process 
begin
    wait for 10ns; --wait time
    bits_i_s <= "1111";

    wait for 10ns; --wait time
    bits_i_s <= "1110";
    
    wait for 10ns; --wait time
    bits_i_s <= "1100"; --should give symbol 2 and len 3, as 1st bit is dont care
    
    wait for 10ns; --wait time
    bits_i_s <= "1101"; --should give symbol 2 and len 3  
    
    wait for 10ns; --wait time
    bits_i_s <= "1000"; --should give symbol 1 and len 2  
    
    wait for 10ns; --wait time
    bits_i_s <= "1011"; --should give symbol 1 and len 2    
    
    wait for 10ns; --wait time
    bits_i_s <= "0101"; --should give symbol 0 and len 1 
end process;

end rtl;
