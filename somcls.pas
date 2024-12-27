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

{$I SOM.INC}

Unit SOMCLS;

Interface

Uses
  SOM, SOMOBJ;

////////////////////////// SOMClass class //////////////////////////////////

const
  SOMClass_MajorVersion = 1;
  {$ifdef SOM_VERSION_3}
    SOMClass_MinorVersion = 6;
  {$else}
    {$ifdef SOM_VERSION_2}
      SOMClass_MinorVersion = 4;
    {$else}
      SOMClass_MinorVersion = 1;
    {$endif}
  {$endif}

type
  SOMClassCClassDataStructure   = record
    parentMtab                  : somMethodTabs;
    instanceDataToken           : somDToken;
  end;

var
  SOMClassCClassData            : SOMClassCClassDataStructure; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMClassCClassData';{$endif}

type
  TSOMClassClassDataStructure    = record
    classObject                 : TRealSOMClass;
	// SOM 1 Methods
    somNew                      : somMToken;
    somRenew                    : somMToken;
    somInitClass                : somMToken;
    somClassReady               : somMToken;
    somGetName                  : somMToken;
    somGetParent                : somMToken;
    somDescendedFrom            : somMToken;
    somCheckVersion             : somMToken;
    somFindMethod               : somMToken;
    somFindMethodOk             : somMToken;
    somSupportsMethod           : somMToken;
    somGetNumMethods            : somMToken;
    somGetInstanceSize          : somMToken;
    somGetInstanceOffset        : somMToken;
    somGetInstancePartSize      : somMToken;
    somGetMethodIndex           : somMToken;
    somGetNumStaticMethods      : somMToken;
    somGetPClsMtab              : somMToken;
    somGetClassMtab             : somMToken;
    somAddStaticMethod          : somMToken;
    somOverrideSMethod          : somMToken;
    somAddDynamicMethod         : somMToken;
    somGetMethodOffset          : somMToken;
    somGetApplyStub             : somMToken;
    somFindSMethod              : somMToken;
    somFindSMethodOk            : somMToken;
    somGetMethodDescriptor      : somMToken;
    somGetNthMethodInfo         : somMToken;
    somSetClassData             : somMToken;
    somGetClassData             : somMToken;
    somNewNoInit                : somMToken;
    somRenewNoInit              : somMToken;
    somGetInstanceToken         : somMToken;
    somGetMemberToken           : somMToken;
    somSetMethodDescriptor      : somMToken;
    somGetMethodData            : somMToken;
	// SOM 2 methods
	{$ifdef SOM_VERSION_2}
    somOverrideMtab             : somMToken;
    somGetMethodToken           : somMToken;
    somGetParents               : somMToken;
    somGetPClsMtabs             : somMToken;
    somInitMIClass              : somMToken;
    somGetVersionNumbers        : somMToken;
    somLookupMethod             : somMToken;
    _get_somInstanceDataOffsets : somMToken;
    somRenewNoZero              : somMToken;
    somRenewNoInitNoZero        : somMToken;
    somAllocate                 : somMToken;
    somDeallocate               : somMToken;
    somGetRdStub                : somMToken;
    somGetNthMethodData         : somMToken;
    somCloneClass               : somMToken;
    _get_somMethodOffsets       : somMToken;
    _get_somDirectInitClasses   : somMToken;
    _set_somDirectInitClasses   : somMToken;
    somGetInstanceInitMask      : somMToken;
    somGetInstanceDestructionMask:somMToken;
    somCastObjCls               : somMToken;
    somResetObjCls              : somMToken;
    _get_somTrueClass           : somMToken;
    _get_somCastedClass         : somMToken;
    somRegLPMToken              : somMToken;
    somDefinedMethod            : somMToken;
    somAddMethod                : somMToken;
    _get_somCClassData          : somMToken;
    _set_somCClassData          : somMToken;
    somClassOfNewClassWithParents : somMToken; {Direct call proc??}
    _set_somClassDataOrder      : somMToken;
    _get_somClassDataOrder      : somMToken;
    somGetClassDataEntry        : somMToken;
    somSetClassDataEntry        : somMToken;
    _get_somDataAlignment       : somMToken;
    somGetInstanceAssignmentMask: somMToken;
    _get_somDirectAssignClasses : somMToken;
    setUserPCallDispatch        : somMToken;
    _get_somClassAllocate       : somMToken;
    _get_somClassDeallocate     : somMToken;
	{$endif}
	// SOM 3 methods
	{$ifdef SOM_VERSION_3}
	somGetMarshalPlan			: somMToken;
	somcUnused11				: somMToken;
	somPrivate23				: somMToken;
	somJoin						: somMToken;
	somEndow					: somMToken;
	{$endif}
  end;

var
  SOMClassClassData             : TSOMClassClassDataStructure; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMClassClassData';{$endif}

const
  SOMClassClassDataPtr: ^TSOMClassClassDataStructure = @SOMClassClassData;

Function SOMClassNewClass(majorVersion,minorVersion:Longint):TRealSOMClass; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * New Method: somNew
 *)

(*
 *  Uses somAllocate to allocate storage for a new
 *  instance of the receiving class, calls somRenewNoInitNoZero
 *  to load the new object's method table pointer, and then
 *  calls somDefaultInit to initialize the new object.
 *  Overrides are not expected. NULL is returned on failure.
 *)

const
  somMD_SOMClass_somNew = '::SOMClass::somNew';

type
  somTP_SOMClass_somNew = function(somSelf: TRealSOMClass): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somNew = somTP_SOMClass_somNew;

function SOMClass_somNew(somSelf: TRealSOMClass): TRealSOMObject;

(*
 * New Method: somNewNoInit
 *)

