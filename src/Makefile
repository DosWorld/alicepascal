
INC=../h

ALIB=/usr/local/lib/alice

INCLUDES = $(INC)/action.h $(INC)/alctype.h $(INC)/alice.h $(INC)/altypes.h\
$(INC)/bfuncs.h $(INC)/break.h $(INC)/class.h $(INC)/command.h\
$(INC)/dbflags.h $(INC)/esbuilt.h $(INC)/flags.h $(INC)/functions.h\
$(INC)/huff.h $(INC)/interp.h $(INC)/jump.h $(INC)/keyibm.h\
$(INC)/keys.h $(INC)/macros.h $(INC)/mem.h $(INC)/menu.h\
$(INC)/mess.h $(INC)/msdos.h $(INC)/node.h\
$(INC)/ole.h $(INC)/printt.h $(INC)/process.h $(INC)/scan.h\
$(INC)/search.h $(INC)/sym.h $(INC)/systemCall.h $(INC)/token.h\
$(INC)/treerot.h $(INC)/tune.h $(INC)/typecodes.h $(INC)/window.h\
$(INC)/workspace.h

IOBJS = trace.o run2.o runfile.o types.o setup.o interp.o runtime.o \
	typecheck.o functions.o cfunc.o fullfuncs.o
NIOBJS = nulli.o
COBJS = classes.o scan_decl.o common.o load_nodes.o
EOBJS=	main.o treesubr.o scan.o subr.o \
	window.o workspace.o search.o \
	pop.o menu.o menudat.o \
	load.o save.o \
	history.o mark.o text.o text2.o oledit.o ole.o keyboard.o \
	expparse.o cmds2.o \
	help.o helpfile.o alsym.o \
	treeprint.o output.o outfuncs.o display.o dump.o \
	command.o action.o actrout.o actrout2.o\
	builtin.o filename.o \
	mem.o kids.o mainloop.o colour.o

EXOBJS = runmsg.o editmsg.o

ASRCS=	main.c treesubr.c scan.c subr.c \
	window.c workspace.c search.c \
	helpfile.c help.c pop.c menu.c menudat.c types.c \
	load.c save.c \
	setup.c interp.c run2.c runfile.c functions.c runtime.c typecheck.c \
	history.c mark.c text.c text2.c ole.c oledit.c keyboard.c \
	expparse.c cmds2.c graphics.c

BSRCS= alsym.c scan_decl.c common.c \
	treeprint.c output.c outfuncs.c display.c dump.c \
	command.c action.c actrout.c actrout2.c\
	builtin.c filename.c \
	load_nodes.c trace.c fullfuncs.c classes.c \
	cfunc.c mem.c dd/segalloc.c

SRCS= $(ASRCS) $(BSRCS)

OBJS= $(EOBJS) $(IOBJS) $(COBJS)


CFLAGS=	 -g -I../h 

LFLAGS= -g

CPP = /lib/cpp -I../h -P -Dunix

alice:	$(EOBJS) $(IOBJS) $(COBJS) unix.o Makefile
	cc $(LFLAGS) $(EOBJS) $(IOBJS) $(COBJS) unix.o -o alice -lncurses -lm

install: alice
	cp ap.init ../tem/*.suf $(ALIB)
	cd ../help; make install


copysrc: $(SRCS) 
	echo $? | tr -s ' ' '\012' > /tmp/pfiles
	-dosmkdir A:\src
	wc $?
	doscp $? A:\src
	doscp /tmp/pfiles A:\src\pfiles
	touch copysrc

ptest.o: test/ptest.c
	ccL $(CFLAGS) -c test/ptest.c

ptest: pop.o ptest.o
	cc $(LFLAGS) pop.o ptest.o -o ptest -lcurses -ltermcap


/u/alice/h/pc_copy : $(INCLUDES)
	-dosmkdir A:\h
	doscp $? A:\h
	touch /u/alice/h/pc_copy

copyit: copysrc /u/alice/h/pc_copy 
	touch copyit

tiny:	$(EOBJS) $(NIOBJS) $(COBJS) unix.o
	-mv tiny otiny
	cc -i -Mm $(LFLAGS) $(EOBJS) $(NIOBJS) $(COBJS) unix.o -o tiny -lcurses -ltermcap

map:	map.o mload.o save.o
	cc $@ -o map

mload.o: mload.c
	cc $(CFLAGS) -DMAP -c mload.c

interp.o: ../h/interp.h ilowstates.c mlowstat.c interp.c
	cc $(CFLAGS) -c interp.c
	
a.out:	$(EOBJS) $(NOBJS) $(COBJS) unix.o
	cc $(LFLAGS) $(EOBJS) $(IOBJS) $(COBJS) unix.o
fast:	$(SRCS) unix.c
	cc -I../h -O -c $?
	cc -i $(LFLAGS) $(OBJS) unix.o -o a.out -lcurses -ltermcap

lint: $(SRCS) unix.c
	lint -I../h $(SRCS) unix.c -lcurses >lint.out

APOBJS= dload.o apdump.o load_nodes.o builtin.o

apdump: $(APOBJS)
	cc -Ml2 $(APOBJS) -o apdump

dload.o:
	cc $(CFLAGS) -DDUMP_LOAD -c dload.c

tags:	/tmp
	ctags $(INCLUDES)
	mv tags h_tags
	ctags $(ASRCS)
	mv tags a_tags
	ctags $(BSRCS)
	mv tags b_tags
	cat h_tags a_tags b_tags > /tmp/tags
	sort -u /tmp/tags > tags
	rm h_tags a_tags b_tags

$(SRCS) $(OBJS):$(.PRECIOUS)

objlist:
	@echo $(OBJS)

dumpnodes: dumpnodes.o nodes.o nodes2.o
	cc $(LFLAGS) dumpnodes.o nodes.o nodes2.o -o dumpnodes

srclist:
	@echo $(SRCS)
