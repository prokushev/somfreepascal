{
    Copyright (c) 1994-1996 by International Business Machines Corporation
    Copyright (c) 1997 Antony T Curtis.
    Copyright (c) 2002-2007, 2025 Yuri Prokushev (yuri.prokushev@gmail.com)
    Copyright (c) 2004-2005 Andrey Vasilkin

    System Object Model Run-time library API (SOM.DLL)

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU Library General Public License (LGPL) as
    published by the Free Software Foundation; either version 2 of the
    License, or (at your option) any later version. This program is
    distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.

    See the GNU Library General Public License for more details. You should
    have received a copy of the GNU Library General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

 **********************************************************************}

{$IFDEF VIRTUALPASCAL}
  {$DEFINE VPC}
  {$H+}
  {$X+}
  {&Optimise-}
  {&AlignData-}
  {&AlignCode-}
  {&AlignRec-}
  {&Use32-}
  {$IFDEF OS2}
    {&Cdecl+}
  {$ENDIF}
  {$IFDEF WIN2}
    {&Stdcall+}
    {$define SOM_STDCALL}
  {$ENDIF}
{$ENDIF}

{$IFDEF FPC}
  {$WARNING This code is beta!}
  {$MODE OBJFPC}
  {$ifdef os2}
  {$warning This units doesn't work because FPC/2 doesn't implements external vars}
  {$endif}
  {$R-}
  {$PACKRECORDS 1}
  {$inline on}
  {$ifdef os2}
    {$CALLING CDECL} 
  {$endif}
  {$ifdef UNIX}
    {$CALLING CDECL} 
  {$endif}
  {$ifdef MSWINDOWS}
    {$CALLING STDCALL} 
    {$define SOM_STDCALL}
  {$endif}
  {$define SOM_EXTVAR}
  {$define SOM_VARARGS}
  {$define SOM_LONG_LONG}
  {$define SOM_WCHAR}
{$ENDIF}

{$ifdef ver90} {Delphi 2}
  {$define SOM_STDCALL}
  {$define SOM_WCHAR}
{$endif}

{$ifdef VER100} {Delphi 3}
  {$define SOM_STDCALL}
  {$define SOM_WCHAR}
{$endif}

{$ifdef VER120} {Delphi 4}
  {$define SOM_STDCALL}
  {$define SOM_WCHAR}
{$endif}

{$ifdef VER130} {Delphi 5}
  {$define SOM_STDCALL}
  {$define SOM_WCHAR}
{$endif}

{$ifdef VER140} {Delphi 6}
  {$define SOM_STDCALL}
  {$define SOM_VARARGS}
  {$define SOM_WCHAR}
  {$J+} {Typed constants writeable}
{$endif}

{$ifdef VER150} {Delphi 7}
  {$define SOM_STDCALL}
  {$define SOM_VARARGS}
  {$define SOM_WCHAR}
  {$J+} {Typed constants writeable}
{$endif}

{$ifdef VER160} {Delphi 8 for Net}
  {$define SOM_STDCALL}
  {$define SOM_VARARGS}
  {$define SOM_WCHAR}
  {$J+} {Typed constants writeable}
{$endif}

{$ifdef VER160} {Delphi 8 for Net}
  {$define SOM_STDCALL}
  {$define SOM_VARARGS}
  {$define SOM_WCHAR}
  {$J+} {Typed constants writeable}
{$endif}

{$ifdef VER170} {Delphi 2005}
  {$define SOM_STDCALL}
  {$define SOM_VARARGS}
  {$define SOM_WCHAR}
  {$J+} {Typed constants writeable}
{$endif}

(*************************************************************************************
 *
 * Method Thunks supported by OS/2, Win32 and AIX. Don't know about OS/390 and MacOS.
 * Linux and other OSes, supported by somFree, not tested, so Thunks turned off.
 *
 *************************************************************************************)

{$ifdef win32}
  {$define SOM_METHOD_THUNKS}
{$endif}
{$ifdef os2}
  {$define SOM_METHOD_THUNKS}
{$endif}

{Don't know, but has rumor AIX supports thunking}

(*************************************************************************************
 *
 * Depending on SOM version not all API and methods will be accessable. Use 1, 2 or 3
 * to set version. somFree reports API support API as SOM 3.
 *
 *************************************************************************************)

{$define SOM_VERSION_1}
{$define SOM_VERSION_2}
{.$define SOM_VERSION_3}

(*************************************************************************************
 *
 * Turn on Object Pascal classes for SOM classes support
 *
 *************************************************************************************)

{.$define SOM_OBJECTS}

(*************************************************************************************
 *
 * Turn on CORBA memory management function like:
 *
 * CORBA_*_alloc
 * CORBA_free
 * CORBA_*_set_release
 * CORBA_*_get_release
 *
 * Experimental feature.
 *
 *************************************************************************************)

{$define SOM_CORBA_MEM}

(*************************************************************************************
 *
 * Turn on varargs modifier support:
 *
 *************************************************************************************)

{.$define SOM_VARARGS}

(*************************************************************************************
 *
 * Turn on long long types support:
 *
 *************************************************************************************)

{.$define SOM_LONG_LONG}

(*************************************************************************************
 *
 * Turn on wchar types support:
 *
 *************************************************************************************)

{.$define SOM_WCHAR}