(*
 *  Equivalent to somNew except that somDefaultInit is not called.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somNewNoInit = '::SOMClass::somNewNoInit';

type
  somTP_SOMClass_somNewNoInit = function(somSelf: TRealSOMClass): TRealSOMObject;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somNewNoInit = somTP_SOMClass_somNewNoInit;

function SOMClass_somNewNoInit(somSelf: TRealSOMClass): TRealSOMObject;

(*
 * New Method: somRenew
 *)

(*
 *  Equivalent to somNew except that storage is not allocated.
 *  <obj> is taken as the address of the new object.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somRenew = '::SOMClass::somRenew';

type
  somTP_SOMClass_somRenew = function(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somRenew = somTP_SOMClass_somRenew;

function SOMClass_somRenew(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;

(*
 * New Method: somRenewNoInit
 *)

(*
 *  Equivalent to somRenew except that somDefaultInit is not called.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somRenewNoInit = '::SOMClass::somRenewNoInit';

type
  somTP_SOMClass_somRenewNoInit = function(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somRenewNoInit = somTP_SOMClass_somRenewNoInit;

function SOMClass_somRenewNoInit(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;


(*
 * New Method: somAddStaticMethod
 *)

(*
 *  Introduce a new static method with the indicated methodId into
 *  the receiving class. Overrides should perform relative parent calls.
 *)

const
  somMD_SOMClass_somAddStaticMethod = '::SOMClass::somAddStaticMethod';
type
  somTP_SOMClass_somAddStaticMethod = function(somSelf: TRealSOMClass; methodId, methodDescriptor: somId; method, redispatchStub, applyStub: somMethodPtr): somMToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somAddStaticMethod = somTP_SOMClass_somAddStaticMethod;

function SOMClass_somAddStaticMethod(somSelf: TRealSOMClass; methodId, methodDescriptor: somId; method, redispatchStub, applyStub: somMethodPtr): somMToken;

(*
 * New Method: somOverrideSMethod
 *)

(*
 *  Replace the implementation for the indicated method in the instances
 *  of the receiving class. Overrides should perform relative parent calls.
 *)
const
  somMD_SOMClass_somOverrideSMethod = '::SOMClass::somOverrideSMethod';

type
  somTP_SOMClass_somOverrideSMethod = procedure(somSelf: TRealSOMClass; methodId: somId; method: somMethodPtr);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somOverrideSMethod = somTP_SOMClass_somOverrideSMethod;

procedure SOMClass_somOverrideSMethod(somSelf: TRealSOMClass; methodId: somId; method: somMethodPtr);

(*
 * New Method: somClassReady
 *)

(*
 *  This method is invoked when all of the static initialization for
 *  the class has been finished (i.e., its instance method table has
 *  been loaded) and allows final setup for the class to be done. When
 *  overriding this method, all setup should be done before doing a
 *  relative pcall, since SOMClass's implementation will register the
 *  class with the class manager.
 *)
const
  somMD_SOMClass_somClassReady = '::SOMClass::somClassReady';

type
  somTP_SOMClass_somClassReady = procedure(somSelf: TRealSOMClass);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somClassReady = somTP_SOMClass_somClassReady;

procedure SOMClass_somClassReady(somSelf: TRealSOMClass);

(*
 * New Method: somAddDynamicMethod
 *)

(*
 *  If the receiving class supports a static method with the indicated
 *  methodId, then override the method with the indicated implementation.
 *  Otherwise, a dynamic method with the indicated methodId is added to
 *  the receiving class.
 *)

const
  somMD_SOMClass_somAddDynamicMethod  = '::SOMClass::somAddDynamicMethod';

type
  somTP_SOMClass_somAddDynamicMethod = procedure(somSelf: TRealSOMClass; methodId, methodDescriptor: somId; methodImpl, applyStub: somMethodPtr);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somAddDynamicMethod = somTP_SOMClass_somAddDynamicMethod;

procedure SOMClass_somAddDynamicMethod(somSelf: TRealSOMClass; methodId, methodDescriptor: somId; methodImpl, applyStub: somMethodPtr);

(*
 * New Method: somGetName
 *)
(*
 *  This object's class name as a NULL terminated string.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetName = '::SOMClass::somGetName';

type
  somTP_SOMClass_somGetName = function(somSelf: TRealSOMClass): PCORBA_char;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetName = somTP_SOMClass_somGetName;

function SOMClass_somGetName(somSelf: TRealSOMClass): PCORBA_char;


(*
 * New Method: somGetNumMethods
 *)

(*
 *  The number of methods currently supported by this class,
 *  including inherited methods (static, nonstatic, and dynamic).
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetNumMethods = '::SOMClass::somGetNumMethods';

type
  somTP_SOMClass_somGetNumMethods = function(somSelf: TRealSOMClass): TCORBA_long;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetNumMethods = somTP_SOMClass_somGetNumMethods;

function SOMClass_somGetNumMethods(somSelf: TRealSOMClass): TCORBA_long;

(*
 * New Method: somGetNumStaticMethods
 *)

(*
 *  The number of nondynamic methods that this class has.  Can
 *  be used by a child class when initializing its method table.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetNumStaticMethods = '::SOMClass::somGetNumStaticMethods';

type
  somTP_SOMClass_somGetNumStaticMethods = function(somSelf: TRealSOMClass): TCORBA_long;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetNumStaticMethods = somTP_SOMClass_somGetNumStaticMethods;

function SOMClass_somGetNumStaticMethods(somSelf: TRealSOMClass): TCORBA_long;

(*
 * New Method: somGetInstanceSize
 *)

(*
 *  The total size of an instance of the receiving class.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetInstanceSize = '::SOMClass::somGetInstanceSize';

type
  somTP_SOMClass_somGetInstanceSize = function(somSelf: TRealSOMClass): TCORBA_long;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetInstanceSize = somTP_SOMClass_somGetInstanceSize;

function SOMClass_somGetInstanceSize(somSelf: TRealSOMClass): TCORBA_long;

(*
 * New Method: somGetInstancePartSize
 *)

(*
 *  The size in bytes of the instance data introduced by the receiving
 *  class.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetInstancePartSize = '::SOMClass::somGetInstancePartSize';

type
  somTP_SOMClass_somGetInstancePartSize = function(somSelf: TRealSOMClass): TCORBA_long;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetInstancePartSize = somTP_SOMClass_somGetInstancePartSize;

function SOMClass_somGetInstancePartSize(somSelf: TRealSOMClass): TCORBA_long;

(*
 * New Method: somGetInstanceToken
 *)

(*
 *  A data token that identifies the introduced portion of this class
 *  within itself or any derived class.  This token can be subsequently
 *  passed to the run-time somDataResolve function to locate the instance
 *  data introduced by this class in any object derived from this class.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetInstanceToken = '::SOMClass::somGetInstanceToken';

type
  somTP_SOMClass_somGetInstanceToken = function(somSelf: TRealSOMClass): somDToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetInstanceToken = somTP_SOMClass_somGetInstanceToken;

function SOMClass_somGetInstanceToken(somSelf: TRealSOMClass): somDToken;

(*
 * New Method: somGetMemberToken
 *)

(*
 *  Returns a data token that for the data member at offset
 *  "memberOffset" within the introduced portion of the class identified
 *  by instanceToken.  The instance token must have been obtained from a
 *  previous invocation of somGetInstanceToken.  The returned member
 *  token can be subsequently passed to the run-time somDataResolve
 *  function to locate the data member.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetMemberToken = '::SOMClass::somGetMemberToken';

type
  somTP_SOMClass_somGetMemberToken = function(somSelf: TRealSOMClass; memberOffset: TCORBA_long; instanceToken: somDToken): somDToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetMemberToken = somTP_SOMClass_somGetMemberToken;

function SOMClass_somGetMemberToken(somSelf: TRealSOMClass; memberOffset: TCORBA_long; instanceToken: somDToken): somDToken;

(*
 * New Method: somGetClassMtab
 *)

(*
 *  A pointer to the method table used by instances of this class. This
 *  method was misnamed; it should have been called somGetInstanceMtab.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetClassMtab = '::SOMClass::somGetClassMtab';

type
  somTP_SOMClass_somGetClassMtab = function(somSelf: TRealSOMClass): somMethodTabPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetClassMtab = somTP_SOMClass_somGetClassMtab;

function SOMClass_somGetClassMtab(somSelf: TRealSOMClass): somMethodTabPtr;

(*
 * New Method: somGetClassData
 *)

const
  somMD_SOMClass_somGetClassData = '::SOMClass::somGetClassData';

type
  somTP_SOMClass_somGetClassData = function(somSelf: TRealSOMClass): somClassDataStructurePtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetClassData = somTP_SOMClass_somGetClassData;
function SOMClass_somGetClassData(somSelf: TRealSOMClass): somClassDataStructurePtr;

(*
 * New Method: somSetClassData
 *)
(*
 *  The pointer to the static <className>ClassData structure.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somSetClassData = '::SOMClass::somSetClassData';

type
  somTP_SOMClass_somSetClassData = procedure(somSelf: TRealSOMClass; cds: somClassDataStructurePtr);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somSetClassData = somTP_SOMClass_somSetClassData;

procedure SOMClass_somSetClassData(somSelf: TRealSOMClass; cds: somClassDataStructurePtr);


(*
 * New Method: somGetMethodDescriptor
 *)

(*
 *  Returns the method descriptor for the indicated method.    If
 *  this object does not support the indicated method then NULL is
 *  returned.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetMethodDescriptor = '::SOMClass::somGetMethodDescriptor';

type
  somTP_SOMClass_somGetMethodDescriptor = function(somSelf: TRealSOMClass; methodId: somId): somId;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetMethodDescriptor = somTP_SOMClass_somGetMethodDescriptor;

function SOMClass_somGetMethodDescriptor(somSelf: TRealSOMClass; methodId: somId): somId;

(*
 * New Method: somGetMethodIndex
 *)

(*
 *  Returns the index for the specified method. (A number that may
 *  change if any methods are added or deleted to this class object or
 *  any of its ancestors).  This number is the basis for other calls to
 *  get info about the method. Indexes start at 0. A -1 is returned if
 *  the method cannot be found.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetMethodIndex = '::SOMClass::somGetMethodIndex';

type
  somTP_SOMClass_somGetMethodIndex = function(somSelf: TRealSOMClass; id: somId): LongInt;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetMethodIndex = somTP_SOMClass_somGetMethodIndex;

function SOMClass_somGetMethodIndex(somSelf: TRealSOMClass; id: somId): LongInt;


(*
 * New Method: somGetMethodData
 *)
(*
 *  If the receiving class supports a method with the specified somId,
 *  then the method data pointed to by md is loaded with information
 *  for the method and 1 (TRUE) is returned. Otherwise md->id is set to
 *  NULL and 0 (FALSE) is returned. On success, the md->method field is
 *  loaded with a the address of a function that invokes the method
 *  implementation appropriate for instances of the receiving class.
 *  Successive calls for the same method are *not* guaranteed to load
 *  md->method with the same address. All somId-based method resolution
 *  routines use the md->method address computed by somGetMethodData
 *  as their resolution result.
 *)

const
  somMD_SOMClass_somGetMethodData = '::SOMClass::somGetMethodData';

type
  somTP_SOMClass_somGetMethodData = function(somSelf: TRealSOMClass; methodId: somId; var md: somMethodData): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetMethodData = somTP_SOMClass_somGetMethodData;

function SOMClass_somGetMethodData(somSelf: TRealSOMClass; methodId: somId; var md: somMethodData): TCORBA_boolean;


(*
 * New Method: somFindMethod
 *)

(*
 *  If the receiving class supports a method with the specified
 *  methodId, m is set to the address of a function that
 *  will invoke the method implementation appropriate for instances
 *  of the receiving class and 1 (TRUE) is returned. Otherwise, m is
 *  set to NULL and 0 (FALSE) is returned. Successive calls on the
 *  same class with the same arguments are not guaranteed to return
 *  the same function address.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somFindMethod = '::SOMClass::somFindMethod';

type
  somTP_SOMClass_somFindMethod = function(somSelf: TRealSOMClass; methodId: somId; var m: somMethodPtr): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somFindMethod = somTP_SOMClass_somFindMethod;

function SOMClass_somFindMethod(somSelf: TRealSOMClass; methodId: somId; var m: somMethodPtr): TCORBA_boolean;

(*
 * New Method: somFindMethodOk
 *)

(*
 *  Just like <somFindMethod> except that if the method is not
 *  supported then an error is raised and execution is halted.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somFindMethodOk = '::SOMClass::somFindMethodOk';

type
  somTP_SOMClass_somFindMethodOk = function(somSelf: TRealSOMClass; methodId: somId; var m: somMethodPtr): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somFindMethodOk = somTP_SOMClass_somFindMethodOk;

function SOMClass_somFindMethodOk(somSelf: TRealSOMClass; methodId: somId; var m: somMethodPtr): TCORBA_boolean;

(*
 * New Method: somFindSMethod
 *)

(*
 *  Finds the indicated method, which must be a static method supported
 *  by this class, and returns a pointer to a function that will
 *  invoke the method implementation appropriate for instances of the
 *  receiving class. If the method is not supported by the receiver
 *  (as a static method or at all) then a NULL pointer is returned.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somFindSMethod = '::SOMClass::somFindSMethod';

type
  somTP_SOMClass_somFindSMethod = function(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somFindSMethod = somTP_SOMClass_somFindSMethod;

function SOMClass_somFindSMethod(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;

(*
 * New Method: somFindSMethodOk
 *)

(*
 *  Uses <somFindSMethod>, and raises an error if the result is NULL.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somFindSMethodOk = '::SOMClass::somFindSMethodOk';

type
  somTP_SOMClass_somFindSMethodOk = function(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somFindSMethodOk = somTP_SOMClass_somFindSMethodOk;

function SOMClass_somFindSMethodOk(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;


(*
 * New Method: somGetApplyStub
 *)

(*
 *  Returns the apply stub associated with the specified method,
 *  if one exists; otherwise NULL is returned. This method is obsolete,
 *  and retained for binary compatability. In SOMr2, users never access
 *  apply stubs directly; The function somApply is used to invoke apply
 *  stubs. See somApply documentation for further information on apply
 *  stubs, and see somAddStaticMethod documentation for information
 *  on how apply stubs are registered by class implementations.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetApplyStub = '::SOMClass::somGetApplyStub';

type
  somTP_SOMClass_somGetApplyStub = function(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetApplyStub = somTP_SOMClass_somGetApplyStub;

function SOMClass_somGetApplyStub(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;

(*
 * New Method: somGetPClsMtab
 *)

(*
 *  Returns a list of the method tables of this class's parent classes in the
 *  specific format required by somParentNumResolve (for making parent method
 *  calls. The first entry on the list is actually the method table of the
 *  receiving class. Because the CClassData structure contains this list, the
 *  method table for any class with a CClassData structure is statically
 *  available. This method now returns a list because older SI emitters load
 *  CClassData.parentMtab with the result of this call, and the new runtime
 *  requires a list of classes in that position.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetPClsMtab = '::SOMClass::somGetPClsMtab';

type
  somTP_SOMClass_somGetPClsMtab = function(somSelf: TRealSOMClass): somMethodTabs;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetPClsMtab = somTP_SOMClass_somGetPClsMtab;

function SOMClass_somGetPClsMtab(somSelf: TRealSOMClass): somMethodTabs;

(*
 * New Method: somCheckVersion
 *)

(*
 *  Returns 1 (true) if the implementation of this class is
 *  compatible with the specified major and minor version number and
 *  false (0) otherwise.  An implementation is compatible with the
 *  specified version numbers if it has the same major version number
 *  and a minor version number that is equal to or greater than
 *  <minorVersion>.    The major, minor version number pair (0,0) is
 *  considered to match any version.  This method is usually called
 *  immediately after creating the class object to verify that a
 *  dynamically loaded class definition is compatible with a using
 *  application.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somCheckVersion = '::SOMClass::somCheckVersion';

type
  somTP_SOMClass_somCheckVersion = function(somSelf: TRealSOMClass; majorVersion, minorVersion: LongInt): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somCheckVersion = somTP_SOMClass_somCheckVersion;

function SOMClass_somCheckVersion(somSelf: TRealSOMClass; majorVersion, minorVersion: LongInt): TCORBA_boolean;

(*
 * New Method: somDescendedFrom
 *)

(*
 *  Returns 1 (true) if <self> is a descendent class of <aClassObj> and
 *  0 (false) otherwise.  Note: a class object is considered to be
 *  descended itself for the purposes of this method.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somDescendedFrom = '::SOMClass::somDescendedFrom';

type
  somTP_SOMClass_somDescendedFrom = function(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somDescendedFrom = somTP_SOMClass_somDescendedFrom;

function SOMClass_somDescendedFrom(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean;

(*
 * New Method: somSupportsMethod
 *)

(*
 *  Returns 1 (true) if the indicated method is supported by this
 *  class and 0 (false) otherwise.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somSupportsMethod = '::SOMClass::somSupportsMethod';

type
  somTP_SOMClass_somSupportsMethod = function(somSelf: TRealSOMClass; mId: somId): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somSupportsMethod = somTP_SOMClass_somSupportsMethod;

function SOMClass_somSupportsMethod(somSelf: TRealSOMClass; mId: somId): TCORBA_boolean;

{$ifdef SOM_VERSION_2}
(*
 * New Method: somRenewNoZero
 *)

(*
 *  Equivalent to somRenew except that memory is not zeroed out.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somRenewNoZero = '::SOMClass::somRenewNoZero';

type
  somTP_SOMClass_somRenewNoZero = function(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somRenewNoZero = somTP_SOMClass_somRenewNoZero;

function SOMClass_somRenewNoZero(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;

(*
 * New Method: somRenewNoInitNoZero
 *)

(*
 *  This method loads an object's method table pointer, turning raw
 *  memory into an uninitialized SOM object. The other somNew and
 *  somRenew methods all call this method, so metaclasses can override
 *  this method to track object creation if this is desired. A relative
 *  parent call should be done from overrides.
 *)
const
  somMD_SOMClass_somRenewNoInitNoZero = '::SOMClass::somRenewNoInitNoZero';

type
  somTP_SOMClass_somRenewNoInitNoZero = function(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somRenewNoInitNoZero = somTP_SOMClass_somRenewNoInitNoZero;

function SOMClass_somRenewNoInitNoZero(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;

(*
 * New Method: somAllocate
 *)

(*
 *  nonstatic
 *  Uses the memory allocation routine associated with the receiving
 *  class to allocate memory to hold an object of the indicated size.
 *  NULL is returned on failure. The default allocation routine uses
 *  SOMMalloc.
 *)

const
  somMD_SOMClass_somAllocate = '::SOMClass::somAllocate';

type
  somTP_SOMClass_somAllocate = function(somSelf: TRealSOMClass; size: LongInt): somToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somAllocate = somTP_SOMClass_somAllocate;

function SOMClass_somAllocate(somSelf: TRealSOMClass; size: LongInt): somToken;

(*
 * New Method: somDeallocate
 *)
(*
 *  nonstatic
 *  Uses the memory deallocation routine associated with the receiving
 *  class to deallocate memory beginning at the address indicated by
 *  memptr. The first word of this memory (normally a method table
 *  pointer) is loaded with NULL. The deallocation routine receives
 *  a void* (memptr) and a size_t (size) as arguments.
 *)
const
  somMD_SOMClass_somDeallocate = '::SOMClass::somDeallocate';

type
  somTP_SOMClass_somDeallocate = procedure(somSelf: TRealSOMClass; memptr: somToken);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somDeallocate = somTP_SOMClass_somDeallocate;

procedure SOMClass_somDeallocate(somSelf: TRealSOMClass; memptr: somToken);

(*
 * New Method: somInitMIClass
 *)

(*
 *  Perform inheritance into a class object from the specified parent
 *  classes, determine the layout of instances for the receiving class, and
 *  determine the layout of the instance method table for the receiving class.
 *  Overrides should perform relative parent calls.
 *)

const
  somMD_SOMClass_somInitMIClass = '::SOMClass::somInitMIClass';

type
  somTP_SOMClass_somInitMIClass = procedure(somSelf: TRealSOMClass;
    inherit_vars: TCORBA_unsigned_long; className: PCORBA_char;
    parentClasses: SOMClass_SOMClassSequence;
    dataSize, dataAlignment, maxNDMethods,
    majorVersion, minorVersion: TCORBA_long);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somInitMIClass = somTP_SOMClass_somInitMIClass;

procedure SOMClass_somInitMIClass(somSelf: TRealSOMClass;
  inherit_vars: TCORBA_unsigned_long; className: PCORBA_char;
  parentClasses: SOMClass_SOMClassSequence;
  dataSize, dataAlignment, maxNDMethods, majorVersion, minorVersion: TCORBA_long);

(*
 * New Method: somGetVersionNumbers
 *)

(*
 *  Returns the class' major and minor version numbers in the corresponding
 *  output parameters.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetVersionNumbers = '::SOMClass::somGetVersionNumbers';

type
  somTP_SOMClass_somGetVersionNumbers = procedure(somSelf: TRealSOMClass; var majorVersion, minorVersion: TCORBA_long);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetVersionNumbers = somTP_SOMClass_somGetVersionNumbers;

procedure SOMClass_somGetVersionNumbers(somSelf: TRealSOMClass; var majorVersion, minorVersion: TCORBA_long);

(*
 * New Method: somGetParents
 *)

(*
 *  Returns a sequence containing pointers to the receiver's parent classes.
 *  Caller is responsible for using SOMFree on the returned sequence buffer.
 *  Overrides are not expected.
 *)
const
  somMD_SOMClass_somGetParents = '::SOMClass::somGetParents';

type
  somTP_SOMClass_somGetParents = function(somSelf: TRealSOMClass): SOMClass_SOMClassSequence;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetParents = somTP_SOMClass_somGetParents;

function SOMClass_somGetParents(somSelf: TRealSOMClass): SOMClass_SOMClassSequence;


(*
 * New Method: _get_somDataAlignment
 *)

(*
 *  The alignment required for the instance data structure
 *  introduced by the receiving class.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass__get_somDataAlignment = '::SOMClass::_get_somDataAlignment';
type
  somTP_SOMClass__get_somDataAlignment = function(somSelf: TRealSOMClass): LongInt;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass__get_somDataAlignment = somTP_SOMClass__get_somDataAlignment;

function SOMClass__get_somDataAlignment(somSelf: TRealSOMClass): LongInt;

(*
 * New Method: _get_somInstanceDataOffsets
 *)

(*
 *  A sequence of the instance data offsets for all classes used in
 *  the derivation of the receiving class (including the receiver).
 *  The caller is responsible for freeing the returned sequence buffer.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass__get_somInstanceDataOffsets = '::SOMClass::_get_somInstanceDataOffsets';

type
  somTP_SOMClass__get_somInstanceDataOffsets = function(somSelf: TRealSOMClass): SOMClass_somOffsets;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass__get_somInstanceDataOffsets = somTP_SOMClass__get_somInstanceDataOffsets;

function SOMClass__get_somInstanceDataOffsets(somSelf: TRealSOMClass): SOMClass_somOffsets;

(*
 * New Method: _get_somDirectInitClasses
 *)

(*
 *  The ancestors whose initializers the receiving class wants to
 *  directly invoke. Caller is responsible for freeing the returned
 *  sequence buffer.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass__get_somDirectInitClasses = '::SOMClass::_get_somDirectInitClasses';

type
  somTP_SOMClass__get_somDirectInitClasses = function(somSelf: TRealSOMClass): SOMClass_SOMClassSequence;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass__get_somDirectInitClasses = somTP_SOMClass__get_somDirectInitClasses;
function SOMClass__get_somDirectInitClasses(somSelf: TRealSOMClass): SOMClass_SOMClassSequence;

(*
 * New Method: somGetNthMethodInfo
 *)

(*
 *  Returns the id of the <n>th method if one exists and NULL
 *  otherwise.
 *
 *  The ordering of the methods is unpredictable, but will not change
 *  unless some change is made to the class or one of its ancestor classes.
 *
 *  See CORBA documentation for info on method descriptors.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetNthMethodInfo = '::SOMClass::somGetNthMethodInfo';

type
  somTP_SOMClass_somGetNthMethodInfo = function(somSelf: TRealSOMClass; n: LongInt; var descriptor: somId): somId;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetNthMethodInfo = somTP_SOMClass_somGetNthMethodInfo;

function SOMClass_somGetNthMethodInfo(somSelf: TRealSOMClass; n: LongInt; var descriptor: somId): somId;

(*
 * New Method: somGetMethodToken
 *)

(*
 *  Returns the specified method's access token. This token can then
 *  be passed to method resolution routines, which use the token
 *  to select a method pointer from a method table.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetMethodToken = '::SOMClass::somGetMethodToken';

type
  somTP_SOMClass_somGetMethodToken = function(somSelf: TRealSOMClass; methodId: somId): somMToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetMethodToken = somTP_SOMClass_somGetMethodToken;

function SOMClass_somGetMethodToken(somSelf: TRealSOMClass; methodId: somId): somMToken;

(*
 * New Method: somGetNthMethodData
 *)

(*
 *  This method is similar to somGetMethodData. The method
 *  whose data is returned is the method for which the receiving
 *  class would return n from somGetMethodIndex.
 *)

const
  somMD_SOMClass_somGetNthMethodData = '::SOMClass::somGetNthMethodData';

type
  somTP_SOMClass_somGetNthMethodData = function(somSelf: TRealSOMClass; n: LongInt; var md: somMethodData): TCORBA_boolean;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetNthMethodData = somTP_SOMClass_somGetNthMethodData;

function SOMClass_somGetNthMethodData(somSelf: TRealSOMClass; n: LongInt; var md: somMethodData): TCORBA_boolean;

(*
 * New Method: somLookupMethod
 *)

(*
 *  Like <somFindSMethodOK>, but without restriction to static methods.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somLookupMethod = '::SOMClass::somLookupMethod';

type
  somTP_SOMClass_somLookupMethod = function(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somLookupMethod = somTP_SOMClass_somLookupMethod;

function SOMClass_somLookupMethod(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;

(*
 * New Method: somDefinedMethod
 *)

(*
 *  If the receiving class explicitly defines an implementation for
 *  the indicated method, then the address of a function that will invoke
 *  this implementation is returned. Otherwise NULL is returned.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somDefinedMethod = '::SOMClass::somDefinedMethod';

type
  somTP_SOMClass_somDefinedMethod = function(somSelf: TRealSOMClass; method: somMToken): somMethodPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somDefinedMethod = somTP_SOMClass_somDefinedMethod;

function SOMClass_somDefinedMethod(somSelf: TRealSOMClass; method: somMToken): somMethodPtr;

(*
 * New Method: somGetRdStub
 *)

(*
 *  Returns a redispatch stub for the indicated method if possible.
 *  If not possible (because a valid redispatch stub has not been
 *  registered, and there is insufficient information to dynamically
 *  construct one), then a pointer to a function that prints an
 *  informative message and terminates execution is returned.
 *)

const
  somMD_SOMClass_somGetRdStub = '::SOMClass::somGetRdStub';

type
  somTP_SOMClass_somGetRdStub = function(somSelf: TRealSOMClass; methodId: somId): somMethodProcPtr;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetRdStub = somTP_SOMClass_somGetRdStub;

function SOMClass_somGetRdStub(somSelf: TRealSOMClass; methodId: somId): somMethodProcPtr;

(*
 * New Method: somOverrideMtab
 *)

(*
 *  Overrides the method table pointers to point to the redispatch stubs.
 *  All the methods except somDispatch methods are overriden.
 *)

const
  somMD_SOMClass_somOverrideMtab = '::SOMClass::somOverrideMtab';

type
  somTP_SOMClass_somOverrideMtab = procedure(somSelf: TRealSOMClass);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somOverrideMtab = somTP_SOMClass_somOverrideMtab;

procedure SOMClass_somOverrideMtab(somSelf: TRealSOMClass);

{$endif}

{$ifdef SOM_VERSION_3}

(*
 * New Method: somJoin
 *)

(*
 *  Creates the multiple inheritance join of the target class and the
 *  secondParent with the class name nameOfNewClass.
 *)

const
  somMD_SOMClass_somJoin = '::SOMClass::somJoin';

type
  somTP_SOMClass_somJoin = function(somSelf: TRealSOMClass; secondParent: TRealSOMClass; nameOfNewClass: PCORBA_char): TRealSOMClass;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somJoin = somTP_SOMClass_somJoin;

function SOMClass_somJoin(somSelf: TRealSOMClass; secondParent: TRealSOMClass; nameOfNewClass: PCORBA_char): TRealSOMClass;

(*
 * New Method: somEndow
 *)

(*
 *  Creates the a subclass of parent with the class name nameOfNewClass
 *  where the target class is an added metaclass constraint.
 *  NOTE: this means that the target class must be a metaclass.
 *)

const
  somMD_SOMClass_somEndow = '::SOMClass::somEndow';

type
  somTP_SOMClass_somEndow = function(somSelf: TRealSOMClass; parent: TRealSOMClass; nameOfNewClass: PCORBA_char): TRealSOMClass;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somEndow = somTP_SOMClass_somEndow;

function SOMClass_somEndow(somSelf: TRealSOMClass; parent: TRealSOMClass;
  nameOfNewClass: PCORBA_char): TRealSOMClass; inline;

(*
 * Direct call procedure
 *)
type
  somTP_SOMClass_somClassOfNewClassWithParents =
    function(newClassName: PCORBA_char; parents: SOMClass_SOMClassSequence; explicitMeta: TRealSOMClass): TRealSOMClass;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somClassOfNewClassWithParents = somTP_SOMClass_somClassOfNewClassWithParents;

function SOMClass_somClassOfNewClassWithParents(newClassName: PCORBA_char; parents: SOMClass_SOMClassSequence; explicitMeta: TRealSOMClass): TRealSOMClass;


(*
 * New Method: somGetMarshalPlan
 *)

(*
 *  uses namelookup from the target class to locate a method that has the
 *  indicated methodId, and returns that method's marshal plan if there
 *  is one. Otherwise, null is returned.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somGetMarshalPlan = '::SOMClass::somGetMarshalPlan';

type
  somTP_SOMClass_somGetMarshalPlan = function(somSelf: TRealSOMClass; methodId: somId): somToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somGetMarshalPlan = somTP_SOMClass_somGetMarshalPlan;

function SOMClass_somGetMarshalPlan(somSelf: TRealSOMClass; methodId: somId): somToken;

(*
 * New Method: somMethodImplOwner
 *)

(*
 *  Returns the owner of the implementation of the method indicated by md
 *  for instances of the receiving class, and loads md->method with a
 *  pointer to the method implementation. If the receiving class doesn't
 *  support the method, md->method is not changed, and null is returned.
 *  Implementations that are automatically installed by SOM (such as for
 *  SOMObject's initializers and for legacy support of somInit) are
 *  reported as being owned by SOMObject.
 *  Overrides are not expected.
 *)

const
  somMD_SOMClass_somMethodImplOwner = '::SOMClass::somMethodImplOwner';

type
  somTP_SOMClass_somMethodImplOwner = function(somSelf: TRealSOMClass; var md: somMethodData): TRealSOMClass;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClass_somMethodImplOwner = somTP_SOMClass_somMethodImplOwner;

function SOMClass_somMethodImplOwner(somSelf: TRealSOMClass; var md: somMethodData): TRealSOMClass;

{$endif}

///////////////////// Parent methods //////////////////////////

procedure SOMClass_somInit(somSelf: TRealSOMClass);
procedure SOMClass_somUninit(somSelf: TRealSOMClass);
procedure SOMClass_somFree(somSelf: TRealSOMClass);
function SOMClass_somGetClass(somSelf: TRealSOMClass): TRealSOMClass;
function SOMClass_somGetClassName(somSelf: TRealSOMClass): PCORBA_char;
function SOMClass_somGetSize(somSelf: TRealSOMClass): LongInt;
function SOMClass_somIsA(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean;
function SOMClass_somIsInstanceOf(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean; 
function SOMClass_somRespondsTo(somSelf: TRealSOMClass; mId: somId): TCORBA_boolean;
function SOMClass_somPrintSelf(somSelf: TRealSOMClass): TRealSOMClass;
procedure SOMClass_somDumpSelf(somSelf: TRealSOMClass; level: LongInt);
procedure SOMClass_somDumpSelfInt(somSelf: TRealSOMClass; level: LongInt);

{$ifdef SOM_VERSION_2}
procedure SOMClass_somDefaultInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr);
procedure SOMClass_somDestruct(somSelf: TRealSOMClass; doFree: TCORBA_boolean; ctrl: somDestructCtrlPtr);
procedure SOMClass_somDefaultCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
function SOMClass_somDefaultAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
procedure SOMClass_somDefaultConstCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
procedure SOMClass_somDefaultVCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
procedure SOMClass_somDefaultConstVCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
function SOMClass_somDefaultConstAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
function SOMClass_somDefaultVAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
function SOMClass_somDefaultConstVAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
function SOMClass_somDispatch(somSelf: TRealSOMClass; var retValue: somToken; methodId: somId; ap: Tva_list{array of const}): TCORBA_boolean;
function SOMClass_somClassDispatch(somSelf: TRealSOMClass; clsObj: TRealSOMClass; var retValue: somToken; methodId: somId; ap: tva_list{array of const}): TCORBA_boolean;
function SOMClass_somCastObj(somSelf: TRealSOMClass; castedCls: TRealSOMClass): TCORBA_boolean; 
function SOMClass_somResetObj(somSelf: TRealSOMClass): TCORBA_boolean;
{$endif}


Implementation

Function SOMClassNewClass(majorVersion,minorVersion:Longint):TRealSOMClass; external SOMDLL name 'SOMClassNewClass';

///////////////////// SOMClass class ////////////////////////////////

function SOMClass_somNew(somSelf: TRealSOMClass): TRealSOMObject;
var
  m: somTD_SOMClass_somNew;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somNew));
  Result:=m(somSelf);
end;

function SOMClass_somNewNoInit(somSelf: TRealSOMClass): TRealSOMObject;
var
  m: somTD_SOMClass_somNewNoInit;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somNewNoInit));
  Result:=m(somSelf);
end;

function SOMClass_somRenew(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;
var
  m: somTD_SOMClass_somRenew;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somRenew));
  Result:=m(somSelf, obj);
end;

function SOMClass_somRenewNoInit(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;
var
  m: somTD_SOMClass_somRenewNoInit;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somRenewNoInit));
  Result:=m(somSelf, obj);
end;

function SOMClass_somAddStaticMethod(somSelf: TRealSOMClass; methodId, methodDescriptor: somId; method, redispatchStub, applyStub: somMethodPtr): somMToken;
var
  m: somTD_SOMClass_somAddStaticMethod;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somAddStaticMethod));
  Result:=m(somSelf, methodId, methodDescriptor, method, redispatchStub, applyStub);
end;

procedure SOMClass_somOverrideSMethod(somSelf: TRealSOMClass; methodId: somId; method: somMethodPtr);
var
  m: somTD_SOMClass_somOverrideSMethod;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somOverrideSMethod));
  m(somSelf, methodId, method);
end;

procedure SOMClass_somClassReady(somSelf: TRealSOMClass);
var
  m: somTD_SOMClass_somClassReady;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somClassReady));
  m(somSelf);
end;

procedure SOMClass_somAddDynamicMethod(somSelf: TRealSOMClass; methodId, methodDescriptor: somId; methodImpl, applyStub: somMethodPtr);
var
  m: somTD_SOMClass_somAddDynamicMethod;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somAddDynamicMethod));
  m(somSelf, methodId, methodDescriptor, methodImpl, applyStub);
end;

function SOMClass_somGetName(somSelf: TRealSOMClass): TCORBA_string;
var
  m: somTD_SOMClass_somGetName;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetName));
  Result:=m(somSelf);
end;

function SOMClass_somGetNumMethods(somSelf: TRealSOMClass): TCORBA_long;
var
  m: somTD_SOMClass_somGetNumMethods;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetNumMethods));
  Result:=m(somSelf);
end;

function SOMClass_somGetNumStaticMethods(somSelf: TRealSOMClass): TCORBA_long;
var
  m: somTD_SOMClass_somGetNumStaticMethods;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetNumStaticMethods));
  Result:=m(somSelf);
end;

function SOMClass_somGetInstanceSize(somSelf: TRealSOMClass): TCORBA_long;
var
  m: somTD_SOMClass_somGetInstanceSize;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetInstanceSize));
  Result:=m(somSelf);
end;

function SOMClass_somGetInstancePartSize(somSelf: TRealSOMClass): TCORBA_long;
var
  m: somTD_SOMClass_somGetInstancePartSize;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetInstancePartSize));
  Result:=m(somSelf);
end;

function SOMClass_somGetInstanceToken(somSelf: TRealSOMClass): somDToken;
var
  m: somTD_SOMClass_somGetInstanceToken;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetInstanceToken));
  Result:=m(somSelf);
end;

function SOMClass_somGetMemberToken(somSelf: TRealSOMClass; memberOffset: TCORBA_long; instanceToken: somDToken): somDToken;
var
  mt: somTD_SOMClass_somGetMemberToken;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetMemberToken));
  Result:=mt(somSelf, memberOffset, instanceToken);
end;

function SOMClass_somGetClassMtab(somSelf: TRealSOMClass): somMethodTabPtr;
var
  m: somTD_SOMClass_somGetClassMtab;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetClassMtab));
  Result:=m(somSelf);
end;

function SOMClass_somGetClassData(somSelf: TRealSOMClass): somClassDataStructurePtr;
var
  m: somTD_SOMClass_somGetClassData;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetClassData));
  Result:=m(somSelf);
end;

procedure SOMClass_somSetClassData(somSelf: TRealSOMClass; cds: somClassDataStructurePtr);
var
  m: somTD_SOMClass_somSetClassData;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somSetClassData));
  m(somSelf, cds);
end;

function SOMClass_somGetMethodDescriptor(somSelf: TRealSOMClass; methodId: somId): somId;
var
  m: somTD_SOMClass_somGetMethodDescriptor;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetMethodDescriptor));
  Result:=m(somSelf, methodId);
end;

function SOMClass_somGetMethodIndex(somSelf: TRealSOMClass; id: somId): LongInt;
var
  m: somTD_SOMClass_somGetMethodIndex;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetMethodIndex));
  Result:=m(somSelf, id);
end;

function SOMClass_somGetMethodData(somSelf: TRealSOMClass; methodId: somId; var md: somMethodData): TCORBA_boolean;
var
  m: somTD_SOMClass_somGetMethodData;
begin
  {$ifdef fpc}somMethodProc(m):={$else}@m:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetMethodIndex));
  Result:=m(somSelf, methodId, md);
end;

function SOMClass_somFindMethod(somSelf: TRealSOMClass; methodId: somId; var m: somMethodPtr): TCORBA_boolean;
var
  mt: somTD_SOMClass_somFindMethod;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somFindMethod));
  Result:=mt(somSelf, methodId, m);
end;

function SOMClass_somFindMethodOk(somSelf: TRealSOMClass; methodId: somId; var m: somMethodPtr): TCORBA_boolean;
var
  mt: somTD_SOMClass_somFindMethodOk;
begin
    {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somFindMethodOk));
    Result:=mt(somSelf, methodId, m);
end;

function SOMClass_somFindSMethod(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;
var
  mt: somTD_SOMClass_somFindSMethod;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somFindSMethod));
  Result:=mt(somSelf, methodId);
end;

function SOMClass_somFindSMethodOk(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;
var
  mt: somTD_SOMClass_somFindSMethodOk;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somFindSMethodOk));
  Result:=mt(somSelf, methodId);
end;


function SOMClass_somGetApplyStub(somSelf: TRealSOMClass; methodId: somId): somMethodPtr;
var
  mt: somTD_SOMClass_somGetApplyStub;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetApplyStub));
  Result:=mt(somSelf, methodId);
end;

function SOMClass_somGetPClsMtab(somSelf: TRealSOMClass): somMethodTabs;
var
  mt: somTD_SOMClass_somGetPClsMtab;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetPClsMtab));
  Result:=mt(somSelf);
end;

function SOMClass_somCheckVersion(somSelf: TRealSOMClass; majorVersion, minorVersion: LongInt): TCORBA_boolean;
var
  mt: somTD_SOMClass_somCheckVersion;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somCheckVersion));
  Result:=mt(somSelf, majorVersion, minorVersion);
end;

function SOMClass_somDescendedFrom(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean;
var
  mt: somTD_SOMClass_somDescendedFrom;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somDescendedFrom));
  Result:=mt(somSelf, aClassObj);
end;

function SOMClass_somSupportsMethod(somSelf: TRealSOMClass; mId: somId): TCORBA_boolean;
var
  mt: somTD_SOMClass_somSupportsMethod;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somSupportsMethod));
  Result:=mt(somSelf, mId);
