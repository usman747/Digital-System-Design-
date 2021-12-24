----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2021 12:33:47 PM
-- Design Name: 
-- Module Name: prior_enc_tb - Behavioral
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

entity prior_enc_tb is
--  Port ( );
end prior_enc_tb;

architecture Behavioral of prior_enc_tb is
component prior_enc is 
port
(
    r      : in  std_logic_vector(3 downto 0);
    code   : out std_logic_vector(1 downto 0);
    active : out std_logic
);
end component; 

    signal r_s : std_logic_vector(3 downto 0);
    signal code_s : std_logic_vector(1 downto 0);
    signal active_s : std_logic;
    
begin
    uut : prior_enc --component instantiation 
    port map(
     r => r_s,  --invert r and r_s and check (r_s => r,) it gives error that port r_s is 
    -- not declared in prior_enc !!! because port on LT is of prior_enc and 
    -- port on RT is of prior_enc_tb 
    code => code_s,
    active => active_s    
        );
        
process 
begin 
    wait for 10ns; --wait time
    r_s <= "1000";
    
    wait for 10ns; --wait time
    r_s <= "1001";
    
    wait for 10ns; --wait time
    r_s <= "0100";
    
    wait for 10ns; --wait time
    r_s <= "0010";
    
    wait for 10ns; --wait time
    r_s <= "0001";
    
    wait for 10ns; --wait time
    r_s <= "0000";
end process;
end Behavioral;
