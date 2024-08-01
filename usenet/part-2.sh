#! /bin/sh
# This is a shell archive.  Remove anything before this line, then unpack
# it by saving it into a file and typing "sh file".  To overwrite existing
# files, type "sh file -c".  You can also feed this as standard input via
# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
# will see the following message at the end:
#		"End of archive 2 (of 3)."
# Contents:  Makefile file_io.c unimplod.c unzip.h unzip.os2
# Wrapped by kirsch@usasoc.soc.mil on Fri Aug 31 11:37:51 1990
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
if test -f 'Makefile' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'Makefile'\"
else
echo shar: Extracting \"'Makefile'\" \(7578 characters\)
sed "s/^X//" >'Makefile' <<'END_OF_FILE'
X# Makefile for unzip
X# v3.07+ Added Amdahl (IBM) mainframe
X#	 Removed casual suggestion to define NOTINT16 if in doubt.
X#	 Turns out we can't be all THAT casual about it!	
X# v3.07+ Added IBM RT 6150 under AIX 2.2.1
X# v3.06+ Changed "make sun4_110" back to "make sun4" (to match SYSTEMS list
X#	 and since we don't have any other sun4 arguments yet).
X# v3.06+ Added VAX 8600/Ultrix, DEC 5820/Ultrix test v4.0
X# v3.05 And better yet, thanks to Bill Davidsen's fixes.
X# v3.04 A better way for multiple systems, thanks to Warner Losh and
X#	Bill Davidsen.
X# foo1:	common
X# foo2: common
X# common: $(MAKE) unzip whateverflags...
X#
X#	Nice .. makes sense .. however don't work worth beans on my vaxbsd
X#	system!  ("Don't know how to make make" or some such)
X#	Added Silicon Graphics system, thanks to 
X#	root%itnsg1.cineca.it@CUNYVM.CUNY.EDU (Root (Valter Cavecchia))
X#
X# v3.0	Added HP-UX
X#	Consolidated some system makerules
X# ******** INSTRUCTIONS (such as they are) ********
X#
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
X# To test your nice new unzip, insure your zip file includes some LARGE
X# members.  Many systems ran just fine with zip file members <512 bytes,
X# but failed with larger ones.
X#
X
X# Defaults most systems use
XCFLAGS = -O -DUNIX
X
XCC=cc
X
XSHELL = /bin/sh
X
X.c.o :
X	$(CC) -c $(CFLAGS) $*.c
X
X# Defaults everybody uses
XOBJS = unzip.o crc32.o match.o ascebc.o mapname.o
XSRCS = unzip.c crc32.c match.c ascebc.c mapname.c
X
X# You'll need these also if you include "-DZMEM" in your CFLAGS
XZMEMS = zmemset.o zmemcpy.o
X
X# list of supported systems in this version
XSYSTEMS	=xenix386 ultrix sun3 sun4 encore stellar convex\
X	vaxbsd next vaxsysV hp_ux pyramid sgi diab\
X	dec5820 vax8600 rtaix amdahl
X
X# The below will try to use your shell variable "SYSTEM"
X# as the type system to use (e.g., if you command:
X# make <no parameters>
X# at the command line).
X
Xdefault:
X	if test -z "$(SYSTEM)";\
X	then make ERROR;\
X	else make $(SYSTEM);\
X	fi
X
XERROR:
X	@echo "Must make one of $(SYSTEMS)"
X	@echo "or set shell variable SYSTEM to a legal value"
X
Xunzip: $(OBJS)
X	cc $(LDFLAGS) -o unzip $(OBJS)
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
X# ********
Xxenix386:	_zmem	# Xenix/386 (tested on 2.3.1)
XvaxsysV:	_zmem	# from Forrest Gehrke
Xencore:		_zmem	# Multimax
X_zmem:
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
X# ********
Xconvex:		_16zmem	# C200/C400
Xstellar:	_16zmem	# gs-2000
Xsun4:		_16zmem	# Sun 4/110, SunOS 4.0.3c
Xhp_ux:		_16zmem	# HP 9000-835 SE, HP-UX Release A.B3.10 Ver D
X			# Thanks to Randy McCaskile,
X			# rmccask@seas.gwu.edu
Xdec5820:	_16zmem	# DEC 5820 (RISC), Test version of Ultrix v4.0
X			# thanks to "Moby" Dick O'Connor 
Xrtaix:		_16zmem	# IBM RT 6150 under AIX 2.2.1
X			# thanks to Erik-Jan Vens
X
X_16zmem:
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
X# ********
Xdiab:		_mc68k  # 680X0, DIAB dnix 5.2/5.3 (a Swedish System V clone)
Xsun3:		_mc68k  # 68020, SunOS 4.0.3
Xamdahl:		_mc68k	# Amdahl (IBM) mainframe, UTS (SysV) 1.2.4 and 2.0.1
X			# thanks to Kim DeVaughn via Greg Roelofs (Cave Newt)
X			# <roelofs@amelia.nas.nasa.gov>
X_mc68k:
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DHIGH_LOW -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
X# Toad Hall:  My Vax doesn't know anything about "$(MAKE)".
X# I tried adding 'setenv MAKE "make" to my .login
X# but it still wouldn't.  Unix wizards, to the rescue!
X# v3.04 and the new flashy common system fix don't work on my vax either!
X# Well .. maybe it will for the Ultrix system and others.
X
Xultrix: _defaults	# per Greg Flint
Xvax8600: _defaults	# also for VAX8600 w/Ultrix OS
X			# per Jim Steiner, steiner@pica.army.mil
Xvaxbsd:	_defaults	# VAX 11-780, BSD 4.3	David Kirschbaum
X_defaults:
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
X# ***
X#I have finished porting unzip 3.0 to the Pyramid 90X under OSX4.1.
X#The biggest problem was the default structure alignment yielding two
X#extra bytes.  The compiler has the -q option to pack structures, and
X#this was all that was needed.  So, I changed the Makefile, adding "pyramid"
X#to the SYSTEMS list, and inserting the following lines:
X#James Dugal, Internet: jpd@usl.edu
X
Xpyramid:	# Pyramid 90X, probably all, under >= OSx4.1, BSD universe
X	make unzip CFLAGS="$(CFLAGS) -q -DBSD -DNOTINT16 -DZMEM" \
X	OBJS="$(OBJS) $(ZMEMS)"
X
X#I successfully compiled and tested the unzip program (v30) for the
X#Silicon Graphics environment (Personal Iris 4D20/G with IRIX v3.2.2)
X#
X#  Valter V. Cavecchia          | Bitnet:       cavecchi@itncisca
X#  Centro di Fisica del C.N.R.  | Internet:     root@itnsg1.cineca.it
X#  I-38050 Povo (TN) - Italy    | Decnet:       itnvax::cavecchia (37.65)
X
Xsgi:		# Silicon Graphics (tested on Personal Iris 4D20)
X	$(MAKE) unzip \
X	CFLAGS="$(CFLAGS) -I/usr/include/bsd -DZMEM -DBSD -DNOTINT16" \
X	OBJS="$(OBJS) $(ZMEMS)" \
X	LDFLAGS="-lbsd"
END_OF_FILE
if test 7578 -ne `wc -c <'Makefile'`; then
    echo shar: \"'Makefile'\" unpacked with wrong size!
