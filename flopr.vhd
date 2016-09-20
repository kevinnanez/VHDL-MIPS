library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr is
	generic (width : integer := 32);
	port (q: out std_logic_vector(width-1 downto 0);
     	  d: in std_logic_vector(width-1 downto 0);
     	  clk, reset: in std_logic);
end flopr;

architecture flopr of flopr is
begin
	process (clk, reset) begin
		if (reset = '1') then
		    q <= (others => '0');
		else if (clk'event and clk='1') then
		    q <= d;
		end if;
		end if;
	end process;
end flopr;
