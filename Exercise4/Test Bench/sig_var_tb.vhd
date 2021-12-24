library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
entity sig_var_tb is

end entity sig_var_tb;

-------------------------------------------------------------------------------

architecture sim of sig_var_tb is

  component sig_var is
    port (
      clk : in  std_logic;
      a   : in  std_logic;
      b   : in  std_logic;
      q   : out std_logic);
  end component sig_var;

  -- component ports
  signal clk : std_logic := '0';
  signal a   : std_logic;
  signal b   : std_logic;
  signal q   : std_logic;

  signal cnt : std_logic_vector(1 downto 0) := (others => '0');

begin  -- architecture sim

  -- clock generation
  clk <= not clk after 10 ns;
  -- component instantiation
  DUT : sig_var
    port map (
      clk => clk,
      a   => a,
      b   => b,
      q   => q
      );


  process (clk) is
  begin  -- process
    if (clk'event and clk = '1') then   -- rising clock edge
      cnt <= std_logic_vector(unsigned(cnt) + 1);
    end if;
  end process;

  a <= cnt(0);
  b <= cnt(1);

end architecture sim;

-------------------------------------------------------------------------------
