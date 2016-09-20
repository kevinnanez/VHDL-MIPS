library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

  entity regfile is
    generic (width : integer := 32);
    port(
      ra1       :in std_logic_vector(4 downto 0);
      ra2       :in std_logic_vector(4 downto 0);
      wa3       :in std_logic_vector(4 downto 0);
      rd1       :out std_logic_vector(width - 1 downto 0);
      rd2       :out std_logic_vector(width - 1 downto 0);
      wd3       :in std_logic_vector(width - 1 downto 0);
      clk       :in std_logic;
      we3       :in std_logic
    );
  end entity;

  architecture behavior of regfile is

  type mem_type is array (width - 1 downto 0) of std_logic_vector(width - 1 downto 0);

  signal mem : mem_type := (
    0 => x"abcdabcd",
    1 => x"12345678",
    others => x"11111111");

  begin
  process(clk, ra1, ra2)
  begin

  if clk'event and clk = '1' and we3 = '1' then
    mem(to_integer(unsigned(wa3))) <= wd3;
  end if;
  rd1 <= mem(to_integer(unsigned(ra1)));
  rd2 <= mem(to_integer(unsigned(ra2)));

  end process;
end behavior;
