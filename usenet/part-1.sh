#! /bin/sh
# This is a shell archive.  Remove anything before this line, then unpack
# it by saving it into a file and typing "sh file".  To overwrite existing
# files, type "sh file -c".  You can also feed this as standard input via
# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
# will see the following message at the end:
#		"End of archive 1 (of 3)."
# Contents:  Makefile.min Makefile.mip ascebc.c coherent.pat crc32.c
#   info-zip.msg levels.uue mapname.c match.c minix20g.pat mips.pat
#   unreduce.c unshrink.c unzip.man unzip310.des zmemcpy.c zmemset.c
# Wrapped by kirsch@usasoc.soc.mil on Fri Aug 31 11:37:49 1990
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
if test -f 'Makefile.min' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'Makefile.min'\"
else
echo shar: Extracting \"'Makefile.min'\" \(220 characters\)
sed "s/^X//" >'Makefile.min' <<'END_OF_FILE'
X# Makefile for unzip30 under Minix
X#Regards,
X#Mark
X#mbeck@ai.mit.edu
X
XCFLAGS = -c -DUNIX -DZMEM
X
XOBJS=	unzip.s match.s crc32.s ascebc.s zmemcpy.s zmemset.s
X
X.c.s:
X	cc $(CFLAGS) $<
X
Xunzip:	$(OBJS)
X	cc -i -o unzip $(OBJS)
END_OF_FILE
if test 220 -ne `wc -c <'Makefile.min'`; then
    echo shar: \"'Makefile.min'\" unpacked with wrong size!
