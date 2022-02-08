program {+ Ignored Name} ;

var
	fileptr : text;

{+Class Declarations}{+Revealed +I turbolib.pas}
procedure CrtExit ;
	{Don't use all these routines at once -- back this up and delete} 
	{the ones you don't need to save space.} 
	{a merge file with all kinds of turbo compat routines} 
	{ No action needed on IBM-PC } 
	{+ Declarations}
    begin
	{+ Statement}
    end;
procedure CrtInit ;
	{ No action needed on IBM-PC } 
	{+ Declarations}
    begin
	{+ Statement}
    end;
function Hi(value: integer) : integer;
	
	{+ Declarations}
    begin
	Hi := value shr 8;
    end;
function Lo(value: integer) : integer;
	
	{+ Declarations}
    begin
	Lo := value and $ff;
    end;
function Swap(value: integer) : integer;
	
	{+ Declarations}
    begin
	Swap := (value shl 8) or (value shr 8);
    end;
procedure NoSound ;
	
	{+ Declarations}
    begin
	Sound(0);
    end;
function WhereX  : integer;
	
	{+ Declarations}
    begin
	WhereX := ScrXY(-2) + 1;
    end;
function WhereY  : integer;
	
	{+ Declarations}
    begin
	WhereY := ScrXY(-1) + 1;
    end;
const
	Black = 0;
	Blue = 1;
	Green = 2;
	Cyan = 3;
	Red = 4;
	Magenta = 5;
	Brown = 6;
	LightGray = 7;
	DarkGray = 8;
	LightBlue = 9;
	LightGreen = 10;
	LightCyan = 11;
	LightRed = 12;
	LightMagenta = 13;
	Yellow = 14;
	White = 15;
	Blink = 16;

const
	BW40 = 0;
	C40 = 1;
	BW80 = 2;
	C80 = 3;
	Mono = 7;

const
	cp_do_undef = 77;
	undef_set = 1;

const
	long_divide = 2;
	l_real_result = 16;

type
	filerecord = record
		boring : integer;
		stream : Pointer;
		flags : integer;
		itemsize : integer;
		name : Pointer;
		buffer : char;
	    end;
	filerecpointer = ^filerecord;
	longint = record
		low, high : integer;
	    end;

type
	largestring = string [120];

type
	untyped_block = array[0..127] of byte;
	Blockfile = file of untyped_block;

type
	registers8086 = record
		case Boolean of
		false : (
			ax, bx, cx, dx, bp, si, di, ds, es, Flags : integer;
		    )
		true : (
			al, ah, bl, bh, cl, ch, dl, dh : Byte;
		    )
		{end variant part}
	    end;

procedure MSDos(registers: Generic);
	
	const
		CC_RECORD = 12;
	
	var
		sizevar : registers8086;
	
    begin
	if registers.TypeCode <> CC_RECORD then begin
		writeln('MsDos - argument must be a record');
		Halt ;
	    end;
	{ delete this test if you really want to take an arg that small } 
	if registers.Size < SizeOf(sizevar) then begin
		writeln('MsDos: Warning: argument record too small to receive result');
	    end;
	Intr($21, registers.Object^);
    end;
function Checkfile(pname: largestring; var vargen: Generic) : filerecpointer;
	{ Check that the generic is a file variable, and return pointer to file } 
	{ record } 
	const
		CC_FILE = 11;
	
    begin
	if vargen.TypeCode <> CC_FILE then begin
		writeln(pname, ' - argument must be a file variable');
		Halt ;
	    end;
	Checkfile := vargen.Object;
    end;
procedure erase(filevar: Generic);
	
	var
		thefile : filerecpointer;
	
    begin
	thefile := Checkfile('Erase', filevar);
	if CIntFunc(67, thefile^.name) <> 0 then begin
		writeln('Erase - cannot delete file');
		Halt ;
	    end;
    end;
procedure Flush(filevariable: Generic);
	
	var
		thefile : filerecpointer;
	
    begin
	thefile := Checkfile('Flush', filevariable);
	if thefile^.stream <> nil then begin
		CProc(36, thefile^.stream);
	    end;
    end;
procedure randomize ;
	
	var
		seconds : registers8086;
	
	{ dos get time function } 
    begin
	seconds.ah := $2C;
	Intr($21, seconds);
	initrandom(abs(seconds.dx), maxint);
	{ watcom random seeding function } 
    end;
function dseg  : integer;
	
	var
		i : integer;
	
    begin
	dseg := address(i, 1);
    end;
function sseg  : integer;
	
	var
		i : integer;
	
    begin
	sseg := address(i, 1);
    end;
function Addr(Name: Generic) : Pointer;
	
	{+ Declarations}
    begin
	Addr := Name.Object;
    end;
function Ptr(seg, offs: integer) : Pointer;
	
	{+ Declarations}
    begin
	if seg <> dseg  then begin
		writeln('Ptr : Sorry, segment must be data segment');
		Halt ;
	    end;
	Ptr := RawPointer(offs);
    end;
function Ofs(Name: Generic) : integer;
	
	{+ Declarations}
    begin
	Ofs := address(Name.Object^);
    end;
function Seg(Name: Generic) : integer;
	
	{+ Declarations}
    begin
	Seg := address(Name.Object^, 1);
    end;
procedure Move(var fromvar, tovar; Bytes: integer);
	
	var
		dataseg : integer;
	
    begin
	dataseg := dseg ;
	CProc(66, tovar, dataseg, fromvar, dataseg, Bytes);
	CProc(cp_do_undef, tovar, undef_set, Bytes);
	{ mark as initialized } 
    end;
procedure FillChar(var Var_to_fill; Bytes: integer; Filler: Generic);
	{ do the fill } 
	const
		CC_ORDVAL = 14;
	
	var
		Fillbyte : Byte;
	
    begin
	if (Filler.TypeCode and 31) < 3 then begin
		Fillbyte := ord(Filler.Object^);
	    end
	 else begin
		if Filler.TypeCode and 31 = CC_ORDVAL then begin
			Fillbyte := Filler.Integer;
		    end
		 else begin
			writeln('FillChar - need a byte-sized value');
			Halt ;
		    end;
	    end;
	CProc(57, Var_to_fill, Fillbyte, Bytes);
	CProc(cp_do_undef, Var_to_fill, undef_set, Bytes);
	{ mark as initialized } 
    end;
procedure Rename(filevar: Generic; newname: largestring);
	
	var
		thefile : filerecpointer;
		doscall : registers8086;
		dataseg : integer;
		textptr : ^text;
	
    begin
	thefile := Checkfile('Rename', filevar);
	{ set up pointers to old and new name } 
	doscall.ah := $56;
	{ old name found in file record } 
	doscall.dx := address(thefile^.name^);
	dataseg := dseg ;
	doscall.ds := dataseg;
	{ new name provided for us } 
	doscall.di := address(newname[1]);
	doscall.es := dataseg;
	Intr($21, doscall);
	if doscall.Flags and 1 <> 0 then begin
		writeln('Rename to ', newname, ' failed');
		Halt ;
	    end;
	textptr := filevar.Object;
	Assign(textptr^, newname);
    end;
function FilePos(filevar: Generic) : integer;
	
	var
		thefile : filerecpointer;
		seekret : ^longint;
		rval : longint;
	
    begin
	thefile := Checkfile('FilePos', filevar);
	{ perform ftell operation on C stream } 
	seekret := CLongFunc(56, thefile^.stream);
	{ do long divide } 
	CProc(2, long_divide, seekret^.low, seekret^.high, thefile^.itemsize, 0, rval);
	if (rval.high <> 0) or (rval.low < 0) then begin
		{ check that it is still in integer range } 
		writeln('filepos - position out of integer bounds');
		Halt ;
	    end;
	FilePos := rval.low;
    end;
procedure ChDir(directory: largestring);
	
	var
		regs : registers8086;
	
    begin
	if (Length(directory) >= 2) and (directory[2] = ':') then begin
		{ if drive prefix change default drive } 
		regs.dx := ord(directory[1]) and 15 - 1;
		Delete(directory, 1, 2);
		regs.ah := $E;
		Intr($21, regs);
	    end;
	{ change directory with cproc } 
	CProc(75, directory);
    end;
procedure MkDir(directory: largestring);
	
	var
		regs : registers8086;
	
	{ make pointer to directory string and call dos function } 
    begin
	regs.ds := dseg ;
	regs.ah := $39;
	regs.dx := address(directory[1]);
	Intr($21, regs);
	if regs.Flags and 1 <> 0 then begin
		writeln('Error: Could not make directory ', directory);
		Halt ;
	    end;
    end;
procedure RmDir(directory: largestring);
	
	var
		regs : registers8086;
	
	{ make pointer to directory string and call dos function } 
    begin
	regs.ah := $3A;
	regs.ds := dseg ;
	regs.dx := address(directory[1]);
	Intr($21, regs);
	if regs.Flags and 1 <> 0 then begin
		writeln('Error: Could not remove directory ', directory);
		Halt ;
	    end;
    end;
procedure GetDir(drive: integer; directory: Generic);
	
	const
		CC_STRING = 6;
	
	var
		dirstr : ^largestring;
	
    begin
	if directory.TypeCode <> CC_STRING then begin
		writeln('GetDir - argument must be a string variable');
		Halt ;
	    end;
	dirstr := directory.Object;
	{ get the directory } 
	CProc(76, dirstr^, drive);
	CProc(cp_do_undef, dirstr, undef_set, directory.Size);
	{ mark the string as defined } 
	dirstr^[0] := chr(StrLen(dirstr^));
	{ set the length byte } 
    end;
procedure Mark(ptrvar: Generic);
	
	var
		p : Pointer;
		pp : ^Pointer;
	
    begin
	GetMem(p, 1);
	pp := ptrvar.Object;
	pp^ := p;
	FreeMem(p, 1);
    end;
procedure Release(ptrvar: Pointer);
	
	var
		p : Pointer;
		size : integer;
	
    begin
	GetMem(p, 1);
	size := address(p^) - address(ptrvar^);
	{ if the user has been clean, this frees it all } 
	{ in case the turkey calls release right after mark } 
	if size > 0 then begin
		FreeMem(ptrvar, address(p^) - address(ptrvar^));
	    end;
	FreeMem(p, 1);
    end;
procedure BlockRead(filevar: Generic; variable: Generic; records: integer);
	{ This does the Turbo block read on any type of file.  It does not } 
	{ have the optional fourth parameter that gives a result code.  It is } 
	{ easy for the user to add it. } 
	var
		thefile : filerecpointer;
		res : integer;
	
    begin
	thefile := Checkfile('BlockRead', filevar);
	if records*128 > variable.Size then begin
		writeln('Blockread - variable isn''t large enough for ', records, ' records');
		Halt ;
	    end;
	res := CIntFunc(58, variable.Object, 128, records, thefile^.stream);
	{ mark defined } 
	CProc(cp_do_undef, variable.Object, undef_set, 128*records);
	{ res contains the number of items written } 
    end;
procedure BlockWrite(filevar: Generic; variable: Generic; records: integer);
	{;var code : integer } 
	{ This does the Turbo block write on any type of file.  It does not } 
	{ have the optional fourth parameter that gives a result code.  It is } 
	{ easy for the user to add it. } 
	var
		thefile : filerecpointer;
		res : integer;
	
    begin
	thefile := Checkfile('BlockWrite', filevar);
	{ one could check the data for being undefined if desired } 
	res := CIntFunc(59, variable.Object, 128, records, thefile^.stream);
	{ res contains the number of items written } 
	{ code := res; } 
    end;
procedure LongSeek(filevar: Generic; seekpos: real);
	
	var
		thefile : filerecpointer;
		poslow, poshigh : integer;
		realpos : real;
		lowpart : real;
	
    begin
	thefile := Checkfile('LongSeek', filevar);
	realpos := seekpos*thefile^.itemsize;
	{ make a long from a real } 
	poshigh := trunc(realpos/65536.0);
	lowpart := realpos - (poshigh*65536.0);
	if lowpart >= 32768.0 then begin
		poslow := trunc(lowpart - 65536.0);
	    end
	 else begin
		poslow := trunc(lowpart);
	    end;
	CProc(35, thefile^.stream, poslow, poshigh, 0);
	{ now we have the long integer } 
	thefile^.flags := thefile^.flags or $10;
	{ set lazy read bit } 
    end;
function LongFilePosition(filevar: Generic) : real;
	
	var
		thefile : filerecpointer;
		seekret : ^longint;
		rval : real;
	
    begin
	thefile := Checkfile('LongFilePos', filevar);
	{ perform ftell operation on C stream } 
	seekret := CLongFunc(56, thefile^.stream);
	{ do long divide add 16 to function number for real result } 
	CProc(2, 16 + 2, seekret^.low, seekret^.high, thefile^.itemsize, 0, MakePointer(
	rval));
	LongFilePosition := rval;
	{ check that it is still in integer range } 
    end;
function FileSize(filevar: Generic) : integer;
	
	var
		thefile : filerecpointer;
		sizeret : ^longint;
		filenumber : integer;
		rval : longint;
	
    begin
	thefile := Checkfile('FileSize', filevar);
	{ get integer file handle } 
	filenumber := CIntFunc(78, thefile^.stream);
	{ ask for size of that file in bytes } 
	sizeret := CLongFunc(71, filenumber);
	writeln(filenumber, sizeret^.low, sizeret^.high, thefile^.itemsize);
	CProc(2, long_divide, sizeret^.low, sizeret^.high, thefile^.itemsize, 0, rval);
	if (rval.high <> 0) or (rval.low < 0) then begin
		{ check that it is still in integer range } 
		writeln('FileSize - position out of integer bounds');
		Halt ;
	    end;
	FileSize := rval.low;
    end;
function LongFileSize(filevar: Generic) : real;
	
	var
		thefile : filerecpointer;
		sizeret : ^longint;     {return from file length function, long}
		filenumber : integer;   {file handle of stream}
		rval : real;
	
    begin
	thefile := Checkfile('LongFileSize', filevar);
	{ get integer file handle } 
	filenumber := CIntFunc(78, thefile^.stream);
	{ ask for size of that file in bytes } 
	sizeret := CLongFunc(71, filenumber);
	CProc(2, long_divide + l_real_result, sizeret^.low, sizeret^.high, thefile^.
	itemsize, 0, MakePointer(rval));
	LongFileSize := rval;
	{ check that it is still in integer range } 
    end;
function SeekEoln(textfile: Generic) : Boolean;
	
	var
		txfile : ^text;
		dummy : filerecpointer;
	
    begin
	dummy := Checkfile('SeekEoln', textfile);
	txfile := textfile.Object;
	while not eoln(txfile^) and ((txfile^^ = ' ') or (txfile^^ = #9)) do begin
		get(txfile^);
	    end;
	SeekEoln := eoln(txfile^);
    end;
function SeekEof(textfile: Generic) : Boolean;
	
	var
		txfile : ^text;
		dontquit : Boolean;
		dummy : filerecpointer;
	
    begin
	dummy := Checkfile('SeekEof', textfile);
	txfile := textfile.Object;
	dontquit := true;
	while dontquit do begin
		{ dare not access the buffer char on eof as it is undefined } 
		if eof(txfile^) then begin
			dontquit := false;
		    end
		 else begin
			dontquit := txfile^^ in [' ', #9, #13, #10];
		    end;
	    end;
	SeekEof := eof(txfile^);
    end;
const
	got_command_line : Boolean = false;
	Maximum_args = 20;

var
	command_line_string : largestring;
	argpos_index : array [0..Maximum_args] of integer;
	argument_lengths : array [0..Maximum_args] of integer;
	I_ParamCount : integer;

procedure getparline ;
	{This routine gets a line of command line arguments} 
	var
		stpos : integer;
		whatreading : (whitespace, characters);
	
    begin
	if not got_command_line then begin
		CProc(14, 'Command Line? ', command_line_string, SizeOf(command_line_string));
		CProc(cp_do_undef, MakePointer(command_line_string), undef_set, SizeOf(
		command_line_string));
		StrConcat(command_line_string, ' ');
		I_ParamCount := 0;
		whatreading := whitespace;
		for stpos := 1 to StrLen(command_line_string) do begin
			if command_line_string[stpos] in [' ', #9] then begin
				if whatreading = characters then begin
					{first bit of white space after an arg} 
					argument_lengths[I_ParamCount] := stpos - argpos_index[I_ParamCount];
					I_ParamCount := I_ParamCount + 1;
				    end;
				whatreading := whitespace;
			    end
			 else begin
				if whatreading = whitespace then begin
					{ first chars after white space } 
					argpos_index[I_ParamCount] := stpos;
				    end;
				whatreading := characters;
			    end;
		    end;
		got_command_line := true;
	    end;
    end;
function ParamStr(argnum: integer) : largestring;
	{return a string from the parsed command line } 
	{+ Declarations}
    begin
	getparline ;
	if (argnum > I_ParamCount) or (argnum < 1) then begin
		ParamStr := ' ';
	    end
	 else begin
		ParamStr := Copy(command_line_string, argpos_index[argnum - 1], argument_lengths[
		argnum - 1]);
	    end;
    end;
function ParamCount  : integer;
	{return the number of parameters on the command line} 
	{+ Declarations}
    begin
	getparline ;
	ParamCount := I_ParamCount;
    end;
{+Hide end}
begin
{+ Statement}
end.
