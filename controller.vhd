library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
  port(Op, Funct : in std_logic_vector(5 downto 0);
      MemToReg, MemWrite, Branch, Alusrc,RegDst, RegWrite, Jump : out std_logic;
      AluControl: out std_logic_vector(2 downto 0)
      );
end controller;

architecture structural of controller is

  component maindec is
    port(Op : in std_logic_vector(5 downto 0);
    MemToReg, MemWrite, Branch, Alusrc, RegDst, RegWrite, Jump : out std_logic;
    AluOp: out std_logic_vector(1 downto 0));
  end component;

  component aludec is
    port(AluOp : in std_logic_vector(1 downto 0);
     Funct : in std_logic_vector(5 downto 0);
     AluControl : out std_logic_vector(2 downto 0));
  end component;

  signal AluOp_aux: std_logic_vector(1 downto 0);
  signal MemToReg_s, MemWrite_s, Branch_s, Alusrc_s, RegDst_s, RegWrite_s, Jump_s : std_logic;
  signal AluControl_s : std_logic_vector(2 downto 0);


  begin
    U1: maindec port map (Op,MemToReg=>MemToReg_s, MemWrite=>MemWrite_s, Branch=>Branch_s, Alusrc=>Alusrc_s, RegDst=>RegDst_s, RegWrite=>RegWrite_s, Jump=>Jump_s,
    AluOp=>AluOp_aux);
    U2: aludec port map(AluOp_aux,Funct,AluControl=>AluControl_s);

    MemToReg <= MemToReg_s;
    MemWrite <= MemWrite_s;
    Branch <= Branch_s;
    Alusrc <= Alusrc_s;
    RegDst <= RegDst_s;
    RegWrite <= RegWrite_s;
    Jump <= Jump_s;

end structural;
