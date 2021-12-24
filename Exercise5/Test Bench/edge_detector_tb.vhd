----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/23/2021 04:40:39 PM
-- Design Name: 
-- Module Name: edge_detector_tb - rtl
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

entity edge_detector_tb is
--  Port ( );
end edge_detector_tb;

architecture rtl of edge_detector_tb is

component edge_detector is
  port (
    rst_i    : in  std_logic;
    clk_i    : in  std_logic;
    strobe_i : in  std_logic;
    p1_o     : out std_logic;
    p2_o     : out std_logic;
    p3_o     : out std_logic);
end component edge_detector;

signal rst_i_s : std_logic;
signal clk_i_s : std_logic;
signal strobe_i_s : std_logic;
signal p1_o_s : std_logic;
signal p2_o_s : std_logic;
signal p3_o_s : std_logic;

begin
uut : edge_detector 
port map(
rst_i => rst_i_s,
clk_i => clk_i_s,
strobe_i => strobe_i_s,
p1_o => p1_o_s,
p2_o => p2_o_s,
p3_o => p3_o_s 
);

clk_process : process
begin
clk_i_s <= '0';
wait for 2ns;
clk_i_s <= '1';
wait for 2ns;
end process; 


main_process : process
begin
rst_i_s <= '0';
strobe_i_s <= '1';

wait for 3ns;
strobe_i_s <= '1';

wait for 3ns;
strobe_i_s <= '1';

wait for 3ns;
strobe_i_s <= '0';

wait for 3ns;
strobe_i_s <= '1';

wait for 3ns;
strobe_i_s <= '0';

wait for 3ns;
strobe_i_s <= '0';

wait for 3ns;
strobe_i_s <= '0';
wait for 100ns;
end process;

end rtl;
