library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all; -- This lib declars "conv_integer" 

entity single_port_ram is

  generic (
    MODE       : string  := "write_first";
    ADDR_WIDTH : natural := 10;
    DATA_WIDTH : natural := 8);

  port (
    clk_i  : in  std_logic;
    ce_i   : in  std_logic; --chip enable 
    wr_i   : in  std_logic; -- write signal 
    rd_i   : in  std_logic; -- read signal 
    addr_i : in  std_logic_vector(ADDR_WIDTH-1 downto 0); -- one addr because single port 
    data_i : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    data_o : out std_logic_vector(DATA_WIDTH-1 downto 0));

end entity single_port_ram;

architecture rtl of single_port_ram is

type ram_type is array(2**ADDR_WIDTH-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal RAM : ram_type;
signal mode_chk : std_logic;

begin  -- architecture rtl
mode_chk <= '1' when MODE = "write_first" else
            '0' when MODE = "read_first";
            
process(clk_i)
begin 
    if(rising_edge(clk_i)) then 
        if(ce_i = '1') then 
            if(wr_i = '1') then
                RAM(conv_integer(addr_i)) <= data_i;
            end if;
            
            if(rd_i = '1' and mode_chk = '1') then
                data_o <= data_i; -- input is reflected at the output as write first mode enabled 
            elsif(rd_i = '1' and mode_chk = '0') then
                data_o <= RAM(conv_integer(addr_i)); -- old content is read befpre new content loaded as in read first mode
            end if;
         end if;
     end if;            
end process;

-- ALSO SEE THE IMPLEMENTAION BELOW, its CLOSER to TEXT...though TA was saying sometheing...btw above one is Abdur Rehman's

--process(clk_i)
--begin 
--    if(rising_edge(clk_i)) then 
--        if(ce_i = '1') then 
--            if(mode_chk = '1') then --write first
--                if(wr_i = '1') then
--                    RAM(conv_integer(addr_i)) <= data_i;
--                    data_o <= data_i; --new content is immediately made available for reading 
--                elsif(rd_i = '1') then
--                    data_o <= RAM(conv_integer(addr_i));    
--                end if;
--            elsif(mode_chk = '0') then --read first 
--                if(wr_i = '1') then
--                    RAM(conv_integer(addr_i)) <= data_i;
--                    data_o <= RAM(conv_integer(addr_i)); -- I THINK THIS LINE SHOLD BE ABOVE ,,to satisfy,, OLD CONTENT IS READ BEFORE LOADING NEW CONTENT
--                elsif(rd_i = '1') then
--                    data_o <= RAM(conv_integer(addr_i));    
--                end if;   
--            end if;
--         end if;
--    end if;                     
--end process;

end architecture rtl;
