library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity controller_tb is
end controller_tb;


architecture arq of controller_tb is

component controller
  port( Op, Funct : in std_logic_vector(5 downto 0);
      MemToReg, MemWrite, Branch, AluSrc,RegDst, RegWrite, Jump : out std_logic;
      AluControl: out std_logic_vector(2 downto 0)
      );
end component;

signal Op_s, Funct_s : std_logic_vector(5 downto 0);
signal MemToReg_s, MemWrite_s, Branch_s, AluSrc_s,RegDst_s, RegWrite_s, Jump_s : std_logic;
signal AluControl_s: std_logic_vector(2 downto 0);

begin

  contr: controller port map (
      Op => Op_s,
      Funct => Funct_s,
      MemToReg => MemToReg_s,
      MemWrite => MemWrite_s,
      Branch => Branch_s,
      AluSrc => AluSrc_s,
      RegDst => RegDst_s,
      RegWrite => RegWrite_s,
      Jump => Jump_s,
      AluControl => AluControl_s
    );

  process
    begin
      --caso others
      Op_s <= "000000";
      Funct_s <= "000000";
      wait for 10 ns;
      --caso aluop = 00
      Op_s <= "000010";
      Funct_s <= "000011";
      wait for 10 ns;
      --caso aluop(1) = 1
      Op_s <= "000000";
      Funct_s <= "100101";
      wait for 10 ns;
      assert false
        report "Listo." severity note;
      wait;
  end process;

end arq;

