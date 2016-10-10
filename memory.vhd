library ieee;
library work;
use ieee.std_logic_1164.all;
use work.components.all;

entity memory is
    port (
        ReadDataM : out std_logic_vector(31 downto 0);
        MemWriteM, clk, dump : in std_logic;
        AluOutM, WriteDataM : in std_logic_vector(31 downto 0)
    );

end entity;

architecture behavior of memory is
begin

    memMIPS : dmem port map (
        a => AluOutM,
        wd => WriteDataM,
        clk => clk,
        we => MemWriteM,
        rd => ReadDataM,
        dump => dump
    );

end architecture;