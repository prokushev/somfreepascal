{
    Copyright (c) 1994-1996 Interfaces by International Business Machines Corporation
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

{$I SOM.INC}

Unit SOMOBJ;

Interface

Uses
  SOM;

///////////// SOM Object Class /////////////////////

const
  SOMObject_MajorVersion = 1;
  {$ifdef SOM_VERSION_3}
    SOMObject_MinorVersion = 7;
  {$else}
    {$ifdef SOM_VERSION_2}
      SOMObject_MinorVersion = 4;
    {$else}
      SOMObject_MinorVersion = 1;
    {$endif}
  {$endif}

type
  TSOMObjectCClassData  = record
    parentMtab          : PsomMethodTabs;
    instanceDataToken   : TsomDToken;
  end;

var
  SOMObjectCClassData   : TSOMObjectCClassData; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMObjectCClassData';{$endif}
  SOMObjectCClassDataPtr: ^TSOMObjectCClassData;

type
  TSOMObjectClassData           = record
    // Start of SOM 1.0 methods (class version 1.1)
    classObject                 : TRealSOMClass;
    somInit                     : TsomMToken;
    somUninit                   : TsomMToken;
    somFree                     : TsomMToken;
    somDefaultVCopyInit         : TsomMToken; // was somMissingMethod in SOM 1.0
    somGetClassName             : TsomMToken;
    somGetClass                 : TsomMToken;
    somIsA                      : TsomMToken;
    somRespondsTo               : TsomMToken;
    somIsInstanceOf             : TsomMToken;
    somGetSize                  : TsomMToken;
    somDumpSelf                 : TsomMToken;
    somDumpSelfInt              : TsomMToken;
    somPrintSelf                : TsomMToken;
    somDefaultConstVCopyInit    : TsomMToken; // was somFreeObj in SOM 1.0
    somDispatchV                : TsomMToken;
    somDispatchL                : TsomMToken;
    somDispatchA                : TsomMToken;
    somDispatchD                : TsomMToken;
    // Start of SOM 2.0 methods (class version 1.4)
    {$ifdef SOM_VERSION_2}
    somDispatch                 : TsomMToken;
    somClassDispatch            : TsomMToken;
    somCastObj                  : TsomMToken;
    somResetObj                 : TsomMToken;
    somDefaultInit              : TsomMToken;
    somDestruct                 : TsomMToken;
    somComputeForwardVisitMask  : TsomMToken;
    somsomComputeReverseVisitMask : TsomMToken;
    somDefaultCopyInit          : TsomMToken;
    somDefaultConstCopyInit     : TsomMToken;
    somDefaultAssign            : TsomMToken;
    somDefaultConstAssign       : TsomMToken;
    somDefaultVAssign           : TsomMToken;
    somDefaultConstVAssign      : TsomMToken;
    {$endif}
    // Start of SOM 3.0 methods (class version 1.7)
    {$ifdef SOM_VERSION_3}
    release		            	: TsomMToken;
    duplicate					: TsomMToken;
    get_interface				: TsomMToken;
    get_implementation			: TsomMToken;
    is_proxy					: TsomMToken;
    create_request				: TsomMToken;
    create_request_args			: TsomMToken;
    is_nil						: TsomMToken;
    {$endif}
  end;

var
  SOMObjectClassData            : TSOMObjectClassData; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMObjectClassData';{$endif}
  SOMObjectClassDataPtr         :^TSOMObjectClassData;

Function SOMObjectNewClass(majorVersion,minorVersion: TCORBA_long):TRealSOMClass; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * New Method: somInit
 *)

(*
 *  Obsolete but still supported. Override somDefaultInit instead of somInit.
 *)

const
  somMD_SOMObject_somInit: PChar = '::SOMObject::somInit';
