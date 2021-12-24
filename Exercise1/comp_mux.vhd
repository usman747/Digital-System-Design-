library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity comp_mux is
  port (
    in0_i    : in  std_logic_vector(3 downto 0);
    in1_i    : in  std_logic_vector(3 downto 0);
    op_i     : in  std_logic_vector(1 downto 0);
    output_o : out std_logic_vector(3 downto 0));
end entity comp_mux;

architecture rtl of comp_mux is

signal shift_l : std_logic_vector(3 downto 0);
signal shift_r : std_logic_vector(3 downto 0);
signal sum : std_logic_vector(3 downto 0);
signal abs_diff : std_logic_vector(3 downto 0);
signal bitwise_or : std_logic_vector(3 downto 0);
signal abs_in1 : std_logic_vector(3 downto 0);
signal chk_sign : std_logic;
signal temp : std_logic_vector(3 downto 0) := (others => '0');

begin  -- architecture rtl
sum <= std_logic_vector(signed(in0_i) + signed(in1_i));
abs_diff <= std_logic_vector(abs(signed(in0_i)) - abs(signed(in1_i))); 
bitwise_or <= in0_i or in1_i; 
abs_in1 <= std_logic_vector(abs(signed(in1_i)));  --discuss with zamik, if std logic removed error, 
--if dont do signed error on abs.. i think all operations are done with signed and unsigened type, 
--but we need to declare I/O s or Ports as STD_Logic otherwise problem says TA
chk_sign <= in1_i(3); --because the MSB tells the sign bit 
shift_l <= std_logic_vector(shift_left(signed(in0_i),to_integer(unsigned(abs_in1))));
shift_r <= std_logic_vector(shift_right(signed(in0_i),to_integer(unsigned(abs_in1))));

    temp <= shift_l when chk_sign = '1' else
            shift_r;

with op_i select
    output_o <= sum when "00",
                abs_diff when "01",
                bitwise_or when "10",
                temp when "11";
              
--temp_l <= abs(signed(in0_i));
--shift_l <= std_logic_vector(shift_left(in0_i,1));
--
--    with op_i select
--       output_o <= (in0_i + in1_i) when "00",
--       abs(signed(in0_i))- abs(signed(in1_i)) when "01",
--      (in0_i or in1_i) when "10",
--      
--       ((signed(in1_i)<0) and (in0_i sll abs(in1_i))) + ((signed(in1_i)>0) and (in0_i srl abs(in1_i)))  when others;
    
    
end architecture rtl;
