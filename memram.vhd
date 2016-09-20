library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
  generic(width: integer := 32);
  port(a, wd : in std_logic_vector(width-1 downto 0);
    clk, we : in std_logic;
    rd : out std_logic_vector(width-1 downto 0)
  );
end ram;

architecture behavior of ram is

  signal

begin

end architecture;