type
  somTP_SOMObject_somInit = procedure(somSelf: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somInit = somTP_SOMObject_somInit;

procedure SOMObject_somInit(somSelf: TRealSOMObject);

(*
 * New Method: somUninit
 *)
(*
 *  Obsolete but still supported. Override somDestruct instead of somUninit.
 *)

const
  somMD_SOMObject_somUninit: PChar = '::SOMObject::somUninit';
type
  somTP_SOMObject_somUninit = procedure(somSelf: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somUninit = somTP_SOMObject_somUninit;

procedure SOMObject_somUninit(somSelf: TRealSOMObject);

(*
 * New Method: somFree
 *)

(*
 *  The default implementation just calls somDestruct.
 *)
const
  somMD_SOMObject_somFree: PChar = '::SOMObject::somFree';

type
  somTP_SOMObject_somFree = procedure(somSelf: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somFree = somTP_SOMObject_somFree;

procedure SOMObject_somFree(somSelf: TRealSOMObject);

(*
 * New Method: somGetClass
 *)
(*
 *  Return the receiver's class.
 *)
const
  somMD_SOMObject_somGetClass: PChar = '::SOMObject::somGetClass';

type
  somTP_SOMObject_somGetClass = function(somSelf: TRealSOMObject): TRealSOMClass; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somGetClass = somTP_SOMObject_somGetClass;

function SOMObject_somGetClass(somSelf: TRealSOMObject): TRealSOMClass;

(*
 * New Method: somGetClassName
 *)

(*
 *  Return the name of the receiver's class.
 *)
const
  somMD_SOMObject_somGetClassName: PChar = '::SOMObject::somGetClassName';

type
  somTP_SOMObject_somGetClassName = function(somSelf: TRealSOMObject): PCORBA_char; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somGetClassName = somTP_SOMObject_somGetClassName;

function SOMObject_somGetClassName(somSelf: TRealSOMObject): PCORBA_char;

(*
 * New Method: somGetSize
 *)

(*
 *  Return the size of the receiver.
 *)
const
  somMD_SOMObject_somGetSize: PChar = '::SOMObject::somGetSize';

type
  somTP_SOMObject_somGetSize = function(somSelf: TRealSOMObject): TCORBA_long; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somGetSize = somTP_SOMObject_somGetSize;

function SOMObject_somGetSize(somSelf: TRealSOMObject): TCORBA_long;

(*
 * New Method: somIsA
 *)

(*
 *  Returns 1 (true) if the receiver responds to methods
 *  introduced by <aClassObj>, and 0 (false) otherwise.
 *)
const
  somMD_SOMObject_somIsA: PChar = '::SOMObject::somIsA';

type
  somTP_SOMObject_somIsA = function(somSelf: TRealSOMObject; aClassObj: TRealSOMClass): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somIsA = somTP_SOMObject_somIsA;

function SOMObject_somIsA(somSelf: TRealSOMObject; aClassObj: TRealSOMClass): TCORBA_boolean;

(*
 * New Method: somIsInstanceOf
 *)

(*
 *  Returns 1 (true) if the receiver is an instance of
 *  <aClassObj> and 0 (false) otherwise.
 *)
const
  somMD_SOMObject_somIsInstanceOf: PChar = '::SOMObject::somIsInstanceOf';

type
  somTP_SOMObject_somIsInstanceOf = function(somSelf: TRealSOMObject; aClassObj: TRealSOMClass): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somIsInstanceOf = somTP_SOMObject_somIsInstanceOf;

function SOMObject_somIsInstanceOf(somSelf: TRealSOMObject; aClassObj: TRealSOMClass): TCORBA_boolean;

(*
 * New Method: somRespondsTo
 *)

(*
 *  Returns 1 (true) if the indicated method can be invoked
 *  on the receiver and 0 (false) otherwise.
 *)
const
  somMD_SOMObject_somRespondsTo: PChar = '::SOMObject::somRespondsTo';

type
  somTP_SOMObject_somRespondsTo = function(somSelf: TRealSOMObject; mId: TsomId): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somRespondsTo = somTP_SOMObject_somRespondsTo;

function SOMObject_somRespondsTo(somSelf: TRealSOMObject; mId: TsomId): TCORBA_boolean;


(*
 * New Method: somPrintSelf
 *)

(*
 *  Uses <SOMOutCharRoutine> to write a brief string with identifying
 *  information about this object.  The default implementation just gives
 *  the object's class name and its address in memory.
 *  <self> is returned.
 *)

const
  somMD_SOMObject_somPrintSelf: PChar = '::SOMObject::somPrintSelf';

type
  somTP_SOMObject_somPrintSelf = function(somSelf: TRealSOMObject): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somPrintSelf = somTP_SOMObject_somPrintSelf;

function SOMObject_somPrintSelf(somSelf: TRealSOMObject): TRealSOMObject;

(*
 * New Method: somDumpSelf
 *)

(*
 *  Uses <SOMOutCharRoutine> to write a detailed description of this object
 *  and its current state.
 *
 *  <level> indicates the nesting level for describing compound objects
 *  it must be greater than or equal to zero.  All lines in the
 *  description will be preceeded by <2*level> spaces.
 *
 *  This routine only actually writes the data that concerns the object
 *  as a whole, such as class, and uses <somDumpSelfInt> to describe
 *  the object's current state.  This approach allows readable
 *  descriptions of compound objects to be constructed.
 *
 *  Generally it is not necessary to override this method, if it is
 *  overriden it generally must be completely replaced.
 *)

const
  somMD_SOMObject_somDumpSelf: PChar = '::SOMObject::somDumpSelf';

type
  somTP_SOMObject_somDumpSelf = procedure(somSelf: TRealSOMObject; level: TCORBA_long); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDumpSelf = somTP_SOMObject_somDumpSelf;

procedure SOMObject_somDumpSelf(somSelf: TRealSOMObject; level: TCORBA_long);

(*
 * New Method: somDumpSelfInt
 *)

(*
 *  Uses <SOMOutCharRoutine> to write in the current state of this object.
 *  Generally this method will need to be overridden.  When overriding
 *  it, begin by calling the parent class form of this method and then
 *  write in a description of your class's instance data. This will
 *  result in a description of all the object's instance data going
 *  from its root ancestor class to its specific class.
 *)
const
  somMD_SOMObject_somDumpSelfInt: PChar = '::SOMObject::somDumpSelfInt';

type
  somTP_SOMObject_somDumpSelfInt = procedure(somSelf: TRealSOMObject; level: TCORBA_long); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDumpSelfInt = somTP_SOMObject_somDumpSelfInt;

procedure SOMObject_somDumpSelfInt(somSelf: TRealSOMObject; level: TCORBA_long);

const
  somMD_SOMObject_somDispatchV: PChar ='::SOMObject::somDispatchV';

type
  somTP_SOMObject_somDispatchV = procedure(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDispatchV = somTP_SOMObject_somDispatchV;

procedure SOMObject_somDispatchV(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list);

const
  somMD_SOMObject_somDispatchL: PChar ='::SOMObject::somDispatchL';

type
  somTP_SOMObject_somDispatchL    = Function(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap: tva_list): TCORBA_long; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDispatchL =somTP_SOMObject_somDispatchL;

function SOMObject_somDispatchL(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list): TCORBA_long;

const
  somMD_SOMObject_somDispatchA: PChar ='::SOMObject::somDispatchA';

type
  somTP_SOMObject_somDispatchA    = Function(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap: tva_list): Pointer; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDispatchA = somTP_SOMObject_somDispatchA;

function SOMObject_somDispatchA(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list): Pointer;

const
  somMD_SOMObject_somDispatchD: PChar ='::SOMObject::somDispatchD';

type
  somTP_SOMObject_somDispatchD    = Function(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap: tva_list): TCORBA_double; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDispatchD = somTP_SOMObject_somDispatchD;

function SOMObject_somDispatchD(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list): TCORBA_double;

{$ifdef SOM_VERSION_2}
(*
 * New Method: somDefaultInit
 *)

(*
 *  A default initializer for a SOM object. Passing a null ctrl
 *  indicates to the receiver that its class is the class of the
 *  object being initialized, whereby the initializer will determine
 *  an appropriate control structure.
 *)

const
  somMD_SOMObject_somDefaultInit: PChar = '::SOMObject::somDefaultInit';

type
  somTP_SOMObject_somDefaultInit = procedure(somSelf: TRealSOMObject; ctrl: PsomInitCtrl); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultInit = somTP_SOMObject_somDefaultInit;

procedure SOMObject_somDefaultInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl); 

(*
 * New Method: somDestruct
 *)

(*
 *  The default destructor for a SOM object. A nonzero <doFree>
 *  indicates that the object storage should be freed by the
 *  object's class (via somDeallocate) after uninitialization.
 *  As with somDefaultInit, a null ctrl can be passed.
 *)

const
  somMD_SOMObject_somDestruct: PChar = '::SOMObject::somDestruct';

type
  somTP_SOMObject_somDestruct = procedure(somSelf: TRealSOMObject; doFree: TCORBA_boolean; ctrl: PsomDestructCtrl); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDestruct = somTP_SOMObject_somDestruct;

procedure SOMObject_somDestruct(somSelf: TRealSOMObject; doFree: TCORBA_boolean; ctrl: PsomDestructCtrl);

(*
 * New Method: somDefaultCopyInit
 *)
(*
 *  A default copy constructor. Use this to make copies of objects for
 *  calling methods with "by-value" argument semantics.
 *)

const
  somMD_SOMObject_somDefaultCopyInit: PChar = '::SOMObject::somDefaultCopyInit';

type
  somTP_SOMObject_somDefaultCopyInit = procedure(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultCopyInit = somTP_SOMObject_somDefaultCopyInit;

procedure SOMObject_somDefaultCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);

(*
 * New Method: somDefaultAssign
 *)

(*
 *  A default assignment operator. Use this to "assign" the state of one
 *  object to another.
 *)

const
  somMD_SOMObject_somDefaultAssign: PChar = '::SOMObject::somDefaultAssign';

type
  somTP_SOMObject_somDefaultAssign = function(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultAssign = somTP_SOMObject_somDefaultAssign;

function SOMObject_somDefaultAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;

(*
 * New Method: somDefaultConstCopyInit
 *)

(*
 *  A default copy constructor that uses a const fromObj.
 *)
const
  somMD_SOMObject_somDefaultConstCopyInit: PChar = '::SOMObject::somDefaultConstCopyInit';

type
  somTP_SOMObject_somDefaultConstCopyInit = procedure(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultConstCopyInit = somTP_SOMObject_somDefaultConstCopyInit;

procedure SOMObject_somDefaultConstCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);

(*
 * New Method: somDefaultVCopyInit
 *)

(*
 *  A default copy constructor that uses a volatile fromObj.
 *)
const
  somMD_SOMObject_somDefaultVCopyInit: PChar = '::SOMObject::somDefaultVCopyInit';

type
  somTP_SOMObject_somDefaultVCopyInit = procedure(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultVCopyInit = somTP_SOMObject_somDefaultVCopyInit;

procedure SOMObject_somDefaultVCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);

(*
 * New Method: somDefaultConstVCopyInit
 *)

(*
 *  A default copy constructor that uses a const volatile fromObj.
 *)

const
  somMD_SOMObject_somDefaultConstVCopyInit: PChar = '::SOMObject::somDefaultConstVCopyInit';

type
  somTP_SOMObject_somDefaultConstVCopyInit = procedure(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultConstVCopyInit = somTP_SOMObject_somDefaultConstVCopyInit;

procedure SOMObject_somDefaultConstVCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);

(*
 * New Method: somDefaultConstAssign
 *)

(*
 *  A default assignment operator that uses a const fromObj.
 *)
const
  somMD_SOMObject_somDefaultConstAssign: PChar = '::SOMObject::somDefaultConstAssign';

type
  somTP_SOMObject_somDefaultConstAssign = function(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultConstAssign = somTP_SOMObject_somDefaultConstAssign;

function SOMObject_somDefaultConstAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;

(*
 * New Method: somDefaultVAssign
 *)

(*
 *  A default assignment operator that uses a volatile fromObj.
 *)
const
  somMD_SOMObject_somDefaultVAssign: PChar = '::SOMObject::somDefaultVAssign';

type
  somTP_SOMObject_somDefaultVAssign = function(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultVAssign = somTP_SOMObject_somDefaultVAssign;

function SOMObject_somDefaultVAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;

(*
 * New Method: somDefaultConstVAssign
 *)

(*
 *  A default assignment operator that uses a const volatile fromObj.
 *)

const
  somMD_SOMObject_somDefaultConstVAssign: PChar = '::SOMObject::somDefaultConstVAssign';

type
  somTP_SOMObject_somDefaultConstVAssign = function(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDefaultConstVAssign = somTP_SOMObject_somDefaultConstVAssign;

function SOMObject_somDefaultConstVAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;

(*
 * New Method: somDispatch
 *)

(*
 *  This method provides a generic, class-specific dispatch mechanism.
 *  It accepts as input <retValue> a pointer to the memory area to be
 *  loaded with the result of dispatching the method indicated by
 *  <methodId> using the arguments in <ap>. <ap> contains the object
 *  on which the method is to be invoked as the first argument.
 *
 *  Default redispatch stubs invoke this method.
 *)
const
  somMD_SOMObject_somDispatch: PChar = '::SOMObject::somDispatch';

type
  somTP_SOMObject_somDispatch = function(somSelf: TRealSOMObject;
    var retValue: TsomToken;
    methodId: TsomId;
    ap: Tva_list{array of const}): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somDispatch = somTP_SOMObject_somDispatch;

function SOMObject_somDispatch(somSelf: TRealSOMObject; var retValue: TsomToken; methodId: TsomId; ap: Tva_list{array of const}): TCORBA_boolean;

(*
 * New Method: somClassDispatch
 *)

(*
 *  Like somDispatch, but method resolution for static methods is done
 *  according to the clsObj instance method table.
 *)

const
  somMD_SOMObject_somClassDispatch: PChar = '::SOMObject::somClassDispatch';

type
  somTP_SOMObject_somClassDispatch = function(somSelf: TRealSOMObject;
    clsObj: TRealSOMClass;
    var retValue: TsomToken;
    methodId: TsomId;
    ap: Tva_list{array of const}): TCORBA_boolean;  {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somClassDispatch = somTP_SOMObject_somClassDispatch;

function SOMObject_somClassDispatch(somSelf: TRealSOMObject;
  clsObj: TRealSOMClass;
  var retValue: TsomToken;
  methodId: TsomId;
  ap: Tva_list{array of const}): TCORBA_boolean;

(*
 * New Method: somCastObj
 *)

(*
 *  Changes the behavior of the target object to that implemented
 *  by castedCls. This is possible when all concrete data in castedCls
 *  is also concrete in the true class of the target object.
 *  Returns true (1) on success, and false (0) otherwise.
 *)

const
  somMD_SOMObject_somCastObj: PChar = '::SOMObject::somCastObj';

type
  somTP_SOMObject_somCastObj = function(somSelf: TRealSOMObject; castedCls: TRealSOMClass): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somCastObj = somTP_SOMObject_somCastObj;

function SOMObject_somCastObj(somSelf: TRealSOMObject;
  castedCls: TRealSOMClass): TCORBA_boolean;

(*
 * New Method: somResetObj
 *)

(*
 *  reset an object to its true class. Returns true always.
 *)

const
  somMD_SOMObject_somResetObj: PChar = '::SOMObject::somResetObj';

type
  somTP_SOMObject_somResetObj = function(somSelf: TRealSOMObject): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_somResetObj = somTP_SOMObject_somResetObj;

function SOMObject_somResetObj(somSelf: TRealSOMObject): TCORBA_boolean;

{$endif}

{$ifdef SOM_VERSION_3}

type
  somTP_SOMObject_release = procedure(somSelf: TRealSOMObject; ev: TCORBA_Environment); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_release = somTP_SOMObject_release;
  
procedure SOMObject_release(somSelf: TRealSOMObject; ev: TCORBA_Environment);

type
  somTP_SOMObject_duplicate = function(somSelf: TRealSOMObject; ev: TCORBA_Environment): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_duplicate = somTP_SOMObject_duplicate;
  
function SOMObject_duplicate(somSelf: TRealSOMObject; ev: TCORBA_Environment): TRealSOMObject;

type  
  somTP_SOMObject_get_interface = Function(somSelf:TRealSOMObject; ev: TCORBA_Environment): TRealSOMObject;  {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_get_interface = somTP_SOMObject_get_interface;

Function SOMObject_get_interface(somSelf:TRealSOMObject; ev: TCORBA_Environment): TRealSOMObject;

type
  somTP_SOMObject_get_implementation   = Function(somSelf: TRealSOMObject; ev: TCORBA_Environment): TRealSOMObject;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_get_implementation   = somTP_SOMObject_get_implementation;

Function SOMObject_get_implementation(somSelf: TRealSOMObject; ev: TCORBA_Environment): TRealSOMObject;

type  
  somTP_SOMObject_is_proxy = Function(somSelf: TRealSOMObject; ev: TCORBA_Environment): TCORBA_Boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_is_proxy = somTP_SOMObject_is_proxy;

Function SOMObject_is_proxy(somSelf: TRealSOMObject; ev: TCORBA_Environment): TCORBA_Boolean;

type
  somTP_SOMObject_create_request = Function(somSelf: TRealSOMObject; ev: TCORBA_Environment; ctx: TRealSOMObject;
                                          operation: Identifier; arg_list: TRealSOMObject ;var result:NamedValue;
                                          var requst: TRealSOMObject; req_flags: TFlags): ORBStatus; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_create_request = somTP_SOMObject_create_request;

Function SOMObject_create_request(somSelf: TRealSOMObject; ev: TCORBA_Environment; ctx: TRealSOMObject;
                                          operation: Identifier; arg_list: TRealSOMObject ;var result:NamedValue;
                                          var requst: TRealSOMObject; req_flags: TFlags): ORBStatus; 

type										  
  somTP_SOMObject_create_request_args  = Function(somSelf: TRealSOMObject; ev: TCORBA_Environment;
                                          operation:Identifier; var arg_list: TRealSOMObject; var result:NamedValue):ORBStatus; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_create_request_args = somTP_SOMObject_create_request_args;

Function SOMObject_create_request_args(somSelf: TRealSOMObject; ev: TCORBA_Environment;
                                          operation:Identifier; var arg_list: TRealSOMObject; var result:NamedValue):ORBStatus;

type										  
  somTP_SOMObject_is_nil = Function(somSelf: TRealSOMObject; ev: TCORBA_Environment): TCORBA_Boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMObject_is_nil = somTP_SOMObject_is_nil;

Function SOMObject_is_nil(somSelf: TRealSOMObject; ev: TCORBA_Environment): TCORBA_Boolean;

{$endif}

//////////////////// And now... 


{$ifdef SOM_OBJECTS}
type
  TSOMObject = class;
  TSOMObjectClass = class of TSOMObject;

  TSOMClass = TSOMObject;

(* Object Pascal classes *)

  TSOMObject = class
  public
    // Start of SOM 1.0 methods (class version 1.1)
    Procedure   somInit;
    Procedure   somUnInit;
    Procedure   somFree;
	{$ifdef SOM_VERSION_2}
    Procedure   somDefaultVCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
	{$endif}
    Function    somGetClassName:PChar;
    Function    somGetClass:TSOMClass;
    Function    somIsA(aClassObj: TSOMClass): TCORBA_boolean;
    Function    somRespondsTo(mId: TsomId): TCORBA_boolean;
    Function    somIsInstanceOf(aClassObj: TSOMClass): TCORBA_boolean;
    Function    somGetSize: TCORBA_long;
    Procedure   somDumpSelf(level: TCORBA_long);
    Procedure   somDumpSelfInt(level: TCORBA_long);
    Function    somPrintSelf: TSOMObject;
    {$ifdef SOM_VERSION_2}
	Procedure   somDefaultConstVCopyInit(ctrl: PsomInitCtrl;fromObj:TSOMObject);
	{$endif}
    Procedure   somDispatchV(methodId: TsomId; descriptor: TsomId; ap:tva_list);
    Function    somDispatchL(methodId: TsomId; descriptor: TsomId; ap:tva_list): TCORBA_long;
    Function    somDispatchA(methodId: TsomId; descriptor: TsomId; ap:tva_list):Pointer;
    Function    somDispatchD(methodId: TsomId; descriptor: TsomId; ap:tva_list): TCORBA_double;
    // Start of SOM 2.0 methods (class version 1.4)
	{$ifdef SOM_VERSION_2}
    Function    somDispatch(var retValue: TsomToken;methodId: TsomId;ap: tva_list): TCORBA_boolean;
    Function    somClassDispatch(clsObj:TSOMClass;var retValue: TsomToken;methodId: TsomId;ap: tva_list): TCORBA_boolean;
    Function    somCastObj(cls:TSOMClass): TCORBA_boolean;
    Function    somResetObj: TCORBA_boolean;
    Procedure   somDefaultInit(ctrl: PsomInitCtrl);
    Procedure   somDestruct(doFree: TCORBA_boolean; ctrl: PsomDestructCtrl);

//    somComputeForwardVisitMask  : somMToken;
//    somsomComputeReverseVisitMask : somMToken;

    Procedure   somDefaultCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
    Procedure   somDefaultConstCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
    Function    somDefaultAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
    Function    somDefaultConstAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
    Function    somDefaultVAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
    Function    somDefaultConstVAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
    {$endif}
    // Start of SOM 3.0 methods (class version 1.7)
	{$ifdef SOM_VERSION_3}
	procedure release(ev: TCORBA_Environment);
	function duplicate(ev: TCORBA_Environment): TSOMObject;
	Function get_interface(ev: TCORBA_Environment): TSOMObject;
	Function get_implementation(ev: TCORBA_Environment): TSOMObject;
	Function is_proxy(ev: TCORBA_Environment): TCORBA_Boolean;
	Function create_request(ev: TCORBA_Environment; ctx: TSOMObject;
										operation: Identifier; arg_list: TSOMObject ;var result:NamedValue;
                                          var requst: TSOMObject; req_flags: TFlags): ORBStatus; 
	Function create_request_args(ev: TCORBA_Environment;
	Function is_nil(ev: TCORBA_Environment): TCORBA_Boolean;
    {$endif}
    // Pascal class helper methods
    Constructor Create;
    function    somSelf: TRealSOMObject;
  public          // Private methods... for SOM.. Pas Touche!
    class function NewInstance:TObject; override; {$ifndef vpc}register;{$endif}
    procedure      FreeInstance; override; {$ifndef vpc}register;{$endif}
  public//protected        // User Class Definition...
    class function InstanceClass: TRealSOMClass; virtual;
    class function RegisterClass: TSOMObjectClass; virtual;
  end;

  PVPSOMRECORD          = ^VPSOMRECORD;
  VPSOMRECORD           = record
    VPCls               : TSOMObjectClass;
    SOMCls              : PRealSOMClass;
    Next                : PVPSOMRECORD;
  end;

Procedure RegisterVPClass(var rec:VPSOMRECORD);

{$endif}

Implementation

{$ifndef SOM_EXTVAR}
uses
  windows;
{$endif}


Function SOMObjectNewClass(majorVersion,minorVersion: TCORBA_long):TRealSOMClass; external SOMDLL name 'SOMObjectNewClass';

(*
 * New Method: somInit
 *)

(*
 *  Obsolete but still supported. Override somDefaultInit instead of somInit.
 *)

procedure SOMObject_somInit(somSelf: TRealSOMObject);
var
    m: somTD_SOMObject_somInit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somInit));
    m(somSelf);
end;

(*
 * New Method: somUninit
 *)
(*
 *  Obsolete but still supported. Override somDestruct instead of somUninit.
 *)

procedure SOMObject_somUninit(somSelf: TRealSOMObject);
var
    m: somTD_SOMObject_somUninit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somUninit));
    m(somSelf);
end;

(*
 * New Method: somFree
 *)

(*
 *  The default implementation just calls somDestruct.
 *)

procedure SOMObject_somFree(somSelf: TRealSOMObject);
var
    m: somTD_SOMObject_somFree;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
//    somPrintf('somFree1=%08X'#13#10, cardinal(somSelf));
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somFree));
//    somPrintf('somFree2'#13#10);
    m(somSelf);
//    somPrintf('somFree3'#13#10);
end;

(*
 * New Method: somGetClass
 *)
(*
 *  Return the receiver's class.
 *)

function SOMObject_somGetClass(somSelf: TRealSOMObject): TRealSOMClass;
var
    m: somTD_SOMObject_somGetClass;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somGetClass));
    Result:=m(somSelf);
end;

(*
 * New Method: somGetClassName
 *)

(*
 *  Return the name of the receiver's class.
 *)

function SOMObject_somGetClassName(somSelf: TRealSOMObject): PCORBA_char;
var
    m: somTD_SOMObject_somGetClassName;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somGetClassName));
    Result:=m(somSelf);
