library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
generic (width : integer := 32);
port(ra1, ra2, wa3: in std_logic_vector(4 downto 0);
     wd3: in std_logic_vector(width - 1 downto 0);
     rd1, rd2: out std_logic_vector(width - 1 downto 0);
     clk, we3: in std_logic);
end regfile;

  signal mem : mem_type := (
    0 => x"abcdabcd",
    1 => x"12345678",
    others => x"11111111");


architecture arq of regfile is

    type imem_type is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal mem : imem_type := (
    others => x"00000000");


begin

process(clk, memory, ra1, ra2, we3, wa3, wd3)
begin

  if(clk'event and clk = '1' and we3 = '1') then
    memory(to_integer(unsigned(wa3))) <=  wd3;
  end if;

  if ra1 = "00000" then
    rd1 <= x"00000000";
  else
    rd1 <= memory(to_integer(unsigned(ra1)));
  end if;

  if ra2 = "00000" then
    rd2 <= x"00000000";
  else
    rd2 <= memory(to_integer(unsigned(ra2)));
  end if;

end process;

end arq;