fi
# end of 'Makefile.min'
fi
if test -f 'Makefile.mip' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'Makefile.mip'\"
else
echo shar: Extracting \"'Makefile.mip'\" \(5757 characters\)
sed "s/^X//" >'Makefile.mip' <<'END_OF_FILE'
X# Makefile for unzip20i
X# P. Jones UQAM April 27th, 1990
X# Added support for Mips
X# "make vaxbsd" -- makes unzip on a VAX 11-780 BSD 4.3 in current directory
X# "make"	-- uses environment variable SYSTEM to set the type
X#		   system to compile for.
X# "make wombat" -- Chokes and dies if you haven't added the specifics
X#		   for your Wombat 68000 (or whatever) to the systems list.
X#
X# CFLAGS are flags for the C compiler.  LDFLAGS are flags for the loader.
X#
X# My host (a VAX 11-780 running BSD 4.3) is hereafter referred to as
X# "my host."
X#
X# My host's /usr/include/sys/param.h defines BSD for me.
X# You may have to add "-DBSD" to the list of CFLAGS for your system.
X#
X# You MAY need to define "-DNOTINT16" if the program produces crc errors
X# during a "-t" run or extraction.  (This involves structure alignment.)
X# It won't HURT to define "-dNOTINT16" anyway .. but if you don't need it,
X# why add to the program size, complexity, etc.?
X#
X# If your host is "big-endian" (as in the 68000 family) and does NOT order
X# its integers and long integers in Intel fashion (low .. high), you should
X# define "-DHIGH_LOW".  This insures key structure values will be "swapped"
X# low end for high end.
X# Some mainframes DO require this.
X#
X# Some systems have a shell-defined "$MAKE" (my host did not).  If not,
X# use "make" instead of the "$MAKE" or "$(MAKE)" in your system's makerule.
X# Or try adding the following line to your .login file:
X#   setenv MAKE "make"
X# (It didn't help on my host.)
X#
X# zmemcpy has been added to the list of required files for some systems.
X# memcpy() is a normal C function that works just fine in Turbo C
X# and some Unix systems, but has a problem in others (producing CRC errors).
X#
X# You can try a compile without zmemcpy.c, and if it works .. fine.
X# (To do this, you may have to remove zmemcpy.o from your system's list
X# of required OBJS files, and the "-DZMEM" from the list of CFLAGS defines.)
X#
X# Else use the included zmemcpy.c.
X# (Again, you may have to add zmemcpy.o to your system's list of required
X# OBJS files, and the "-DZMEM" to the list of CFLAGS defines.)
X
X# To test, insure your zip file includes some LARGE members.  Many systems
X# ran just fine with zip file members <512 bytes, but failed with larger ones.
X#
X
X# Defaults most systems use
XCFLAGS = -O -DUNIX
X
XCC=cc
X
X.c.o :
X	$(CC) -c $(CFLAGS) $*.c
X
X# Defaults everybody uses
XOBJS = unzip.o crc32.o match.o ascebc.o mapname.o
XSRCS = unzip.c crc32.c match.c ascebc.c mapname.c
X
X# You'll need these also if you include "-DZMEM" in your CFLAGS
XZMEMC = zmemset.c zmemcpy.c
XZMEMS = zmemset.o zmemcpy.o
X
X# list of supported systems in this version
XSYSTEMS	=xenix386 ultrix sun3 sun4 encore stellar convex vaxbsd next vaxsysV mips
XSYSTEM = MIPS
X
X# The code below will try to use your shell variable "SYSTEM"
X# as the type system to use (e.g., if you command:
X# make <no parameters>
X# at the command line).
X
Xdefault:
X       - test  -z $(SYSTEM) -f Makefile.mips  \
X       && make ERROR -f Makefile.mips \
X       || make $(SYSTEM) -f Makefile.mips
X       exit
X
XERROR:
X	@echo "Must make one of $(SYSTEMS)"
X	@echo "or set shell variable SYSTEM to a legal value"
X	exit 1
X
Xunzip: $(OBJS)
X	cc $(LDFLAGS) -o unzip $(OBJS)
X      rm $(OBJS)
X
Xunzip.o: unzip.c
X
Xcrc32.o: crc32.c
X
Xmatch.o: match.c
X
Xascebc.o: ascebc.c
X
Xzmemcpy.o: zmemcpy.c
X
Xzmemset.o: zmemset.c
X
Xmapname.o: mapname.c
X#
X# these are the makerules for various systems
X# TABS ARE REQUIRED FOR SOME VERSIONS OF make!
X# DO NOT DE-TABIFY THIS FILE!
X# Example:
X# wombat:^I# wombat 68000
X#        ^this is an ASCII 9 tab char, NOT a bunch of spaces!
X#^I$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
X#^IOBJS="$(OBJS) $(ZMEMS)"
X#^these indentations are an ASCII 9 tab char!
X
Xxenix386:	# Xenix/386 (tested on 2.3.1)
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
XvaxsysV:	# from Forrest Gehrke
Xencore:		# Multimax
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
Xstellar:	# gs-2000
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
Xsun3:		# 68020, SunOS 4.0.3
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DHIGH_LOW -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
Xsun4:		# Sun 4/110, SunOS 4.0.3c
X		# v2.0g Removed -DHIGH_LOW (my mistake) David Kirschbaum
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
Xconvex:		# C200/C400
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
X# My Vax doesn't know anything about "$(MAKE)".
X# I tried adding 'setenv MAKE "make" to my .login
X# but it still wouldn't.  Unix wizards, to the rescue!
X
Xultrix:		# per Greg Flint
Xvaxbsd:		# VAX 11-780, BSD 4.3	David Kirschbaum
X#	$(MAKE) unzip
X	make unzip
X
X#From Mark Adler, madler@tybalt.caltech.edu:
X#  I used "make stellar" on the NeXT and the resulting unzip
X#  worked fine on all my zip test files.  Not willing to leave
X#  well enough alone, I tried it without the zmem* routines by
X#  adding the following to the Makefile:
X
Xnext:		# 68030 BSD 4.3+Mach
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16" \
X	OBJS="$(OBJS)"
X
X#  and using "make next".  This also worked fine, and presumably
X#  is faster since the native memcpy and memset routines are
X#  optimized assembler.
X
X# Mips code is here
Xmips: #MIPS System V
X#Print system identification
X      uname -A
X# Show file creation date
X      ls -l Makefile.mips Makefile
X#show differences in Makefile and this file
X      @- diff Makefile Makefile.mips
X#Actual coplilation run
X      $(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM"      \
X      OBJS="$(OBJS) $(ZMEMS)"  
X#Test on a handy file
X      ./unzip -t levels.zip
X#Run lint to finish up
X      lint $(CFLAGS) -DNOTINT16 -DZMEM $(SRCS) $(ZMEMC)
X
X# added the useful function below....
Xclean:
X      - rm $(OBJS) 
X      - rm unzip
END_OF_FILE
if test 5757 -ne `wc -c <'Makefile.mip'`; then
    echo shar: \"'Makefile.mip'\" unpacked with wrong size!
fi
# end of 'Makefile.mip'
fi
if test -f 'ascebc.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'ascebc.c'\"
else
echo shar: Extracting \"'ascebc.c'\" \(3430 characters\)
sed "s/^X//" >'ascebc.c' <<'END_OF_FILE'
X/* ascebc.c -  ASCii to EBCdic.                             
X *             Written by Allan Bjorklund
X *             March 21, 1990
X *
X * v3.04 No more need for ae_buf() since no longer used.
X * v3.01 patched by Bo Kullmar to fix an -a switch bug.
X * patch is in kullmar.pat
X */
X
X#ifdef EBCDIC                                 /* Thy may want only the <CR><NL> to <SP><NL> routine */
X 
X/*  This is the translation table MTS uses.  (7bit ascii to ebcdic) */
X 
X 
Xstatic unsigned char ebcdic [] = {0x00,0x01,0x02,0x03,0x37,0x2d,0x2e,0x2f,0x16,0x05,0x25,0x0b,0x0c,0x0d,0x0e,0x0f,0x10,0x11,0x12,0x13,0x3c,0x3d,0x32,0x26,0x18,0x19,0x3f,0x27,0x1c,0x1d,0x1e,0x1f,
X0x40,0x5a,0x7f,0x7b,0x5b,0x6c,0x50,0x7d,0x4d,0x5d,0x5c,0x4e,0x6b,0x60,0x4b,0x61,0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,0xf8,0xf9,0x7a,0x5e,0x4c,0x7e,0x6e,0x6f,
X0x7c,0xc1,0xc2,0xc3,0xc4,0xc5,0xc6,0xc7,0xc8,0xc9,0xd1,0xd2,0xd3,0xd4,0xd5,0xd6,0xd7,0xd8,0xd9,0xe2,0xe3,0xe4,0xe5,0xe6,0xe7,0xe8,0xe9,0xba,0xe0,0xbb,0xb0,0x6d,
X0x79,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7,0xa8,0xa9,0xc0,0x4f,0xd0,0xa1,0x07,
X0x20,0x21,0x22,0x23,0x24,0x15,0x06,0x17,0x28,0x29,0x2a,0x2b,0x2c,0x09,0x0a,0x1b,0x30,0x31,0x1a,0x33,0x34,0x35,0x36,0x08,0x38,0x39,0x3a,0x3b,0x04,0x14,0x3e,0xff,
X0x41,0xaa,0x4a,0xb1,0x9f,0xb2,0x6a,0xb5,0xbd,0xb4,0x9a,0x8a,0x5f,0xca,0xaf,0xbc,0x90,0x8f,0xea,0xfa,0xbe,0xa0,0xb6,0xb3,0x9d,0xda,0x9b,0x8b,0xb7,0xb8,0xb9,0xab,
X0x64,0x65,0x62,0x66,0x63,0x67,0x9e,0x68,0x74,0x71,0x72,0x73,0x78,0x75,0x76,0x77,0xac,0x69,0xed,0xee,0xeb,0xef,0xec,0xbf,0x80,0xfd,0xfe,0xfb,0xfc,0xad,0xae,0x59,
X0x44,0x45,0x42,0x46,0x43,0x47,0x9c,0x48,0x54,0x51,0x52,0x53,0x58,0x55,0x56,0x57,0x8c,0x49,0xcd,0xce,0xcb,0xcf,0xcc,0xe1,0x70,0xdd,0xde,0xdb,0xdc,0x8d,0x8e,0xdf}; 
X                      
X  
X#include <string.h>
X 
X 
X/* a_to_e - This is the routine that does the translation.
X *
X * instr (in/out) - the string to be translated.
X *
X */
X 
Xvoid a_to_e ( instr )
X     char *instr;
X     {
X      int index;      /* Just to keep track of where we are in the string */
X      int counter;    /* The length of the string */
X      
X      counter = strlen(instr);     /* The string must be null terminated */
X 
X      for (index = 0; index <= counter; index++)
X          {
X           instr[index] = ebcdic[instr[index]];
X          }
X 
X      return;
X     }
X 
X#endif
X 
X 
X#ifdef BEFORE304 
X/* ae_buf - This routine translates a buffer instead of a string
X *          and substitues <SP><NL> for <CR><NL>.  Returns an integer
X *          indicating the number of bytes after conversion.
X *
X *          Put in the #ifdef so that the routine could
X *          be used to convert the <CR><NL> to <SP><NL>
X *          on non ebcdic systems.   A.B. 03/21/90
X *
X * cbuff (in/out) - The buffer to be translated.
X * numb  (in)     - The number of Bytes comming in.
X */
X 
X#ifdef EBCDIC
X#define SPACE 0x40
X#else
X#define SPACE 0x20
X#endif
X   
Xvoid ae_buf ( cbuff, numb )
X     char *cbuff;
X     int *numb;
X     {
X      int index;     /* Where are we in the array */
X      int ocount = 0;
X  
X      for (index = 0; index <= *numb; index++) 
X          {
X	   if (cbuff[index] != 0x0d)
X	      {
X#ifdef EBCDIC                                  /* See above */
X               cbuff[ocount++] = ebcdic[cbuff[index]];
X#else
X               cbuff[ocount++] = cbuff[index];
X#endif
X	      }
X          }
X      *numb = ocount;
X     }
X#endif	/* BEFORE304 */
END_OF_FILE
if test 3430 -ne `wc -c <'ascebc.c'`; then
    echo shar: \"'ascebc.c'\" unpacked with wrong size!
fi
# end of 'ascebc.c'
fi
if test -f 'coherent.pat' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'coherent.pat'\"
else
echo shar: Extracting \"'coherent.pat'\" \(4751 characters\)
sed "s/^X//" >'coherent.pat' <<'END_OF_FILE'
X[These patches have been installed in version 3.10.
X They actually had to be manually installed in unzip.h since the dif files
X were intended for an earlier unzip.c where all the defines, etc. were
X still in the one file.
X For them to take effect, you must (of course) define COHERENT somewhere
X (like in your Makefile).  Our Makefile has NOT been enabled for Coherent.
X
X David Kirschbaum
X Toad Hall
X]
X
XFrom @WSMR-SIMTEL20.ARMY.MIL:kirsch@usasoc.soc.mil Wed Aug  8 19:23:51 1990
XReceived: from usasoc.soc.mil by WSMR-SIMTEL20.ARMY.MIL with TCP; Wed, 8 Aug 90 15:37:55 MDT
XDate: Wed, 8 Aug 90 17:37:25 -0400
XFrom: David Kirschbaum <kirsch>
XMessage-Id: <9008082137.AA03919@usasoc.soc.mil>
XTo: INFO-ZIP <info-zip@WSMR-Simtel20.Army.Mil>
XCc: Esa T. Aloha <msdc!esa@uunet.UU.NET>, kirsch <kirsch@usasoc.soc.mil>
XSubject:  Re:  Unzip30 & Coherent
XStatus: R
X
XOf COURSE you can distribute it!  We're talking public domain here, folks;
Xthe good old-fashioned, "do anything you want with this sucker" kind...
X
XI'm really kinda amazed at the relatively few diffs that came up in
Xporting it to Coherent .. really all quite forseeable stuff! Heck, we had
Xmore trouble with flavors of true-blue Unix!
X
XFor the rest of the Info-ZIP people: I'll be posting the differences
X(eventually), to be distributed as v3.08 (whenever ...  I'm waiting for
Xsome Atari/TurboC patches from Germany).  I may throw in some v3.08
Xnumbers in the diff patches just to help in tracking changes.
X
XIncidentally, how many snarfers of the unzip307.tar-Z file from SIMTEL20
Xnoticed that bug.lst somehow became a tar of all the OTHER files! Yep,
X180K or so!  Donno HOW that happened!  Anyway, just uploaded a fixed
Xversion, so SIMTEL archives are up to date per v3.07 anyway.
X
XDavid Kirschbaum
XInfo-ZIP Coordinator
X
X----- Forwarded Message Start
X
XReceived: from msdc.UUCP by uunet.uu.net (5.61/1.14) with UUCP
X        id AA20573; Wed, 8 Aug 90 15:47:41 -0400
XMessage-Id: <9008081939.AA10689@msdc.msdc.com>
XFrom: msdc!esa@uunet.UU.NET (Esa T. Ahola)
XDate: Wed, 8 Aug 90 15:31:45 EDT
XX-Mailer: Mail User's Shell (7.0.4 1/31/90)
XTo: kirsch@usasoc.soc.mil
XSubject: Unzip30 & Coherent
X
XI have ported Unzip 3.0 to Coherent (a V7-clone by Mark Williams Co) and
Xwould like permission to distribute it to other Coherent users (we have
Xan active mailing list).  Diffs below:
X
XOnly in unzip: Makefile.mwc
Xdiff -c unzip.orig/unzip.c unzip/unzip.c
X*** unzip.orig/unzip.c  Thu May  3 17:02:50 1990
X--- unzip/unzip.c       Wed Aug  8 15:05:14 1990
X***************
X*** 54,59
X
X  #ifdef __STDC__
X
X  #include <stdlib.h>
X   /* this include defines various standard library prototypes */
X
X
X--- 54,60 -----
X
X  #ifdef __STDC__
X
X+ #ifndef COHERENT
X  #include <stdlib.h>
X  #endif
X   /* this include defines various standard library prototypes */
X***************
X*** 55,60
X  #ifdef __STDC__
X
X  #include <stdlib.h>
X   /* this include defines various standard library prototypes */
X
X  #else
X
X--- 56,62 -----
X
X  #ifndef COHERENT
X  #include <stdlib.h>
X+ #endif
X   /* this include defines various standard library prototypes */
X
X  #else
X***************
X*** 351,356
X  #include <sys/param.h>
X  #define ZSUFX ".zip"
X  #ifndef BSIZE
X  #define BSIZE DEV_BSIZE     /* v2.0c assume common for all Unix systems */
X  #endif
X  #ifndef BSD                 /* v2.0b */
X
X--- 353,361 -----
X  #include <sys/param.h>
X  #define ZSUFX ".zip"
X  #ifndef BSIZE
X+ #ifdef COHERENT
X+ #define BSIZE 512
X+ #else
X  #define BSIZE DEV_BSIZE     /* v2.0c assume common for all Unix systems */
X  #endif
X  #endif
X***************
X*** 353,358
X  #ifndef BSIZE
X  #define BSIZE DEV_BSIZE     /* v2.0c assume common for all Unix systems */
X  #endif
X  #ifndef BSD                 /* v2.0b */
X  #include <time.h>
X  struct tm *gmtime(), *localtime();
X
X--- 358,364 -----
X  #else
X  #define BSIZE DEV_BSIZE     /* v2.0c assume common for all Unix systems */
X  #endif
X+ #endif
X  #ifndef BSD                 /* v2.0b */
X  #include <time.h>
X  struct tm *gmtime(), *localtime();
X***************
X*** 399,404
X
X  #else   /* !V7 */
X
X  #include <fcntl.h>
X   /*
X    * this include file defines
X
X--- 405,413 -----
X
X  #else   /* !V7 */
X
X+ #ifdef COHERENT
X+ #include <sys/fcntl.h>
X+ #else
X  #include <fcntl.h>
X  #endif
X   /*
X***************
X*** 400,405
X  #else   /* !V7 */
X
X  #include <fcntl.h>
X   /*
X    * this include file defines
X    *             #define O_BINARY 0x8000  (* no cr-lf translation *)
X
X--- 409,415 -----
X  #include <sys/fcntl.h>
X  #else
X  #include <fcntl.h>
X+ #endif
X   /*
X    * this include file defines
X    *             #define O_BINARY 0x8000  (* no cr-lf translation *)
X
X--
XEsa Ahola           esa@msdc.com      uunet!msdc!esa        CIS:70012,2753
XMedical Systems Development Corporation (MsdC), Atlanta GA  (404) 589-3368
X
X
X----- End of Forwarded Message
X
END_OF_FILE
if test 4751 -ne `wc -c <'coherent.pat'`; then
    echo shar: \"'coherent.pat'\" unpacked with wrong size!
fi
# end of 'coherent.pat'
fi
if test -f 'crc32.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'crc32.c'\"
else
echo shar: Extracting \"'crc32.c'\" \(7543 characters\)
sed "s/^X//" >'crc32.c' <<'END_OF_FILE'
X/*
X * crc32.c
X *
X * REVISION HISTORY
X *
X * 11/16/89  C. Mascott     keep working crcval in register
X *
X */
X
X  /* ============================================================= */
X  /*  COPYRIGHT (C) 1986 Gary S. Brown.  You may use this program, or       */
X  /*  code or tables extracted from it, as desired without restriction.     */
X  /*                                                                        */
X  /*  First, the polynomial itself and its table of feedback terms.  The    */
X  /*  polynomial is                                                         */
X  /*  X^32+X^26+X^23+X^22+X^16+X^12+X^11+X^10+X^8+X^7+X^5+X^4+X^2+X^1+X^0   */
X  /*                                                                        */
X  /*  Note that we take it "backwards" and put the highest-order term in    */
X  /*  the lowest-order bit.  The X^32 term is "implied"; the LSB is the     */
X  /*  X^31 term, etc.  The X^0 term (usually shown as "+1") results in      */
X  /*  the MSB being 1.                                                      */
X  /*                                                                        */
X  /*  Note that the usual hardware shift register implementation, which     */
X  /*  is what we're using (we're merely optimizing it by doing eight-bit    */
X  /*  chunks at a time) shifts bits into the lowest-order term.  In our     */
X  /*  implementation, that means shifting towards the right.  Why do we     */
X  /*  do it this way?  Because the calculated CRC must be transmitted in    */
X  /*  order from highest-order term to lowest-order term.  UARTs transmit   */
X  /*  characters in order from LSB to MSB.  By storing the CRC this way,    */
X  /*  we hand it to the UART in the order low-byte to high-byte; the UART   */
X  /*  sends each low-bit to hight-bit; and the result is transmission bit   */
X  /*  by bit from highest- to lowest-order term without requiring any bit   */
X  /*  shuffling on our part.  Reception works similarly.                    */
X  /*                                                                        */
X  /*  The feedback terms table consists of 256, 32-bit entries.  Notes:     */
X  /*                                                                        */
X  /*      The table can be generated at runtime if desired; code to do so   */
X  /*      is shown later.  It might not be obvious, but the feedback        */
X  /*      terms simply represent the results of eight shift/xor opera-      */
X  /*      tions for all combinations of data and CRC register values.       */
X  /*                                                                        */
X  /*      The values must be right-shifted by eight bits by the "updcrc"    */
X  /*      logic; the shift must be unsigned (bring in zeroes).  On some     */
X  /*      hardware you could probably optimize the shift in assembler by    */
X  /*      using byte-swap instructions.                                     */
X  /*      polynomial $edb88320                                              */
X  /*                                                                        */
X  /*  --------------------------------------------------------------------  */
X
Xunsigned long crc_32_tab[] = {      /* v2.0d */
X      0x00000000L, 0x77073096L, 0xee0e612cL, 0x990951baL, 0x076dc419L,
X      0x706af48fL, 0xe963a535L, 0x9e6495a3L, 0x0edb8832L, 0x79dcb8a4L,
X      0xe0d5e91eL, 0x97d2d988L, 0x09b64c2bL, 0x7eb17cbdL, 0xe7b82d07L,
X      0x90bf1d91L, 0x1db71064L, 0x6ab020f2L, 0xf3b97148L, 0x84be41deL,
X      0x1adad47dL, 0x6ddde4ebL, 0xf4d4b551L, 0x83d385c7L, 0x136c9856L,
X      0x646ba8c0L, 0xfd62f97aL, 0x8a65c9ecL, 0x14015c4fL, 0x63066cd9L,
X      0xfa0f3d63L, 0x8d080df5L, 0x3b6e20c8L, 0x4c69105eL, 0xd56041e4L,
X      0xa2677172L, 0x3c03e4d1L, 0x4b04d447L, 0xd20d85fdL, 0xa50ab56bL,
X      0x35b5a8faL, 0x42b2986cL, 0xdbbbc9d6L, 0xacbcf940L, 0x32d86ce3L,
X      0x45df5c75L, 0xdcd60dcfL, 0xabd13d59L, 0x26d930acL, 0x51de003aL,
X      0xc8d75180L, 0xbfd06116L, 0x21b4f4b5L, 0x56b3c423L, 0xcfba9599L,
X      0xb8bda50fL, 0x2802b89eL, 0x5f058808L, 0xc60cd9b2L, 0xb10be924L,
X      0x2f6f7c87L, 0x58684c11L, 0xc1611dabL, 0xb6662d3dL, 0x76dc4190L,
X      0x01db7106L, 0x98d220bcL, 0xefd5102aL, 0x71b18589L, 0x06b6b51fL,
X      0x9fbfe4a5L, 0xe8b8d433L, 0x7807c9a2L, 0x0f00f934L, 0x9609a88eL,
X      0xe10e9818L, 0x7f6a0dbbL, 0x086d3d2dL, 0x91646c97L, 0xe6635c01L,
X      0x6b6b51f4L, 0x1c6c6162L, 0x856530d8L, 0xf262004eL, 0x6c0695edL,
X      0x1b01a57bL, 0x8208f4c1L, 0xf50fc457L, 0x65b0d9c6L, 0x12b7e950L,
X      0x8bbeb8eaL, 0xfcb9887cL, 0x62dd1ddfL, 0x15da2d49L, 0x8cd37cf3L,
X      0xfbd44c65L, 0x4db26158L, 0x3ab551ceL, 0xa3bc0074L, 0xd4bb30e2L,
X      0x4adfa541L, 0x3dd895d7L, 0xa4d1c46dL, 0xd3d6f4fbL, 0x4369e96aL,
X      0x346ed9fcL, 0xad678846L, 0xda60b8d0L, 0x44042d73L, 0x33031de5L,
X      0xaa0a4c5fL, 0xdd0d7cc9L, 0x5005713cL, 0x270241aaL, 0xbe0b1010L,
X      0xc90c2086L, 0x5768b525L, 0x206f85b3L, 0xb966d409L, 0xce61e49fL,
X      0x5edef90eL, 0x29d9c998L, 0xb0d09822L, 0xc7d7a8b4L, 0x59b33d17L,
X      0x2eb40d81L, 0xb7bd5c3bL, 0xc0ba6cadL, 0xedb88320L, 0x9abfb3b6L,
X      0x03b6e20cL, 0x74b1d29aL, 0xead54739L, 0x9dd277afL, 0x04db2615L,
X      0x73dc1683L, 0xe3630b12L, 0x94643b84L, 0x0d6d6a3eL, 0x7a6a5aa8L,
X      0xe40ecf0bL, 0x9309ff9dL, 0x0a00ae27L, 0x7d079eb1L, 0xf00f9344L,
X      0x8708a3d2L, 0x1e01f268L, 0x6906c2feL, 0xf762575dL, 0x806567cbL,
X      0x196c3671L, 0x6e6b06e7L, 0xfed41b76L, 0x89d32be0L, 0x10da7a5aL,
X      0x67dd4accL, 0xf9b9df6fL, 0x8ebeeff9L, 0x17b7be43L, 0x60b08ed5L,
X      0xd6d6a3e8L, 0xa1d1937eL, 0x38d8c2c4L, 0x4fdff252L, 0xd1bb67f1L,
X      0xa6bc5767L, 0x3fb506ddL, 0x48b2364bL, 0xd80d2bdaL, 0xaf0a1b4cL,
X      0x36034af6L, 0x41047a60L, 0xdf60efc3L, 0xa867df55L, 0x316e8eefL,
X      0x4669be79L, 0xcb61b38cL, 0xbc66831aL, 0x256fd2a0L, 0x5268e236L,
X      0xcc0c7795L, 0xbb0b4703L, 0x220216b9L, 0x5505262fL, 0xc5ba3bbeL,
X      0xb2bd0b28L, 0x2bb45a92L, 0x5cb36a04L, 0xc2d7ffa7L, 0xb5d0cf31L,
X      0x2cd99e8bL, 0x5bdeae1dL, 0x9b64c2b0L, 0xec63f226L, 0x756aa39cL,
X      0x026d930aL, 0x9c0906a9L, 0xeb0e363fL, 0x72076785L, 0x05005713L,
X      0x95bf4a82L, 0xe2b87a14L, 0x7bb12baeL, 0x0cb61b38L, 0x92d28e9bL,
X      0xe5d5be0dL, 0x7cdcefb7L, 0x0bdbdf21L, 0x86d3d2d4L, 0xf1d4e242L,
X      0x68ddb3f8L, 0x1fda836eL, 0x81be16cdL, 0xf6b9265bL, 0x6fb077e1L,
X      0x18b74777L, 0x88085ae6L, 0xff0f6a70L, 0x66063bcaL, 0x11010b5cL,
X      0x8f659effL, 0xf862ae69L, 0x616bffd3L, 0x166ccf45L, 0xa00ae278L,
X      0xd70dd2eeL, 0x4e048354L, 0x3903b3c2L, 0xa7672661L, 0xd06016f7L,
X      0x4969474dL, 0x3e6e77dbL, 0xaed16a4aL, 0xd9d65adcL, 0x40df0b66L,
X      0x37d83bf0L, 0xa9bcae53L, 0xdebb9ec5L, 0x47b2cf7fL, 0x30b5ffe9L,
X      0xbdbdf21cL, 0xcabac28aL, 0x53b39330L, 0x24b4a3a6L, 0xbad03605L,
X      0xcdd70693L, 0x54de5729L, 0x23d967bfL, 0xb3667a2eL, 0xc4614ab8L,
X      0x5d681b02L, 0x2a6f2b94L, 0xb40bbe37L, 0xc30c8ea1L, 0x5a05df1bL,
X      0x2d02ef8dL
X   };
X
Xtypedef unsigned char byte;
X
X#define UPDCRC32(res,oct) res=crc_32_tab[(byte)res^(byte)oct] ^ ((res>>8) & 0x00FFFFFFL)
X
X/*
X * macro UPDCRC32(res,oct)
X *  res=crc_32_tab[(byte)res ^ (byte)oct] ^ ((res >> 8) & 0x00FFFFFFL)
X *
X */
X
X/* ------------------------------------------------------------- */
X
Xextern unsigned long crc32val;
X
Xvoid UpdateCRC(s, len)
Xregister unsigned char *s;
Xregister int len;
X /* update running CRC calculation with contents of a buffer */
X{
X    register unsigned long crcval;
X
X    crcval = crc32val;
X        while (len--) {
X        crcval = crc_32_tab[(byte)crcval ^ (byte)(*s++)]
X            ^ (crcval >> 8);
X        }
X    crc32val = crcval;
X}
X
END_OF_FILE
if test 7543 -ne `wc -c <'crc32.c'`; then
    echo shar: \"'crc32.c'\" unpacked with wrong size!
fi
# end of 'crc32.c'
fi
if test -f 'info-zip.msg' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'info-zip.msg'\"
else
echo shar: Extracting \"'info-zip.msg'\" \(1525 characters\)
sed "s/^X//" >'info-zip.msg' <<'END_OF_FILE'
XDate: Wed, 11 Apr 1990  01:36 MDT
XFrom: Keith Petersen <w8sdz@WSMR-SIMTEL20.ARMY.MIL>
XTo: David Kirschbaum <kirsch@usasoc.soc.mil>
XCc: Info-ZIP@WSMR-SIMTEL20.ARMY.MIL
XSubject: Release of unzip for Unix
X
X> I've been waiting to see if there were any new changes/improvements, but
X> nothing lately.  I guess there ARE still some systems the latest won't run
X> on .. but nobody's fixing it.  So be it.
X
XPlease put a note in the release, telling how to contact Info-ZIP to
Xreport bugs/improvements/additional ports.  The uucp address most
Xuseful to Usenet people would be:  uunet!wsmr-simtel20.army.mil!info-zip
X
X> (And I've been good too .. didn't stick in ONE "Toad" ANYWHERE!)
X
XAnyone who knows about the world famous Toad Hall source of programs
Xwill know what a sacrifice you've made.  Thanks!   :-)
X
X--Keith
X
X(And back at Toad Hall .. that "world famous" bit is an inside joke,
Xguys .. we're just kidding .. really!
X
XSo .. to contact Info-ZIP for reporting bugs/improvements/additional ports:
X  Usenet people via uucp:  uunet!wsmr-simtel20.army.mil!info-zip
X  ARPAnet:		   Info-ZIP@wsmr-simtel20.army.mil
X
XDavid Kirschbaum
Xmoderator?
X13 Apr 90
X
X22 May 90:  Keith is moving Info-ZIP to another host, so the above addresses
Xwill be:
X  Usenet people via uucp:  uunet!tacom-emh1.army.mil!info-zip
X  ARPAnet:		   Info-ZIP@tacom-emh1.army.mil
X
X25 May 90:  Informed yet again by Keith that (because he's also losing access
Xto tacom-emh1) Info-ZIP will return to wsmr-simtel20.army.mil
Xso .. back to the original addresses, folks.
X
END_OF_FILE
if test 1525 -ne `wc -c <'info-zip.msg'`; then
    echo shar: \"'info-zip.msg'\" unpacked with wrong size!
fi
# end of 'info-zip.msg'
fi
if test -f 'levels.uue' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'levels.uue'\"
else
echo shar: Extracting \"'levels.uue'\" \(1103 characters\)
sed "s/^X//" >'levels.uue' <<'END_OF_FILE'
Xbegin 664 levels.zip
XM4$L#!`H``````%1ZFA1RC&T(8@```&(````)````3$5614PN5%A45&AI<R!I
XM<R!<=&5M<"X@($ET(&AA<R!T=V\@<W5B9&ER96-T;W)I97,@*&QE=F5L,2!A
XM;F0@;&5V96PR*2P-"F)O=&@@=VET:"!O;F4@<W5B9&ER96-T;W)Y(&5A8V@N
XM#0I02P,$"@``````^GF:%/)3,2H2````$@```!$```!,159%3#$O3$5614PQ
XM+E185%1H:7,@:7,@7&QE=F5L,2X-"E!+`P0*``````#Q>9H4[]!.ZAH````:
XM````&@```$Q%5D5,,2],159%3#$Q+TQ%5D5,,3$N5%A45&AI<R!I<R!<;&5V
XM96PQ7&QE=F5L,3$N#0I02P,$"@``````"GJ:%!S\A#@2````$@```!$```!,
XM159%3#(O3$5614PR+E185%1H:7,@:7,@7&QE=F5L,BX-"E!+`P0*```````4
XM>IH4SWAPVAH````:````&@```$Q%5D5,,B],159%3#(Q+TQ%5D5,,C$N5%A4
XM5&AI<R!I<R!<;&5V96PR7&QE=F5L,C$N#0I02P$""P`*``````!4>IH4<HQM
XM"&(```!B````"0`````````!`"``````````3$5614PN5%A44$L!`@L`"@``
XM````^GF:%/)3,2H2````$@```!$``````````0`@````B0```$Q%5D5,,2],
XM159%3#$N5%A44$L!`@L`"@``````\7F:%._03NH:````&@```!H`````````
XM`0`@````R@```$Q%5D5,,2],159%3#$Q+TQ%5D5,,3$N5%A44$L!`@L`"@``
XM````"GJ:%!S\A#@2````$@```!$``````````0`@````'`$``$Q%5D5,,B],
XM159%3#(N5%A44$L!`@L`"@``````%'J:%,]X<-H:````&@```!H`````````
XM`0`@````70$``$Q%5D5,,B],159%3#(Q+TQ%5D5,,C$N5%A44$L%!@`````%
X-``4`10$``*\!`````$5,
X`
Xend
END_OF_FILE
if test 1103 -ne `wc -c <'levels.uue'`; then
    echo shar: \"'levels.uue'\" unpacked with wrong size!
fi
# end of 'levels.uue'
fi
if test -f 'mapname.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'mapname.c'\"
else
echo shar: Extracting \"'mapname.c'\" \(4811 characters\)
sed "s/^X//" >'mapname.c' <<'END_OF_FILE'
X/*
X mapname.c  for unzip v3.05
X
X Change DEC-20, VAX/VMS, DOS style filenames into normal Unix names.
X Almost ALL the code is from good old xxu, Author:  F. da Cruz, CUCCA
X
X We're assuming, of course, that someday somebody will be creating
X files on DECs and VAX/VMS systems, of course.
X
X Usage: set the "-m" switch on the unzip command line.
X
X Action: Renames argument files as follows:
X   strips Unix and PKZIP DOS path name from front (up to rightmost '/')
X   if present.
X   strips DEC device:, node:: names from front (up to rightmost ':')
X   if present.  (This also takes care of any DOS drive: artifacts.)
X   strips DEC-20 <directory> or VMS [directory] name if present
X   strips DEC-20 version number from end (everything after 2nd dot) if present
X   strips VMS generation number from end (everything after ';') if present
X   lowercases any uppercase letters
X   honors DEC-20 CTRL-V quote for special characters
X   discards unquoted unprintable characters
X
X   Returns non-0 if filename zeroed out.
X
X Author:  David Kirschbaum, 25 Apr 90
X
X 27 Apr 90: Reports indicate something's SERIOUSLY wrong.  When -m switch
X is enabled, it gobbles digits in file names!  Sigh ... Fixed.
X Sloppy testing.
X David Kirschbaum
X
X 25 Apr 90:  Bill Davidsen did some tweaking.  v3.05
X
X*/
X
X#ifndef UNIX
X#ifndef STRSIZ
X#define STRSIZ 256
X#endif
X#endif
X
X#include <stdio.h>
X /* this is your standard header for all C compiles */
X#include <ctype.h>
X#include <stdio.h>
X
X#ifdef UNIX
X
X/* On some systems the contents of sys/param.h duplicates the
X   contents of sys/types.h, so you don't need (and can't use)
X   sys/types.h. */
X
X#include <sys/types.h>
X#endif
X
X#ifdef __STDC__
X
X#include <string.h>
X /* this include defines strcpy, strcmp, etc. */
X#endif
X
X
Xextern char filename[];		/* in unzip.c */
Xextern int mflag;
X
Xmapped_name()
X{
X    char name[13];			/* File name buffer (long enough
X        				 * for a DOS filename) */
X    char *pp, *cp, *xp;			/* Character pointers */
X    char delim = '\0';			/* Directory Delimiter */
X    int dc = 0;				/* Counters */
X    int quote = 0;			/* Flags */
X    int indir = 0;
X    int done = 0;
X    register int workch;		/* hold the character being tested */
X
X
X    xp = filename;		/* Copy pointer for simplicity */
X#ifdef MAP_DEBUG
X    fprintf(stderr,"%s ",*xp);	/* Echo name of this file */
X#endif
X    pp = name;			/* Point to translation buffer */
X    *name = '\0';		/* Initialize buffer */
X    dc = 0;			/* Filename dot counter */
X    done = 0;			/* Flag for early completion */
X
X    for (cp = xp; workch = *cp++; ) { /* Loop thru chars... */
X
X	if (quote) {		/* If this char quoted.. */
X	    *pp++ = workch;	/*  include it literally. */
X	    quote = 0;
X        }
X	else if (indir) {	/* If in directory name.. */
X	    if (workch == delim)
X		indir = 0;	/* look for end delimiter. */
X        }
X        else switch (workch) {
X	    case '<':		/* Discard DEC-20 directory name */
X		indir = 1;
X		delim = '>';
X		break;
X	    case '[':		/* Discard VMS directory name */
X		indir = 1;
X		delim = ']';
X		break;
X	    case '/':		/* Discard Unix path name.. */
X	    case '\\':		/*  or MS-DOS path name.. */
X	    case ':':   	/*  or DEC dev: or node:: name */
X		pp = name;
X		break;
X	    case '.':		/* DEC -20 generation number
X				 * or MS-DOS type */
X		if (++dc == 1)	/* Keep first dot */
X		    *pp++ = workch;
X		else		/* Discard everything starting */
X		    done = 1;	/* with second dot. */
X		break;
X	    case ';':		/* VMS generation or DEC-20 attrib */
X		done = 1;	/* Discard everything starting with */
X		break;		/* semicolon */
X	    case '\026':	/* Control-V quote for special chars */
X		quote = 1;	/* Set flag for next time. */
X		break;
X	    default:		/* some other char */
X		if(isdigit(workch))	/* v2.0k '0'..'9' */
X		    *pp++ = workch;	/* v2.0k accept them, no tests */
X		else{
X		    if(mflag){		/* if -m switch.. */
X		        if (isupper(workch)) /* Uppercase letter to lowercase */
X        	            workch = tolower(workch);
X		    }
X		    if (workch == ' ')  /* change blanks to underscore */
X		        *pp++ = '_';
X		    else if (isprint(workch)) /* Other printable, just keep */
X		        *pp++ = workch;
X		}
X	}  /* switch */
X    }  /* for loop */
X    *pp = '\0';				/* Done with name, terminate it */
X
X    /* We COULD check for existing names right now,
X     * create a "unique" name, etc.
X     * However, since other unzips don't do that...
X     * we won't bother.  Maybe another day, ne?
X     * If this went bad, the name'll either be nulled out
X     * (in which case we'll return non-0)
X     * or following procedures won't be able to create the
X     * extracted file, and other error msgs will result.
X     */
X
X    if(*name == '\0'){
X	fprintf(stderr,"conversion of [%s] failed\n",filename);
X	return(0);
X    }
X    strcpy(filename,name);	/* copy converted name into global */
X    return(1);
X}
X
END_OF_FILE
if test 4811 -ne `wc -c <'mapname.c'`; then
    echo shar: \"'mapname.c'\" unpacked with wrong size!
fi
# end of 'mapname.c'
fi
if test -f 'match.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'match.c'\"
else
echo shar: Extracting \"'match.c'\" \(4308 characters\)
sed "s/^X//" >'match.c' <<'END_OF_FILE'
X/*
X *  arcmatch.c  1.1
X *
X *  Author: Thom Henderson
X *  Original System V port: Mike Stump
X *
X * REVISION HISTORY
X *
X * 03/22/87  C. Seaman      enhancements, bug fixes, cleanup
X * 11/13/89  C. Mascott     adapt for use with unzip
X * 01/25/90  J. Cowan       match case-insensitive
X * 03/17/90  D. Kirschbaum      Prototypes, other tweaks for Turbo C.
X *
X */
X
X/*
X * ARC - Archive utility - ARCMATCH
X * 
X * Version 2.17, created on 12/17/85) at 20:32:18
X *
X * (C) COPYRIGHT 1985 by System Enhancement Associates; ALL RIGHTS RESERVED
X *
X *     Description:
X *        This file contains service routines needed to maintain an archive.
X */
X
X#include <sys/types.h>
X#include <sys/dir.h>
X#include <ctype.h>
X
X#ifdef __TURBOC__               /* v2.0b */
X#include <stdio.h>      /* for printf() */
X#include <stdlib.h>     /* for exit() */
X#endif
X
X#define ASTERISK '*'        /* The '*' metacharacter */
X#define QUESTION '?'        /* The '?' metacharacter */
X#define BACK_SLASH '\\'         /* The '\' metacharacter */
X#define LEFT_BRACKET '['    /* The '[' metacharacter */
X#define RIGHT_BRACKET ']'   /* The ']' metacharacter */
X
X#define IS_OCTAL(ch) (ch >= '0' && ch <= '7')
X
Xtypedef short int INT;      /* v2.0b */
Xtypedef short int BOOLEAN;  /* v2.0b */
X#define TRUE 1
X#define FALSE 0
X#define EOS '\000'
X
X#ifdef __TURBOC__              /* v2.0b */
X/* local prototypes for Turbo */
X
Xint match(char *string, char *pattern);
Xstatic BOOLEAN do_list (register char *string, char *pattern);  /* v2.0b */
Xstatic void list_parse (char **patp, char *lowp, char *highp);
Xstatic char nextch (char **patp);
X#else       /* v2.0b original code */
Xstatic BOOLEAN do_list();
Xstatic char nextch();
Xstatic void list_parse();
X#endif
X
Xint match(string, pattern)
Xchar *string;
Xchar *pattern;
X{
X    register int ismatch;
X
X    ismatch = FALSE;
X    switch (*pattern)
X    {
X    case ASTERISK:
X        pattern++;
X        do
X        {
X            ismatch = match (string, pattern);
X        }
X        while (!ismatch && *string++ != EOS);
X        break;
X    case QUESTION:
X        if (*string != EOS)
X            ismatch = match (++string, ++pattern);
X        break;
X    case EOS:
X        if (*string == EOS)
X            ismatch = TRUE;
X        break;
X    case LEFT_BRACKET:
X        if (*string != EOS)
X            ismatch = do_list (string, pattern);
X        break;
X    case BACK_SLASH:
X        pattern++;
X    default:
X    if (toupper(*string) == toupper(*pattern))
X        {
X            string++;
X            pattern++;
X            ismatch = match (string, pattern);
X        }
X        else
X            ismatch = FALSE;
X        break;
X    }
X    return(ismatch);
X}
X
Xstatic BOOLEAN do_list (string, pattern)
Xregister char *string;
Xchar *pattern;
X{
X    register BOOLEAN ismatch;
X    register BOOLEAN if_found;
X    register BOOLEAN if_not_found;
X    auto char lower;
X    auto char upper;
X
X    pattern++;
X    if (*pattern == '!')
X    {
X        if_found = FALSE;
X        if_not_found = TRUE;
X        pattern++;
X    }
X    else
X    {
X        if_found = TRUE;
X        if_not_found = FALSE;
X    }
X    ismatch = if_not_found;
X    while (*pattern != ']' && *pattern != EOS)
X    {
X        list_parse(&pattern, &lower, &upper);
X        if (*string >= lower && *string <= upper)
X        {
X            ismatch = if_found;
X            while (*pattern != ']' && *pattern != EOS) pattern++;
X        }
X    }
X
X    if (*pattern++ != ']')
X    {
X        printf("Character class error\n");
X        exit(1);
X    }
X    else
X        if (ismatch)
X            ismatch = match (++string, pattern);
X
X    return(ismatch);
X}
X
Xstatic void list_parse (patp, lowp, highp)
Xchar **patp;
Xchar *lowp;
Xchar *highp;
X{
X    *lowp = nextch (patp);
X    if (**patp == '-')
X    {
X        (*patp)++;
X        *highp = nextch(patp);
X    }
X    else
X        *highp = *lowp;
X}
X
Xstatic char nextch (patp)
Xchar **patp;
X{
X    register char ch;
X    register char chsum;
X    register INT count;
X
X    ch = *(*patp)++;
X    if (ch == '\\')
X    {
X        ch = *(*patp)++;
X        if (IS_OCTAL (ch))
X        {
X            chsum = 0;
X            for (count = 0; count < 3 && IS_OCTAL (ch); count++)
X            {
X                chsum *= 8;
X                chsum += ch - '0';
X                ch = *(*patp)++;
X            }
X            (*patp)--;
X            ch = chsum;
X        }
X    }
X    return(ch);
X}
X
END_OF_FILE
if test 4308 -ne `wc -c <'match.c'`; then
    echo shar: \"'match.c'\" unpacked with wrong size!
fi
# end of 'match.c'
fi
if test -f 'minix20g.pat' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'minix20g.pat'\"
else
echo shar: Extracting \"'minix20g.pat'\" \(1682 characters\)
sed "s/^X//" >'minix20g.pat' <<'END_OF_FILE'
XFrom: mbeck@ai.mit.edu (Mark Becker)
XDate: Thu, 5 Apr 90 16:17:27 EDT
XTo: kirsch@arsocomvax.socom.mil
XSubject: BINGO!  unzip20g.tar.Z functional under MINIX
X
XPulled a copy of 20g from White Sands and tried it out.
X
XMinix C still gets crc32.c wrong .. enclosed is a context diff for
Xwhat I did to get it running.  Nothing earthshaking.. but CRC's on
Xthis thing won't come out right unless the unused bits are masked off.
XHow would you handle the code change?  As a context diff supplied
Xseparately or a #ifdef MINIX ?
X
XAlso enclosed is the stripped-down makefile I used for this.  I did it
Xthis way because Minix is a small model system (64K data/64K code) and
Xrunning two makes eats a lot of memory.  Feel free to modify as you'd
Xlike; I can pull a new Makefile and test at your convience.
X
XI wonder why zmemcpy.c doesn't used unsigned character pointers?  For
Xa test I changed from signed chars (the default under Minix) to
Xunsigned chars and things still ran okay.  Come to think of it, I'm
Xnot sure it really matters...  :-)
X
XHOORAY!
X
XRegards,
XMark
Xmbeck@ai.mit.edu
X-- cut here -- cut here -- cut here -- cut here -- cut here 
X*** crc32.c.old	Fri Mar 23 05:51:24 1990
X--- crc32.c	Thu Apr  5 16:05:48 1990
X***************
X*** 125,131 ****
X
X      crcval = crc32val;
X          while (len--) {
X!         crcval = crc_32_tab[(byte)crcval ^ (byte)(*s++)]
X              ^ (crcval >> 8);
X          }
X      crc32val = crcval;
X--- 125,131 ----
X
X      crcval = crc32val;
X          while (len--) {
X!         crcval = crc_32_tab[(int)((0x0FF & crcval) ^ (*s++))]
X              ^ (crcval >> 8);
X          }
X      crc32val = crcval;
X-- cut here -- cut here -- cut here -- cut here -- cut here 
END_OF_FILE
if test 1682 -ne `wc -c <'minix20g.pat'`; then
    echo shar: \"'minix20g.pat'\" unpacked with wrong size!
fi
# end of 'minix20g.pat'
fi
if test -f 'mips.pat' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'mips.pat'\"
else
echo shar: Extracting \"'mips.pat'\" \(2238 characters\)
sed "s/^X//" >'mips.pat' <<'END_OF_FILE'
XDate: Fri, 27 Apr 90 05:15:29 EDT
XFrom: jones@mips1.uqam.ca (Jones*Peter)
XMessage-Id: <9004270915.AA23290@mips1.uqam.CA>
XApparently-To: info-zip@simtel20.army.mil
X
X         
XHere is my compile and test run on a mips machine. It works fine, despite a
Xcertain number of lint message. The procdeure was invoked with;
Xmake -f Makefile.mips > (the file your are reading now) .
X
X        test  -z mips -f Makefile.mips  \    <--- make default
X        && make ERROR -f Makefile.mips \
X        || make mips -f Makefile.mips
X        uname -A
Xmips1 mips1 4_0 UMIPS mips m120-5 ATT_V3_0    <---- make mips
X        ls -l Makefile.mips Makefile
X-rw-rw-r--   1 jones    prof        5003 Apr 26 08:52 Makefile
X-rw-------   1 jones    prof        5677 Apr 27 05:04 Makefile.mips
X2c2,3                   <------ changes to Makefile (only file changed)
X< 
X---
X> # P. Jones UQAM April 27th, 1990
X> # Added support for Mips
X62a64
X> ZMEMC = zmemset.c zmemcpy.c
X66c68,69
X< SYSTEMS       =xenix386 ultrix sun3 sun4 encore stellar convex vaxbsd next vaxsysV
X---
X> SYSTEMS       =xenix386 ultrix sun3 sun4 encore stellar convex vaxbsd next vaxsysV mips
X> SYSTEM = mips
X68c71
X< # The below will try to use your shell variable "SYSTEM"
X---
X> # The code below will try to use your shell variable "SYSTEM"
X74,77c77,80
X<       if test -z "$(SYSTEM)";\       <---- Causes a syntax error on our system
X<       then make ERROR;\
X<       else make $(SYSTEM);\
X<       fi
X---
X>       - test  -z $(SYSTEM) -f Makefile.mips  \
X>       && make ERROR -f Makefile.mips \
X>       || make $(SYSTEM) -f Makefile.mips
X>       exit
X85a89
X>       rm $(OBJS)
X158a163,177
X> # Mips code is here
X> mips: #MIPS System V
X> #Print system identification
X>       uname -A
X> # Show file creation date
X>       ls -l Makefile.mips Makefile
X> #show differences in Makefile and this file
X>       @- diff Makefile Makefile.mips
X> #Actual coplilation run
X>       $(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM"      \
X>       OBJS="$(OBJS) $(ZMEMS)"  
X> #Test on a handy file
X>       ./unzip -t levels.zip
X> #Run lint to finish up
X>       lint $(CFLAGS) -DNOTINT16 -DZMEM $(SRCS) $(ZMEMC)
X160c179,182
X< 
X---
X> # added the useful function below....
X> clean:
X>       - rm $(OBJS) 
X>       - rm unzip
END_OF_FILE
if test 2238 -ne `wc -c <'mips.pat'`; then
    echo shar: \"'mips.pat'\" unpacked with wrong size!
fi
# end of 'mips.pat'
fi
if test -f 'unreduce.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unreduce.c'\"
else
echo shar: Extracting \"'unreduce.c'\" \(4613 characters\)
sed "s/^X//" >'unreduce.c' <<'END_OF_FILE'
X/* ----------------------------------------------------------- */
X
Xvoid LoadFollowers()
X{
X    register int x;
X    register int i;
X
X    for (x = 255; x >= 0; x--) {
X        READBIT(6,Slen[x]);
X        for (i = 0; i < Slen[x]; i++) {
X            READBIT(8,followers[x][i]);
X        }
X    }
X}
X
X
X/* ----------------------------------------------------------- */
X/*
X * The Reducing algorithm is actually a combination of two
X * distinct algorithms.  The first algorithm compresses repeated
X * byte sequences, and the second algorithm takes the compressed
X * stream from the first algorithm and applies a probabilistic
X * compression method.
X */
X
Xint L_table[] = {0, 0x7f, 0x3f, 0x1f, 0x0f};
X
Xint D_shift[] = {0, 0x07, 0x06, 0x05, 0x04};
Xint D_mask[]  = {0, 0x01, 0x03, 0x07, 0x0f};
X
Xint B_table[] = {8, 1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5,
X                 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6,
X                 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
X                 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7,
X                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
X                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
X                 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
X                 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X                 8, 8, 8, 8};
X
X/* ----------------------------------------------------------- */
X
Xvoid unReduce()
X /* expand probablisticly reduced data */
X{
X    register int lchar;
X    int nchar;
X    int ExState;
X    int V;
X    int Len;
X
X    factor = lrec.compression_method - 1;
X    ExState = 0;
X    lchar = 0;
X    LoadFollowers();
X
X    while (((outpos+outcnt) < ucsize) && (!zipeof)) {
X        if (Slen[lchar] == 0)
X            READBIT(8,nchar)      /* ; */
X        else
X        {
X            READBIT(1,nchar);
X            if (nchar != 0)
X                READBIT(8,nchar)      /* ; */
X            else
X            {
X                int follower;
X                int bitsneeded = B_table[Slen[lchar]];
X                READBIT(bitsneeded,follower);
X                nchar = followers[lchar][follower];
X            }
X        }
X
X        /* expand the resulting byte */
X        switch (ExState) {
X
X        case 0:
X            if (nchar != DLE)
X                OUTB(nchar) /*;*/
X            else
X                ExState = 1;
X            break;
X
X        case 1:
X            if (nchar != 0) {
X                V = nchar;
X                Len = V & L_table[factor];
X                if (Len == L_table[factor])
X                    ExState = 2;
X                else
X                    ExState = 3;
X            }
X            else {
X                OUTB(DLE);
X                ExState = 0;
X            }
X            break;
X
X        case 2: {
X                Len += nchar;
X                ExState = 3;
X            }
X            break;
X
X        case 3: {
X                register int i = Len + 3;
X                int offset = (((V >> D_shift[factor]) &
X                                     D_mask[factor]) << 8) + nchar + 1;
X                longint op = (outpos+outcnt) - offset;
X
X                /* special case- before start of file */
X                while ((op < 0L) && (i > 0)) {
X                    OUTB(0);
X                    op++;
X                    i--;
X                }
X
X                /* normal copy of data from output buffer */
X                {
X                    register int ix = (int) (op % OUTBUFSIZ);
X
X                    /* do a block memory copy if possible */
X                    if ( ((ix    +i) < OUTBUFSIZ) &&
X                      ((outcnt+i) < OUTBUFSIZ) ) {
X                        zmemcpy(outptr,&outbuf[ix],i);
X                        outptr += i;
X                        outcnt += i;
X                    }
X
X                    /* otherwise copy byte by byte */
X                    else while (i--) {
X                        OUTB(outbuf[ix]);
X                        if (++ix >= OUTBUFSIZ)
X                            ix = 0;
X                    }
X                }
X
X                ExState = 0;
X            }
X            break;
X        }
X
X        /* store character for next iteration */
X        lchar = nchar;
X    }
X}
X
END_OF_FILE
if test 4613 -ne `wc -c <'unreduce.c'`; then
    echo shar: \"'unreduce.c'\" unpacked with wrong size!
fi
# end of 'unreduce.c'
fi
if test -f 'unshrink.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unshrink.c'\"
else
echo shar: Extracting \"'unshrink.c'\" \(3566 characters\)
sed "s/^X//" >'unshrink.c' <<'END_OF_FILE'
X/* ------------------------------------------------------------- */
X/*
X * Shrinking is a Dynamic Ziv-Lempel-Welch compression algorithm
X * with partial clearing.
X *
X */
X
Xvoid partial_clear()
X{
X    register int pr;
X    register int cd;
X
X    /* mark all nodes as potentially unused */
X    for (cd = first_ent; cd < free_ent; cd++)
X        prefix_of[cd] |= 0x8000;
X
X    /* unmark those that are used by other nodes */
X    for (cd = first_ent; cd < free_ent; cd++) {
X        pr = prefix_of[cd] & 0x7fff;    /* reference to another node? */
X        if (pr >= first_ent)            /* flag node as referenced */
X            prefix_of[pr] &= 0x7fff;
X    }
X
X    /* clear the ones that are still marked */
X    for (cd = first_ent; cd < free_ent; cd++)
X        if ((prefix_of[cd] & 0x8000) != 0)
X            prefix_of[cd] = -1;
X
X    /* find first cleared node as next free_ent */
X    cd = first_ent;
X    while ((cd < maxcodemax) && (prefix_of[cd] != -1))
X        cd++;
X    free_ent = cd;
X}
X
X
X/* ------------------------------------------------------------- */
X
Xvoid unShrink()
X{
X#define  GetCode(dest) READBIT(codesize,dest)
X
X    register int code;
X    register int stackp;
X    int finchar;
X    int oldcode;
X    int incode;
X
X
X    /* decompress the file */
X    maxcodemax = 1 << max_bits;
X    codesize = init_bits;
X    maxcode = (1 << codesize) - 1;
X    free_ent = first_ent;
X    offset = 0;
X    sizex = 0;
X
X    for (code = maxcodemax; code > 255; code--)
X        prefix_of[code] = -1;
X
X    for (code = 255; code >= 0; code--) {
X        prefix_of[code] = 0;
X        suffix_of[code] = code;
X    }
X
X    GetCode(oldcode);
X    if (zipeof)
X        return;
X    finchar = oldcode;
X
X    OUTB(finchar);
X
X    stackp = hsize;
X
X    while (!zipeof) {
X        GetCode(code);
X        if (zipeof)
X            return;
X
X        while (code == clear) {
X            GetCode(code);
X            switch (code) {
X
X            case 1:{
X                    codesize++;
X                    if (codesize == max_bits)
X                        maxcode = maxcodemax;
X                    else
X                        maxcode = (1 << codesize) - 1;
X                }
X                break;
X
X            case 2:
X                partial_clear();
X                break;
X            }
X
X            GetCode(code);
X            if (zipeof)
X                return;
X        }
X
X
X        /* special case for KwKwK string */
X        incode = code;
X        if (prefix_of[code] == -1) {
X            stack[--stackp] = finchar;
X            code = oldcode;
X        }
X
X
X        /* generate output characters in reverse order */
X        while (code >= first_ent) {
X            stack[--stackp] = suffix_of[code];
X            code = prefix_of[code];
X        }
X
X        finchar = suffix_of[code];
X        stack[--stackp] = finchar;
X
X
X        /* and put them out in forward order, block copy */
X        if ((hsize-stackp+outcnt) < OUTBUFSIZ) {
X            zmemcpy(outptr,&stack[stackp],hsize-stackp);
X            outptr += hsize-stackp;
X            outcnt += hsize-stackp;
X            stackp = hsize;
X        }
X
X        /* output byte by byte if we can't go by blocks */
X        else while (stackp < hsize)
X            OUTB(stack[stackp++]);
X
X
X        /* generate new entry */
X        code = free_ent;
X        if (code < maxcodemax) {
X            prefix_of[code] = oldcode;
X            suffix_of[code] = finchar;
X
X            do
X                code++;
X            while ((code < maxcodemax) && (prefix_of[code] != -1));
X
X            free_ent = code;
X        }
X
X        /* remember previous code */
X        oldcode = incode;
X    }
X}
X
END_OF_FILE
if test 3566 -ne `wc -c <'unshrink.c'`; then
    echo shar: \"'unshrink.c'\" unpacked with wrong size!
fi
# end of 'unshrink.c'
fi
if test -f 'unzip.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unzip.man'\"
else
echo shar: Extracting \"'unzip.man'\" \(1903 characters\)
sed "s/^X//" >'unzip.man' <<'END_OF_FILE'
XDate: Fri, 25 May 90 12:52:22 -0500
XFrom: jpd@pc.usl.edu (jpd DugalJP)
XMessage-Id: <9005251752.AA28036@pc.usl.edu>
XTo: Info-ZIP@WSMR-SIMTEL20.ARMY.MIL
XSubject: Improved unzip man page
X
X.TH unzip 1 "version 3.0"
X.SH NAME
Xunzip - list/test/extract from a ZIP archive file
X.SH SYNOPSIS
Xunzip [-tvcam] file[.zip]  [filespec] ...
X.SH ARGUMENTS
X.in +12
X.ti -12
Xfile[.zip]  Path of the ZIP archive.  The suffix ".zip" is applied
Xif the entryname portion lacks a suffix.  Note that
Xself-extracting ZIP files are supported; just specify
Xthe ".exe" suffix yourself.
X.sp 1
X.ti -12
X[filespec]  An optional list of archive members to be processed.
XExpressions may be used to match multiple menbers.  See
XDESCRIPTION (below) for more details.
X.SH OPTIONS
X.nf
X-t	test archive contents for validity
X-v	view (ie, list) archive contents
X-c	extract to stdout
X.sp 1
X-a	convert <CR> <LF> at line end to <LF>
X-m	map extracted filenames to lower case
X.fi
X.SH DESCRIPTION
X.B unzip
Xwill list, test, or extract from a ZIP archive, commonly found on MSDOS
Xsystems.
XArchive member extraction is implied by the absence of the -v or -t
Xoptions.  All archive members are processed unless a
X.B filespec
Xis provided to specify a subset of the archive members.
XThe
X.B filespec
Xis similar to an egrep expression, and may contain:
X.sp 1
X.in +8
X.ti -8
X*       matches a sequence of 0 or more characters
X.ti -8
X?       matches exactly 1 character
X.ti -8
X\\nnn    matches the character having octal code nnn
X.ti -8
X[...]   matches any single character found inside the brackets; ranges
Xare specified by a beginning character, a hyphen, and an ending
Xcharacter.  If a '!' follows the left bracket, then the range
Xof characters matched is complemented, with respect to the ASCII
Xcharacter set.
X.SH AUTHOR
X.nf
Xv1.2	3/15/89	Samuel H. Smith
Xv2.x	1989 Many contributors.	
Xv3.0	5/1/90 David Kirschbaum consolidator, kirsch@arsocomvax.socom.mil
X.fi
X
END_OF_FILE
if test 1903 -ne `wc -c <'unzip.man'`; then
    echo shar: \"'unzip.man'\" unpacked with wrong size!
fi
# end of 'unzip.man'
fi
if test -f 'unzip310.des' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unzip310.des'\"
else
echo shar: Extracting \"'unzip310.des'\" \(2356 characters\)
sed "s/^X//" >'unzip310.des' <<'END_OF_FILE'
XUNZIP310.ARC	Current Unix unzip source
XUNZIP310.TAR-Z	Ditto, in compressed tar format
X
Xv3.10, 16 Aug 90
X- No significant changes.  Amdahl mainframe system added to Makefile.
X  (Who ever thought calling an Amdalh (IBM clone) a 68000 would work!?)
X- Dif file required for Coherent installation in coherent.msg.
X- Dif files required for Atari (Turbo C v2.0) in atari.zip
X  (atari.hdr is msg header for initial uuencoded transfer).
X  These dif files are for an earlier version (v3.06?) and may need
X  some tweaking to patch smoothly.
X  They (and the Coherent patches) have NOT been installed.     
X
XVersion 3.10 will be the current "fielded" version until further notice.
XNo patches to earlier versions will be accepted.  (PLEASE don't expect me
Xto be able to back-engineer your Wombat 68000 patches for v3.02!)
X
XThe Info-ZIP workgroup are currently working on a new beta-test version
Xthat may or may not involve the following "features":
X  - default lowercasing of extracted member file names
X  - IFDEFs for incremental vs. new "monster" compile
X  - Integration of the Atari (Turbo C) patches.
X  - Use of central directory for member listing and more.
X  - Use of central directory "created by" byte to make "intelligent"
X    guesses as to filename and/or text conversion.
X
X(No there were no versions 3.08 or 3.09: we went right from v3.07 (last
Xbeta test) to v3.10.)
X
XThis version will NOT be fielded via EMail to Info-ZIP members.
X
XAs soon as I can figure out how, I'll be transferring full source, history,
Xetc. to comp.sources.misc (wherever THAT is).
X
XThe above archives are currently maintained on SIMTEL20 in:
XPS:<KPETERSEN.ZIP> subdirectory, available for anonymous ftp (and other means
Xof snarfing).
X
XTo contact Info-ZIP for reporting bugs/improvements/additional ports:
X  Usenet people via uucp:  uunet!wsmr-simtel20.army.mil!info-zip
X  ARPAnet:		   Info-ZIP@wsmr-simtel20.army.mil
X
XFor normal unzip-related messages and discussion, please address them to
XInfo-ZIP and not to me personally.  I'm only the coordinator and shall simply
Xredirect your messages to the Info-ZIP mailing list.  If it's something
Xpersonal or a monster mailing (like the Atari uuencoded archive of dif files)
Xyou don't wish to inflict on everyone .. ok, send to me and I'll figure out
Xhow to distribute, announce, implement, whatever.
X
XDavid Kirschbaum
XInfo-ZIP Coordinator
X
END_OF_FILE
if test 2356 -ne `wc -c <'unzip310.des'`; then
    echo shar: \"'unzip310.des'\" unpacked with wrong size!
fi
# end of 'unzip310.des'
fi
if test -f 'zmemcpy.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'zmemcpy.c'\"
else
echo shar: Extracting \"'zmemcpy.c'\" \(200 characters\)
sed "s/^X//" >'zmemcpy.c' <<'END_OF_FILE'
X/* zmemcpy.c v2.0f */
X
Xchar *
Xzmemcpy(dst,src,len)
Xregister char *dst, *src;
Xregister int len;
X{
X    char *start;
X
X    start = dst;
X    while (len-- > 0)
X        *dst++ = *src++;
X    return(start);
X}
END_OF_FILE
if test 200 -ne `wc -c <'zmemcpy.c'`; then
    echo shar: \"'zmemcpy.c'\" unpacked with wrong size!
fi
# end of 'zmemcpy.c'
fi
if test -f 'zmemset.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'zmemset.c'\"
else
echo shar: Extracting \"'zmemset.c'\" \(249 characters\)
sed "s/^X//" >'zmemset.c' <<'END_OF_FILE'
X/* zmemset - memset for systems without it
X *  bill davidsen - March 1990
X */
X
Xzmemset(buf, init, len)
X register char *buf, init;	/* buffer loc and initializer */
X register int len;		/* length of the buffer */
X{
X    while (len--) *(buf++) = init;
X}
END_OF_FILE
if test 249 -ne `wc -c <'zmemset.c'`; then
    echo shar: \"'zmemset.c'\" unpacked with wrong size!
fi
# end of 'zmemset.c'
fi
echo shar: End of archive 1 \(of 3\).
cp /dev/null ark1isdone
MISSING=""
for I in 1 2 3 ; do
    if test ! -f ark${I}isdone ; then
	MISSING="${MISSING} ${I}"
    fi
done
if test "${MISSING}" = "" ; then
    echo You have unpacked all 3 archives.
    rm -f ark[1-9]isdone
else
    echo You still need to unpack the following archives:
    echo "        " ${MISSING}
fi
##  End of shell archive.
exit 0