end;

(*
 * New Method: somGetSize
 *)

(*
 *  Return the size of the receiver.
 *)

function SOMObject_somGetSize(somSelf: TRealSOMObject): TCORBA_long;
var
    m: somTD_SOMObject_somGetSize;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somGetSize));
    Result:=m(somSelf);
end;

(*
 * New Method: somIsA
 *)

(*
 *  Returns 1 (true) if the receiver responds to methods
 *  introduced by <aClassObj>, and 0 (false) otherwise.
 *)

function SOMObject_somIsA(somSelf: TRealSOMObject; aClassObj: TRealSOMClass): TCORBA_boolean;
var
    m: somTD_SOMObject_somIsA;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somIsA));
    Result:=m(somSelf, aClassObj);
end;

(*
 * New Method: somIsInstanceOf
 *)

(*
 *  Returns 1 (true) if the receiver is an instance of
 *  <aClassObj> and 0 (false) otherwise.
 *)

function SOMObject_somIsInstanceOf(somSelf: TRealSOMObject; aClassObj: TRealSOMClass): TCORBA_boolean;
var
    m: somTD_SOMObject_somIsInstanceOf;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somIsInstanceOf));
    Result:=m(somSelf, aClassObj);
end;

(*
 * New Method: somRespondsTo
 *)

