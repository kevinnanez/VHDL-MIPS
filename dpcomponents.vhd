library ieee;
use ieee.std_logic_1164.all;

package dpcomponents is

    component fetch is
        port (
            Jump, PcSrcM, clk, reset : in std_logic;
            PcBranchM : in std_logic_vector(31 downto 0);
            InstrF, PCF, PcPlus4F : out std_logic_vector(31 downto 0)
        );
    end component;

    component decode is
        port(
            InstrD, ResultW : in std_logic_vector(31 downto 0);
            WriteRegW : in std_logic_vector(4 downto 0);
            RegWriteW, clk : in std_logic;
            Op, Funct : out std_logic_vector(5 downto 0);
            RD1, RD2 : out std_logic_vector(31 downto 0);
            RtD, RdD : out std_logic_vector(4 downto 0);
            SignImmD : out std_logic_vector(31 downto 0)
        );
    end component;

    component execute is
        port (
            RegDst, AluSrc : in std_logic;
            AluControl : in std_logic_vector(2 downto 0);
            RtE, RdE : in std_logic_vector(4 downto 0);
            RD1E, RD2E, PCPlus4E, SignImmE : in std_logic_vector(31 downto 0);
            ZeroE : out std_logic;
            WriteRegE : out std_logic_vector(4 downto 0);
            AluOutE, WriteDataE, PCBranchE : out std_logic_vector(31 downto 0)
        );
    end component;

    component memory is
        port (
            ReadDataM : out std_logic_vector(31 downto 0);
            MemWriteM, clk, dump : in std_logic;
            AluOutM, WriteDataM : in std_logic_vector(31 downto 0)
        );
    end component;

    component writeback is
        port (
            MemToReg : in std_logic;
            ResultW : out std_logic_vector(31 downto 0);
            AluOutW, ReadDataW : in std_logic_vector(31 downto 0)
        );
    end component;

end dpcomponents;
