library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity procs is

  port (
    A   : in  std_logic;
    B   : in  std_logic;
    c   : in  std_logic;
    D   : in  std_logic;
    SEL : in  std_logic;
    Z   : out std_logic);
end entity procs;

architecture rtl of procs is

begin  -- architecture rtl
--  proc1 : process (A, B, SEL) is
--  begin  -- process proc1
--    Z <= B;
--    if (SEL = '1') then
--      Z <= A;
--    end if;
--  end process proc1;

--   proc2 : process is
--   begin  -- process proc2
--     Z <= B;
--     if (SEL = '1') then
--       Z <= A;
--     end if;
--   end process proc2;

   proc3 : process(C) is
   begin  -- process proc3
     -- Z <= B;
     Z <= C and D;
     --if (SEL = '1') then
      -- Z <= A;
    -- end if;
   end process proc3;
--   proc4 : process is
--   begin  -- process proc4
--     if (SEL = '1') then
--       Z <= A;
--     end if;
--     Z <= B;
--   end process proc4;

end architecture rtl;