(*
 *  Returns 1 (true) if the indicated method can be invoked
 *  on the receiver and 0 (false) otherwise.
 *)

function SOMObject_somRespondsTo(somSelf: TRealSOMObject; mId: TsomId): TCORBA_boolean;
var
    m: somTD_SOMObject_somRespondsTo;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somRespondsTo));
    Result:=m(somSelf, mId);
end;



(*
 * New Method: somPrintSelf
 *)

(*
 *  Uses <SOMOutCharRoutine> to write a brief string with identifying
 *  information about this object.  The default implementation just gives
 *  the object's class name and its address in memory.
 *  <self> is returned.
 *)

function SOMObject_somPrintSelf(somSelf: TRealSOMObject): TRealSOMObject;
var
    m: somTD_SOMObject_somPrintSelf;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somPrintSelf));
    Result:=m(somSelf);
end;

(*
 * New Method: somDumpSelf
 *)

(*
 *  Uses <SOMOutCharRoutine> to write a detailed description of this object
 *  and its current state.
 *
 *  <level> indicates the nesting level for describing compound objects
 *  it must be greater than or equal to zero.  All lines in the
 *  description will be preceeded by <2*level> spaces.
 *
 *  This routine only actually writes the data that concerns the object
 *  as a whole, such as class, and uses <somDumpSelfInt> to describe
 *  the object's current state.  This approach allows readable
 *  descriptions of compound objects to be constructed.
 *
 *  Generally it is not necessary to override this method, if it is
 *  overriden it generally must be completely replaced.
 *)

