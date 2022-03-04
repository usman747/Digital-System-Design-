library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity fifo is
  generic (
    ADDR_WIDTH : natural := 10;
    DATA_WIDTH : natural := 8);

  port (
    clk_i   : in  std_logic;
    wr_i    : in  std_logic;  --if 1 means want to write, write enable
    di_i    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    rd_i    : in  std_logic;  --if 1 means want to read, read enable
    do_o    : out std_logic_vector(DATA_WIDTH-1 downto 0);
    empty_o : out std_logic; -- 1 means empty
    full_o  : out std_logic); -- 1 means full

end entity fifo;

architecture rtl of fifo is

type block_ram is array ((2**ADDR_WIDTH)-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);

signal bram_s : block_ram; -- FIFO buffer
signal rd_ptr_s : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0'); -- Read pointer
signal wr_ptr_s : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0'); -- Write pointer
signal full_s : std_logic := '0'; -- Full indicator 
signal empty_s : std_logic := '1'; -- Empty indicator 

begin  -- architecture rtl

fifo_proc : process(clk_i) is
begin
    if rising_edge(clk_i) then 
    
        if wr_i='1' and rd_i='1' then 
            bram_s(to_integer(wr_ptr_s)) <= di_i;     --write opeartion 
            wr_ptr_s <= wr_ptr_s + 1;             -- updating write pointer   
            do_o <= bram_s(to_integer(rd_ptr_s)); --read opearion
            rd_ptr_s <= rd_ptr_s + 1;            -- updating read pointer 
            
        elsif wr_i='1' and rd_i='0' then
            if full_s = '0' then   -- make sure buffer is not full
                bram_s(to_integer(wr_ptr_s)) <= di_i;  -- if buffer not full write operation happen and write poitner+1
                wr_ptr_s <= wr_ptr_s + 1;
                if wr_ptr_s = rd_ptr_s then  -- the advancement may make the buffer full, this happens when next value of.. 
                    full_s <= '1';       -- ..write pointer is equal to current value of read pointer. If this case, full=1.    
                end if;
                empty_s <= '0';  -- after write operation and counter increment, empty FF should be deasserted.
            end if;

        elsif wr_i='0' and rd_i='1' then
            if empty_s = '0' then  -- make sure buffer is not empty
                do_o <= bram_s(to_integer(rd_ptr_s)); -- if buffer not empty read operation happen and read poitner+1
                rd_ptr_s <= rd_ptr_s + 1;  
                if rd_ptr_s = wr_ptr_s then -- the advancement may make the buffer empty, this happens when next value of.. 
                    empty_s <= '1';  --..read pointer is equal to current value of write pointer. If this case, empty=1.
                end if;
                full_s <= '0'; -- after read operation and read counter increment, Full FF should be deasserted.
            end if;
       end if;
    end if;
        
end process fifo_proc;

empty_o <= empty_s;
full_o <= full_s;

end architecture rtl;
