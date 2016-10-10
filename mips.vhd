library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity mips is
  port(reset, clk, dump : in std_logic;
      Instr, pc : out std_logic_vector(31 downto 0)
      );
end entity;

architecture structural of mips is

  signal MemToReg_s, MemWrite_s, Branch_s, AluSrc_s, RegDst_s, RegWrite_s, Jump_s : std_logic;
  signal AluControl_s : std_logic_vector(2 downto 0);
  signal Instr_s : std_logic_vector(11 downto 0);

  begin
    U1: controller port map(
      Op => Instr_s(31 downto 26),
      Funct => Instr_s(5 downto 0),
      MemToReg => MemToReg_s,
      MemWrite => MemWrite_s,
      Branch => Branch_s,
      AluSrc => AluSrc_s,
      RegDst => RegDst_s,
      RegWrite => RegWrite_s,
      Jump => Jump_s,
      AluControl => AluControl_s);

    U2: datapath port map(
      reset, clk, dump,
      MemToReg => MemToReg_s,
      MemWrite => MemWrite_s,
      Branch => Branch_s,
      AluSrc => AluSrc_s,
      RegDst => RegDst_s,
      RegWrite => RegWrite_s,
      Jump => Jump_s,
      AluControl => AluControl_s,
      instr => Instr_s,
      pc => pc
    );

end structural;
