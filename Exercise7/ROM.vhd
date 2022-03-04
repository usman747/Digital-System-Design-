----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2022 11:28:00 AM
-- Design Name: 
-- Module Name: ROM - rtl
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
use work.ROM_PACKAGE.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
generic(
ipwidth: natural:=6;
opmode: Mode:=combinational;
divisor: natural:=6
);

port (
clk: in std_logic;
ip: in std_logic_vector(ipwidth-1 downto 0);
quotient: out std_logic_vector(quotient_width(ipwidth,divisor)-1 downto 0);
remainder: out std_logic_vector(remainder_width(divisor)-1 downto 0) 
);
end ROM;

architecture rtl of ROM is

constant one: std_logic_vector(0 downto 0):="1";
constant quotientW: natural:= quotient_width(ipwidth, divisor);
constant remainderW: natural:= remainder_width(divisor);
signal DROM : MEM:= rom_init(ipwidth,divisor);

begin

quotient <= DROM(to_integer(unsigned(ip)))(quotientW+remainderW-1 downto remainderW);
remainder <= DROM(TO_INTEGER(unsigned(ip)))(remainderW-1 downto 0);

end rtl;
