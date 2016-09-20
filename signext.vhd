library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signext is
port(
    a : in std_logic_vector (15 downto 0);
    y : out std_logic_vector (31 downto 0)
  );
end signext;

architecture behavior of signext is
begin  -- process se usa cuando necesito algo secuencial, si tengo 1 sola instruccion no hace falta crearlo
    y <= std_logic_vector(resize(signed(a), y'length));
end behavior;
