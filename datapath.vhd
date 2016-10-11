library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity datapath is
    port(
        MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump, dump : in std_logic;
        clk, reset : in std_logic;
        pc, instr : in std_logic_vector(31 downto 0)
    );
end entity;


architecture structural of datapath is

    signal InstrF_FD, InstrD_FD : std_logic_vector(31 downto 0);

begin
--Fetch
    fetchA : fetch port map (
        Jump => JumpM,
        PcScrM => PCSrcM,
        clk => clk,
        reset => reset,
        PcBranchM => PCBranchM,
        InstrF => Instr,
        PCF => PCPlus4D,
        PcPlus4F => PCPlus4F
    );
--FF Fe-De
    Instr_FF : flopr port map (
        reset => reset,
        clk => clk,
        d => InstrF,
        q => InstrD
    );

    PCPlus4_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => PCPlus4F, 
        q => PCPlus4D
    );
--Decode
    decodeA : decode port map (
        InstrD => InstrD,
        ResultW => ResultW,
        WriteRegW => WriteRegW,
        RegWriteW => RegWriteW,
        clk => clk,
        Op => Op,
        Funct => Funct,
        RD1 => RD1,
        RD2 => RD2,
        RtD => RtD,
        RdD => RdD,
        SignImmD => SignImmD
    );
--FF De-Ex
    RD1_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => RD1, 
        q => RD2E
    );

    RD2_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => RD2, 
        q => RD2E
    );

    Rt_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => RtD, 
        q => RtE
    );

    Rd_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => RdD, 
        q => RdE
    );

    Sign_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => SignImmD, 
        q => SignImmE
    );

    PCPlus41_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => PCPlus4D, 
        q => PCPlus4E
    );
--Execute
    executeA : execute port map (
        ZeroE => ZeroE,
        RegDst => RegDstE,
        AluSrc => ALUSrcE,
        RtE => RtE,
        RdE => RdE,
        AluControl => ALUControlE,
        WriteRegE => WriteRegE,
        RD1E => RD1E,
        RD2E => RD2E,
        PCPlus4E => PCPlus4E,
        SignImmE => SignImmE,
        AluOutE => ALUOutE,
        WriteDataE => WriteDataE,
        PCBranchE => PCBranchE
    );
--FF Ex-Mem
    Zero_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => ZeroE, 
        q => ZeroM
    );
    ALUOut_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => ALUOutE, 
        q => ALUOutM
    );
    WriteData_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => WriteDataE, 
        q => WriteDataM
    );
    WriteReg_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => WriteRegE, 
        q => WriteRegM
    );
    PCBranch_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => PCBranchE, 
        q => PCBranchM
    );
--Memory
    memoryA : memory port map (
        ReadDataM => ReadDataM,
        MemWriteM => MemWriteM,
        clk => clk,
        dump => dump,
        AluOutM => ALUOutM,
        WriteDataM => WriteDataM
    );
--FF Mem-Wr
    ALUOut1_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => ALUOutM, 
        q => ALUOutW
    );
    ReadData_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => ReadDataM, 
        q => ReadDataW
    );
    WriteReg_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => WriteRegM, 
        q => WriteRegW
    );
--Writeback
    writebackA : writeback port map (
        MemToReg => MemtoRegW,
        ResultW => ResultW,
        AluOutW => ALUOutW,
        ReadDataW => ReadDataW
    );

end architecture;