end;

{$ifdef SOM_VERSION_2}
function SOMClass_somRenewNoZero(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;
var
  mt: somTD_SOMClass_somRenewNoZero;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somRenewNoZero));
  Result:=mt(somSelf, obj);
end;

function SOMClass_somRenewNoInitNoZero(somSelf: TRealSOMClass; obj: Pointer): TRealSOMObject;
var
  mt: somTD_SOMClass_somRenewNoInitNoZero;
begin
    {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somRenewNoInitNoZero));
    Result:=mt(somSelf, obj);
end;

function SOMClass_somAllocate(somSelf: TRealSOMClass; size: LongInt): somToken;
var
  mt: somTD_SOMClass_somAllocate;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somAllocate));
  Result:=mt(somSelf, size);
end;

procedure SOMClass_somDeallocate(somSelf: TRealSOMClass; memptr: somToken);
var
  mt: somTD_SOMClass_somDeallocate;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somDeallocate));
  mt(somSelf, memptr);
end;

procedure SOMClass_somInitMIClass(somSelf: TRealSOMClass; inherit_vars: TCORBA_unsigned_long; className: PCORBA_char; parentClasses: SOMClass_SOMClassSequence; dataSize, dataAlignment, maxNDMethods, majorVersion, minorVersion: TCORBA_long);
var
  mt: somTD_SOMClass_somInitMIClass;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somInitMIClass));
    mt(somSelf, inherit_vars, className, parentClasses, dataSize, dataAlignment, maxNDMethods, majorVersion, minorVersion);
