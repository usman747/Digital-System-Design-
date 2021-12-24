library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_detector is
  port (
    rst_i    : in  std_logic;
    clk_i    : in  std_logic;
    strobe_i : in  std_logic;
    p1_o     : out std_logic;
    p2_o     : out std_logic;
    p3_o     : out std_logic);
end entity edge_detector;

architecture rtl of edge_detector is

type state_type is (zero,edge,one,delay);  --type of state machine.
signal cur_state1_s, nxt_state1_s, cur_state2_s, nxt_state2_s, cur_state3_s, nxt_state3_s : state_type;  --current and next state declaration.

begin  -- architecture rtl

process(clk_i, rst_i)
begin
    if rst_i='1' then
        cur_state1_s <= zero;
        cur_state2_s <= zero;
        cur_state3_s <= zero;
    elsif (rising_edge(clk_i)) then
        cur_state1_s <= nxt_state1_s;
        cur_state2_s <= nxt_state2_s;
        cur_state3_s <= nxt_state3_s;
    end if;
end process;

--1st state machine process.
process(cur_state1_s, strobe_i)
begin
  case cur_state1_s is
     when zero =>        --when current state is "zero"
     if(strobe_i ='0') then
--      p1_o <= '0';
      nxt_state1_s <= zero;
    else
--      p1_o <= '1';
      nxt_state1_s <= edge;
     end if;
     
     when edge =>        --when current state is "edge"
     if(strobe_i ='0') then
      nxt_state1_s <= zero;
    else
      nxt_state1_s <= one;
      end if;
      
    when one =>        --when current state is "one"
     if(strobe_i ='0') then
      nxt_state1_s <= zero;
    else
      nxt_state1_s <= one;
     end if;
     
     when others => null;
  end case;
end process;

--2nd state machine process.
process(cur_state2_s, strobe_i)
begin
  case cur_state2_s is
     when zero =>        --when current state is "zero"
     if(strobe_i ='0') then
      nxt_state2_s <= zero;
    else
      nxt_state2_s <= one;
     end if;
     
     when edge =>        --when current state is "one"
     if(strobe_i ='0') then
      nxt_state2_s <= zero;
    else
      nxt_state2_s <= one;
     end if;
     
     when others => null;
  end case;
end process;

--2nd state machine process.
process(cur_state3_s, strobe_i)
begin
  case cur_state3_s is
     when zero =>        --when current state is "zero"
     if(strobe_i ='0') then
      nxt_state3_s <= zero;
    else
      nxt_state3_s <= delay;
     end if;
     
     when delay =>        --when current state is "one"
     if(strobe_i ='0') then
      nxt_state3_s <= zero;
    else
      nxt_state3_s <= one;
     end if;
     
     when one =>        --when current state is "one"
     if(strobe_i ='0') then
      nxt_state3_s <= zero;
    else
      nxt_state3_s <= one;
     end if;
     
     when others => null;
  end case;
end process;

p1_o <= '1' when cur_state1_s = edge else
       '0';
       
p2_o <= '1' when (cur_state2_s = zero) and (strobe_i = '1') else
       '0';
       
p3_o <= '1' when ((cur_state3_s = zero) and (strobe_i = '1')) or (cur_state3_s = delay) else
       '0';

end architecture rtl;
