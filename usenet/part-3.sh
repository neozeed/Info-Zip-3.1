#! /bin/sh
# This is a shell archive.  Remove anything before this line, then unpack
# it by saving it into a file and typing "sh file".  To overwrite existing
# files, type "sh file -c".  You can also feed this as standard input via
# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
# will see the following message at the end:
#		"End of archive 3 (of 3)."
# Contents:  history.310 unzip.c
# Wrapped by kirsch@usasoc.soc.mil on Fri Aug 31 11:37:53 1990
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
if test -f 'history.310' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'history.310'\"
else
echo shar: Extracting \"'history.310'\" \(18493 characters\)
sed "s/^X//" >'history.310' <<'END_OF_FILE'
X********************************
Xv3.10, 16 Aug 90
X- No significant changes.  Two new systems added to Makefile.
X- Dif file required for Coherent installation in coherent.msg.
X- Dif files required for Atari (Turbo C v2.0) in atari.zip
X  (atari.hdr is msg header for initial uuencoded transfer).
X  These dif files are for an earlier version (v3.06?) and may need
X  some tweaking to patch smoothly.
X  They (and the Coherent patches) have NOT been installed.     
X
XVersion 3.10 will be the current "fielded" version until further notice.
XNo patches to earlier versions will be accepted.
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
X********************************
Xv3.07, 30 Jul 90
X- No changes. Just a new addition to the Makefile (see below).
X  Changing internal version number to v3.07 and updating archives
X  at SIMTEL20.
X
XThings have been stable for a LONG time, so it's time to send a tar
Xto the uunet boys for archiving over there.
X
X>today I picked up version 3.05 of unzip and got it running OK in very
X>little time on out IBM RT 6150 under AIX 2.2.1. The only thing necessary
X>was to add a line:
X>rtaix: _16zmem # IBM RT 6150 under AIX 2.2.1
X>in the Makefile, and <make rtaix> does the rest.
X>
X>Erik-Jan Vens
X>Interdisciplinary Center for the development of Computer Coaches and
X>Expertsystems
X>University of Groningen, the Neths.
X>Vens@Rug.Nl
X
X*********************************
Xv3.06, 26 May 90
X  - Patches to fix a bug that sneaked in to the header parsing in unzip.c.
X  - New system (68000-type), plus small tweaks to Makefile.
X  - Minor changes to "usage" display.
X
X*********************************
Xv3.05, 25 May 90
X  - Bill Davidsen tweaked mapname.c to solve some problems.
X    Then he cleaned up Makefile to solve the identical-system problems.
X  - He also did a hack on unzip.c to provide "ask before overwrite".
X    (Bill's a busy lad, ne?)
X  - James Dugal provided a patch for skip_to_signature to solve a problem
X    with his Pyramid system (once again, unsigned char-related).
X    He also added a small eof-trapping routine during signature scan.
X  - Several requests to break up unzip.c into smaller pieces (but by
X    function or logically, not just arbitrarily by line numbers or whatever).
X    We can do that!  Now have separate files for file I/O (file_io.c),
X    the different unzip algorithms (unimplod.c, [unreduce.c, unshrink.c),
X    and one big unzip.h with lots of defines, etc.
X    Makes unzip.c smaller, anyway.
X    crc32.h is gone now .. its two lines are incorporated in unzip.h
X
X*********************************
Xv3.04, 22 May 90
X  - Commented out ae_buf() in ascec.c (no longer used) with Warner
X    Losh's changes to CR/LF conversion.
X  - Trying out Warner's patch to enable unzip to work with self-extracting
X    ".EXE" files (via bruteforce feeling about for the first file header).
X    He warns this byte-by-byte read will be sloooow .. yeah, sure, we could
X    do something flash with a big buffer read .. but who needs it?  How
X    often will we be processing self-extracting file headers, after all? 
X  - Bo Kullmar (all the way from Sweden!) had the nicest patch for the
X    changed help display, so his shall be implemented.  (How's instant world
X    fame feel, Bo?)
X  - Got two submissions of the same kinda fix for the duplicate system
X    requirement problem (crudely fixed in v3.03).  Nice, elegant, except
X    it don't work on my Vax BSD system!  Ah well, I installed the fix anyway
X    in Makefile.  If you have problems, examine the vaxbsd portion to see
X    if you might have to drop back to brute force.
X
X*******************************************
X- v3.03
X   Reconciliation of earlier patches from Warner Losh, plus fix to
X   make stat() work.
X
X   New Makefile with separate commands for each different system
X   (too many makes didn't like things like
X     wombat:	# thanks to Joe Isuzu
X     sun4:	#
X		cc etc. etc.
X   )
X
X   unzip will NOT work on self-extracting .EXE files (a problem with how
X   it looks for the first file header).
X
XThe file unzp303s.arc (source)  will be distributed via EMail to Info-ZIP
Xmembers.  (It'll include the latest Makefile, all source files, plus this
Xmessage.)  No significant changes to documentation, so no separate distribution
Xof that stuff via a separate unzp303d.arc.
X
XAs usual, EVERYTHING will be in unzip303.arc and unzip303.tar-Z at
XSIMTEL20.
X****************************************
X- v3.02 continued
X
XDate: Tue, 15 May 90 22:19:39 MDT
XFrom: imp@Solbourne.COM (Warner Losh)
XTo: info-zip@wsmr-simtel20.army.mil
XSubject: Patch for .exe problem.
X
XHere is a patch for the problem that was reported about not being able
Xto extract a zip file named foo.exe.  I don't know of any problems
Xwith this patch.  It should work on any system that knows about the
Xstat command.  If you suspect this patch is causing you problems, then
Xjust add -DREALOLDSTUFF to your CFLAGS line in the Makefile and it
Xwill compile the old way.
X
XWarner Losh             imp@Solbourne.COM
X
X[Applied via patch to v3.02.  Actual patch is in patchexe.pch file.
X Since v3.02 hasn't REALLY been fielded yet,
X no change to version number.
X
XThis patch, with its use of the stat() function, didn't want to work on
Xmy BSD 4.3 system (problems with stat() always returning a -1, not being
Xable to define a struct stat variable, etc.).
XReplaced the "file-existence" testing with the access() function
Xand it worked just fine!  You can now direct unzip to any target file at all.
Xunzip will check for that file's existence, and if not found, will add a
X".zip" and try again.  That oughtta take care of LEVELS.ZIP, selfextr.exe,
Xand so forth. 
X
XMy system is now working perfectly, using various combinations of the
X-a and -m switch.  No CRC errors, file end-of-line conversion is working
Xwell, etc.
X
X19 May 90
X David Kirschbaum
X Toad Hall
X]
X***********************************************
X-v 3.02
X
XDate: Wed, 9 May 90 11:27:39 MDT
XTo: info-zip@wsmr-simtel20.army.mil
XSubject: Patch for the -a CRC problem.
XFrom: imp@Solbourne.COM (Warner Losh)
X
XGreetings...
X
Xsince it looks like David is going away for a while, here are the
Xcontext diffs to 3.0 to make it quit bitching about CRC problems when
Xit unpacks incorrectly.  I didn't patch the existing code.  I rewrote
Xit so that all writes go though FlushBuffer which calls WriteBuffer
Xwhich might call dos2unix to map <CR><LF> to just <LF>.  Note:  I
Xthink I broke EBCDIC in the process.  Lemme know what you think of
Xthese patches.  They worked for me a dozen times on this sun4 I have.
XI'd be interested in knowing where else they work.
X
XOh yah, if the last character of the buffer is <CR>, then weird things
Xwill happen (more than likely it will do nothing).  There is a bug
Xthat in what I sent to David that causes a buffer overflow (dos2unix
Xlooks at too many character) in reading (but not in writing.  The one
Xline fix is to add i++ where you see it in this context diff.
X
XWarner Losh
Ximp@Solbourne.COM
X[Applied to v3.01, producing v3.02.
X Patch itself is in the file losh.pat
X David Kirschbaum
X Toad Hall
X]
X
X***************************************  
X- v3.01  
X
XFrom: Bo Kullmar <bk@kullmar.se>
XAs far as I understand there is a little bug in version 3.0 with option -a.
XThe resulting file will be one character to long compared to a file that is
Xconverted separately. It is due to the fact that the first element in the
Xbuffer is 0 and the ocount goes from 1 to ...
X
XThis does not solve the bug with reporting wrong CRC.
X
XThe CR conversion must only be performed if there is a CR+LF. Not if there
Xonly is a CR. This patch fixes this also.
X
XI noticed that the text for the -a option is worg. It does not change CR
Xto space, it removes CR.
X
XToad Hall: Added the HP 9000/HP-UX makerules to Makefile
X           Consolidated several system makerules to clean up a little.
X****************************************** 
X- v3.0
X   Moderate friendly pressure from Keith Petersen, Keeper of the Archives
X   at SIMTEL20, to "get this sucker out the door" (or words to that effect).
X   SHOT.  OUT.
X   (And thanks to all the contributors of Info-ZIP!  Nice work, people!)
X   David Kirschbaum
X   Coordinator (?) Info-ZIP
X******************************************
X *
X * v2.0j, 25 Apr 90
X * After MUCH discussion, adding a "-m" switch to map extracted member
X * filenames to lower case (if upper case).
X * (Scan for "mapped_name" function and "mflag" switch.)
X * Recently revealed problem re MS-DOS PKZIP'ed files and paths:
X * Now stripping all paths from member filenames.
X * (All this stuff in mapname.c)
X * David Kirschbaum
X * Toad Hall
X *
X * v2.0i, around 20 Apr 90
X * Changes to Makefile only.  Distributed via EMail, SIMTEL archives updated.
X************************************
X * 13 Apr 90 v2.0h
X
XGeneral synopsis of changes from v2.0g to 2.0h:
X
XFrom Bill Davidsen
X   (davidsen@crdos1.crd.GE.COM -or- uunet!crdgw1!crdos1!davidsen)
X
XFixed Makefile up.
X
X  Also, the inclusion of types.h for O_BINARY is wrong... this is DOS
Xstuff, not needed in UNIX. I put #ifndef UNIX around it to keep it from
Xcausing trouble. All of the code which uses it is also ifndef'd, so this
Xcan't break anything.
X[Looks like it's MTS stuff also.]
X
XRemoved a duplicate define.
X
XFixed the -a switch:
X
XAs implemented it totally breaks C programs being unzipped from DOS to
XUNIX. The option changes the return to a blank instead of deleting it.
XSince C requires that continuation be noted with a \ *as the last
Xcharacter on a line* this breaks the program.
X
X  Some editors don't strip or ignore trailing blanks, and when
Xreformatting paragraphs this results in two blanks between words, or
Xeven the lines not being joined.
X
X  In short, this is a hack which can badly mangle the files on which
Xit's used. I will look to see if the logic will support simply deleting
Xthe returns. Proper logic should be to delete a return only if it is
Xfollowed by a newline, since any other logic breaks embedded returns
Xused for overstrike.
X
X...
X
X  Well, it turned out not to be too hard to fix the -a option to do the
Xright thing and simply remove the offending returns. I didn't look too
Xclosely, but I'm not sure this ever worked, since the test for return
Xwas made after the character had been translated into EBCDIC. Perhaps
Xthe table lookup turned the return into a space.
X
X  After testing on sun, convex, encore, stellar, and xenix, here are the
Xfinal diffs I had to make to get 20g working. Would someone please test
Xthem on a EBCDIC machine?
X
X[Diffs were removed, but they affected:
XMakefile:
Xunzip.c:
Xascebc.c:
X]
X
X  Still doesn't seem to work on 64 bit machines.
X
X*******************
X
XAnd from Forrest Gehrke, for his VAX SysV system:
X
XOk, here's the story for VAX SysV:
X
XSysV chokes on an #include David added, to wit:  [NOT me!]
X  #include <sys/file.h>  // v2.0g Chitra says MTS needs this for O_BINARY //
X
XSo, that line will have to be handled as an #ifdef MTS conditional
Xand a Makefile rule change added to have that compiler conditionally
Xinclude that file.
X
X[We've made it an #ifdef MTS.
X However, I'm waiting for an authentic MTS hacker to produce and authenticate
Xthe requirement with a new Makefile.
X]
X
XAs to the Makefile, I have found that the recipe provided
Xfor "encore" does the job.  I have added an identical 
Xlayout with the exception of a "system" label called
X   vaxsysV
XA copy of that Makefile is included herewith:  [Eaten in the mail]
X
X*********************
X
XAbove comments consolidated from a number of Info-ZIP messages in prep for
Xthe v2.0h release.
X
XDavid Kirschbaum
Xkirsch@usasoc.soc.mil, 13 Apr 90
X
X*************************************************
X* 7 Apr 90 v2.0g
X * - Incorporated Allan Bjorklund's -a buffer bug fix.
X *   The old contents of outbuf are used by unzip to extract the next
X *   block of data.  The fix involved setting up an auxillary buffer to hold
X *   the translated material so that outbuf could be left alone.
X *   Just scan for "outout" to see where he (and I) made the changes.
X *   (I tightened up his code a little in FlushOutput(), whether to
X *   allocate outout at all, when/how to output from outout ).
X * - Found and fixed the couple of bogus UWORDs that sneaked in during a
X *   global search-and-replace (like "UWORDp").
X * - Took a couple Sun-related error (mine) out of Makefile.
X *
X * 03/28/90 v2.0f
X * - Using a REAL complicated Makefile that sets makerules for all sorts
X *   of different systems.
X *   See Makefile to see if this'll compile on your system.
X * - Added Allan Bjorklund's patch to enable EBCDIC/EOL conversion
X *   during output to stdout.
X * - Changed the typedef "word" to UWORD throughout.  (Known conflict on
X *   Crays.)
X * - Changed "memcpy()" and "memset()" throughout to "zmemcpy()" and
X *   "zmemset()".  This is for the situation where some systems' library
X *   memcpy() and/or memset() don't work properly .. or don't exist at all.
X *   A compile define ("-DZMEM") enables use of our own functions
X *   (in zmemcpy.c and zmemset.c).  Members suggested we not use the
X *   ANSI-defined function names in that case.
X *   If you have NOT used the "-DZMEM", no problem .. the library's
X *   memcpy() and memset() will be used.
X *
X * 03/23/90 v2.0e
X * - Allan Bjorklund's tweaks: (allanb@us.cc.umich.edu)
X * I've also added another switch to the program for ASCII->EBCDIC
X * conversion.  If your wondering why I would do such a thing, it
X * is because I manage two archives sites. One on the SUN I'm working on
X * now (terminator) and one on an IBM 3090-600E (um{ub}mts.cc.umich.edu).
X * After I had gotten the code for the ascii->ebcdic working, I rearranged
X * the defines so the for people not using ebcdic on their system could
X * use it to convert 0x0D to 0x20.  I find it real annoying to see ^M
X * at the end of the lines of text while in vi.  The option can be invoked
X * with -a.
X *
X * Toad Hall Notes:
X * Alan's changes include a new cmdline "-a" flag, a new "ascebc.c" file,
X * and a new "Makefile".  Define "EBCDIC" to enable the ebcdic conversion.
X * (And I'd be REAL careful if I were you about just which files you
X * used that "-a" switch for CR/LF -> LF conversion in a Unix system.)
X *
X * Re other portability problems, turns out the problem is in the memcpy()
X * routines (along with general confusion about other compile defines.
X * We'll have a separate doc ref how to compile on different systems.
X * David Kirschbaum
X *
X * 03/20/90  D. Kirschbaum v2.0d
X *      - Found a bug down in FillBitBuff() (introduced in v2.0c).
X *        Fixed.  While I was hunting that, I changed a bunch of
X *        long variables to unsigned longs (AKA longint) just to
X *        be nice and consistent.
X *        The structures seem to work fine now with the NOTINT16
X *        compiler flag enabled.  Strangely, on my VAX 11-780,
X *        the first structure in each pair (the one with the longs)
X *        is two bytes longer than the byte-defined structure.
X *        Your mileage may vary (enable DEBUG to see what I mean).
X *      - davidsen@crdos1.crd.ge.com cleaned up a bunch of the
X *        ifdef's, and re-enabled the LONGI macros.  He also
X *        picked up an unnecessary address override.
X *
X * 03/19/90  D. Kirschbaum v2.0c
X *              - Many problems with structures (since different machines
X *                align words and longs differently, have different sizes
X *                of words and longs, etc.
X *                Fixing by reading our structures into a working
X *                structure that's ALL bytes, and then processing each
X *                and every bloody word and long into a separate structure
X *                properly defined as words, longs, etc.
X *                Define "NOTINT16" to make this happen.
X *                (With that above define, it STILL compiles and runs fine
X *                with Turbo C.)
X *                NO idea what'll happen with "bigendian" processors!
X *
X * 03/16/90  D. Kirschbaum v2.0b Hacked back to Turbo C v2.0 and BSD 4.3
X *              - Added a bunch of Turbo- and BSD 4.3-unique (I guess)
X *                #include <>'s.
X *              - Prototyped everything to reduce Turbo C warnings.
X *              - Removing the Daylight Savings Time adjustment for file
X *                times.  (They're throwing the file time off by an hour
X *                on my BSD system.)
X *              - Changed target .zip filename ".zip" appending
X *                so it can deal with paths like "..\subdir\filename".
X *                (Original would catch the first "." and not add the zip.)
X *              - Including .TC and .PRJ files for Turbo C compiles.
X *              - Including Makefile.BSD for Unix BSD compiles.
X *                (Rename to Makefile and "make unzip".)
X *              MUCH better version than the horrible I've been hacking at
X *              for the past couple of months.  Everyone throw that old
X *              unzip23 away!
X *              Compiles just fine on my DOS 3.1 clone, Turbo C v2.0,
X *              and on my Vax 11-780, BSD 4.3.
X *              David Kirschbaum
X *              Toad Hall
X *
X * 12/14/89  C. Mascott  2.0a   adapt for UNIX
X *              ifdef HIGH_LOW swap bytes in time, date, CRC,
X *                version needed, bit flag
X *              implement true s-f trees instead of table
X *              don't pre-allocate output file space
X *              implement -t, -v, member file specs
X *              buffer all input
X *              change hsize_array_integer to short
X *              overlap storage used by different comp. methods
X *              speed up unImplode
X *              use insertion sort in SortLengths
X *              define zipfile header structs in a way that
X *                avoids structure padding on 32-bit machines
X *              fix "Bad CRC" msg: good/bad CRCs were swapped
X *              check for write error on output file
X *              added by John Cowan <cowan@magpie.masa.com>:
X *              support -c option to expand to console
X *              use stderr for messages
X *              allow lowercase component name specs
X *
END_OF_FILE
if test 18493 -ne `wc -c <'history.310'`; then
    echo shar: \"'history.310'\" unpacked with wrong size!
fi
# end of 'history.310'
fi
if test -f 'unzip.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unzip.c'\"
else
echo shar: Extracting \"'unzip.c'\" \(22987 characters\)
sed "s/^X//" >'unzip.c' <<'END_OF_FILE'
X/*
X * Copyright 1989 Samuel H. Smith;  All rights reserved
X *
X * Do not distribute modified versions without my permission.
X * Do not remove or alter this notice or any other copyright notice.
X * If you use this in your own program you must distribute source code.
X * Do not use any of this in a commercial product.
X *
X */
X
X/*
X * UnZip - A simple zipfile extract utility
X *
X * Compile-time definitions:
X * See the Makefile for details, explanations, and all the current
X * system makerules.
X *
X * If you have to add a new one for YOUR system, please forward the
X * new Makefile to kirsch@usasoc.soc.mil for distribution.
X * Be SURE to give FULL details on your system (hardware, OS, versions,
X * processor, whatever) that made it unique.
X *
X * REVISION HISTORY : See history.307 (or whatever current version is)
X *
X */
X
X#include "unzip.h"	/* v3.05 a BUNCH of ifdefs, etc.
X			 * split out to reduce file size.
X			 * David Kirschbaum
X			 */
X
Xchar *fnames[2] = { /* default filenames vector */
X    "*",
X    NULL
X};
Xchar **fnv = &fnames[0];
X
Xint tflag;      /* -t: test */
Xint vflag;      /* -v: view directory */
Xint cflag;      /* -c: output to stdout (JC) */
Xint aflag;      /* -a: do ascii to ebcdic translation 2.0f */
X                /*     OR <cr><nl> to <nl> conversion  */
Xint mflag;	/* -m: map member filenames to lower case v2.0j */
Xint CR_flag = 0; /* When last char of buffer == CR */
X
Xint members;
Xlongint csize;
Xlongint ucsize;
Xlongint tot_csize;
Xlongint tot_ucsize;
X
X
X/* ----------------------------------------------------------- */
X/*
X * shrink/reduce working storage
X *
X */
X
Xint factor;
X/* really need only 256, but prefix_of, which shares the same
X   storage, is just over 16K */
Xbyte followers[257][64];    /* also lzw prefix_of, s-f lit_nodes */
Xbyte Slen[256];
X
Xtypedef short hsize_array_integer[hsize+1]; /* was used for prefix_of */
Xtypedef byte hsize_array_byte[hsize+1];
X
Xshort *prefix_of = (short *) followers; /* share reduce/shrink storage */
Xhsize_array_byte suffix_of;     /* also s-f length_nodes */
Xhsize_array_byte stack;         /* also s-f distance_nodes */
X
Xint codesize;
Xint maxcode;
Xint free_ent;
Xint maxcodemax;
Xint offset;
Xint sizex;
X
X/* Code now begins ( .. once more into the Valley of Death.. ) */
X
X
X#ifdef NOTINT16     /* v2.0c */
XUWORD makeword(b)
Xbyte * b;
X /* convert Intel style 'short' integer to non-Intel non-16-bit
X  * host format
X  */
X{
X/*
X    return  ( ((UWORD) (b[1]) << 8)
X            | (UWORD) (b[0])
X            );
X*/
X    return  ( ( b[1] << 8)
X            | b[0]
X            );
X}
X
Xlongint makelong(sig)
Xbyte *sig;
X /* convert intel style 'long' variable to non-Intel non-16-bit
X  * host format
X  */
X{
X    return ( ((longint) sig[3]) << 24)
X          + ( ((longint) sig[2]) << 16)
X          + ( ((longint) sig[1]) << 8)
X          +   ((longint)  sig[0]) ;
X}
X#endif  /* NOTINT16 */
X
X#ifdef HIGH_LOW
X
Xvoid swap_bytes(wordp)
XUWORD *wordp;
X /* convert Intel style 'short int' variable to host format */
X{
X    char *charp = (char *) wordp;
X    char temp;
X
X    temp = charp[0];
X    charp[0] = charp[1];
X    charp[1] = temp;
X}
X
Xvoid swap_lbytes(longp)
Xlongint *longp;
X /* convert intel style 'long' variable to host format */
X{
X    char *charp = (char *) longp;
X    char temp[4];
X
X    temp[3] = charp[0];
X    temp[2] = charp[1];
X    temp[1] = charp[2];
X    temp[0] = charp[3];
X
X    charp[0] = temp[0];
X    charp[1] = temp[1];
X    charp[2] = temp[2];
X    charp[3] = temp[3];
X}
X
X#endif /* HIGH_LOW */
X/* ----------------------------------------------------------- */
X
X#include "file_io.c"		/* v3.05 file-related vars, functions */
X
X#include "unreduce.c"		/* v3.05 */
X
X#include "unshrink.c"		/* v3.05 */
X
X#include "unimplod.c"		/* v3.05 */
X
X
X/* ---------------------------------------------------------- */
X
X/*
X Length  Method   Size  Ratio   Date    Time   CRC-32    Name
X ------  ------   ----- -----   ----    ----   ------    ----
X  44004  Implode  13041  71%  11-02-89  19:34  88420727  DIFF3.C
X */
X
Xvoid dir_member()
X{
X    char *method;
X    int ratio;
X    int yr, mo, dy, hh, mm;
X
X    yr = (((lrec.last_mod_file_date >> 9) & 0x7f) + 80);
X    mo = ((lrec.last_mod_file_date >> 5) & 0x0f);
X    dy = (lrec.last_mod_file_date & 0x1f);
X
X    hh = ((lrec.last_mod_file_time >> 11) & 0x1f);
X    mm = ((lrec.last_mod_file_time >> 5) & 0x3f);
X
X    switch (lrec.compression_method)  {
X    case 0:
X        method = "Stored";
X        break;
X    case 1:
X        method = "Shrunk";
X        break;
X    case 2:
X    case 3:
X    case 4:
X    case 5:
X        method = "Reduced";
X        break;
X    case 6:
X        method = "Implode";
X        break;
X    }
X
X    if (ucsize != 0)  {
X        ratio = (int) ((1000L * (ucsize - csize)) / ucsize);
X        if ((ratio % 10) >= 5)
X            ratio += 10;
X    }
X    else
X        ratio = 0;  /* can .zip contain 0-size file? */
X
X#ifdef NOTINT16     /* v2.0c */
X    printf("%7ld  %-7s%7ld %3d%%  %02d-%02d-%02d  %02d:%02d  \
X%08lx  %s\n", ucsize, method, csize,
X        ratio / 10, mo, dy, yr, hh, mm,
X        lrec.crc32, filename);
X#else   /* !NOTINT16 */
X    printf("%7ld  %-7s%7ld %3d%%  %02d-%02d-%02d  %02d:%02d  \
X%08lx  %s\n", ucsize, method, csize,
X        ratio / 10, mo, dy, yr, hh, mm,
X        LONGI(lrec.crc32), filename);
X#endif  /* NOTINT16 */
X    tot_ucsize += ucsize;
X    tot_csize += csize;
X    ++members;
X}
X
X/* ---------------------------------------------------------- */
X
Xvoid skip_member()
X{
X    register long pos;
X    long endbuf;
X    int offset;
X
X    endbuf = lseek(zipfd, 0L, SEEK_CUR);    /* 1st byte beyond inbuf */
X    pos = endbuf - incnt;                   /* 1st compressed byte */
X    pos += csize;                           /* next header signature */
X    if (pos < endbuf)  {
X        incnt -= csize;
X        inptr += csize;
X    }
X    else  {
X        offset = pos % BSIZE;               /* offset within block */
X        pos = (pos / BSIZE) * BSIZE;        /* block start */
X        lseek(zipfd, pos, SEEK_SET);
X        incnt = read(zipfd, inbuf, INBUFSIZ);
X        incnt -= offset;
X        inptr = inbuf + offset;
X    }
X}
X
X/* ---------------------------------------------------------- */
X
Xvoid extract_member()
X{
X        UWORD     b;
X/* for test reasons */
X
X    bits_left = 0;
X    bitbuf = 0;
X    outpos = 0L;
X    outcnt = 0;
X    outptr = outbuf;
X    zipeof = 0;
X    crc32val = 0xFFFFFFFFL;
X
X    zmemset(outbuf, 0, OUTBUFSIZ);
X    if (aflag)                          /* if we have scratchpad.. v2.0g */
X        zmemset(outout, 0, OUTBUFSIZ);  /* ..clear it out v2.0g */
X      
X    if (tflag)
X        fprintf(stderr, "Testing: %-12s ", filename);
X    else {
X        if(!mapped_name())	/* member name conversion failed  v2.0j */
X	    exit(1);		/* choke and die v2.0j */
X
X        /* create the output file with READ and WRITE permissions */
X        if (create_output_file())
X            return; /* was exit(1); */
X    }
X    switch (lrec.compression_method) {
X
X    case 0: {   /* stored */
X            if (!tflag)
X                fprintf(stderr, " Extracting: %-12s ", filename);
X            if (cflag) fprintf(stderr, "\n");
X            while (ReadByte(&b))
X                OUTB(b);
X        }
X        break;
X
X    case 1: {       /* shrunk */
X            if (!tflag)
X                fprintf(stderr, "UnShrinking: %-12s ", filename);
X            if (cflag) fprintf(stderr, "\n");
X            unShrink();
X        }
X        break;
X
X    case 2:
X    case 3:
X    case 4:
X    case 5: {
X            if (!tflag)
X                fprintf(stderr, "  Expanding: %-12s ", filename);
X            if (cflag) fprintf(stderr, "\n");
X            unReduce();
X        }
X        break;
X
X    case 6: {
X            if (!tflag)
X                fprintf(stderr, "  Exploding: %-12s ", filename);
X            if (cflag) fprintf(stderr, "\n");
X            unImplode();
X        }
X        break;
X
X    default:
X        fprintf(stderr, "Unknown compression method.");
X    }
X
X    /* write the last partial buffer, if any */
X    FlushOutput ();
X
X    if (!tflag)  {
X#ifndef UNIX
X        /* set output file date and time */
X        set_file_time();
X        close(outfd);
X#else
X        close(outfd);
X        /* set output file date and time */
X        set_file_time();
X#endif
X    }
X
X    crc32val = ~crc32val;
X#ifdef NOTINT16     /* v2.0c */
X    if (crc32val != lrec.crc32)
X        fprintf(stderr, " Bad CRC %08lx  (should be %08lx)", crc32val,
X            lrec.crc32);
X#else   /* !NOTINT16 */
X    if (crc32val != LONGI(lrec.crc32))
X        fprintf(stderr, " Bad CRC %08lx  (should be %08lx)", crc32val,
X            LONGI(lrec.crc32));
X#endif  /* NOTINT16 */
X
X    else if (tflag)
X        fprintf(stderr, " OK");
X
X    fprintf(stderr, "\n");
X}
X
X
X/* ---------------------------------------------------------- */
X
Xvoid get_string(len, s)
Xint len;
Xchar *s;
X{
X    readbuf(zipfd, s, len);
X    s[len] = 0;
X
X#ifdef EBCDIC           /* translate the filename to ebcdic */
X    a_to_e( s );        /* A.B.  03/21/90                   */
X#endif
X}
X
X
X/* ---------------------------------------------------------- */
X
Xvoid process_local_file_header(fnamev)
Xchar **fnamev;
X{
X    int extracted;
X#ifdef NOTINT16     /* v2.0c */
X    local_byte_header brec;
X#endif
X
X#ifndef NOTINT16    /* v2.0c */
X    readbuf(zipfd, (char *) &lrec, sizeof(lrec));   /* v2.0b */
X#else   /* NOTINT16 */
X    readbuf(zipfd, (char *) &brec, sizeof(brec));
X
X    lrec.version_needed_to_extract =
X        makeword(brec.version_needed_to_extract);
X    lrec.general_purpose_bit_flag =
X        makeword(brec.general_purpose_bit_flag);
X    lrec.compression_method =
X        makeword(brec.compression_method);
X    lrec.last_mod_file_time =
X        makeword(brec.last_mod_file_time);
X    lrec.last_mod_file_date =
X        makeword(brec.last_mod_file_date);
X    lrec.crc32 =
X        makelong(brec.crc32);
X    lrec.compressed_size =
X        makelong(brec.compressed_size);
X    lrec.uncompressed_size =
X        makelong(brec.uncompressed_size);
X    lrec.filename_length =
X        makeword(brec.filename_length);
X    lrec.extra_field_length =
X        makeword(brec.extra_field_length);
X#endif  /* NOTINT16 */
X
X#ifdef HIGH_LOW
X    swap_bytes(&lrec.filename_length);
X    swap_bytes(&lrec.extra_field_length);
X    swap_lbytes(LONGIP(lrec.compressed_size));
X    swap_lbytes(LONGIP(lrec.uncompressed_size));
X    swap_bytes(&lrec.compression_method);
X    swap_bytes(&lrec.version_needed_to_extract);
X    swap_bytes(&lrec.general_purpose_bit_flag);
X    swap_bytes(&lrec.last_mod_file_time);
X    swap_bytes(&lrec.last_mod_file_date);
X    swap_lbytes(LONGIP(lrec.crc32));
X#endif  /* HIGH_LOW */
X
X#ifdef NOTINT16     /* v2.0c */
X    csize = lrec.compressed_size;
X    ucsize = lrec.uncompressed_size;
X#else   /* !NOTINT16 */
X    csize = LONGI(lrec.compressed_size);
X    ucsize = LONGI(lrec.uncompressed_size);
X#endif  /* NOTINT16 */
X
X    get_string(lrec.filename_length, filename);
X    get_string(lrec.extra_field_length, extra);
X
X    extracted = 0;
X    for (--fnamev; *++fnamev; )  {
X        if (match(filename, *fnamev))  {
X            if (vflag)
X                dir_member();
X            else  {
X                extract_member();
X                extracted = 1;
X            }
X            break;
X        }
X    }
X    if (!extracted)
X        skip_member();
X}
X
X
X/* ---------------------------------------------------------- */
X
Xvoid process_central_file_header()
X{
X    central_directory_file_header rec;
X    char filename[STRSIZ];
X    char extra[STRSIZ];
X/*  char comment[STRSIZ]; v2.0b using global comment so we can display it */
X
X#ifdef NOTINT16     /* v2.0c */
X    central_directory_byte_header byterec;
X#endif
X
X#ifndef NOTINT16    /* v2.0c */
X    readbuf(zipfd, (char *) &rec, sizeof(rec)); /* v2.0b */
X#else   /* NOTINT16 */
X    readbuf(zipfd, (char *) &byterec, sizeof(byterec) );        /* v2.0c */
X
X    rec.version_made_by =
X        makeword(byterec.version_made_by);
X    rec.version_needed_to_extract =
X        makeword(byterec.version_needed_to_extract);
X    rec.general_purpose_bit_flag =
X        makeword(byterec.general_purpose_bit_flag);
X    rec.compression_method =
X        makeword(byterec.compression_method);
X    rec.last_mod_file_time =
X        makeword(byterec.last_mod_file_time);
X    rec.last_mod_file_date =
X        makeword(byterec.last_mod_file_date);
X    rec.crc32 =
X        makelong(byterec.crc32);
X    rec.compressed_size =
X        makelong(byterec.compressed_size);
X    rec.uncompressed_size =
X        makelong(byterec.uncompressed_size);
X    rec.filename_length =
X        makeword(byterec.filename_length);
X    rec.extra_field_length =
X        makeword(byterec.extra_field_length);
X    rec.file_comment_length =
X        makeword(byterec.file_comment_length);
X    rec.disk_number_start =
X        makeword(byterec.disk_number_start);
X    rec.internal_file_attributes =
X        makeword(byterec.internal_file_attributes);
X    rec.external_file_attributes =
X        makeword(byterec.external_file_attributes);
X    rec.relative_offset_local_header =
X        makelong(byterec.relative_offset_local_header);
X#endif  /* NOTINT16 */
X
X#ifdef HIGH_LOW
X    swap_bytes(&rec.filename_length);
X    swap_bytes(&rec.extra_field_length);
X    swap_bytes(&rec.file_comment_length);
X#endif
X
X    get_string(rec.filename_length, filename);
X    get_string(rec.extra_field_length, extra);
X    get_string(rec.file_comment_length, comment);
X}
X
X
X/* ---------------------------------------------------------- */
X
Xvoid process_end_central_dir()
X{
X    end_central_dir_record rec;
X/*  char comment[STRSIZ]; v2.0b made global */
X
X#ifdef NOTINT16     /* v2.0c */
X    end_central_byte_record byterec;
X#endif
X
X#ifndef NOTINT16    /* v2.0c */
X    readbuf(zipfd, (char *) &rec, sizeof(rec)); /* v2.0b */
X#else   /* NOTINT16 */
X    readbuf(zipfd, (char *) &byterec, sizeof(byterec) );
X
X    rec.number_this_disk =
X        makeword(byterec.number_this_disk);
X    rec.number_disk_with_start_central_directory =
X        makeword(byterec.number_disk_with_start_central_directory);
X    rec.total_entries_central_dir_on_this_disk =
X        makeword(byterec.total_entries_central_dir_on_this_disk);
X    rec.total_entries_central_dir =
X        makeword(byterec.total_entries_central_dir);
X    rec.size_central_directory =
X        makelong(byterec.size_central_directory);
X    rec.offset_start_central_directory =
X        makelong(byterec.offset_start_central_directory);
X    rec.zipfile_comment_length =
X        makeword(byterec.zipfile_comment_length);
X#endif  /* NOTINT16 */
X
X#ifdef HIGH_LOW
X    swap_bytes(&rec.zipfile_comment_length);
X#endif
X
X    /* There seems to be no limit to the zipfile
X       comment length.  Some zipfiles have comments
X       longer than 256 bytes.  Currently no use is
X       made of the comment anyway.
X     */
X/* #if 0
X * v2.0b Enabling comment display
X */
X    get_string(rec.zipfile_comment_length, comment);
X/* #endif */
X}
X
X
X/* ---------------------------------------------------------- */
X
Xvoid process_headers()
X{
X    int ratio;
X    long sig;
X
X#ifdef NOTINT16     /* v2.0c */
X    byte sigbyte[4];
X#endif
X
X    if (vflag)  {
X        members = 0;
X        tot_ucsize = tot_csize = 0;
X        printf("\n Length  Method   Size  Ratio   Date    Time   \
XCRC-32    Name\n ------  ------   ----- -----   ----    ----   ------    \
X----\n");
X    }
X
X    while (1) {
X#ifdef NOTINT16     /* v2.0c */
X    if (readbuf(zipfd, (char *) sigbyte, 4) != 4)
X#else   /* !NOTINT16 */
X    if (readbuf(zipfd, (char *) &sig, sizeof(sig)) != sizeof(sig))
X#endif  /* NOTINT16 */
X        return;
X
X#ifdef NOTINT16     /* v2.0c */
X        sig = makelong(sigbyte);
X#endif
X
X#ifdef HIGH_LOW
X        swap_lbytes(&sig);
X#endif
X
X        if (sig == LOCAL_FILE_HEADER_SIGNATURE)
X            process_local_file_header(fnv);
X        else if (sig == CENTRAL_FILE_HEADER_SIGNATURE)
X            process_central_file_header();
X        else if (sig == END_CENTRAL_DIR_SIGNATURE) {
X            process_end_central_dir();
X            break;
X        }
X        else {
X            fprintf(stderr, "Invalid Zipfile Header\n");
X            return;
X        }
X    }
X    if (vflag)  {
X        if (tot_ucsize != 0)  {
X            ratio = (int) ((1000L * (tot_ucsize-tot_csize))
X                    / tot_ucsize);
X            if ((ratio % 10) >= 5)
X                ratio += 10;
X        }
X        else
X            ratio = 0;
X        printf(" ------          ------  \
X---                             -------\n\
X%7ld         %7ld %3d%%                             %7d\n",
X        tot_ucsize, tot_csize, ratio / 10, members);
X
X        if( comment[0] )                /* v2.0b */
X            printf("%s\n",comment);     /* v2.0b */
X    }
X}
X
X
X/* ---------------------------------------------------------- */
X/* v3.04 Patch to enable processing of self-extracting ".EXE"
X * (and other) files that might have weird junk before the first
X * actual file member.
X * I don't THINK anyone'll have problems with this .. but just in case,
X * you can disable the entire mess by enabling the "NOSKIP" ifdef.
X * (up near code top).
X * Thanks to Warner Losh for this patch.
X */
X#ifndef NOSKIP
Xvoid skip_to_signature()
X{
X    static char pk[] = "PK";
X    int i, nread;
X    unsigned char ch;
X    extern int errno;
X	
X    errno = 0;			/* Be sure we start with 0 */
X    do {
X        /*
X         * Search for "PK"
X         */
X        i = 0;
X        while ((nread = read (zipfd, &ch, 1)) && i < 2) {
X            if (ch == pk[i]) {
X                i++;
X            }
X            else {
X                if (ch == pk[0])
X                    i = 1;
X                else
X                    i = 0;
X            }
X        }
X	if (errno || nread==0) {	/* read err or EOF */
X	    fprintf(stderr, "Unable to find a valid header signature. Aborting.\n");
X	    exit (2);
X	}
X    } while (ch > 20);
X
X    /*
X     * We have now read 3 characters too many, so we backup.
X     */
X    lseek (zipfd, -3L, SEEK_CUR);
X}
X#endif		/* NOSKIP */
X
X
Xvoid process_zipfile()
X{
X    /*
X     * open the zipfile for reading and in BINARY mode to prevent cr/lf
X     * translation, which would corrupt the bitstreams
X     */
X
X    if (open_input_file())
X        exit(1);
X
X#ifndef NOSKIP		/* v3.03 */
X    skip_to_signature();	/* read up to first "PK%" v3.03 */
X#endif
X    process_headers();
X
X    close(zipfd);
X}
X
X/* ---------------------------------------------------------- */
X
Xvoid usage()        /* v2.0j */
X{
X
X#ifdef EBCDIC                              /* A.B. 03/20/90   */
X  char *astring = "-a  ascii to ebcdic conversion";
X#else
X  char *astring = "-a  convert to unix textfile format (CR LF => LF)";	/* v3.04 */
X#endif
X
Xfprintf(stderr, "\n%s\nCourtesy of:  S.H.Smith  and  The Tool Shop BBS,  (602) 279-2673.\n\n",VERSION);
Xfprintf(stderr, "Usage:  unzip [-tcamv] file[.zip] [filespec...]\n\
X  -t  test member files\n\
X  -c  output to stdout\n\
X  %s\n\
X  -m  map extracted filenames to lowercase\n\
X  -v  view directory\n",astring);
X    exit(1);
X}
X
X/* ---------------------------------------------------------- */
X
X/*
X * main program
X *
X */
X
Xvoid main(argc, argv)
Xint argc;
Xchar **argv;
X{
X    char *s;
X    int c;
X    struct stat statbuf;		/* v3.03 */
X    
X#ifdef DEBUG_STRUC                      /* v2.0e */
Xprintf("local_file_header size: %X\n",
X    sizeof(struct local_file_header) );
Xprintf("local_byte_header size: %X\n",
X    sizeof(struct local_byte_header) );
X
Xprintf("central directory header size: %X\n",
X    sizeof(struct central_directory_file_header) );
Xprintf("central directory byte header size: %X\n",
X    sizeof(struct central_directory_byte_header) );
X
Xprintf("end central dir record size: %X\n",
X    sizeof(struct end_central_dir_record) );
Xprintf("end central dir byte record size: %X\n",
X    sizeof(struct end_central_byte_record) );
X#endif
X
X    while (--argc > 0 && (*++argv)[0] == '-')  {
X        s = argv[0] + 1;
X#ifndef __TURBOC__
X        while (c = *s++)  {
X#else
X        while ((c = *s++) != '\0') {      /* v2.0b */
X#endif
X
X/* Something is SERIOUSLY wrong with my host's tolower() function! */
X/* #ifndef BSD */
X/*            switch (tolower(c))  { */
X/* #else */
X            switch(c) {
X/* #endif */
X            case ('T'):
X            case ('t'):
X                ++tflag;
X                break;
X            case ('V'):
X            case ('v'):
X                ++vflag;
X                break;
X            case ('C'):
X            case ('c'):
X                ++cflag;
X#ifdef EBCDIC
X                ++aflag;       /* This is so you can read it on the screen */
X#endif                         /*  A.B.  03/24/90                          */
X                break;
X            case ('A'):
X            case ('a'):
X                ++aflag;
X                break;
X	    case ('M'):		/* map filename flag v2.0j */
X	    case ('m'):
X		++mflag;
X		break;
X            default:
X                usage();
X                break;
X            }
X        }
X    }
X/*  I removed the filter for the a and c flags so they could be used together */
X/*  Especially on EBCDIC based systems where you would want to read the text  */
X/*  on the screen.  Allan Bjorklund.  03/24/90                                */
X
X    if ((tflag && vflag) || (tflag && cflag) || (vflag && cflag) ||
X        (tflag && aflag) || (aflag && vflag))
X
X    {
X        fprintf(stderr, "only one of -t, -c, -a, or -v\n");
X        exit(1);
X    }
X    if (argc-- == 0)
X        usage();
X
X    /* .ZIP default if none provided by user */
X    strcpy(zipfn, *argv++);
X/* v2.0b This doesn't permit paths like "..\dir\filename" */
X
X#ifdef REALOLDSTUFF		/* v3.02 */
X#ifdef OLDSTUF
X    if (strchr(zipfn, '.') == NULL)
X        strcat(zipfn, ZSUFX);
X#else    /* v2.0b New code */
X
X    c = strlen(zipfn);
X    if ( (c < 5)                             /* less than x.zip */
X      || (strcmp (&zipfn[c-4], ZSUFX) != 0)) /* v2.0b type doesn't
X                                              * match */
X        strcat (zipfn, ZSUFX);
X#endif
X#else				/* v3.02 */
X      /*
X       * OK, first check to see if the name is as given.  If it is
X       * found as given, then we don't need to bother adding the
X       * ZSUFX.  If it isn't found, then add the ZSUFX.  We don't
X       * check to see if this results in a good name, but that check
X       * will be done later.
X       */
X    if(stat (zipfn, &statbuf))		/* v3.02 */
X        strcat (zipfn, ZSUFX);		/* v3.02 */
X
X#endif	/* not REALOLDSTUF */
X      
X    /* if any member file specs on command line, set filename
X       pointer to point to them. */
X
X    if (argc != 0)
X        fnv = argv;
X
X        /* allocate i/o buffers */
X    inbuf = (byte *) (malloc(INBUFSIZ));
X    outbuf = (byte *) (malloc(OUTBUFSIZ));
X
X    /* v2.0g Hacked Allan's code.  No need allocating an ascebc
X     * scratch buffer unless we're doing translation.
X     */
X
X    if(aflag)                           /* we need an ascebc scratch v2.0g */
X        outout = (byte *) (malloc(OUTBUFSIZ)); /* ..so allocate it v2.0g */
X    else
X        outout = outbuf;                /* just point to outbuf v2.0g */
X
X    if ((inbuf == NULL) || (outbuf == NULL) || (outout == NULL)) {  /* v2.0g */
X        fprintf(stderr, "Can't allocate buffers!\n");
X        exit(1);
X    }
X
X    /* do the job... */
X    process_zipfile();
X    exit(0);
X}
X
END_OF_FILE
if test 22987 -ne `wc -c <'unzip.c'`; then
    echo shar: \"'unzip.c'\" unpacked with wrong size!
fi
# end of 'unzip.c'
fi
echo shar: End of archive 3 \(of 3\).
cp /dev/null ark3isdone
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
