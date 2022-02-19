library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lsr is  
  port (
    clk_i      : in  std_logic;
    rst_i      : in  std_logic;
    load_i     : in  std_logic;
    data_in_i  : in  std_logic_vector(7 downto 0);
    data_out_o : out std_logic_vector(7 downto 0));
end entity lsr;

architecture rtl of lsr is

signal temp_reg : std_logic_vector(7 downto 0) :=(others => '0');

begin  -- architecture rtl
    main_process : process(clk_i) is
    begin
        if rising_edge(clk_i) then
            if rst_i = '0' then
                if load_i = '0' then
                    temp_reg(0) <= '0'; --loading data
                    temp_reg(7 downto 1) <= data_in_i(6 downto 0);
                else
                    temp_reg <= data_in_i;
                end if;
            else
                temp_reg <= "00000000";
            end if;
         else
            --temp_reg <= (others => '0');
            temp_reg <= temp_reg;       
        end if; 
    end process main_process;
    data_out_o <= temp_reg;

end architecture rtl;
