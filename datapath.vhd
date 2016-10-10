library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity datapath is
    port(
        MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump, AluSrc, dump : in std_logic;
        clk, reset : in std_logic;
        pc, instr : in std_logic_vector(31 downto 0)
    );
end entity;


architecture structural of datapath is

    signal InstrF_FD, InstrD_FD : std_logic_vector(31 downto 0);

begin

    fetchA : fetch port map (
        Jump => ,
        PcScrM => ,
        clk => clk,
        reset => reset,
        PcBranchM => ,
        InstrF => ,
        PCF => ,
        PcPlus4F =>
    );

    Instr_FF : flopr port map (
        reset => reset,
        clk => clk,
        d => InstrF,
        q => InstrD
    );
    PCPlus_FF : flopr port map (reset => reset, clk => clk, d => PCPlus4F, q => PCPlus4D);

    decodeA : decode port map (
        InstrD => ,
        ResultW => ,
        WriteRegW => ,
        RegWriteW => ,
        clk => ,
        Op => ,
        Funct => ,
        RD1 => ,
        RD2 => ,
        RtD => ,
        RdD => ,
        SignImmD => 
    );

    executeA : execute port map (
        ZeroE => ,
        RegDst => ,
        AluSrc => ,
        RtE => ,
        RdE => ,
        AluControl => ,
        WriteRegE => ,
        RD1E => ,
        RD2E => ,
        PCPlus4E => ,
        SignImmE => ,
        AluOutE => ,
        WriteDataE => ,
        PCBranchE =>
    );

    memoryA : memory port map (
        ReadDataM => ,
        MemWriteM => ,
        clk => ,
        dump => ,
        AluOutM => ,
        WriteDataM => 
    );

    writebackA : writeback port map (
        MemToReg => ,
        ResultW => ,
        AluOutW => ,
        ReadDataW => 
    );

end architecture;