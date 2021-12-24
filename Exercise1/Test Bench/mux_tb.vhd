----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2021 02:52:52 PM
-- Design Name: 
-- Module Name: mux_tb - Behavioral
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

entity mux_tb is
--  Port ( );
end mux_tb;

architecture Behavioral of mux_tb is
component mux is 
  port (
    a        : in  std_logic_vector(3 downto 0);
    b        : in  std_logic_vector(3 downto 0);
    c        : in  std_logic_vector(3 downto 0);
    d        : in  std_logic_vector(3 downto 0);
    sel      : in  std_logic_vector(1 downto 0);
    selected : out std_logic_vector(3 downto 0)
    );
 end component; 
 
 signal a_s :std_logic_vector(3 downto 0);
 signal b_s :std_logic_vector(3 downto 0);
 signal c_s :std_logic_vector(3 downto 0);
 signal d_s :std_logic_vector(3 downto 0);
 signal sel_s :std_logic_vector(1 downto 0);
 signal selected_s :std_logic_vector(3 downto 0);
 
begin

    uut : mux 
    port map(
    a => a_s,
    b => b_s,
    c => c_s,
    d => d_s,
    sel => sel_s,
    selected => selected_s
    );

process 
begin 
    wait for 10ns; --wait time
    a_s <= "1000";
    sel_s <= "00";
    
    wait for 10ns; --wait time
    b_s <= "0100";
    sel_s <= "01";
    
    wait for 10ns; --wait time
    c_s <= "0010";
    sel_s <= "10";
    
    wait for 10ns; --wait time
    d_s <= "0001";
    sel_s <= "11";
end process;

end Behavioral;
