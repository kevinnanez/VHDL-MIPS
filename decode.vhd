library ieee;
library work;
use ieee.std_logic_1164.all;
use work.components.all;

entity decode is
    port(
        InstrD, ResultW : in std_logic_vector(31 downto 0);
        WriteRegW : in std_logic_vector(4 downto 0);
        RegWriteW, clk : in std_logic;
        Op, Funct : out std_logic_vector(5 downto 0);
        RD1, RD2 : out std_logic_vector(31 downto 0);
        RtD, RdD : out std_logic_vector(4 downto 0);
        SignImmD : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of decode is
begin

    Op <= InstrD(31 downto 26);
    Funct <= InstrD(5 downto 0);
    RtD <= InstrD(20 downto 16);
    RdD <= InstrD(15 downto 11);

    regfileD : regfile port map (
        ra1 => InstrD(25 downto 21),
        ra2 => InstrD(20 downto 16),
        wa3 => WriteRegW,
        wd3 => ResultW,
        we3 => RegWriteW,
        clk => clk,
        rd1 => RD1,
        rd2 => RD2
    );

    signextD : signext port map (
        a => InstrD(15 downto 0),
        y => SignImmD
    );
end architecture;