library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity procs_tb is

end entity procs_tb;

-------------------------------------------------------------------------------

architecture sim of procs_tb is

  component procs is
    port (
      A   : in  std_logic;
      B   : in  std_logic;
      C   : in  std_logic;
      D   : in  std_logic;
      SEL : in  std_logic;
      Z   : out std_logic);
  end component procs;

  -- component ports
  signal A   : std_logic;
  signal B   : std_logic;
  signal C   : std_logic;
  signal D   : std_logic;
  signal SEL : std_logic;
  signal Z   : std_logic;

  signal cnt : std_logic_vector(2 downto 0) := (others => '0');

begin  -- architecture sim

  -- component instantiation
  DUT : procs
    port map (
      A   => A,
      B   => B,
         C   => C,
            D   => D,
      SEL => SEL,
      Z   => Z);

  stim_proc : process is
  begin  -- process stim_proc
    if (cnt = (cnt'range => '1')) then
      wait;
    else
      cnt <= std_logic_vector(unsigned(cnt) + 1);
      wait for 20 ns;
    end if;
  end process stim_proc;

  D   <= cnt(0);
  --B   <= cnt(1);
  --SEL <= cnt(2);

end architecture sim;

-------------------------------------------------------------------------------