fi
# end of 'Makefile'
fi
if test -f 'file_io.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'file_io.c'\"
else
echo shar: Extracting \"'file_io.c'\" \(9601 characters\)
sed "s/^X//" >'file_io.c' <<'END_OF_FILE'
X/* v3.05 File related functions for unzip.c */
X
X/*
X * input file variables
X *
X */
X
X#define INBUFSIZ BUFSIZ     /* same as stdio uses */
Xbyte *inbuf;            /* input file buffer - any size is legal */
Xbyte *inptr;
X
Xint incnt;
XUWORD bitbuf;
Xint bits_left;
Xboolean zipeof;
X
Xint zipfd;
Xchar zipfn[STRSIZ];
Xlocal_file_header lrec;
X
X/* ----------------------------------------------------------- */
X/*
X * output stream variables
X *
X */
X
X#define OUTBUFSIZ 0x2000        /* unImplode needs power of 2, >= 0x2000 */
Xbyte *outbuf;                   /* buffer for rle look-back */
Xbyte *outptr;
Xbyte *outout;                 /* Scratch pad for ascebc trans v2.0g */
X
Xlongint outpos;         /* absolute position in outfile */
Xint outcnt;             /* current position in outbuf */
X
Xint outfd;
Xchar filename[STRSIZ];
Xchar extra[STRSIZ];
Xchar comment[STRSIZ];       /* v2.0b made it global for displays */
X
X
Xvoid set_file_time()
X /*
X  * set the output file date/time stamp according to information from the
X  * zipfile directory record for this file
X  */
X{
X#ifndef UNIX
X    union {
X        struct ftime ft;        /* system file time record */
X        struct {
X                UWORD ztime;     /* date and time words */
X                UWORD zdate;     /* .. same format as in .ZIP file */
X        } zt;
X    } td;
X
X    /*
X     * set output file date and time - this is optional and can be
X     * deleted if your compiler does not easily support setftime()
X     */
X
X    td.zt.ztime = lrec.last_mod_file_time;
X    td.zt.zdate = lrec.last_mod_file_date;
X
X    setftime(outfd, &td.ft);
X
X#else   /* UNIX */
X
X    time_t times[2];
X    struct tm *tmbuf;
X    long m_time;
X    int yr, mo, dy, hh, mm, ss, leap, days = 0;
X#ifdef BSD
X    struct timeval tv;
X    struct timezone tz;
X#endif
X
X    /*
X     * These date conversions look a little wierd, so I'll explain.
X     * UNIX bases all file modification times on the number of seconds
X     * elapsed since Jan 1, 1970, 00:00:00 GMT.  Therefore, to maintain
X     * compatibility with MS-DOS archives, which date from Jan 1, 1980,
X     * with NO relation to GMT, the following conversions must be made:
X     *      the Year (yr) must be incremented by 10;
X     *      the Date (dy) must be decremented by 1;
X     *      and the whole mess must be adjusted by TWO factors:
X     *          relationship to GMT (ie.,Pacific Time adds 8 hrs.),
X     *          and whether or not it is Daylight Savings Time.
X     * Also, the usual conversions must take place to account for leap years,
X     * etc.
X     *                                     C. Seaman
X     */
X
X    yr = (((lrec.last_mod_file_date >> 9) & 0x7f) + 10);  /* dissect date */
X    mo = ((lrec.last_mod_file_date >> 5) & 0x0f);
X    dy = ((lrec.last_mod_file_date & 0x1f) - 1);
X
X    hh = ((lrec.last_mod_file_time >> 11) & 0x1f);        /* dissect time */
X    mm = ((lrec.last_mod_file_time >> 5) & 0x3f);
X    ss = ((lrec.last_mod_file_time & 0x1f) * 2);
X
X    /* leap = # of leap years from 1970 up to but not including
X       the current year */
X
X    leap = ((yr+1969)/4);              /* Leap year base factor */
X
X    /* How many days from 1970 to this year? */
X    days = (yr * 365) + (leap - 492);
X
X    switch(mo)                 /* calculate expired days this year */
X    {
X    case 12:
X        days += 30;
X    case 11:
X        days += 31;
X    case 10:
X        days += 30;
X    case 9:
X        days += 31;
X    case 8:
X        days += 31;
X    case 7:
X        days += 30;
X    case 6:
X        days += 31;
X    case 5:
X        days += 30;
X    case 4:
X        days += 31;
X    case 3:
X        days += 28;                    /* account for leap years */
X        if (((yr+1970) % 4 == 0) && (yr+1970) != 2000)
X            ++days;
X    case 2:
X        days += 31;
X    }
X
X    /* convert date & time to seconds relative to 00:00:00, 01/01/1970 */
X    m_time = ((days + dy) * 86400) + (hh * 3600) + (mm * 60) + ss;
X
X#ifdef BSD
X    gettimeofday(&tv, &tz);
X/* This program is TOO smart about daylight savings time.
X * Adjusting for it throws our file times off by one hour if it's true.
X * Remming it out.
X *
X *  if (tz.tz_dsttime != 0)
X *      m_time -= 3600;
X */
X    m_time += tz.tz_minuteswest * 60;  /* account for timezone differences */
X#else   /* !BSD */
X    tmbuf = localtime(&m_time);
X    hh = tmbuf->tm_hour;
X    tmbuf = gmtime(&m_time);
X    hh = tmbuf->tm_hour - hh;
X    if (hh < 0)
X    hh += 24;
X    m_time += (hh * 3600);             /* account for timezone differences */
X#endif
X
X    times[0] = m_time;             /* set the stamp on the file */
X    times[1] = m_time;
X    utime(filename, times);
X#endif  /* UNIX */
X}
X
X
Xint create_output_file()
X /* return non-0 if creat failed */
X{   /* create the output file with READ and WRITE permissions */
X    static int do_all = 0;
X    char answerbuf[10];
X    UWORD holder;
X
X    if (cflag) {        /* output to stdout (a copy of it, really) */
X        outfd = dup(1);
X        return 0;
X        }
X    CR_flag = 0;	/* Hack to get CR at end of buffer working. */
X
X    /* 
X     * check if the file exists, unless do_all 
X     * ask before overwrite code by Bill Davidsen (davidsen@crdos1.crd.ge.com)
X     */
X    if (!do_all) {
X        outfd = open(filename, 0);
X	if (outfd >= 0) {
X	    /* first close it, before you forget! */
X	    close(outfd);
X
X	    /* ask the user before blowing it away */
X	    fprintf(stderr, "replace %s, y-yes, n-no, a-all: ", filename);
X	    fgets(answerbuf, 9, stdin);
X
X	    switch (answerbuf[0]) {
X	      case 'y':
X	      case 'Y':
X	        break;
X	      case 'a':
X	      case 'A':
X	        do_all = 1;
X		break;
X	      case 'n':
X	      case 'N':
X	      default:
X	        while(ReadByte(&holder));
X		return 1; /* it's done! */
X	    }
X	}
X    }
X
X#ifndef UNIX
X    outfd = creat(filename, S_IWRITE | S_IREAD);
X#else
X    outfd = creat(filename, 0666);  /* let umask strip unwanted perm's */
X#endif
X
X    if (outfd < 1) {
X        fprintf(stderr, "Can't create output: %s\n", filename);
X        return 1;
X    }
X
X    /*
X     * close the newly created file and reopen it in BINARY mode to
X     * disable all CR/LF translations
X     */
X#ifndef UNIX
X    close(outfd);
X    outfd = open(filename, O_RDWR | O_BINARY);
X#endif
X    return 0;
X}
X
X
Xint open_input_file()
X /* return non-0 if open failed */
X{
X    /*
X     * open the zipfile for reading and in BINARY mode to prevent cr/lf
X     * translation, which would corrupt the bitstreams
X     */
X
X#ifndef UNIX
X    zipfd = open(zipfn, O_RDONLY | O_BINARY);
X#else
X    zipfd = open(zipfn, O_RDONLY);
X#endif
X    if (zipfd < 1) {
X        fprintf(stderr, "Can't open input file: %s\n", zipfn);
X        return (1);
X    }
X    return 0;
X}
X
X/* ============================================================= */
X
Xint readbuf(fd, buf, size)
Xint fd;
Xchar *buf;
Xregister unsigned size;
X{
X    register int count;
X    int n;
X
X    n = size;
X    while (size)  {
X        if (incnt == 0)  {
X            if ((incnt = read(fd, inbuf, INBUFSIZ)) <= 0)
X                return(incnt);
X            inptr = inbuf;
X        }
X        count = min(size, incnt);
X        zmemcpy(buf, inptr, count);
X        buf += count;
X        inptr += count;
X        incnt -= count;
X        size -= count;
X    }
X    return(n);
X}
X
Xint ReadByte(x)
XUWORD *x;
X /* read a byte; return 8 if byte available, 0 if not */
X{
X    if (csize-- <= 0)
X        return 0;
X    if (incnt == 0)  {
X        if ((incnt = read(zipfd, inbuf, INBUFSIZ)) <= 0)
X            return 0;
X        inptr = inbuf;
X    }
X    *x = *inptr++;
X    --incnt;
X    return 8;
X}
X
X
X/* ------------------------------------------------------------- */
Xstatic UWORD mask_bits[] =
X        {0,     0x0001, 0x0003, 0x0007, 0x000f,
X                0x001f, 0x003f, 0x007f, 0x00ff,
X                0x01ff, 0x03ff, 0x07ff, 0x0fff,
X                0x1fff, 0x3fff, 0x7fff, 0xffff
X        };
X
X
Xint FillBitBuffer(bits)
Xregister int bits;
X{
X    /* get the bits that are left and read the next UWORD */
X        register int result = bitbuf;
X    UWORD temp;
X    int sbits = bits_left;
X    bits -= bits_left;
X
X    /* read next UWORD of input */
X    bits_left = ReadByte(&bitbuf);
X    bits_left += ReadByte(&temp);
X
X    bitbuf |= (temp << 8);
X    if (bits_left == 0)
X        zipeof = 1;
X
X    /* get the remaining bits */
X        result = result | (int) ((bitbuf & mask_bits[bits]) << sbits);
X        bitbuf >>= bits;
X        bits_left -= bits;
X        return result;
X}
X
X/* ------------------------------------------------------------- */
X
Xint dos2unix (buf, len)
Xunsigned char *buf;
Xint len;
X{
X    int new_len;
X    int i;
X    unsigned char *walker;
X
X    new_len = len;
X    walker = outout;
X    if (CR_flag && *buf != LF)
X        *walker++ = ascii_to_native(CR);
X    CR_flag = buf[len - 1] == CR;
X    for (i = 0; i < len; i += 1) {
X        *walker++ = *buf;
X        if (*buf++ == CR && *buf == LF) {
X            new_len--;
X            walker[-1] = ascii_to_native(*buf++);
X            i++;
X        }
X    }
X    /*
X     * If the last character is a CR, then "ignore it" for now...
X     */
X    if (walker[-1] == CR)
X        new_len--;
X    return new_len;
X}
X
Xvoid WriteBuffer(fd, buf, len)
Xint fd;
Xunsigned char *buf;
Xint len;
X{
X     if (aflag)
X         len = dos2unix (buf, len);
X     if (write (fd, outout, len) != len) {
X         fprintf (stderr, "Fatal write error.\n");
X         exit (1);
X     }
X}
X
X
X/* ------------------------------------------------------------- */
X
Xvoid FlushOutput()
X /* flush contents of output buffer */
X{
X    if (outcnt) {
X        UpdateCRC(outbuf, outcnt);
X
X        if (!tflag)
X            WriteBuffer(outfd, outbuf, outcnt);
X
X        outpos += outcnt;
X        outcnt = 0;
X        outptr = outbuf;
X    }
X}
X
END_OF_FILE
if test 9601 -ne `wc -c <'file_io.c'`; then
    echo shar: \"'file_io.c'\" unpacked with wrong size!
