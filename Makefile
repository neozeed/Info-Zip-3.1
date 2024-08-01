# Makefile for unzip
# v3.07+ Added Amdahl (IBM) mainframe
#	 Removed casual suggestion to define NOTINT16 if in doubt.
#	 Turns out we can't be all THAT casual about it!	
# v3.07+ Added IBM RT 6150 under AIX 2.2.1
# v3.06+ Changed "make sun4_110" back to "make sun4" (to match SYSTEMS list
#	 and since we don't have any other sun4 arguments yet).
# v3.06+ Added VAX 8600/Ultrix, DEC 5820/Ultrix test v4.0
# v3.05 And better yet, thanks to Bill Davidsen's fixes.
# v3.04 A better way for multiple systems, thanks to Warner Losh and
#	Bill Davidsen.
# foo1:	common
# foo2: common
# common: $(MAKE) unzip whateverflags...
#
#	Nice .. makes sense .. however don't work worth beans on my vaxbsd
#	system!  ("Don't know how to make make" or some such)
#	Added Silicon Graphics system, thanks to 
#	root%itnsg1.cineca.it@CUNYVM.CUNY.EDU (Root (Valter Cavecchia))
#
# v3.0	Added HP-UX
#	Consolidated some system makerules
# ******** INSTRUCTIONS (such as they are) ********
#
# "make vaxbsd" -- makes unzip on a VAX 11-780 BSD 4.3 in current directory
# "make"	-- uses environment variable SYSTEM to set the type
#		   system to compile for.
# "make wombat" -- Chokes and dies if you haven't added the specifics
#		   for your Wombat 68000 (or whatever) to the systems list.
#
# CFLAGS are flags for the C compiler.  LDFLAGS are flags for the loader.
#
# My host (a VAX 11-780 running BSD 4.3) is hereafter referred to as
# "my host."
#
# My host's /usr/include/sys/param.h defines BSD for me.
# You may have to add "-DBSD" to the list of CFLAGS for your system.
#
# You MAY need to define "-DNOTINT16" if the program produces crc errors
# during a "-t" run or extraction.  (This involves structure alignment.)
#
# If your host is "big-endian" (as in the 68000 family) and does NOT order
# its integers and long integers in Intel fashion (low .. high), you should
# define "-DHIGH_LOW".  This insures key structure values will be "swapped"
# low end for high end.
# Some mainframes DO require this.
#
# Some systems have a shell-defined "$MAKE" (my host did not).  If not,
# use "make" instead of the "$MAKE" or "$(MAKE)" in your system's makerule.
# Or try adding the following line to your .login file:
#   setenv MAKE "make"
# (It didn't help on my host.)
#
# zmemcpy has been added to the list of required files for some systems.
# memcpy() is a normal C function that works just fine in Turbo C
# and some Unix systems, but has a problem in others (producing CRC errors).
#
# You can try a compile without zmemcpy.c, and if it works .. fine.
# (To do this, you may have to remove zmemcpy.o from your system's list
# of required OBJS files, and the "-DZMEM" from the list of CFLAGS defines.)
#
# Else use the included zmemcpy.c.
# (Again, you may have to add zmemcpy.o to your system's list of required
# OBJS files, and the "-DZMEM" to the list of CFLAGS defines.)

# To test your nice new unzip, insure your zip file includes some LARGE
# members.  Many systems ran just fine with zip file members <512 bytes,
# but failed with larger ones.
#

# Defaults most systems use
CFLAGS = -O -DUNIX

CC=cc

SHELL = /bin/sh

.c.o :
	$(CC) -c $(CFLAGS) $*.c

# Defaults everybody uses
OBJS = unzip.o crc32.o match.o ascebc.o mapname.o
SRCS = unzip.c crc32.c match.c ascebc.c mapname.c

# You'll need these also if you include "-DZMEM" in your CFLAGS
ZMEMS = zmemset.o zmemcpy.o

# list of supported systems in this version
SYSTEMS	=xenix386 ultrix sun3 sun4 encore stellar convex\
	vaxbsd next vaxsysV hp_ux pyramid sgi diab\
	dec5820 vax8600 rtaix amdahl

# The below will try to use your shell variable "SYSTEM"
# as the type system to use (e.g., if you command:
# make <no parameters>
# at the command line).

default:
	if test -z "$(SYSTEM)";\
	then make ERROR;\
	else make $(SYSTEM);\
	fi

ERROR:
	@echo "Must make one of $(SYSTEMS)"
	@echo "or set shell variable SYSTEM to a legal value"

unzip: $(OBJS)
	cc $(LDFLAGS) -o unzip $(OBJS)

unzip.o: unzip.c

crc32.o: crc32.c

match.o: match.c

ascebc.o: ascebc.c

zmemcpy.o: zmemcpy.c

