library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr is
	generic (width : integer := 32); --variable "width" q es un entero de 32 bits // esto es como un define
port (
     q		:out std_logic_vector(width-1 downto 0);
     d		:in  std_logic_vector(width-1 downto 0);     -- up_down control for counter
     clk	:in  std_logic;                   	     -- Input clock
     reset	:in  std_logic                               -- Input reset
   );
end entity;

architecture behavior of flopr is
begin
process (clk, reset) begin
    if (reset = '1') then
        q <= (others => '0');
    else if (clk'event and clk='1') then
        q <= d;
    end if;
	end if;
end process;
end architecture;
