library ieee;
use ieee.std_logic_1164.all;

package components is

    constant MIPS_SOFT_FILE: string := "mips.dat";
    constant MEMORY_DUMP_FILE: string := "mem.dump";

    component adder is
        port (
            a, b: in std_logic_vector(31 downto 0);
            y: out std_logic_vector(31 downto 0)
        );
    end component;

    component flopr1 is
        port (
            d: in std_logic;
            clk, reset: in std_logic;
            q: out std_logic
        );
    end component;

    component flopr is
        generic (width : integer := 32);
        port (
            d: in std_logic_vector(width-1 downto 0);
            clk, reset: in std_logic;
            q: out std_logic_vector(width-1 downto 0)
        );
    end component;

    component mux2 is
        generic (width : integer := 32);
        port (
            d0, d1: in std_logic_vector(width-1 downto 0);
            s: in std_logic; y: out std_logic_vector(width-1 downto 0)
        );
    end component;

    component imem is
        port(
            a: in std_logic_vector(5 downto 0);
            rd: out std_logic_vector(31 downto 0)
        );
    end component;

    component signext is
        port(a: in std_logic_vector (15 downto 0);
            y: out std_logic_vector (31 downto 0)
        );
    end component;

    component sl2 is
        generic (width : integer := 32);
        port(
            a: in std_logic_vector(width - 1 downto 0);
            y: out std_logic_vector(width - 1 downto 0)
        );
    end component;

    component alu is
        port(
            a, b: in std_logic_vector(31 downto 0);
            alucontrol: in std_logic_vector(2 downto 0);
            zero: out std_logic; result: out std_logic_vector(31 downto 0)
        );
    end component;

    component regfile is
        port(
            ra1, ra2, wa3: in std_logic_vector(4 downto 0);
            wd3: in std_logic_vector(31 downto 0);
            clk: in std_logic;
            we3: in std_logic;
            rd1, rd2: out std_logic_vector(31 downto 0)
        );
    end component;

    component dmem is
        port(
            a, wd: in std_logic_vector(31 downto 0);
            clk, we, dump: in std_logic;
            rd: out std_logic_vector(31 downto 0)
        );
    end component;

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

    component maindec is
      port (
          Op : in std_logic_vector(5 downto 0);
          MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump : out std_logic;
          AluOp: out std_logic_vector(1 downto 0)
      );
    end component;

    component aludec is
      port(
          funct : in std_logic_vector(5 downto 0);
          aluop : in std_logic_vector(1 downto 0);
          alucontrol : out std_logic_vector(2 downto 0)
      );
    end component;

    component datapath is
        port(
             clk, reset:        in  std_logic;
             MemToReg, Branch:   in  std_logic;
             AluSrc, RegDst:    in  std_logic;
             RegWrite, Jump:    in  std_logic;
             AluControl:        in  std_logic_vector(2 downto 0);
             pc:                out std_logic_vector(31 downto 0);
             instr:             out  std_logic_vector(31 downto 0);
             MemWrite: 			  in std_logic;
             dump:				  in std_logic
        );
    end component;

    component controller is
    port(
        Op, Funct:          in  std_logic_vector(5 downto 0);
        MemToReg, MemWrite: out std_logic;
        AluSrc:      		out std_logic;
        RegDst, RegWrite:   out std_logic;
        Jump:               out std_logic;
        Branch: 			out std_logic;
        AluControl:         out std_logic_vector(2 downto 0)
    );

    end component;

end components;