fi
# end of 'file_io.c'
fi
if test -f 'unimplod.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unimplod.c'\"
else
echo shar: Extracting \"'unimplod.c'\" \(8228 characters\)
sed "s/^X//" >'unimplod.c' <<'END_OF_FILE'
X/* ------------------------------------------------------------- */
X/*
X * Imploding
X * ---------
X *
X * The Imploding algorithm is actually a combination of two distinct
X * algorithms.  The first algorithm compresses repeated byte sequences
X * using a sliding dictionary.  The second algorithm is used to compress
X * the encoding of the sliding dictionary ouput, using multiple
X * Shannon-Fano trees.
X *
X */
X
X#define LITVALS     256
X#define DISTVALS    64
X#define LENVALS     64
X#define MAXSF       LITVALS
X
X   typedef struct sf_entry {
X       byte         Value;
X       byte         BitLength;
X   } sf_entry;
X
X   typedef struct sf_tree {   /* a shannon-fano "tree" (table) */
X      sf_entry     entry[MAXSF];
X      int          entries;
X      int          MaxLength;
X   } sf_tree;
X
X   typedef sf_tree      *sf_treep;
X
X   typedef struct sf_node {   /* node in a true shannon-fano tree */
X      UWORD         left;      /* 0 means leaf node */
X      UWORD         right;     /* or value if leaf node */
X   } sf_node;
X
X   sf_tree  lit_tree;
X   sf_tree  length_tree;
X   sf_tree  distance_tree;
X   /* s-f storage is shared with that used by other comp. methods */
X   sf_node  *lit_nodes = (sf_node *) followers;     /* 2*LITVALS nodes */
X   sf_node  *length_nodes = (sf_node *) suffix_of;  /* 2*LENVALS nodes */
X   sf_node  *distance_nodes = (sf_node *) stack;    /* 2*DISTVALS nodes */
X   boolean  lit_tree_present;
X   boolean  eightK_dictionary;
X   int      minimum_match_length;
X   int      dict_bits;
X
X#ifdef __TURBOC__
X/* v2.0b More local prototypes */
Xvoid ReadLengths(sf_tree *tree);
Xvoid SortLengths(sf_tree *tree);
Xvoid GenerateTrees(sf_tree *tree, sf_node *nodes);
Xvoid LoadTree(sf_tree *tree, int treesize, sf_node *nodes);
Xvoid LoadTrees(void);
Xvoid ReadTree(register sf_node *nodes, int *dest);
X#endif
X
Xvoid         SortLengths(tree)
Xsf_tree *tree;
X  /* Sort the Bit Lengths in ascending order, while retaining the order
X    of the original lengths stored in the file */
X{
X    register sf_entry *ejm1;    /* entry[j - 1] */
X    register int j;
X    register sf_entry *entry;
X    register int i;
X    sf_entry tmp;
X    int entries;
X    unsigned a, b;
X
X    entry = &tree->entry[0];
X    entries = tree->entries;
X
X    for (i = 0; ++i < entries; )  {
X        tmp = entry[i];
X        b = tmp.BitLength;
X        j = i;
X        while ((j > 0)
X        && ((a = (ejm1 = &entry[j - 1])->BitLength) >= b))  {
X            if ((a == b) && (ejm1->Value <= tmp.Value))
X                break;
X            *(ejm1 + 1) = *ejm1;    /* entry[j] = entry[j - 1] */
X            --j;
X        }
X        entry[j] = tmp;
X    }
X}
X
X
X/* ----------------------------------------------------------- */
X
Xvoid         ReadLengths(tree)
Xsf_tree *tree;
X{
X   int    treeBytes;
X   int    i;
X   int    num, len;
X
X  /* get number of bytes in compressed tree */
X   READBIT(8,treeBytes);
X   treeBytes++;
X   i = 0;
X
X   tree->MaxLength = 0;
X
X/* High 4 bits: Number of values at this bit length + 1. (1 - 16)
X * Low  4 bits: Bit Length needed to represent value + 1. (1 - 16)
X */
X   while (treeBytes > 0) {
X      READBIT(4,len); len++;
X      READBIT(4,num); num++;
X
X      while (num > 0) {
X         if (len > tree->MaxLength)
X            tree->MaxLength = len;
X         tree->entry[i].BitLength = len;
X         tree->entry[i].Value = i;
X         i++;
X         num--;
X      }
X
X      treeBytes--;
X   }
X}
X
X
X/* ----------------------------------------------------------- */
X
Xvoid         GenerateTrees(tree, nodes)
Xsf_tree *tree;
Xsf_node *nodes;
X     /* Generate the Shannon-Fano trees */
X{
X    int codelen, i, j, lvlstart, next, parents;
X
X    i = tree->entries - 1;          /* either 255 or 63 */
X    lvlstart = next = 1;
X
X    /* believe it or not, there may be a 1-bit code */
X
X    for (codelen = tree->MaxLength; codelen >= 1; --codelen)  {
X
X        /* create leaf nodes at level <codelen> */
X
X        while ((i >= 0) && (tree->entry[i].BitLength == codelen))  {
X            nodes[next].left = 0;
X            nodes[next].right = tree->entry[i].Value;
X            ++next;
X            --i;
X        }
X
X        /* create parent nodes for all nodes at level <codelen>,
X           but don't create the root node here */
X
X        parents = next;
X        if (codelen > 1)  {
X            for (j = lvlstart; j <= parents-2; j += 2)  {
X                nodes[next].left = j;
X                nodes[next].right = j + 1;
X                ++next;
X            }
X        }
X        lvlstart = parents;
X    }
X
X    /* create root node */
X
X    nodes[0].left = next - 2;
X    nodes[0].right = next - 1;
X}
X
X
X/* ----------------------------------------------------------- */
X
Xvoid         LoadTree(tree, treesize, nodes)
Xsf_tree *tree;
Xint treesize;
Xsf_node *nodes;
X     /* allocate and load a shannon-fano tree from the compressed file */
X{
X   tree->entries = treesize;
X   ReadLengths(tree);
X   SortLengths(tree);
X   GenerateTrees(tree, nodes);
X}
X
X
X/* ----------------------------------------------------------- */
X
Xvoid         LoadTrees()
X{
X   eightK_dictionary = (lrec.general_purpose_bit_flag & 0x02) != 0; /* bit 1 */
X   lit_tree_present = (lrec.general_purpose_bit_flag & 0x04) != 0;  /* bit 2 */
X
X   if (eightK_dictionary)
X      dict_bits = 7;
X   else
X      dict_bits = 6;
X
X   if (lit_tree_present) {
X      minimum_match_length = 3;
X      LoadTree(&lit_tree,256,lit_nodes);
X   }
X   else
X      minimum_match_length = 2;
X
X   LoadTree(&length_tree,64,length_nodes);
X   LoadTree(&distance_tree,64,distance_nodes);
X}
X
X
X/* ----------------------------------------------------------- */
X
X#ifndef ASM
X
Xvoid         ReadTree(nodes, dest)
Xregister sf_node *nodes;
Xint *dest;
X     /* read next byte using a shannon-fano tree */
X{
X    register int cur;
X    register int left;
X    UWORD b;
X
X    for (cur = 0; ; )  {
X        if ((left = nodes[cur].left) == 0)  {
X            *dest = nodes[cur].right;
X            return;
X        }
X        READBIT(1, b);
X        cur = (b ? nodes[cur].right : left);
X    }
X}
X
X#endif
X
X/* ----------------------------------------------------------- */
X
Xvoid         unImplode()
X     /* expand imploded data */
X{
X   register int srcix;
X   register int Length;
X   register int limit;
X   int          lout;
X   int          Distance;
X
X   LoadTrees();
X
X#ifdef DEBUG
X   printf("\n");
X#endif
X   while ((!zipeof) && ((outpos+outcnt) < ucsize)) {
X      READBIT(1,lout);
X
X      if (lout != 0) {   /* encoded data is literal data */
X         if (lit_tree_present)  /* use Literal Shannon-Fano tree */  {
X            ReadTree(lit_nodes,&lout);
X#ifdef DEBUG
X            printf("lit=%d\n", lout);
X#endif
X         }
X         else
X            READBIT(8,lout);
X
X         OUTB(lout);
X      }
X      else {            /* encoded data is sliding dictionary match */
X         READBIT(dict_bits,Distance);
X
X         ReadTree(distance_nodes,&lout);
X#ifdef DEBUG
X     printf("d=%5d (%2d,%3d)", (lout << dict_bits) | Distance, lout,
X            Distance);
X#endif
X         Distance |= (lout << dict_bits);
X         /* using the Distance Shannon-Fano tree, read and decode the
X            upper 6 bits of the Distance value */
X
X         ReadTree(length_nodes,&lout);
X         Length = lout;
X#ifdef DEBUG
X     printf("\tl=%3d\n", Length);
X#endif
X         /* using the Length Shannon-Fano tree, read and decode the
X            Length value */
X
X         if (Length == 63) {
X            READBIT(8,lout);
X            Length += lout;
X         }
X         Length += minimum_match_length;
X
X        /* move backwards Distance+1 bytes in the output stream, and copy
X          Length characters from this position to the output stream.
X          (if this position is before the start of the output stream,
X          then assume that all the data before the start of the output
X          stream is filled with zeros.  Requires initializing outbuf
X          for each file.) */
X
X        srcix = (outcnt - (Distance + 1)) & (OUTBUFSIZ-1);
X        limit = OUTBUFSIZ - Length;
X        if ((srcix <= limit) && (outcnt < limit))  {
X            zmemcpy(outptr, &outbuf[srcix], Length);
X            outptr += Length;
X            outcnt += Length;
X        }
X        else {
X            while (Length--)  {
X                OUTB(outbuf[srcix++]);
X                srcix &= OUTBUFSIZ-1;
X            }
X        }
X      }
X   }
X}
X
END_OF_FILE
if test 8228 -ne `wc -c <'unimplod.c'`; then
    echo shar: \"'unimplod.c'\" unpacked with wrong size!