procedure SOMObject_somDumpSelf(somSelf: TRealSOMObject; level: TCORBA_long);
var
    m: somTD_SOMObject_somDumpSelf;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDumpSelf));
    m(somSelf, level);
end;

(*
 * New Method: somDumpSelfInt
 *)

(*
 *  Uses <SOMOutCharRoutine> to write in the current state of this object.
 *  Generally this method will need to be overridden.  When overriding
 *  it, begin by calling the parent class form of this method and then
 *  write in a description of your class's instance data. This will
 *  result in a description of all the object's instance data going
 *  from its root ancestor class to its specific class.
 *)

procedure SOMObject_somDumpSelfInt(somSelf: TRealSOMObject; level: TCORBA_long);
var
    m: somTD_SOMObject_somDumpSelfInt;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDumpSelfInt));
    m(somSelf, level);
end;

(* Does not return a value. *)
procedure SOMObject_somDispatchV(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list);
var
    m: somTD_SOMObject_somDispatchV;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDispatchV));
    m(somSelf, methodId, descriptor, ap);
end;

(* Returns a 4 byte quanity in the normal manner that integer data is
 * returned. This 4 byte quanity can, of course, be something other
 * than an integer.
 *)
function SOMObject_somDispatchL(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list): TCORBA_long;
var
    m: somTD_SOMObject_somDispatchL;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDispatchL));
    Result:=m(somSelf, methodId, descriptor, ap);
end;

function SOMObject_somDispatchA(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list):Pointer;
var
    m: somTD_SOMObject_somDispatchA;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDispatchA));
    Result:=m(somSelf, methodId, descriptor, ap);
end;

function SOMObject_somDispatchD(somSelf:TRealSOMObject; methodId: TsomId; descriptor: TsomId; ap:tva_list): TCORBA_double;
var
    m: somTD_SOMObject_somDispatchD;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDispatchD));
    Result:=m(somSelf, methodId, descriptor, ap);
end;

{$ifdef SOM_VERSION_2}

