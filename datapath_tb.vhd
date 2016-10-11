library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.components.flopr;
use work.dpcomponents.all;

entity datapath_tb is
end datapath_tb;

architecture data of datapath_tb is

  component datapath
    port(
        MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump, dump : in std_logic;
        clk, reset : in std_logic;
        pc, instr : in std_logic_vector(31 downto 0)
        );

end component;

signal MemToReg_s, MemWrite_s, Branch_s, AluSrc_s, RegDst_s, RegWrite_s, Jump_s, dump_s : in std_logic;
signal clk_s, reset_s : in std_logic;
signal pc_s, instr_s : in std_logic_vector(31 downto 0);

begin

  port map (
    MemToReg => MemToReg_s,
    MemWrite => MemWrite_s,
    Branch => Branch_s,
    AluSrc => AluSrc_s,
    RegDst => RegDst_s,
    RegWrite => RegWrite_s,
    Jump => Jump_s,
    clk => clk_s,
    reset => reset_s,
    pc => pc_s,
    instr => instr_s
    );

  process

    begin
  end process;

end data;
