library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic (width : integer := 32);
    port (a, b: in std_logic_vector(width-1 downto 0);
          y: out std_logic_vector(width-1 downto 0));
end adder;

architecture adder of adder is
    begin
    y <= std_logic_vector (unsigned(a) + unsigned(b));
end adder;