(*
 * New Method: somDefaultInit
 *)

(*
 *  A default initializer for a SOM object. Passing a null ctrl
 *  indicates to the receiver that its class is the class of the
 *  object being initialized, whereby the initializer will determine
 *  an appropriate control structure.
 *)

procedure SOMObject_somDefaultInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl);
var
    m: somTD_SOMObject_somDefaultInit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultInit));
    m(somSelf, ctrl);
end;

(*
 * New Method: somDestruct
 *)

(*
 *  The default destructor for a SOM object. A nonzero <doFree>
 *  indicates that the object storage should be freed by the
 *  object's class (via somDeallocate) after uninitialization.
 *  As with somDefaultInit, a null ctrl can be passed.
 *)

procedure SOMObject_somDestruct(somSelf: TRealSOMObject; doFree: TCORBA_boolean; ctrl: PsomDestructCtrl);
var
    m: somTD_SOMObject_somDestruct;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDestruct));
    m(somSelf, doFree, ctrl);
end;

(*
 * New Method: somDefaultCopyInit
 *)
(*
 *  A default copy constructor. Use this to make copies of objects for
 *  calling methods with "by-value" argument semantics.
 *)

procedure SOMObject_somDefaultCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
var
    m: somTD_SOMObject_somDefaultCopyInit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultCopyInit));
    m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDefaultAssign
 *)

(*
 *  A default assignment operator. Use this to "assign" the state of one
 *  object to another.
 *)


function SOMObject_somDefaultAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
var
    m: somTD_SOMObject_somDefaultAssign;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultAssign));
	Result:=m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDefaultConstCopyInit
 *)

(*
 *  A default copy constructor that uses a const fromObj.
 *)

procedure SOMObject_somDefaultConstCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
var
    m: somTD_SOMObject_somDefaultConstCopyInit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultConstCopyInit));
	m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDefaultVCopyInit
 *)

(*
 *  A default copy constructor that uses a volatile fromObj.
 *)

procedure SOMObject_somDefaultVCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
var
    m: somTD_SOMObject_somDefaultVCopyInit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultVCopyInit));
	m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDefaultConstVCopyInit
 *)

(*
 *  A default copy constructor that uses a const volatile fromObj.
 *)

procedure SOMObject_somDefaultConstVCopyInit(somSelf: TRealSOMObject; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
var
    m: somTD_SOMObject_somDefaultConstVCopyInit;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultConstVCopyInit));
	m(somSelf, ctrl, fromObj);;
end;

(*
 * New Method: somDefaultConstAssign
 *)

(*
 *  A default assignment operator that uses a const fromObj.
 *)

function SOMObject_somDefaultConstAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
var
    m: somTD_SOMObject_somDefaultConstAssign;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultConstAssign));
    Result:=m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDefaultVAssign
 *)

(*
 *  A default assignment operator that uses a volatile fromObj.
 *)

function SOMObject_somDefaultVAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
var
    m: somTD_SOMObject_somDefaultVAssign;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultVAssign));
    Result:=m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDefaultConstVAssign
 *)

(*
 *  A default assignment operator that uses a const volatile fromObj.
 *)

function SOMObject_somDefaultConstVAssign(somSelf: TRealSOMObject; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
var
    m: somTD_SOMObject_somDefaultConstVAssign;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDefaultConstVAssign));
    Result:=m(somSelf, ctrl, fromObj);
end;

(*
 * New Method: somDispatch
 *)

(*
 *  This method provides a generic, class-specific dispatch mechanism.
 *  It accepts as input <retValue> a pointer to the memory area to be
 *  loaded with the result of dispatching the method indicated by
 *  <methodId> using the arguments in <ap>. <ap> contains the object
 *  on which the method is to be invoked as the first argument.
 *
 *  Default redispatch stubs invoke this method.
 *)

function SOMObject_somDispatch(somSelf: TRealSOMObject; var retValue: TsomToken; methodId: TsomId; ap: Tva_list{array of const}): TCORBA_boolean;
var
    m: somTD_SOMObject_somDispatch;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somDispatch));
    Result:=m(somSelf, retValue, methodId, ap);
end;

(*
 * New Method: somClassDispatch
 *)

(*
 *  Like somDispatch, but method resolution for static methods is done
 *  according to the clsObj instance method table.
 *)

function SOMObject_somClassDispatch(somSelf: TRealSOMObject; clsObj: TRealSOMClass; var retValue: TsomToken; methodId: TsomId; ap: tva_list{array of const}): TCORBA_boolean;
var
    m: somTD_SOMObject_somClassDispatch;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somClassDispatch));
    Result:=m(somSelf, clsObj, retValue, methodId, ap);
end;

(*
 * New Method: somCastObj
 *)

(*
 *  Changes the behavior of the target object to that implemented
 *  by castedCls. This is possible when all concrete data in castedCls
 *  is also concrete in the true class of the target object.
 *  Returns true (1) on success, and false (0) otherwise.
 *)

function SOMObject_somCastObj(somSelf: TRealSOMObject; castedCls: TRealSOMClass): TCORBA_boolean;
var
    m: somTD_SOMObject_somCastObj;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somCastObj));
    Result:=m(somSelf, castedCls);
end;

(*
 * New Method: somResetObj
 *)

(*
 *  reset an object to its true class. Returns true always.
 *)

function SOMObject_somResetObj(somSelf: TRealSOMObject): TCORBA_boolean;
var
    m: somTD_SOMObject_somResetObj;
begin
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$ifdef fpc}TsomMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMObjectClassData.classObject, SOMObjectClassData.somResetObj));
    Result:=m(somSelf);
end;

{$endif}

{$ifdef SOM_OBJECTS}
(********************** Helpers ***********************************)

const
  RSOMObject            : VPSOMRECORD = (
    VPCls               : TSOMObject;
    SOMCls              : @SOMObjectClassData;
  );

