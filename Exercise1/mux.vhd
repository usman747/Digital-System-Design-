library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity mux is
  port (
    a        : in  std_logic_vector(3 downto 0);
    b        : in  std_logic_vector(3 downto 0);
    c        : in  std_logic_vector(3 downto 0);
    d        : in  std_logic_vector(3 downto 0);
    sel      : in  std_logic_vector(1 downto 0);
    selected : out std_logic_vector(3 downto 0));
end entity mux;

architecture rtl of mux is

begin  -- architecture rtl
    selected <= a when sel="00" else 
                b when sel="01" else 
                c when sel="10" else 
                d when sel="11" else 
                d;  
  
end architecture rtl;