end;

function SOMClass_somGetParents(somSelf: TRealSOMClass): SOMClass_SOMClassSequence;
var
  mt: somTD_SOMClass_somGetParents;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetParents));
  Result := mt(somSelf);
end;

procedure SOMClass_somGetVersionNumbers(somSelf: TRealSOMClass; var majorVersion, minorVersion: TCORBA_long);
var
  mt: somTD_SOMClass_somGetVersionNumbers;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetVersionNumbers));
  mt(somSelf, majorVersion, minorVersion);
end;

function SOMClass__get_somInstanceDataOffsets(somSelf: TRealSOMClass): SOMClass_somOffsets;
var
  mt: somTD_SOMClass__get_somInstanceDataOffsets;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData._get_somInstanceDataOffsets));
  Result:=mt(somSelf);
end;

function SOMClass__get_somDirectInitClasses(somSelf: TRealSOMClass): SOMClass_SOMClassSequence;
var
  mt: somTD_SOMClass__get_somDirectInitClasses;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData._get_somDirectInitClasses));
  Result:=mt(somSelf);
end;

function SOMClass__get_somDataAlignment(somSelf: TRealSOMClass): LongInt;
var
  mt: somTD_SOMClass__get_somDataAlignment;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData._get_somDataAlignment));
  Result:=mt(somSelf);
