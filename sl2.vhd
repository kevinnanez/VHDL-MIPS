library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sl2 is
  generic (width: integer := 32);
	port(
    a : in std_logic_vector(width - 1 downto 0);
    y : out std_logic_vector(width - 1 downto 0)
  );
end sl2;

architecture behavior of sl2 is
begin
    y <= a(width - 1 downto 2) & "00";
end behavior;