Procedure RegisterSOMPasClass(PasCls: TSOMObjectClass; SOMCls: PRealSOMObject);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
  somPrintf('Register VPClass som=0X%08X pas=0X%08X'#13#10, Cardinal(SOMCls^), Cardinal(PasCls));
end;

Procedure RegisterVPClass(var rec:VPSOMRECORD);
var
  p,q                   : PVPSOMRecord;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
//  somPrintf('Register VPClass som=0X%08X pas=0X%08X'#13#10, Cardinal(rec.SOMCls^^), Cardinal(rec.VPCls));
  rec.SOMCls:=PRealSOMObject(rec.SOMCls^);
  if (rec.Next<>nil)or(rec.SOMCls=nil)or(rec.VPCls=nil) then exit;
  p := @RSOMObject; q := nil;
  repeat
    if p^.SOMCls=rec.SOMCls then begin  // Overriding existing registered class
      if q<>nil then begin
        q^.Next := @rec;
        rec.Next := p^.Next;
      end;
      exit;
    end;
    if p^.Next=nil then begin
      p^.Next := @rec;
      exit;
    end;
    q := p; p := p^.Next;
  until false;
end;

Function ResolveClass(obj:TRealSOMObject):TSOMObject;
var
  p,q                   : PVPSOMRecord;
  obj2                  : TRealSOMObject;
  _somIsInstance        : somTD_SOMObject_somIsInstanceOf;
  _somIsA               : somTD_SOMObject_somIsA;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
  if not somIsObj(obj) then Result := nil else
  begin
//      somPrintf('obj=0X%08X'#13#10, longint(obj));

    if PCardinal(Cardinal(obj)-8)^=$DEADBEAF then
    begin
      obj2 := Pointer(Cardinal(obj)-4);
      Result := TSOMObject(Pointer(obj2));

      if PCardinal(obj2)^<>0 then exit;  // Class already resolved;
    end else begin
//      somPrintf('Dead beaf 0X%08X'#13#10, PCardinal(Cardinal(obj)-8)^);
//      somPrintf('Trying to resolve instance of 0X%08X'#13#10, Cardinal(obj));
{----------------------------}
    {$ifdef fpc}TsomMethodProc(_somIsInstance):={$else}@_somIsInstance:=Pointer{$endif}(somResolve(obj,SOMObjectClassData.somIsInstanceOf));
    p := @RSOMObject;                   // First check for specific instances...
    while (p<>nil)and(not (obj=TRealSOMObject(p^.SOMCls^))) do
    begin
//      somPrintf('0X%08X'#13#10, longint(p^.SOMCls^));
      p:=p^.Next;
    end;
    if p=nil then somPrintf('oops'#13#10);
    if p<>nil then begin
//      PCardinal(obj2)^ := Cardinal(p^.VPCls);
      Result:=TSOMObject(p^.VPCls);
    end;
    exit;
    end;


    {$ifdef fpc}TsomMethodProc(_somIsInstance):={$else}@_somIsInstance:=Pointer{$endif}(somResolve(obj,SOMObjectClassData.somIsInstanceOf));
    p := @RSOMObject;                   // First check for specific instances...
    while (p<>nil)and(not _somIsInstance(obj,TRealSOMObject(p^.SOMCls^))) do
    begin
//      somPrintf('0X%08X'#13#10, longint(p^.SOMCls^));
      p:=p^.Next;
    end;
    if p=nil then somPrintf('oops'#13#10);
    if p<>nil then begin
      PCardinal(obj2)^ := Cardinal(p^.VPCls);
    //  Result:=TSOMObject(p^.VPCls);
      exit;
    end;

    {$ifdef fpc}TsomMethodProc(_somIsA):={$else}@_somIsA:=Pointer{$endif}(somResolve(obj,SOMObjectClassData.somIsA));
    p := @RSOMObject; // Specific class not registered. Look for best general class.
    q := @RSOMObject;
    while (p<>nil) do begin
      if _somIsA(obj,TRealSOMObject(p^.SOMCls^)) then q := p;
//      somPrintf('0X%08X'#13#10, longint(p^.SOMCls^));
      p := p^.Next;
    end;

//    somPrintf('found 0X%08X'#13#10, longint(TSOMObject));
//    somPrintf('found 0X%08X'#13#10, longint(TSOMObject(q^.VPCls)));

    PCardinal(obj2)^ := Cardinal(q^.VPCls);
//    Result:=TSOMObject(q^.VPCls);
  end;
end;

Function CastClass(obj:TRealSOMObject; cls:TSOMObjectClass): TSOMObjectClass;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
  if not somIsObj(obj) then
  begin
    Result := nil
  end else begin
    if PCardinal(Cardinal(obj)-8)^=$DEADBEAF then
    begin
      dec(Cardinal(obj),4);
      Result := TSOMObjectClass(Pointer(obj));
      PCardinal(Cardinal(obj))^ := Cardinal(cls);
    end else begin
//      somPrintf('Dead beaf 0X%08X'#13#10, PCardinal(Cardinal(obj)-8)^);
//      somPrintf('Trying to cast instance of 0X%08X'#13#10, Cardinal(obj));
      Result:=TSOMObjectClass(ResolveClass(obj));
      //Halt(1);
    end;
  end;
end;

Function ResolveSOMClass(obj:TSOMObject):TRealSOMObject;
var
  p,q                   : PVPSOMRecord;
  obj2                  : TRealSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);

//      somPrintf('Trying to resolve instance of 0X%08X'#13#10, Cardinal(obj));
{----------------------------}
    p := @RSOMObject;                   // First check for specific instances...
    while (p<>nil) do
    begin
//      somPrintf('0X%08X'#13#10, longint(p^.VPCls));
//      somPrintf('0X%08X'#13#10, longint(p^.SOMCls^));
      if TSOMObject(p^.VPCls)=obj then break;
      p:=p^.Next;
    end;
    if p=nil then somPrintf('oops'#13#10);
    if p<>nil then begin
//      PCardinal(obj2)^ := Cardinal(p^.VPCls);
      Result:=TRealSOMObject(p^.SOMCls^);
      exit;
    end;

{----------------------------}

end;

(********************** Object Pascal mappings *************************)

class function TSOMObject.InstanceClass: TRealSOMClass;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObjectClassData.classObject;
end;

class function TSOMObject.RegisterClass:TSOMObjectClass;
const
  firsttime     : Boolean = True;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  if (SOMObjectClassData.classObject=nil)or firsttime then begin
    firsttime:=false;
    if (SOMObjectClassData.classObject=nil) then SOMObjectNewClass(SOMObject_MajorVersion,SOMObject_MinorVersion);
    CastClass(SOMObjectClassData.classObject, TSOMClass.RegisterClass);   // SOM Metaclass is SOMClass
  end;
  Result := TSOMObject;
end;

Constructor TSOMObject.Create;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  inherited Create;
  {$ifdef SOM_VERSION_2}
  somDefaultInit(nil);
  {$else}
  somInit;
  {$endif}
end;

class function TSOMObject.NewInstance: TObject; {$ifndef vpc}register;{$endif}
type
  somTD_SOMClass_somNewNoInit = function(somSelf: TRealSOMClass): TRealSOMObject;
var
  somNewNoInit          : somTD_SOMClass_somNewNoInit;
  NewObj                : TRealSOMObject;
  NewCls                : TSOMObjectClass;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
{ Original NewInstance 
           getmem(p, InstanceSize);
           if p <> nil then
              InitInstance(p);
           NewInstance:=TObject(p);
}

  Result := nil;
  NewCls := RegisterClass;
  if (InstanceSize>4)or(NewCls=nil) then exit;
  somNewNoInit := somTD_SOMClass_somNewNoInit(somResolveByName(InstanceClass,'somNewNoInit'{SOMClassClassData.somNewNoInit}));
  NewObj := somNewNoInit(InstanceClass);
  if NewObj=nil then exit;
  dec(Cardinal(NewObj),4);
  PCardinal(NewObj)^ := Cardinal(NewCls);
  Result := TObject(NewObj);
end;

procedure TSOMObject.FreeInstance; {$ifndef vpc}register;{$endif}
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
{ Original FreeInstance
           CleanupInstance;
           FreeMem(Pointer(Self));
}
  // Cleanup Pascal object
  CleanupInstance;

  // Destroy SOM object and Pascal object
  SOMObject_somFree(somSelf);
end;

// Return SOM Object 
function TSOMObject.somSelf:TRealSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := Self;
  if Result<>nil then
  begin
    if PCardinal(Cardinal(Result)-4)^=$DEADBEAF then
    begin
      Inc(Cardinal(Result), 4);
    end else begin
//      somPrintf('Dead beaf 0X%08X'#13#10, PCardinal(Cardinal(Result)-4)^);
//      somPrintf('Trying to get somSelf instance from 0X%08X'#13#10, Cardinal(Result));
      Result:=ResolveSOMClass(Self);
//      somPrintf('somSelf 0X%08X'#13#10, Cardinal(Result));
    end;
  end;
end;

Procedure TSOMObject.somFree;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Free;
end;

Procedure TSOMObject.somInit;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somInit(somSelf);
end;

Procedure TSOMObject.somUnInit;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somUnInit(somSelf);
end;

Function TSOMObject.somGetClass:TSOMClass;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := TSOMClass(CastClass(SOMObject_somGetClass(somSelf), TSOMClass));
end;

Function TSOMObject.somGetClassName:PChar;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somGetClassName(somSelf);
end;

Function TSOMObject.somGetSize:Longint;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somGetSize(somSelf);
end;

Function TSOMObject.somIsA(aClassObj:TSOMClass): TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somIsA(somSelf,aClassObj.somSelf);
end;

Function TSOMObject.somIsInstanceOf(aClassObj:TSOMClass): TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somIsInstanceOf(somSelf,aClassObj.somSelf);
end;

Function TSOMObject.somRespondsTo(mId: TsomId): TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somRespondsTo(somSelf,mId);
end;

Procedure TSOMObject.somDispatchV(methodId: TsomId; descriptor: TsomId; ap:tva_list);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDispatchV(somSelf, methodId, descriptor, ap);
end;

Function TSOMObject.somDispatchL(methodId: TsomId; descriptor: TsomId; ap:tva_list):Longint;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result:=SOMObject_somDispatchL(somSelf, methodId, descriptor, ap);
end;

Function TSOMObject.somDispatchA(methodId: TsomId; descriptor: TsomId; ap:tva_list):Pointer;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result:=SOMObject_somDispatchA(somSelf, methodId, descriptor, ap);
end;

Function TSOMObject.somDispatchD(methodId: TsomId; descriptor: TsomId; ap:tva_list):Double;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result:=SOMObject_somDispatchD(somSelf, methodId, descriptor, ap);
end;

Function TSOMObject.somPrintSelf:TSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := ResolveClass(SOMObject_somPrintSelf(somSelf));
end;

Procedure TSOMObject.somDumpSelf(level:longint);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDumpSelf(somSelf,level);
end;

Procedure TSOMObject.somDumpSelfInt(level:longint);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDumpSelfInt(somSelf,level);
end;

{$ifdef SOM_VERSION_2}
Procedure TSOMObject.somDefaultInit(ctrl: PsomInitCtrl);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDefaultInit(somSelf,ctrl);
end;

Procedure TSOMObject.somDestruct(doFree: TCORBA_boolean;ctrl: PsomDestructCtrl);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDestruct(somSelf,doFree,ctrl);
end;

Procedure TSOMObject.somDefaultCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDefaultCopyInit(somSelf,ctrl,fromObj.somSelf);
end;

Procedure TSOMObject.somDefaultConstCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDefaultConstCopyInit(somSelf,ctrl,fromObj.somSelf);
end;

Procedure TSOMObject.somDefaultVCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDefaultVCopyInit(somSelf,ctrl,fromObj.somSelf);
end;

Procedure TSOMObject.somDefaultConstVCopyInit(ctrl: PsomInitCtrl; fromObj:TSOMObject);
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  SOMObject_somDefaultConstVCopyInit(somSelf,ctrl,fromObj.somSelf);
end;

Function TSOMObject.somDefaultAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := ResolveClass(SOMObject_somDefaultAssign(somSelf,ctrl,fromObj.somSelf));
end;

Function TSOMObject.somDefaultConstAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := ResolveClass(SOMObject_somDefaultConstAssign(somSelf,ctrl,fromObj.somSelf));
end;

Function TSOMObject.somDefaultVAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := ResolveClass(SOMObject_somDefaultVAssign(somSelf,ctrl,fromObj.somSelf));
end;

Function TSOMObject.somDefaultConstVAssign(ctrl: PsomAssignCtrl; fromObj:TSOMObject):TSOMObject;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := ResolveClass(SOMObject_somDefaultConstVAssign(somSelf,ctrl,fromObj.somSelf));
end;

Function TSOMObject.somDispatch(var retValue: TsomToken;methodId: TsomId; ap: tva_list): TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somDispatch(somSelf,retValue,methodId,ap);
end;

Function TSOMObject.somClassDispatch(clsObj: TSOMClass; var retValue: TsomToken; methodId: TsomId; ap: tva_list): TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somClassDispatch(somSelf,clsObj.somSelf,retValue,methodId,ap);
end;

Function TSOMObject.somCastObj(cls: TSOMClass): TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somCastObj(somSelf,cls.somSelf);
end;

Function TSOMObject.somResetObj: TCORBA_boolean;
begin
  if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMObject.'+{$I %CURRENTROUTINE%}+#13#10);
  Result := SOMObject_somResetObj(somSelf);
end;

{$endif}

{$endif}

{$ifndef SOM_EXTVAR}
var
  hLib1: THandle;
{$endif}
Begin
{$ifndef SOM_EXTVAR}
  hLib1 := LoadLibrary(SOMDLL);
  SOMObjectClassDataPtr := GetProcAddress(hLib1, 'SOMObjectClassData');
  SOMObjectClassData:=SOMObjectClassDataPtr^;
  FreeLibrary(hLib1);
{$else}
  SOMObjectClassDataPtr := @SOMObjectClassData;
{$endif}
{$ifdef SOM_OBJECTS}
//  somPrintf('Register SOMObject=0X%08X'#13#10, SOMObjectClassData);
//  RegisterSOMPasClass(TSOMObject, @SOMObjectClassData);
  RegisterVPClass(RSOMObject);
{$endif}
end.