end;

function SOMClass_somGetMethodToken(somSelf: TRealSOMClass; methodId: somId): somMToken;
var
  mt: somTD_SOMClass_somGetMethodToken;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetMethodToken));
  Result:=mt(somSelf, methodId);
end;

function SOMClass_somGetNthMethodInfo(somSelf: TRealSOMClass; n: LongInt; var descriptor: somId): somId;
var
  mt: somTD_SOMClass_somGetNthMethodInfo;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetNthMethodInfo));
  Result:=mt(somSelf, n, descriptor);
end;

function SOMClass_somGetNthMethodData(somSelf: TRealSOMClass; n: LongInt;
  var md: somMethodData): TCORBA_boolean;
var
  mt: somTD_SOMClass_somGetNthMethodData;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetNthMethodData));
  Result := mt(somSelf, n, md);
end;

function SOMClass_somLookupMethod(somSelf: TRealSOMClass; methodId: somId):
  somMethodPtr;
var
  mt: somTD_SOMClass_somLookupMethod;  
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somLookupMethod));
  Result := mt(somSelf, methodId);
end;

function SOMClass_somDefinedMethod(somSelf: TRealSOMClass; method: somMToken):
  somMethodPtr;
var
  mt: somTD_SOMClass_somDefinedMethod;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somDefinedMethod));
  Result := mt(somSelf, method);
