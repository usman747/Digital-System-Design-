library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sig_var is

  port (
    clk : in  std_logic;
    a   : in  std_logic;
    b   : in  std_logic;
    q   : out std_logic);
end entity sig_var;

architecture rtl of sig_var is
  signal tmp : std_logic;
begin  -- architecture rtl

   proc1 : process (clk) is
   begin  -- process proc1
     if (rising_edge(clk)) then   -- rising clock edge
       tmp <= a and b;
       q   <= tmp;
     end if;
   end process proc1;

--   proc2: process (clk) is
--   begin  -- process proc2
--     if (clk'event and clk = '1') then     -- rising clock edge
--       q <= tmp;
--       tmp <= a and b;
--     end if;
--   end process proc2;

--   proc3: process (clk) is
--     variable tmp : std_logic;
--   begin  -- process proc3
--     if (clk'event and clk = '1') then     -- rising clock edge
--       tmp := a and b;
--       q <= tmp;
--     end if;
--   end process proc3;

--  proc4: process (clk) is
--    variable tmp : std_logic;
--  begin  -- process proc4
--    if (clk'event and clk = '1') then     -- rising clock edge
--      q <= tmp;
--      tmp := a and b;
--    end if;
--  end process proc4;  

end architecture rtl;