fi
# end of 'unimplod.c'
fi
if test -f 'unzip.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unzip.h'\"
else
echo shar: Extracting \"'unzip.h'\" \(10690 characters\)
sed "s/^X//" >'unzip.h' <<'END_OF_FILE'
X/*
X * unzip.c was getting TOO big, so I split out a bunch of likely
X * defines and constants into a separate file.
X * David Kirschbaum
X * Toad Hall
X */
X
X#define VERSION  "UnZip:  Zipfile Extract v3.10 (C) of 08-16-90;  (C) 1989 Samuel H. Smith"
X
X/* #define NOSKIP 1 */	/* v3.04 Enable if you do NOT want
X			 * skip_to_signature() enabled */
X
Xtypedef unsigned char byte; /* code assumes UNSIGNED bytes */
Xtypedef long longint;
Xtypedef unsigned short UWORD;
Xtypedef char boolean;
X
X/* v2.0g Allan Bjorklund added this.  Confirm it doesn't make your system
X * choke and die!  (Could be it belongs down in the !__STDC__ section
X * along with *malloc()
X */
X#ifdef MTS		/* v2.0h No one else seems to want it tho... */
X#include <sys/file.h>   /* v2.0g Chitra says MTS needs this for O_BINARY */
X#endif
X
X#define STRSIZ 256
X
X#include <stdio.h>
X /* this is your standard header for all C compiles */
X#include <ctype.h>
X
X#ifdef __TURBOC__           /* v2.0b */
X#include <timeb.h>      /* for structure ftime */
X#include <io.h>         /* for setftime(), dup(), creat() */
X#include <mem.h>        /* for memcpy() */
X#include <stat.h>       /* for S_IWRITE, S_IREAD */
X#endif
X
X#ifdef __STDC__
X
X#include <stdlib.h>
X /* this include defines various standard library prototypes */
X
X#else
X
Xchar *malloc();         /* who knows WHERE this is prototyped... */
X
X#endif
X
X#define min(a,b) ((a) < (b) ? (a) : (b))
X
X#ifndef ZMEM                            /* v2.0f use your system's stuff */
X#define zmemcpy memcpy
X#define zmemset memset
X#endif
X
X/* ----------------------------------------------------------- */
X/*
X * Zipfile layout declarations
X *
X */
X
X/* Macros for accessing the longint header fields.  These fields
X   are defined as array of char to prevent a 32-bit compiler from
X   padding the struct so that longints start on a 4-byte boundary.
X   This will not work on a machine that can access longints only
X   if they start on a 4-byte boundary.
X*/
X
X#ifndef NOTINT16    /* v2.0c */
X#define LONGIP(l) ((longint *) &((l)[0]))
X#define LONGI(l) (*(LONGIP(l)))
X#else       /* Have to define, since used for HIGH_LOW */
X#define LONGIP(I) &I
X#define LONGI(I) I
X#endif
X
Xtypedef longint signature_type;
X
X#define LOCAL_FILE_HEADER_SIGNATURE  0x04034b50L
X
X#ifndef NOTINT16            /* v2.0c */
Xtypedef struct local_file_header {
X    UWORD version_needed_to_extract;
X    UWORD general_purpose_bit_flag;
X    UWORD compression_method;
X    UWORD last_mod_file_time;
X    UWORD last_mod_file_date;
X    byte crc32[4];
X    byte compressed_size[4];
X    byte uncompressed_size[4];
X    UWORD filename_length;
X    UWORD extra_field_length;
X} local_file_header;
X
X#else   /* NOTINT16 */
Xtypedef struct local_file_header {
X    UWORD version_needed_to_extract;
X    UWORD general_purpose_bit_flag;
X    UWORD compression_method;
X    UWORD last_mod_file_time;
X    UWORD last_mod_file_date;
X    longint crc32;              /* v2.0e */
X    longint compressed_size;
X    longint uncompressed_size;  /* v2.0e */
X    UWORD filename_length;
X    UWORD extra_field_length;
X} local_file_header;
X
Xtypedef struct local_byte_header {
X    byte version_needed_to_extract[2];
X    byte general_purpose_bit_flag[2];
X    byte compression_method[2];
X    byte last_mod_file_time[2];
X    byte last_mod_file_date[2];
X    byte crc32[4];
X    byte compressed_size[4];
X    byte uncompressed_size[4];
X    byte filename_length[2];
X    byte extra_field_length[2];
X} local_byte_header;
X#endif
X
X#define CENTRAL_FILE_HEADER_SIGNATURE  0x02014b50L
X
X#ifndef NOTINT16            /* v2.0c */
Xtypedef struct central_directory_file_header {
X    UWORD version_made_by;
X    UWORD version_needed_to_extract;
X    UWORD general_purpose_bit_flag;
X    UWORD compression_method;
X    UWORD last_mod_file_time;
X    UWORD last_mod_file_date;
X    byte crc32[4];
X    byte compressed_size[4];
X    byte uncompressed_size[4];
X    UWORD filename_length;
X    UWORD extra_field_length;
X    UWORD file_comment_length;
X    UWORD disk_number_start;
X    UWORD internal_file_attributes;
X    byte external_file_attributes[4];
X    byte relative_offset_local_header[4];
X} central_directory_file_header;
X
X#else   /* NOTINT16 */
Xtypedef struct central_directory_file_header {
X    UWORD version_made_by;
X    UWORD version_needed_to_extract;
X    UWORD general_purpose_bit_flag;
X    UWORD compression_method;
X    UWORD last_mod_file_time;
X    UWORD last_mod_file_date;
X    longint crc32;                  /* v2.0e */
X    longint compressed_size;        /* v2.0e */
X    longint uncompressed_size;      /* v2.0e */
X    UWORD filename_length;
X    UWORD extra_field_length;
X    UWORD file_comment_length;
X    UWORD disk_number_start;
X    UWORD internal_file_attributes;
X    longint external_file_attributes;       /* v2.0e */
X    longint relative_offset_local_header;   /* v2.0e */
X} central_directory_file_header;
X
Xtypedef struct central_directory_byte_header {
X    byte version_made_by[2];
X    byte version_needed_to_extract[2];
X    byte general_purpose_bit_flag[2];
X    byte compression_method[2];
X    byte last_mod_file_time[2];
X    byte last_mod_file_date[2];
X    byte crc32[4];
X    byte compressed_size[4];
X    byte uncompressed_size[4];
X    byte filename_length[2];
X    byte extra_field_length[2];
X    byte file_comment_length[2];
X    byte disk_number_start[2];
X    byte internal_file_attributes[2];
X    byte external_file_attributes[4];
X    byte relative_offset_local_header[4];
X} central_directory_byte_header;
X#endif
X
X#define END_CENTRAL_DIR_SIGNATURE  0x06054b50L
X
X#ifndef NOTINT16            /* v2.0c */
Xtypedef struct end_central_dir_record {
X    UWORD number_this_disk;
X    UWORD number_disk_with_start_central_directory;
X    UWORD total_entries_central_dir_on_this_disk;
X    UWORD total_entries_central_dir;
X    byte size_central_directory[4];
X    byte offset_start_central_directory[4];
X    UWORD zipfile_comment_length;
X} end_central_dir_record;
X
X#else   /* NOTINT16 */
Xtypedef struct end_central_dir_record {
X    UWORD number_this_disk;
X    UWORD number_disk_with_start_central_directory;
X    UWORD total_entries_central_dir_on_this_disk;
X    UWORD total_entries_central_dir;
X    longint size_central_directory;         /* v2.0e */
X    longint offset_start_central_directory; /* v2.0e */
X    UWORD zipfile_comment_length;
X} end_central_dir_record;
X
Xtypedef struct end_central_byte_record {
X    byte number_this_disk[2];
X    byte number_disk_with_start_central_directory[2];
X    byte total_entries_central_dir_on_this_disk[2];
X    byte total_entries_central_dir[2];
X    byte size_central_directory[4];
X    byte offset_start_central_directory[4];
X    byte zipfile_comment_length[2];
X} end_central_byte_record;
X#endif  /* NOTINT16 */
X
X#define DLE 144
X
X#define max_bits 13
X#define init_bits 9
X#define hsize 8192
X#define first_ent 257
X#define clear 256
X
X/* ============================================================= */
X/*
X * Host operating system details
X *
X */
X
X#ifdef UNIX
X
X/* On some systems the contents of sys/param.h duplicates the
X   contents of sys/types.h, so you don't need (and can't use)
X   sys/types.h. */
X
X#include <sys/types.h>
X#include <sys/param.h>
X
X#define ZSUFX ".zip"
X#ifndef BSIZE
X#define BSIZE DEV_BSIZE     /* v2.0c assume common for all Unix systems */
X#endif
X
X#ifndef BSD                 /* v2.0b */
X#include <time.h>
Xstruct tm *gmtime(), *localtime();
X#else   /* BSD */
X#include <sys/time.h>
X#endif
X
X#else   /* !UNIX */
X
X#define BSIZE 512   /* disk block size */
X#define ZSUFX ".ZIP"
X
X#endif
X
X#if defined(V7) || defined(BSD)
X
X#define strchr index
X#define strrchr rindex
X
X#endif
X
X/*  v3.03 Everybody seems to need this.
X * this include file defines
X *             #define S_IREAD 0x0100  (* owner may read *)
X *             #define S_IWRITE 0x0080 (* owner may write *)
X * as used in the creat() standard function
X */
X#ifndef __TURBOC__	/* it's already included */
X#include <sys/stat.h>	/* for S_IWRITE, S_IREAD  v3.03 */
X#endif
X
X#ifdef __STDC__
X
X#include <string.h>
X /* this include defines strcpy, strcmp, etc. */
X
X#else
X
Xchar *strchr(), *strrchr();
X
X#endif
X
Xlong lseek();
X
X#define SEEK_SET  0
X#define SEEK_CUR  1
X#define SEEK_END  2
X
X#ifdef V7
X
X#define O_RDONLY  0
X#define O_WRONLY  1
X#define O_RDWR    2
X
X#else   /* !V7 */
X
X#include <fcntl.h>
X /*
X  * this include file defines
X  *             #define O_BINARY 0x8000  (* no cr-lf translation *)
X  * as used in the open() standard function
X  */
X
X#endif  /* V7 */
X
X#ifdef __TURBOC__
X/* v2.0b Local Prototypes */
X    /* In CRC32.C */
Xextern void UpdateCRC(register unsigned char *s, register int len);
X    /* In MATCH.C */
Xextern int match(char *string, char *pattern);
X    /* v2.0j in mapname.c */
Xextern int mapped_name(void);
X
X#ifdef NOTINT16         /* v2.0c */
X/* The next two are only prototyped here for debug testing on my PC
X * with Turbo C.
X */
X
XUWORD makeword(byte *b);
Xlongint makelong(byte *sig);    /* v2.0e */
X#endif  /* NOTINT16 */
X
Xint ReadByte(UWORD *x);
Xint FillBitBuffer(register int bits);
Xvoid LoadFollowers(void);
Xvoid FlushOutput(void);
Xvoid partial_clear(void);
Xint create_output_file(void);
Xvoid unShrink(void);
Xvoid unReduce(void);
Xvoid unImplode(void);
Xvoid set_file_time(void);
Xint readbuf(int fd, char *buf, register unsigned size);
Xvoid get_string(int len, char *s);
Xvoid dir_member(void);
Xvoid extract_member(void);
Xvoid skip_member(void);
Xvoid process_local_file_header(char **fnamev);
Xvoid process_central_file_header(void);
Xvoid process_end_central_dir(void);
Xint open_input_file(void);
Xvoid process_headers(void);
Xvoid usage(void);
Xvoid process_zipfile(void);
X#endif  /* __TURBOC__ */
X
X/* ------------------------------------------------------------- */
X
X/* v3.05 Deleting  crc32.h and incorporating its two lines right here */
X/* #include "crc32.h" */
X
Xunsigned long crc32val;
X#ifndef __TURBOC__	/* it's already been prototyped above */
Xvoid UpdateCRC();
X#endif
X
X#define LF 10		/* '\n' on ascii machines.  Must be 10 due to EBCDIC */
X#define CR 13		/* '\r' on ascii machines.  Must be 13 due to EBCDIC */
X
X#ifdef EBCDIC
Xextern unsigned char ebcdic [];
X#define ascii_to_native(c) ebcdic[(c)]
X#else
X#define ascii_to_native(c) (c)
X#endif
X
X#define OUTB(intc) { *outptr++=intc; if (++outcnt==OUTBUFSIZ) FlushOutput(); }
X
X/*
X *  macro OUTB(intc)
X *  {
X *      *outptr++=intc;
X *      if (++outcnt==OUTBUFSIZ)
X *          FlushOutput();
X *  }
X *
X */
X
X#define READBIT(nbits,zdest) { if (nbits <= bits_left) { zdest = (int)(bitbuf & mask_bits[nbits]); bitbuf >>= nbits; bits_left -= nbits; } else zdest = FillBitBuffer(nbits);}
X
X/*
X * macro READBIT(nbits,zdest)
X *  {
X *      if (nbits <= bits_left) {
X *          zdest = (int)(bitbuf & mask_bits[nbits]);
X *          bitbuf >>= nbits;
X *          bits_left -= nbits;
X *      } else
X *          zdest = FillBitBuffer(nbits);
X *  }
X *
X */
END_OF_FILE
if test 10690 -ne `wc -c <'unzip.h'`; then
    echo shar: \"'unzip.h'\" unpacked with wrong size!