end;

function SOMClass_somGetRdStub(somSelf: TRealSOMClass; methodId: somId):
  somMethodProcPtr;
var
  mt: somTD_SOMClass_somGetRdStub;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetRdStub));
  Result := mt(somSelf, methodId);
end;

procedure SOMClass_somOverrideMtab(somSelf: TRealSOMClass);
var
  mt: somTD_SOMClass_somOverrideMtab;
begin
  {$ifdef fpc}somMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somOverrideMtab));
  mt(somSelf);
end;

{$endif}

{$ifdef SOM_VERSION_3}

function SOMClass_somClassOfNewClassWithParents(newClassName: PCORBA_char;
  parents: SOMClass_SOMClassSequence; explicitMeta: TRealSOMClass): TRealSOMClass;
begin
  Result := somTD_SOMClass_somClassOfNewClassWithParents(SOMClassClassData.somClassOfNewClassWithParents)(newClassName, parents, explicitMeta);
end;

function SOMClass_somJoin(somSelf: TRealSOMClass; secondParent: TRealSOMClass;
  nameOfNewClass: PCORBA_char): TRealSOMClass;
begin
  Result := somTD_SOMClass_somJoin(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somJoin))(somSelf, secondParent, nameOfNewClass);
end;

function SOMClass_somEndow(somSelf: TRealSOMClass; parent: TRealSOMClass;
  nameOfNewClass: PCORBA_char): TRealSOMClass;
