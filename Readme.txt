Atención que imem y dmem fueron modificadas para nuevas versiones de ghdl!!

Agregar las siguientes líneas en el archivo package:

	constant MIPS_SOFT_FILE: string := "//<ruta>//mips.dat";
	constant MEMORY_DUMP_FILE: string := "mem.dump";

