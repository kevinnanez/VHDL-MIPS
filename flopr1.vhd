library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr1 is
    generic (width : integer := 32);
    port (clk, reset: in std_logic;
                d: in std_logic;
                q: out std_logic
                );
end flopr1;

architecture flopr of flopr1 is
begin
    process (clk, reset) begin
        if (reset = '1') then
            q <= '0';
        else if (clk'event and clk='1') then
            q <= d;
        end if;
        end if;
    end process;
end flopr;