begin
  Result := somTD_SOMClass_somEndow(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somEndow))(somSelf, parent, nameOfNewClass);
end;

function SOMClass_somGetMarshalPlan(somSelf: TRealSOMClass; methodId: somId):
  somToken;
begin
  Result := somTD_SOMClass_somGetMarshalPlan(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somGetMarshalPlan))(somSelf, methodId);
end;

function SOMClass_somMethodImplOwner(somSelf: TRealSOMClass; var md: somMethodData):
  TRealSOMClass;
begin
  Result:=somTD_SOMClass_somMethodImplOwner(SOM_Resolve(somSelf, SOMClassClassData.classObject, SOMClassClassData.somMethodImplOwner))(somSelf, md);
end;

{$endif}

////////////// SOMClass parent methods ////////////////////////////////////


procedure SOMClass_somInit(somSelf: TRealSOMClass);
begin
  SOMObject_somInit(somSelf);
end;

procedure SOMClass_somUninit(somSelf: TRealSOMClass);
begin
  SOMObject_somUninit(somSelf);
end;

procedure SOMClass_somFree(somSelf: TRealSOMClass);
begin
  SOMObject_somFree(somSelf);
end;

function SOMClass_somGetClass(somSelf: TRealSOMClass): TRealSOMClass;
begin
  Result:=SOMObject_somGetClass(somSelf);
