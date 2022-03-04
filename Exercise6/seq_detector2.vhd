library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seq_detector2 is
  port (
    rst_i    : in  std_logic;
    clk_i    : in  std_logic;
    strobe_i : in  std_logic;
    seq_o     : out std_logic);
end entity seq_detector2;

architecture rtl of seq_detector2 is

type state_type is (s0,s1,s2,s3,s4,s5);  --type of state machine.
signal cur_state_s, next_state_s : state_type;  --current and next state declaration.

begin  -- architecture rtl

--state reg
process(clk_i)
begin
    if rising_edge(clk_i) then
        if rst_i = '1' then 
            cur_state_s <= s0;
        else
            cur_state_s <= next_state_s;
        end if;
    end if; 
end process; 


--next state logic
process(strobe_i, cur_state_s)
begin
                case cur_state_s is
                     when s0 =>        --when current state is "s0"    -- x
                         if(strobe_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s1; 
                         end if;

                     when s1 =>        --when current state is "s1"   -- x1
                         if(strobe_i ='0') then
                              next_state_s <= s0; 
                         else
                              next_state_s <= s1;
                         end if;

                     when s2 =>        --when current state is "s1"     -- x11
                         if(strobe_i ='0') then
                              next_state_s <= s3;
                         else
                              next_state_s <= s1;
                         end if;
                         
                     when s3 =>        --when current state is "s1"     -- x110
                         if(strobe_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s4;
                         end if;
                         
                     when s4 =>        --when current state is "s1"      --x1101
                         if(strobe_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s5;
                         end if;

                     when s5 =>        --when current state is "s1"     --x11011
                         if(strobe_i ='0') then
                              next_state_s <= s3;
                         else
                              next_state_s <= s2;
                         end if;
  
                       when others => null;
                 end case;
     end process;
     
     seq_o <= '1' when (cur_state_s = s4) and (strobe_i='1')
     else '0';
end architecture rtl;
