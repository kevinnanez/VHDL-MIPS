library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity controller is
    port(
        Op, Funct : in std_logic_vector(5 downto 0);
        MemToReg, MemWrite, Branch, AluSrc,RegDst, RegWrite, Jump : out std_logic;
        AluControl: out std_logic_vector(2 downto 0)
    );
end controller;

architecture structural of controller is

  signal AluOp_aux: std_logic_vector(1 downto 0);
  signal MemToReg_s, MemWrite_s, Branch_s, AluSrc_s, RegDst_s, RegWrite_s, Jump_s : std_logic;

  begin
    U1: maindec port map (
        Op,MemToReg => MemToReg_s,
        MemWrite => MemWrite_s,
        Branch => Branch_s,
        AluSrc => AluSrc_s,
        RegDst => RegDst_s,
        RegWrite => RegWrite_s,
        Jump => Jump_s,
        AluOp => AluOp_aux
    );

    U2: aludec port map(
        Funct,
        AluOp_aux,
        alucontrol => AluControl
    );

    MemToReg <= MemToReg_s;
    MemWrite <= MemWrite_s;
    Branch <= Branch_s;
    AluSrc <= AluSrc_s;
    RegDst <= RegDst_s;
    RegWrite <= RegWrite_s;
    Jump <= Jump_s;

end structural;