end;

function SOMClass_somGetClassName(somSelf: TRealSOMClass): PCORBA_char;
begin
  Result:=SOMObject_somGetClassName(somSelf);
end;

function SOMClass_somGetSize(somSelf: TRealSOMClass): LongInt;
begin
  Result:=SOMObject_somGetSize(somSelf);
end;

function SOMClass_somIsA(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean;
begin
  Result:=SOMClass_somIsA(somSelf, aClassObj);
end;

function SOMClass_somIsInstanceOf(somSelf: TRealSOMClass; aClassObj: TRealSOMClass): TCORBA_boolean;
begin
  Result:=SOMObject_somIsInstanceOf(somSelf, aClassObj);
end;

function SOMClass_somRespondsTo(somSelf: TRealSOMClass; mId: somId): TCORBA_boolean;
begin
  Result:=SOMObject_somRespondsTo(somSelf, mId);
end;

function SOMClass_somPrintSelf(somSelf: TRealSOMClass): TRealSOMObject;
begin
  Result:=SOMObject_somPrintSelf(somSelf);
end;

procedure SOMClass_somDumpSelf(somSelf: TRealSOMClass; level: LongInt);
begin
  SOMObject_somDumpSelf(somSelf, level);
end;

procedure SOMClass_somDumpSelfInt(somSelf: TRealSOMClass; level: LongInt);
begin
  SOMObject_somDumpSelfInt(somSelf, level);
end;

{$ifdef SOM_VERSION_2}
procedure SOMClass_somDefaultInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr);
begin
  SOMObject_somDefaultInit(somSelf, ctrl);
end;


procedure SOMClass_somDestruct(somSelf: TRealSOMClass; doFree: TCORBA_boolean; ctrl: somDestructCtrlPtr);
begin
  SOMObject_somDestruct(somSelf, doFree, ctrl);
end;

procedure SOMClass_somDefaultCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
begin
  SOMObject_somDefaultCopyInit(somSelf, ctrl, fromObj);
end;

function SOMClass_somDefaultAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
begin
  Result:=SOMObject_somDefaultAssign(somSelf, ctrl, fromObj);
end;

procedure SOMClass_somDefaultConstCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
begin
  SOMObject_somDefaultConstCopyInit(somSelf, ctrl, fromObj);
end;

procedure SOMClass_somDefaultVCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
begin
  SOMObject_somDefaultVCopyInit(somSelf, ctrl, fromObj);
end;

procedure SOMClass_somDefaultConstVCopyInit(somSelf: TRealSOMClass; ctrl: somInitCtrlPtr; fromObj: TRealSOMObject);
begin
  SOMObject_somDefaultConstVCopyInit(somSelf, ctrl, fromObj);
end;

function SOMClass_somDefaultConstAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
begin
  Result:=SOMObject_somDefaultConstAssign(somSelf, ctrl, fromObj);
end;

function SOMClass_somDefaultVAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
begin
  Result:=SOMObject_somDefaultVAssign(somSelf, ctrl, fromObj);
end;

function SOMClass_somDefaultConstVAssign(somSelf: TRealSOMClass; ctrl: somAssignCtrlPtr; fromObj: TRealSOMObject): TRealSOMObject;
begin
  Result:=SOMObject_somDefaultConstVAssign(somSelf, ctrl, fromObj);
end;

function SOMClass_somDispatch(somSelf: TRealSOMClass; var retValue: somToken; methodId: somId; ap: Tva_list{array of const}): TCORBA_boolean;
begin
  Result:=SOMObject_somDispatch(somSelf, retValue, methodId, ap);
end;

function SOMClass_somClassDispatch(somSelf: TRealSOMClass; clsObj: TRealSOMClass; var retValue: somToken; methodId: somId; ap: tva_list{array of const}): TCORBA_boolean;
begin
  Result:=SOMObject_somClassDispatch(somSelf, clsObj, retValue, methodId, ap);
end;

function SOMClass_somCastObj(somSelf: TRealSOMClass; castedCls: TRealSOMClass): TCORBA_boolean;
begin
  Result:=SOMObject_somCastObj(somSelf, castedCls);
end;

function SOMClass_somResetObj(somSelf: TRealSOMClass): TCORBA_boolean;
begin
  Result:=SOMObject_somResetObj(somSelf);
end;

{$endif}

end.
