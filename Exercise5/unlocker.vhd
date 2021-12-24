library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unlocker is
  port (
    rst_i    : in  std_logic;
    clk_i    : in  std_logic;
    psw_i    : in  std_logic;
    unlock_o : out std_logic);
end entity unlocker;

architecture rtl of unlocker is

type state_type is (s0,s1,s2,s3,s4,s5);  --type of state machine.
signal cur_state_s, next_state_s : state_type;  --current and next state declaration.

begin  -- architecture rtl

process(clk_i)
begin
    if (rising_edge(clk_i)) then
        cur_state_s <= next_state_s;
            if rst_i='1' then
                cur_state_s <= s0;
            else
                case cur_state_s is
                     when s0 =>        --when current state is "s0"
                         if(psw_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s1;
                         end if;

                     when s1 =>        --when current state is "s1"
                         if(psw_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s2;
                         end if;

                     when s2 =>        --when current state is "s1"
                         if(psw_i ='0') then
                              next_state_s <= s3;
                         else
                              next_state_s <= s2;
                         end if;
                         
                     when s3 =>        --when current state is "s1"
                         if(psw_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s4;
                         end if;
                         
                     when s4 =>        --when current state is "s1"
                         if(psw_i ='0') then
                              next_state_s <= s5;
                         else
                              next_state_s <= s2;
                         end if;

                     when s5 =>        --when current state is "s1"
                         if(psw_i ='0') then
                              next_state_s <= s0;
                         else
                              next_state_s <= s1;
                         end if;
  
                       when others => null;
                 end case;
             end if;
         end if;
     end process;
     
     unlock_o <= '1' when (cur_state_s = s4) and (psw_i='0')
     else '0';
end architecture rtl;
