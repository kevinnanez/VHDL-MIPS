library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity mips is
  port(reset, clk, dump : in std_logic;
      instr, pc : out std_logic_vector(31 downto 0)
      );
end entity;

architecture structural of mips is

  signal MemToReg_s, MemWrite_s, Branch_s, AluSrc_s, RegDst_s, RegWrite_s, Jump_s, dump_s, clk_s, reset_s : std_logic;
  signal AluControl_s : std_logic_vector(2 downto 0);
  signal instr_s, pc_s : std_logic_vector(31 downto 0);

  begin
    U1: controller port map(
      Op => instr_s(31 downto 26),
      Funct => instr_s(5 downto 0),
      MemToReg => MemToReg_s,
      MemWrite => MemWrite_s,
      Branch => Branch_s,
      AluSrc => AluSrc_s,
      RegDst => RegDst_s,
      RegWrite => RegWrite_s,
      Jump => Jump_s,
      AluControl => AluControl_s);

    U2: datapath port map(
      reset => reset_s,
      clk => clk_s,
      dump => dump_s,
      MemToReg => MemToReg_s,
      MemWrite => MemWrite_s,
      Branch => Branch_s,
      AluSrc => AluSrc_s,
      RegDst => RegDst_s,
      RegWrite => RegWrite_s,
      Jump => Jump_s,
      AluControl => AluControl_s,
      instr => instr_s,
      pc => pc
    );

end structural;
