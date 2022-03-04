library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_computer is

end entity tb_computer;
architecture rtl of tb_computer is

  component computer is
    port (
      rst_i  : in  std_logic;
      clk_i  : in  std_logic;
      data_i : in  std_logic_vector(7 downto 0);
      vld_o  : out std_logic;
      data_o : out std_logic_vector(7 downto 0)
      );
  end component computer;

  type rom_t is array(0 to 15) of std_logic_vector(7 downto 0);
  signal rom : rom_t := ("00000011",    --  rst R0
                         "00000101",    --  R0 + 
                         "00000001",    --  1
                         "00000101",    --  R0 + 
                         "00000010",    --  2
                         "00000101",    --  R0 +
                         "00000011",    --  3
                         "00000101",    --  R0 +
                         "00000100",    --  4
                         "00000100",    --  read R0
                         "00000000",    --  nop
                         "00000000",    --  nop
                         "00000000",    --  nop
                         "00000000",    --  nop
                         "00000000",    --  nop
                         "00000000");   --  nop

  signal clk_s  : std_logic := '0';
  signal rst_s  : std_logic := '1';
  signal din_s  : std_logic_vector(7 downto 0);
  signal dout_s : std_logic_vector(7 downto 0);
  signal vld_s  : std_logic;
  signal cnt_s  : unsigned(3 downto 0);

begin  -- architecture rtl

  -- DUT
  DUT : computer
    port map (
      clk_i  => clk_s,
      rst_i  => rst_s,
      data_i => din_s,
      vld_o  => vld_s,
      data_o => dout_s);

  -- clock gen
  clk_s <= not clk_s after 5 ns;
  -- rst handling
  rst_s <= '0'       after 100 ns;
  process(clk_s) is
  begin
    if rising_edge(clk_s) then
      if rst_s = '1' then
        din_s <= (others => '0');
        cnt_s <= (others => '0');
      else
        cnt_s <= cnt_s + 1;
        din_s <= rom(to_integer(cnt_s));
      end if;  -- rst_s
    end if;  -- clk_s
  end process;

end architecture rtl;
