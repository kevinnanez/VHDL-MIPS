library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity datapath is
    port(
        MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump, dump:  in std_logic;
        clk, reset: in std_logic;
        ALUControl: in std_logic_vector(2 downto 0);
        pc, instr: out std_logic_vector(31 downto 0)
    );
end entity;


architecture structural of datapath is
    signal InstrF_FD, InstrD_FD, PCBranchE, PCBranchM, PCPlus4F, PCPlus4D, PCPlus4E, InstrF, InstrD, ResultW, RD1D, RD2D, RD1E, RD2E, SignImmD,SignImmE, ALUOutE, ALUOutM, ALUOutW, WriteDataE, WriteDataM, ReadDataM, ReadDAtaW: std_logic_vector(31 downto 0);
    signal ZeroE, ZeroM, RegWriteE, RegWriteM, RegWriteW_D, MemtoRegE, MemtoRegM, MemtoRegW, MemWriteE, MemWriteM, JumpE, JumpM, BranchE, BranchM : std_logic;
    signal AluSrcE, RegDstE : std_logic;
    signal AluControlE : std_logic_vector(2 downto 0);
    signal Funct, Op: std_logic_vector(5 downto 0);
    signal RtD, RtE, RdD, RdE, WriteRegE, WriteRegM, WriteRegW: std_logic_vector(4 downto 0);
    signal andFetch : std_logic;

begin

    andFetch <= BranchM and ZeroM;

--Fetch
    fetchA : fetch port map (
        Jump => JumpM,
        PcSrcM => andFetch,
        clk => clk,
        reset => reset,
        PcBranchM => PCBranchM,
        InstrF => InstrF,
        PCF => pc,
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
        RegWriteW => RegWriteW_D,
        clk => clk,
        Op => Op,
        Funct => Funct,
        RD1 => RD1D,
        RD2 => RD2D,
        RtD => RtD,
        RdD => RdD,
        SignImmD => SignImmD
    );
--FF De-Ex
    RD1_FF : flopr port map (
        reset => reset, 
        clk => clk, 
        d => RD1D, 
        q => RD2E
    );

    RD2_FF : flopr port map (
        reset => reset, 
        clk => clk,
        d => RD2D, 
        q => RD2E
    );

    Rt_FF : flopr generic map(width => 5) port map (
        reset => reset, 
        clk => clk, 
        d => RtD, 
        q => RtE
    );

    Rd_FF : flopr generic map(width => 5) port map (
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
--Blue FF
    BRegWrite_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => RegWrite,
        q => RegWriteE
    );
    BMemtoReg_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => MemtoReg,
        q => MemtoRegE
    );
    BMemWrite_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => MemWrite,
        q => MemWriteE
    );
    BJump_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => Jump,
        q => JumpE
    );
    BBranch_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => Branch,
        q => BranchE
    );
    BALUControl_FF : flopr generic map(width => 3) port map (
        reset => reset,
        clk => clk,
        d => ALUControl,
        q => ALUControlE
    );
    BALUSrc_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => AluSrc,
        q => AluSrcE
    );
    BRegDst_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => RegDst,
        q => RegDstE
    );

--Execute
    executeA : execute port map (
        ZeroE => ZeroE,
        RegDst => RegDstE,
        AluSrc => AluSrcE,
        RtE => RtE,
        RdE => RdE,
        AluControl => AluControlE,
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
    Zero_FF : flopr1 port map (
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
    WriteReg_FF : flopr generic map(width => 5) port map (
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
--Blue FF
    BRegWrite2_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => RegWriteE,
        q => RegWriteM
    );
    BMemtoReg2_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => MemtoRegE,
        q => MemtoRegM
    );
    BMemWrite2_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => MemWriteE,
        q => MemWriteM
    );
    BJump2_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => JumpE,
        q => JumpM
    );
    BBranch2_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => BranchE,
        q => BranchM
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
    WriteReg_FF1 : flopr generic map(width => 5) port map (
        reset => reset, 
        clk => clk, 
        d => WriteRegM, 
        q => WriteRegW
    );
--Blue FF
    BRegWrite3_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => RegWriteM,
        q => RegWriteW_D
    );
    BMemtoReg3_FF : flopr1 port map (
        reset => reset,
        clk => clk,
        d => MemtoRegM,
        q => MemtoRegW
    );
--Writeback
    writebackA : writeback port map (
        MemToReg => MemToRegW,
        ResultW => ResultW,
        AluOutW => ALUOutW,
        ReadDataW => ReadDataW
    );

end architecture;
