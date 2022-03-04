library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity dual_port_ram is

  generic (
    ADDR_WIDTH : natural := 10;
    DATA_WIDTH : natural := 8);

  port (
    clk_i   : in  std_logic;
    wr_i    : in  std_logic; -- write enable, when 1 means want to write
    addra_i : in  std_logic_vector(ADDR_WIDTH-1 downto 0); -- address/location in port a
    da_i    : in  std_logic_vector(DATA_WIDTH-1 downto 0); -- data_in at port a
    rd_i    : in  std_logic; -- read enable, , when 1 means want to read
    addrb_i : in  std_logic_vector(ADDR_WIDTH-1 downto 0); --address/location in port a
    db_o    : out std_logic_vector(DATA_WIDTH-1 downto 0)); -- data_out at port a

end entity dual_port_ram;

architecture rtl of dual_port_ram is 

type block_ram is array ((2**ADDR_WIDTH-1) downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal bram_s: block_ram;
--attribute bram_style : string;
--attribute bram_style of bram_s : signal is "distributed";

begin  -- architecture rtl
-- we can also do this in one process, no issue 
write_proc: process(clk_i) is 
begin 
    if rising_edge(clk_i) then 
        if wr_i = '1' then -- if write enable/want to write  
            bram_s(TO_INTEGER(unsigned(addra_i))) <= da_i;  --assign input data to ram
        end if;
    end if;
end process write_proc;

read_proc: process(clk_i) is 
begin 
    if rising_edge(clk_i) then -- if read enable/want to read 
        if rd_i = '1' then 
            db_o <= bram_s(to_integer(unsigned(addrb_i)));  --assign ram data to ouput port
        end if;
    end if;  
end process read_proc;

end architecture rtl;
