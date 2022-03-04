library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity stack is

  generic (
    ADDR_WIDTH : natural := 8;
    DATA_WIDTH : natural := 5);

  port (
    clk_i   : in  std_logic;
    push_i  : in  std_logic; -- 1 = push
    empty_i : out std_logic; -- 1 when stack is empty
    data_i  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    pop_i   : in  std_logic; -- 1 = pop
    full_o  : out std_logic; -- 1 when stack is full 
    data_o  : out std_logic_vector(DATA_WIDTH-1 downto 0));

end entity stack;

architecture rtl of stack is

type ram_type is array ((2**ADDR_WIDTH-1) downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0); -- for 8, mem is from 0 to 255
signal stack_mem : ram_type;
signal empty_s, full_s : std_logic;
signal sp : unsigned(ADDR_WIDTH downto 0) := (others => '0'); -- stack pointer, 255 full, 0 empty 
-- sp is 1 bit longer than memory, incrementing sp wraps it past the end. This is prevented by making SP one bit longer than needed to address the memory.
begin  -- architecture rtl

full_o <= full_s;
empty_i <= empty_s; 

--if sp(ADDR_WIDTH) = '1' then      -- IF ELSE can only be used inside process (Sequential), so when else or with select be used
--    full_s <= '1';
--else 
--    full_s <= '0';
--end if;

--if sp = '0' then
--    empty_s <= '1';
--else 
--    empty_s <= '0';
--end if;

full_s <= '1' when sp = 256 else -- Gen_Info: decimal values directly written in std_logic. For binary do this B"11111111"  (decimal value 255)
            '0';                -- sp is unsigned thats why
empty_s <= '1' when sp = 0 else
            '0';
                
process(clk_i)
begin
    if(rising_edge(clk_i)) then
        if(pop_i = '1' and empty_s = '0' and push_i = '0') then -- when pop signal is 1 and stack is not empty then we can retrive data
            sp <= sp - 1;  -- pop uses a decremented sp as given in text of question, wo retrive most recent saved item.. 
            data_o <= stack_mem(to_integer(sp));  -- ..As sp is always pointing on top of data, so sp-1 first then pop
        end if;
        
        if(push_i = '1' and full_s = '0' and pop_i = '0') then -- when push signal is 1 and stack is not full then we can put data
            stack_mem(to_integer(sp)) <= data_i;            
            sp <= sp + 1; --after adding data in sp, do the push ..as sp points above added data
        end if;
    end if;        
end process;

end architecture rtl;
