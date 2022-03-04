library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity computer is
  port (
    rst_i  : in  std_logic;
    clk_i  : in  std_logic;
    data_i : in  std_logic_vector(7 downto 0);
    vld_o  : out std_logic;
    data_o : out std_logic_vector(7 downto 0)
    );
end entity computer;

architecture rtl of computer is

  type state_type is (chk_cmd, s1, s2, s1_get_op2, s2_get_op2, s3, s4, s5, s6);
  signal cur_state, next_state : state_type; 
  signal R0_s : unsigned(7 downto 0);
begin  -- architecture rtl

process(clk_i, rst_i) -- state register 
begin
    if rst_i = '1' then 
            cur_state <= chk_cmd;  -- This is the state in which the we'll come again and again to check whr to go
        elsif rising_edge(clk_i) then 
            cur_state <= next_state;    
    end if;    
end process;


process(cur_state, data_i)   -- next state logic 
begin
    R0_s <= (others=> '0');
    case cur_state is 
        when chk_cmd => 
            if (data_i(2 downto 0)= "000") then 
                next_state <= chk_cmd; 
                
            elsif (data_i(2 downto 0)= "001") then 
                next_state <= s1; 
                
            elsif (data_i(2 downto 0)= "010") then
                next_state <= s2; 
                
            elsif (data_i(2 downto 0)= "011" ) then
                next_state <= s3;
                
            elsif (data_i(2 downto 0)= "100" ) then
                next_state <= s4;
                
            elsif (data_i(2 downto 0)= "101" ) then
                next_state <= s5;
                
            elsif (data_i(2 downto 0)= "110" ) then
                next_state <= s6;
                
            else
                next_state <= chk_cmd; 
            end if;         

                
        when s1 =>                -- we have to add a + b. In s1, data_i has op1. Now we need op2
            R0_s <= unsigned(data_i);
            next_state <= s1_get_op2; 
            
        when s1_get_op2 =>      -- we already have op1 from s1 in R0_s, now need op2 from s1_get_op2 state
            R0_s <= R0_s + unsigned(data_i);
            next_state <= chk_cmd;             
           
        when s2 =>      -- we have to add a - b. In s2, this is the 2nd time we are accesing data_i
            R0_s <= unsigned(data_i);  -- data_i has op1 this time which is "a". 
            next_state <= s2_get_op2; 
            
        when s2_get_op2 =>        -- we have to get "b", this is the 3rd time getting data_i.  
            R0_s <= R0_s - unsigned(data_i);  -- R0_s already has "a" in it.
            next_state <= chk_cmd;  
            
        when s3 =>      -- no 2nd or 3rd data_i req in this state. put R0_s -> 0, data_o is don't care
            R0_s <= (others=>'0');
            next_state <= chk_cmd;
            
        when s4 =>      -- keep R0_s unchanged
            R0_s <= R0_s;
            next_state <= chk_cmd;                 
            
        when s5 =>      -- R0_s + a, this is the 2nd time data_i is taken. 
            R0_s <= R0_s + unsigned(data_i);
            next_state <= chk_cmd; 
            
        when s6 =>      -- R0_s + a, this is the 2nd time data_i is taken. 
            R0_s <= R0_s - unsigned(data_i);
            next_state <= chk_cmd; 
                     
    end case;
end process;

output : process(cur_state)  -- output logic
begin 
    data_o <= std_logic_vector(R0_s);
    
    case cur_state is
        when s1_get_op2 =>
        vld_o <= '1';
        
        when s2_get_op2 =>
        vld_o <= '1';
        
        when s4 =>
        vld_o <= '1';  
        
        when others =>
        vld_o <= '0';      
    end case; 
end process;

end architecture rtl;
