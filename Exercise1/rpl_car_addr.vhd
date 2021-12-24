----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2021 10:07:50 PM
-- Design Name: 
-- Module Name: rpl_car_addr - rtl
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

entity rpl_car_addr is
generic(
bus_wid : integer := 3
);
port (
in0_i, in1_i    : in std_logic_vector(bus_wid-1 downto 0);
carry_i         : in std_logic;
carry_o         : out std_logic;
output_o        : out std_logic_vector(bus_wid-1 downto 0)
);
end rpl_car_addr;

architecture rtl of rpl_car_addr is
    component full_addr
    port(
    a_i, b_i, cin_i : in std_logic;
    sum_o, cout_o   : out std_logic
    );
    end component; 
signal carry_between : std_logic_vector((bus_wid-1) downto 0);

begin
carry_between(0) <= carry_i;
carry_o <= carry_between(bus_wid);
loop1:
for i in 0 to (bus_wid-1) generate 
joiner : full_addr
port map(
a_i => in0_i(i),
b_i => in1_i(i),
cin_i => carry_between(i),
sum_o => output_o(i),
cout_o => carry_between(i+1)
);
end generate;
end rtl;