zmemset.o: zmemset.c

mapname.o: mapname.c
#
# these are the makerules for various systems
# TABS ARE REQUIRED FOR SOME VERSIONS OF make!
# DO NOT DE-TABIFY THIS FILE!
# Example:
# wombat:^I# wombat 68000
#        ^this is an ASCII 9 tab char, NOT a bunch of spaces!
#^I$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
#^IOBJS="$(OBJS) $(ZMEMS)"
#^these indentations are an ASCII 9 tab char!

# ********
xenix386:	_zmem	# Xenix/386 (tested on 2.3.1)
vaxsysV:	_zmem	# from Forrest Gehrke
encore:		_zmem	# Multimax
_zmem:
	$(MAKE) unzip CFLAGS="$(CFLAGS) -DZMEM" \
	OBJS="$(OBJS) $(ZMEMS)"

# ********
convex:		_16zmem	# C200/C400
stellar:	_16zmem	# gs-2000
sun4:		_16zmem	# Sun 4/110, SunOS 4.0.3c
hp_ux:		_16zmem	# HP 9000-835 SE, HP-UX Release A.B3.10 Ver D
			# Thanks to Randy McCaskile,
			# rmccask@seas.gwu.edu
dec5820:	_16zmem	# DEC 5820 (RISC), Test version of Ultrix v4.0
			# thanks to "Moby" Dick O'Connor 
rtaix:		_16zmem	# IBM RT 6150 under AIX 2.2.1
			# thanks to Erik-Jan Vens

_16zmem:
	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
	OBJS="$(OBJS) $(ZMEMS)"

# ********
diab:		_mc68k  # 680X0, DIAB dnix 5.2/5.3 (a Swedish System V clone)
sun3:		_mc68k  # 68020, SunOS 4.0.3
amdahl:		_mc68k	# Amdahl (IBM) mainframe, UTS (SysV) 1.2.4 and 2.0.1
			# thanks to Kim DeVaughn via Greg Roelofs (Cave Newt)
			# <roelofs@amelia.nas.nasa.gov>
_mc68k:
	$(MAKE) unzip CFLAGS="$(CFLAGS) -DHIGH_LOW -DZMEM" \
	OBJS="$(OBJS) $(ZMEMS)"

# Toad Hall:  My Vax doesn't know anything about "$(MAKE)".
# I tried adding 'setenv MAKE "make" to my .login
# but it still wouldn't.  Unix wizards, to the rescue!
# v3.04 and the new flashy common system fix don't work on my vax either!
# Well .. maybe it will for the Ultrix system and others.

ultrix: _defaults	# per Greg Flint
vax8600: _defaults	# also for VAX8600 w/Ultrix OS
			# per Jim Steiner, steiner@pica.army.mil
vaxbsd:	_defaults	# VAX 11-780, BSD 4.3	David Kirschbaum
_defaults:
	make unzip

#From Mark Adler, madler@tybalt.caltech.edu:
#  I used "make stellar" on the NeXT and the resulting unzip
#  worked fine on all my zip test files.  Not willing to leave
#  well enough alone, I tried it without the zmem* routines by
#  adding the following to the Makefile:

next:		# 68030 BSD 4.3+Mach
	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16" \
	OBJS="$(OBJS)"

#  and using "make next".  This also worked fine, and presumably
#  is faster since the native memcpy and memset routines are
#  optimized assembler.
# ***
#I have finished porting unzip 3.0 to the Pyramid 90X under OSX4.1.
#The biggest problem was the default structure alignment yielding two
#extra bytes.  The compiler has the -q option to pack structures, and
#this was all that was needed.  So, I changed the Makefile, adding "pyramid"
#to the SYSTEMS list, and inserting the following lines:
#James Dugal, Internet: jpd@usl.edu

pyramid:	# Pyramid 90X, probably all, under >= OSx4.1, BSD universe
	make unzip CFLAGS="$(CFLAGS) -q -DBSD -DNOTINT16 -DZMEM" \
	OBJS="$(OBJS) $(ZMEMS)"

#I successfully compiled and tested the unzip program (v30) for the
#Silicon Graphics environment (Personal Iris 4D20/G with IRIX v3.2.2)
#
#  Valter V. Cavecchia          | Bitnet:       cavecchi@itncisca
#  Centro di Fisica del C.N.R.  | Internet:     root@itnsg1.cineca.it
#  I-38050 Povo (TN) - Italy    | Decnet:       itnvax::cavecchia (37.65)

sgi:		# Silicon Graphics (tested on Personal Iris 4D20)
	$(MAKE) unzip \
	CFLAGS="$(CFLAGS) -I/usr/include/bsd -DZMEM -DBSD -DNOTINT16" \
	OBJS="$(OBJS) $(ZMEMS)" \
	LDFLAGS="-lbsd"
