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
  {&AlignData-}
  {&AlignCode-}
  {&AlignRec-}
  {&Use32-}
  {&Delphi+}
  {$IFDEF OS2}
    {&Cdecl+}
  {$ENDIF}
  {$IFDEF WIN2}
    {&Cdecl+}
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
  {$ifdef win32}
    {$CALLING STDCALL} 
    {$define SOM_STDCALL}
  {$endif}
  {$define SOM_EXTVAR}
{$ENDIF}

{$ifdef ver90} {Delphi 2}
  {$define SOM_STDCALL}
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