fi
# end of 'unzip.h'
fi
if test -f 'unzip.os2' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unzip.os2'\"
else
echo shar: Extracting \"'unzip.os2'\" \(9658 characters\)
sed "s/^X//" >'unzip.os2' <<'END_OF_FILE'
X[These patches have NOT been installed as of v3.10.
X David Kirschbaum
X Info-ZIP Coordinator
X]
X
XReceived: by mcsun.EU.net via EUnet; Fri, 18 May 90 20:50:40 +0200 (MET)
XReceived: from lena by kestrel.Ukc.AC.UK   with UUCP  id aa00758;
X          18 May 90 18:19 BST
XReceived: by lena with netmail(8.73); Fri May 18 14:30:13 BST 1990
XDate: Fri May 18 14:30:13 BST 1990
XX-Mailer: Mail User's Shell (7.0.4 1/26/90)
XFrom: Mike O'Carroll <mike@elec-eng.leeds.ac.uk>
XMessage-Id: <4867.9005181430.lena@lena.uucp>
XTo: kirsch@usasoc.soc.mil
XSubject: unzip30
X
XI'm not sure if anyone else has done this, but I have made a Dos & OS/2
Xversion of unzip.  The cdiffs are below.  The supplied makefile (unzip)
Xgenerates a family program which executes in both Dos and OS/2 modes.
XI can supply the .exe if required (31K).
X
XThe mods took 15 minutes, and the result has undergone 35 seconds
Xtesting (:-) ; I had one .ZIP file to unzip, and it worked OK, but no
Xgreat confidence yet.
X
XBTW, can I get a corresponding ZIP from somewhere?  Simtel20?
X
XRegards,
X        Mike
X
X-------------------------
X#       This is a shell archive.
X#       Remove everything above and including the cut line.
X#       Then run the rest of the file through sh.
X#-----cut here-----cut here-----cut here-----cut here-----
X#!/bin/sh
X# shar: Shell Archiver
X#       Run the following text with /bin/sh to create:
X#       match.dif
X#       unzip.dif
X#       unzip
X# This archive created: Fri May 18 14:20:18 BST 1990
Xif [ -f 'match.dif' ] ; then
Xecho shar: will not overwrite existing file \'match.dif\' >&2
Xelse
Xcat << \SHAR_EOF >'match.dif'
X*** match.c     Fri May 18 13:54:07 1990
X--- Dmatch.c    Fri May 18 13:54:15 1990
X***************
X*** 10,15
X   * 11/13/89  C. Mascott     adapt for use with unzip
X   * 01/25/90  J. Cowan       match case-insensitive
X   * 03/17/90  D. Kirschbaum      Prototypes, other tweaks for Turbo C.
X   *
X   */
X  
X
X--- 10,16 -----
X   * 11/13/89  C. Mascott     adapt for use with unzip
X   * 01/25/90  J. Cowan       match case-insensitive
X   * 03/17/90  D. Kirschbaum      Prototypes, other tweaks for Turbo C.
X+  * 18-may-90 M. O'Carroll   Dos & OS/2 family version
X   *
X   */
X  
X***************
X*** 24,29
X   *        This file contains service routines needed to maintain an archive.
X   */
X  
X  #include <sys/types.h>
X  #include <sys/dir.h>
X  #include <ctype.h>
X
X--- 25,31 -----
X   *        This file contains service routines needed to maintain an archive.
X   */
X  
X+ #ifdef MSC
X  #include <sys/types.h>
X  #include <ctype.h>
X  #include <stdio.h>
X***************
X*** 25,30
X   */
X  
X  #include <sys/types.h>
X  #include <sys/dir.h>
X  #include <ctype.h>
X  
X
X--- 27,36 -----
X  
X  #ifdef MSC
X  #include <sys/types.h>
X+ #include <ctype.h>
X+ #include <stdio.h>
X+ #else
X+ #include <sys/types.h>
X  #include <sys/dir.h>
X  #include <ctype.h>
X  #endif
X***************
X*** 27,32
X  #include <sys/types.h>
X  #include <sys/dir.h>
X  #include <ctype.h>
X  
X  #ifdef __TURBOC__               /* v2.0b */
X  #include <stdio.h>      /* for printf() */
X
X--- 33,39 -----
X  #include <sys/types.h>
X  #include <sys/dir.h>
X  #include <ctype.h>
X+ #endif
X  
X  #ifdef __TURBOC__               /* v2.0b */
X  #include <stdio.h>      /* for printf() */
XSHAR_EOF
Xfi
Xif [ -f 'unzip.dif' ] ; then
Xecho shar: will not overwrite existing file \'unzip.dif\' >&2
Xelse
Xcat << \SHAR_EOF >'unzip.dif'
X*** unzip.c     Fri May 18 13:52:51 1990
X--- Dunzip.c    Fri May 18 13:53:00 1990
X***************
X*** 63,68
X  
X  #endif
X  
X  #define min(a,b) ((a) < (b) ? (a) : (b))
X  
X  #ifndef ZMEM                            /* v2.0f use your system's stuff */
X
X--- 63,77 -----
X  
X  #endif
X  
X+ /* Added stuff for MSC Dos & OS/2 family version - Mike O'Carroll, 18-May-90
X+  */
X+ #ifdef MSC
X+ #include <os2.h>
X+ #include <sys/types.h>
X+ #include <io.h>         /* for setftime(), dup(), creat() */
X+ #include <sys/stat.h>   /* for S_IWRITE, S_IREAD */
X+ #include <memory.h>     /* for memcpy() */
X+ #else
X  #define min(a,b) ((a) < (b) ? (a) : (b))
X  #endif /* MSC */
X  
X***************
X*** 64,69
X  #endif
X  
X  #define min(a,b) ((a) < (b) ? (a) : (b))
X  
X  #ifndef ZMEM                            /* v2.0f use your system's stuff */
X  #define zmemcpy memcpy
X
X--- 73,79 -----
X  #include <memory.h>     /* for memcpy() */
X  #else
X  #define min(a,b) ((a) < (b) ? (a) : (b))
X+ #endif /* MSC */
X  
X  #ifndef ZMEM                            /* v2.0f use your system's stuff */
X  #define zmemcpy memcpy
X***************
X*** 473,478
X    */
X  {
X  #ifndef UNIX
X      union {
X          struct ftime ft;        /* system file time record */
X          struct {
X
X--- 483,489 -----
X    */
X  {
X  #ifndef UNIX
X+ #   ifdef MSC
X      union {
X          FDATE fd;               /* system file date record */
X          UWORD zdate;            /* date word */
X***************
X*** 474,479
X  {
X  #ifndef UNIX
X      union {
X          struct ftime ft;        /* system file time record */
X          struct {
X                  UWORD ztime;     /* date and time words */
X
X--- 485,511 -----
X  #ifndef UNIX
X  #   ifdef MSC
X      union {
X+         FDATE fd;               /* system file date record */
X+         UWORD zdate;            /* date word */
X+     } ud;
X+ 
X+     union {
X+         FTIME ft;               /* system file time record */
X+         UWORD ztime;            /* time word */
X+     } ut;
X+ 
X+     FILESTATUS fs;
X+ 
X+     DosQFileInfo(outfd, 1, &fs, sizeof(fs));
X+     ud.zdate = lrec.last_mod_file_date;
X+     fs.fdateLastWrite = ud.fd;
X+     ut.ztime = lrec.last_mod_file_time;
X+     fs.ftimeLastWrite = ut.ft;
X+     DosSetFileInfo(outfd, 1, &fs, sizeof(fs));
X+ 
X+ #   else /* MSC */
X+ 
X+     union {
X          struct ftime ft;        /* system file time record */
X          struct {
X                  UWORD ztime;     /* date and time words */
X***************
X*** 490,495
X      td.zt.zdate = lrec.last_mod_file_date;
X  
X      setftime(outfd, &td.ft);
X  
X  #else   /* UNIX */
X  
X
X--- 522,529 -----
X      td.zt.zdate = lrec.last_mod_file_date;
X  
X      setftime(outfd, &td.ft);
X+ 
X+ #   endif /* MSC */
X  
X  #else   /* UNIX */
X  
XSHAR_EOF
Xfi
Xif [ -f 'unzip' ] ; then
Xecho shar: will not overwrite existing file \'unzip\' >&2
Xelse
Xcat << \SHAR_EOF >'unzip'
X# For MSC brian damaged (:-) make.  To generate Dos & OS/2 version, type
X# "make unzip"
X#
X# I used Microsoft C V5.1, with the SDK.
X#
X# The following comments come from the Unix Makefile, and most may
X# well be irrelevant to the Dos version.
X#       Mike O'Carroll 18-May-90 <mike@ee.leeds.ac.uk>
X# -----------------------------------------------------------------------
X#
X# "make vaxbsd" -- makes unzip on a VAX 11-780 BSD 4.3 in current directory
X# "make"        -- uses environment variable SYSTEM to set the type
X#                  system to compile for.
X# "make wombat" -- Chokes and dies if you haven't added the specifics
X#                  for your Wombat 68000 (or whatever) to the systems list.
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
XCC = cl
XCFLAGS = -DMSC
XLD = link
XLDFLAGS = /NOI
XRM = del
XLIBC = c:\m5\lib\p\slibce
XLIBD = c:\m5\lib\doscalls.lib
XLIBA = c:\m5\lib\api.lib
XINCL = -Ic:\m5\include
X
XOBJ1 = unzip.obj crc32.obj match.obj ascebc.obj mapname.obj
XOBJ2 = zmemset.obj zmemcpy.obj
X
X.c.obj:
X        $(CC) -c $(CFLAGS) $(INCL) $*.c
X
Xunzip.obj:      unzip.c
X
Xcrc32.obj:      crc32.c
X
Xmatch.obj:      match.c
X
Xascebc.obj:     ascebc.c
X
Xmapname.obj:    mapname.c
X
Xzmemset.obj:    zmemset.c
X
Xzmemcpy.obj:    zmemcpy.c
X
Xunziptmp.exe:   $(OBJ1) $(OBJ2)
X        $(LD) $(LDFLAGS) $(OBJ1) $(OBJ2), $*.exe,,$(LIBC)+$(LIBD);
X
Xunzip.exe:      unziptmp.exe
X        bind unziptmp.exe $(LIBD) $(LIBA) -o unzip.exe
X        $(RM) unziptmp.exe
X        $(RM) *.obj
X        $(RM) *.map
XSHAR_EOF
Xfi
X
X-- 
XMike O'Carroll, Microsystems Unit, University of Leeds, LS2 9JT, UK
XE-mail: @ukc.ac.uk:mike@ee.leeds.ac.uk
XUUCP:   ...!mcsun!ukc!lena!mike or mike@lena.uucp
END_OF_FILE
if test 9658 -ne `wc -c <'unzip.os2'`; then
    echo shar: \"'unzip.os2'\" unpacked with wrong size!
fi
# end of 'unzip.os2'
fi
echo shar: End of archive 2 \(of 3\).
cp /dev/null ark2isdone
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
