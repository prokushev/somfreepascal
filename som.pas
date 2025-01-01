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

{** Version info ******************************************************}
{ alpha: was included in FPC 2.x serie. Not usable.                    }
{ alpha 2: OS/2 version broken, Windows version added. SOMObject,      }
{          SOMClass and SOMClassMgr Pascal class mappings added.       }
{          Supports FPC, Delphi compilers. Tested on SOM 2.1,          }
{          SOM 3.0 and somFree versions.                               }
{**********************************************************************}

{$I SOM.INC}

Unit SOM;

Interface

const
  {$IFDEF UNIX}
    SOMDLL='libsomtk';
    SOMTCDLL='libsomtk';
  {$ELSE}
    SOMDLL='som.dll';
    SOMTCDLL='somtc.dll';
  {$ENDIF}

{$ifdef vpc}
type
  PCardinal=^Cardinal;
{$endif}
{$ifdef ver90}
type
  PCardinal=^Cardinal;
{$endif}

(* CORBA basic data types. System/compiler depended. *)
type
  TCORBA_short              = SmallInt;
  TCORBA_unsigned_short     = Word;

  TCORBA_long               = Longint;
  TCORBA_unsigned_long      = Cardinal;

{$ifdef SOM_LONG_LONG}
  TCORBA_long_long          = Int64;
{$ifdef fpc}
  TCORBA_unsigned_long_long = UInt64;
{$else} {Delphi 6+}
  TCORBA_unsigned_long_long = UInt64;???
{$endif}
{$endif}

  TCORBA_float              = Single;
  TCORBA_Double             = Double;
  TCORBA_long_double        = Extended;
  TCORBA_char               = Char;
{$ifdef SOM_WCHAR}
  TCORBA_wchar   			= WideChar;
{$endif}
  TCORBA_boolean            = ByteBool;
  
  TCORBA_octet              = Byte;

(* Pointers to basic data types *)
{$ifdef fpc}
  PCORBA_char    = ^TCORBA_char;
{$else}
  PCORBA_char    = PChar;
{$endif}
  TCORBA_string  = PCORBA_char;

  PCORBA_long    = ^TCORBA_long;
  PCORBA_octet   = ^TCORBA_octet;
  PCORBA_boolean = ^TCORBA_boolean;

(*  SOM Version Numbers  *)
var
  SOM_MajorVersion: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_MajorVersion';{$endif}
  SOM_MinorVersion: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_MinorVersion';{$endif}

var
  SOM_MajorVersionPtr: PCORBA_long;
  SOM_MinorVersionPtr: PCORBA_long;

(*  SOM Thread Support   *)
var
  SOM_MaxThreads: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_MaxThreads';{$endif}
  SOM_MaxThreadsPtr: PCORBA_long;

type
  TFlags                 = TCORBA_long;

type
  TRealSOMObject                        = Pointer;
  TRealSOMClass                         = TRealSOMObject;
  SOMMSingleInstanceType                = Pointer;
  TRealSOMClassMgr                      = TRealSOMObject;
  PRealSOMClassMgr                      = ^TRealSOMClassMgr;
  PRealSOMClass                         = ^TRealSOMClass;
  PRealSOMObject                        = ^TRealSOMObject;
  TCORBA_Object                         = TRealSOMObject;    (* in SOM, a CORBA object is a SOM object *)

  TsomToken              = Pointer;       (* Uninterpretted value   *)
  PsomToken              = ^TsomToken;    (* Uninterpretted value   *)
  TsomId                 = ^PCORBA_char;
  PsomId                 = ^TsomId;

  TsomMToken             = TsomToken;
  TsomDToken             = TsomToken;
  PsomMToken             = ^TsomMToken;
  PsomDToken             = ^TsomDToken;

  Tva_list               = TsomToken;
  Pva_list               = ^Tva_list;

type

  PsomMethod             = Pointer;
  TsomBooleanVector      = PCORBA_boolean;
  TsomCtrlInfo           = TsomToken;

  TsomSharedMethodData   = TsomToken;
  PsomSharedMethodData   = ^TsomSharedMethodData;

  TsomClassInfo          = TsomToken;
  PsomClassInfo          = ^TsomClassInfo;


  TCORBA_TypeCode       = pointer;

(* CORBA 5.7, p.89 *)
  TCORBA_any            = record
    _type               : TCORBA_TypeCode;
    _value              : Pointer;
  end;
  PCORBA_any            = ^TCORBA_any;

{$ifdef SOM_CORBA_MEM}
function CORBA_any_alloc: PCORBA_any;
procedure CORBA_any_set_release(var any: TCORBA_any; status: TCORBA_boolean);
function CORBA_any_get_release(var any: TCORBA_any): TCORBA_boolean;
{$endif}

{$ifdef SOM_CORBA_MEM}
function CORBA_string_alloc(Len: TCORBA_unsigned_long): TCORBA_string;
procedure CORBA_free(Storage: Pointer);
{$endif}

type
(* -- Method/Data Tokens -- For locating methods and data members. *)

  TsomRdAppType         = TCORBA_long;       (* method signature code -- see def below *)
  TsomFloatMap          = Array[0..13] of TCORBA_long; (* float map -- see def below *)
  PsomFloatMap          = ^TsomFloatMap;

  TsomMethodInfo        = record
    callType            : TsomRdAppType;
    va_listSize         : TCORBA_long;
    float_map           : PsomFloatMap;
  end;
  PsomMethodInfo        = ^TsomMethodInfo;

  TsomMethodData        = record
    id                  : TsomId;
    ctype               : TCORBA_long;            (* 0=static, 1=dynamic 2=nonstatic *)
    descriptor          : TsomId;                 (* for use with IR interfaces *)
    mToken              : TsomMToken;             (* NULL for dynamic methods *)
    method              : PsomMethod;             (* depends on resolution context *)
    shared              : PsomSharedMethodData;
  end;
  PsomMethodData        = ^TsomMethodData;

  TsomMethodProc        = Procedure(somSelf:TRealSOMObject);
  PsomMethodProc        = ^TsomMethodProc;


(*---------------------------------------------------------------------
 * C++-style constructors are called initializers in SOM. Initializers
 * are methods that receive a pointer to a somCtrlStruct as an argument.
 *)

  TsomInitInfo          = record
    cls                 : TRealSOMClass;  (* the class whose introduced data is to be initialized *)
    defaultInit         : TsomMethodProc;
    defaultCopyInit     : TsomMethodProc;
    defaultConstCopyInit: TsomMethodProc;
    defaultNCArgCopyInit: TsomMethodProc;
    dataOffset          : TCORBA_long;
    legacyInit          : TsomMethodProc;
  end;
  PsomInitInfo          = ^TsomInitInfo;

  TsomDestructInfo      = record
    cls                 : TRealSOMClass;(* the class whose introduced data is to be destroyed *)
    defaultDestruct     : TsomMethodProc;
    dataOffset          : TCORBA_long;
    legacyUninit        : TsomMethodProc;
  end;
  PsomDestructInfo      = ^TsomDestructInfo;

  TsomAssignInfo        = record
    cls                 : TRealSOMClass;(* the class whose introduced data is to be assigned *)
    defaultAssign       : TsomMethodProc;
    defaultConstAssign  : TsomMethodProc;
    defaultNCArgAssign  : TsomMethodProc;
    udaAssign           : TsomMethodProc;
    udaConstAssign      : TsomMethodProc;
    dataOffset          : TCORBA_long;
  end;
  PsomAssignInfo        = ^TsomAssignInfo;

  TCORBA_sequence_octet   = record
    _maximum            : TCORBA_unsigned_long;
    _length             : TCORBA_unsigned_long;
    _buffer             : PCORBA_octet;
  end;
  PCORBA_sequence_octet = ^TCORBA_sequence_octet;
  T_IDL_SEQUENCE_octet = TCORBA_sequence_octet;
  P_IDL_SEQUENCE_octet = TCORBA_sequence_octet;

{$ifdef SOM_CORBA_MEM}
function CORBA_sequence_octet__allocbuf(Len: TCORBA_unsigned_long): PCORBA_octet;
function CORBA_sequence_octet__alloc(Len: TCORBA_unsigned_long): PCORBA_sequence_octet;
procedure CORBA_sequence_set_release(Sequence: Pointer; status: TCORBA_boolean);
function CORBA_sequence_get_release(Sequence: Pointer): TCORBA_boolean;
{$endif}

type
(*
 * A special info access structure pointed to by
 * the parentMtab entry of somCClassDataStructure.
 *)
  somTD_somRenewNoInitNoZeroThunk      =Procedure(var buf);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}

  TsomInitCtrl          = record
    mask                : TsomBooleanVector; (* an array of booleans to control ancestor calls *)
    info                : PsomInitInfo;      (* an array of structs *)
    infoSize            : TCORBA_long;       (* increment for info access *)
    ctrlInfo            : TsomCtrlInfo;
  end;
  PsomInitCtrl          =^TsomInitCtrl;
  Tsom3InitCtrl         = TsomInitCtrl;

  TsomDestructCtrl      = record
    mask                : TsomBooleanVector;  (* an array of booleans to control ancestor calls *)
    info                : PsomDestructInfo;   (* an array of structs *)
    infoSize            : TCORBA_long;        (* increment for info access *)
    ctrlInfo            : TsomCtrlInfo;
  end;
  PsomDestructCtrl      =^TsomDestructCtrl;
  Tsom3DestructCtrl     = TsomDestructCtrl;

  TsomAssignCtrl        = record
    mask                : TsomBooleanVector; (* an array of booleans to control ancestor calls *)
    info                : PsomAssignInfo;    (* an array of structs *)
    infoSize            : TCORBA_long;         (* increment for info access *)
    ctrlInfo            : TsomCtrlInfo;
  end;
  PsomAssignCtrl        =^TsomAssignCtrl;
  Tsom3AssignCtrl       = TsomAssignCtrl;

(*----------------------------------------------------------------------
 *  The Class Data Structures -- these are used to implement static
 *  method and data interfaces to SOM objects.
 *)

type
(* -- (Generic) Class data Structure *)
  TsomClassData         = record
    classObject         : TRealSOMClass;                 (* changed by shadowing *)
    tokens              : Array[0..0] of TsomToken;      (* method tokens, etc. *)
  end;
  PsomClassData         =^TsomClassData;


(*----------------------------------------------------------------------
 *  The Method Table Structure
 *)

  TsomEmbeddedObj       =record
    copp                : TRealSOMClass;  (* address of class of object ptr *)
    cnt                 : TCORBA_long;       (* object count *)
    offset              : TCORBA_long;       (* Offset to pointer (to embedded objs) *)
  end;
(* -- to specify an embedded object (or array of objects). *)
  PsomEmbeddedObj       =^TsomEmbeddedObj;

  TsomMethodTab    =record
    classObject         : TRealSOMClass;
    classInfo           : PsomClassInfo;
    className           : TCORBA_string;
    instanceSize        : TCORBA_long;
    dataAlignment       : TCORBA_long;
    mtabSize            : TCORBA_long;
    protectedDataOffset : TCORBA_long;       (* from class's introduced data *)
    protectedDataToken  : TsomDToken;
    embeddedObjs        : PsomEmbeddedObj;
    (* remaining structure is opaque *)
    entries             :Array[0..0] of TsomMethodProc;
  end;
(* -- For building lists of method tables *)
  PsomMethodTab         =^TsomMethodTab;

  PsomMethodTabs        =^TsomMethodTabList;
  TsomMethodTabList     =record
    mtab                : PsomMethodTab;
    next                : PsomMethodTabs;
  end;

  TsomParentMtab        =record
    mtab                : PsomMethodTab;       (* this class' mtab -- changed by shadowing *)
    next                : PsomMethodTabs;        (* the parent mtabs -- unchanged by shadowing *)
    classObject         : TRealSOMClass;          (* unchanged by shadowing *)
    somRenewNoInitNoZeroThunk:somTD_somRenewNoInitNoZeroThunk; (* changed by shadowing *)
    instanceSize        : TCORBA_long;               (* changed by shadowing *)
    initializers        : PsomMethodProc;      (* resolved initializer array in releaseorder *)
    resolvedMTokens     : PsomMethodProc;      (* resolved methods *)
    initCtrl            : TsomInitCtrl;           (* these fields are filled in if somDTSClass&2 is on *)
    destructCtrl        : TsomDestructCtrl;
    assignCtrl          : TsomAssignCtrl;
    embeddedTotalCount  : TCORBA_long;
    hierarchyTotalCount : TCORBA_long;
    unused              : TCORBA_long;
  end;
  PsomParentMtab        =^TsomParentMtab;

(*
 * (Generic) Auxiliary Class Data Structure
 *)
  TsomCClassData        =record
    parentMtab          : PsomParentMtab;
    instanceDataToken   : TsomDToken;
    wrappers            : Array[0..0] of TsomMethodProc;  (* for valist methods *)
  end;
  PsomCClassData        =^TsomCClassData;

(*----------------------------------------------------------------------
 * Method Stubs -- Signature Support
 *
 *
 * This section defines the structures used to pass method signature
 * ingo to the runtime. This supports selection of generic apply stubs
 * and runtime generation of redispatchstubs when these are needed. The
 * information is registered with the runtime when methods are defined.
 *
 * When calling somAddStaticMethod, if the redispatchStub is -1, then a
 * pointer to a struct of type somApRdInfo is passed as the applyStub.
 * Otherwise, the passed redispatchstub and applystub are taken as given.
 * When calling somAddDynamicMethod, an actual apply stub must be passed.
 * Redispatch stubs for dynamic methods are not available, nor is
 * automated support for dynamic method apply stubs. The following
 * atructures only appropriate in relation to static methods.
 *
 * In SOMr2, somAddStaticMethod can be called with an actual redispatchstub
 * and applystub *ONLY* if the method doesn't return a structure. Recall
 * that no SOMr1 methods returned structures, so SOMr1 binaries obey this
 * restriction. The reason for this rule is that SOMr2 *may* use thunks,
 * and thunks need to know if a structure is returned. We therefore assume
 * that if no signature information is provided for a method through the
 * somAddStaticMethod interface, then the method returns a scalar.
 *
 * If a structure is returned, then a -1 *must* be passed to
 * somAddStaticMethod as a redispatchstub. In any case, if a -1 is passed,
 * then this means that the applystub actually points to a structure of type
 * somApRdInfo. This structure is used to hold and access signature
 * information encoded as follows.
 *
 * If the somApRdInfo pointer is NULL, then, if the runtime was built with
 * SOM_METHOD_STUBS defined, a default signature is assumed (no arguments,
 * and no structure returned); otherwise, the stubs are taken as
 * somDefaultMethod (which produces a runtime error when used) if dynamic
 * stubs are not available.
 *
 * If the somApRdInfo pointer is not NULL, then the structure it points to can
 * either include (non-null) redispatch and applystubs (the method is then
 * assumed to return a structure), or null stubs followed by information needed
 * to generate necessary stubs dynamically.
 *)

  TsomApRdInfo          =record
    rdStub              : TsomMethodProc;
    apStub              : TsomMethodProc;
    stubInfo            : PsomMethodInfo;
  end;


(*
 * Values for somRdAppType are generated by summing one from column A and one
 * from column B of the following constants:
 *)
(* Column A: return type *)
const
  SOMRdRetsimple        = 0; (* Return type is a non-float fullword *)
  SOMRdRetfloat         = 2; (* Return type is (single) float *)
  SOMRdRetdouble        = 4; (* Return type is double *)
  SOMRdRetlongdouble    = 6; (* Return type is long double *)
  SOMRdRetaggregate     = 8; (* Return type is struct or union *)
  SOMRdRetbyte          =10; (* Return type is a byte *)
  SOMRdRethalf          =12; (* Return type is a (2 byte) halfword *)
(* Column B: are there any floating point scalar arguments? *)
  SOMRdNoFloatArgs      = 0;
  SOMRdFloatArgs        = 1;

(* A somFloatMap is only needed on RS/6000 *)
(*
 * This is an array of offsets for up to the first 13 floating point arguments.
 * If there are fewer than 13 floating point arguments, then there will be
 * zero entries following the non-zero entries which represent the float args.
 * A non-zero entry signals either a single- or a double-precision floating point
 * argument. For a double-precision argument, the entry is the stack
 * frame offset. For a single-precision argument the entry is the stack
 * frame offset + 1. For the final floating point argument, add 2 to the
 * code that would otherwise be used.
 *)
  SOMFMSingle           = 1; (* add to indicate single-precision *)
  SOMFMLast             = 2; (* add to indicate last floating point arg *)

const
  SOM_SCILEVEL          = 4;


(* The SCI includes the following information:
 *
 * The address of a class's ClassData structure is passed.
 * This structure should have the external name,
 * <className>ClassData. The classObject field should be NULL
 * (if it is not NULL, then a new class will not be built). somBuildClass will
 * set this field to the address of the new class object when it is built.
 *
 * The address of the class's auxiliary ClassData structure is passed.
 * Thi structure should have the external name,
 * <className>CClassData. The parentMtab field will be set by somBuildClass.
 * This field often allows method calls to a class object to be avoided.
 *
 * The other structures referenced by the static class information (SCI)
 * are used to:
 *)

(*
 * to specify a static method. The methodId used here must be
 * a simple name (i.e., no colons). In all other cases,
 * where a somId is used to identify a registered method,
 * the somId can include explicit scoping. An explicitly-scoped
 * method name is called a method descriptor. For example,
 * the method introduced by TSOMObject as somGetClass has the
 * method descriptor "TSOMObject::somGetClass". When a
 * class is contained in an IDL module, the descriptor syntax
 * <moduleName>::<className>::<methodName> can be used. Method
 * descriptors can be useful when a class supports different methods
 * that have the same name (note: IDL prevents this from occuring
 * statically, but SOM itself has no problems with this).
 *)

type
  TsomStaticMethod      = record
    classData           : PsomMToken;
    methodId            : PsomId;        (* this must be a simple name (no colons) *)
    methodDescriptor    : PsomId;
    method              : PsomMethod;//somMethodProc;
    redispatchStub      : PsomMethod;//somMethodProc;
    applyStub           : PsomMethod;//somMethodProc;
  end;
  PsomStaticMethod      =^TsomStaticMethod;

(* to specify an overridden method *)
  TsomOverrideMethod     = record
    methodId            : PsomId;        (* this can be a method descriptor *)
    method              : PsomMethod;  //somMethodProc;
  end;
  PsomOverrideMethod    =^TsomOverrideMethod;

(* to inherit a specific parent's method implementation *)
  TsomInheritedMethod   = record
    methodId            : PsomId;            (* identify the method *)
    parentNum           : TCORBA_long;       (* identify the parent *)
    mToken              : PsomMToken;        (* for parentNumresolve *)
  end;
  PsomInheritedMethod   =^TsomInheritedMethod;

(* to register a method that has been moved from this *)
(* class <cls> upwards in the class hierachy to class <dest> *)
  TsomMigratedMethod    = record
    clsMToken           : PsomMToken;
                                (* points into the <cls> classdata structure *)
                                (* the method token in <dest> will copied here *)
    destMToken          : PsomMToken;
                                (* points into the <dest> classdata structure *)
                                (* the method token here will be copied to <cls> *)
  end;
  PsomMigratedMethod    =^TsomMigratedMethod;

(* to specify non-internal data *)
  TsomNonInternalData   = record
    classData           : PsomDToken;
    basisForDataOffset  : PChar;
  end;
  PsomNonInternalData   =^TsomNonInternalData;

(* to specify a "procedure" or "classdata" *)
  TsomProcMethods       = record
    classData           : PsomMethodProc;
    pEntry              : TsomMethodProc;
  end;
  PsomProcMethods       =^TsomProcMethods;

(* to specify a general method "action" using somMethodStruct *)
(*
  the type of action is specified by loading the type field of the
  somMethodStruct. There are three bit fields in the overall type:

  action (in type & 0xFF)
   0: static -- (i.e., virtual) uses somAddStaticMethod
   1: dynamic -- uses somAddDynamicMethod (classData==0)
   2: nonstatic -- (i.e., nonvirtual) uses somAddMethod
   3: udaAssign -- registers a method as the udaAssign (but doesn't add the method)
   4: udaConstAssign -- like 3, this doesn't add the method
   5: somClassResolve Override (using the class pointed to by *classData)
   6: somMToken Override (using the method token pointed to by methodId)
                         (note: classData==0 for this)
   7: classAllocate -- indicates the default heap allocator for this class.
                       If classData == 0, then method is the code address (or NULL)
                       If classData != 0, then *classData is the code address.
                       No other info required (or used)
   8: classDeallocate -- like 7, but indicates the default heap deallocator.
   9: classAllocator -- indicates a non default heap allocator for this class.
                        like 7, but a methodDescriptor can be given.

   === the following is not currently supported ===
   binary data access -- in (type & 0x100), valid for actions 0,1,2,5,6
   0: the method procedure doesn't want binary data access
   1: the method procedure does want binary data access

   aggregate return -- in (type & 0x200), used when binary data access requested
   0: method procedure doesn't return a structure
   1: method procedure does return a structure
*)

  TsomMethods           = record
    mtype               : TCORBA_long;
    classData           : PsomMToken;
    methodId            : PsomId;
    methodDescriptor    : PsomId;
    method              : TsomMethodProc;
    redispatchStub      : TsomMethodProc;
    applyStub           : TsomMethodProc;
  end;
  PsomMethods           =^TsomMethods;

(* to specify a varargs function *)
  TsomVarargsFuncs      = record
    classData           : PsomMethodProc;
    vEntry              : TsomMethodProc;
  end;
  PsomVarargsFuncs      =^TsomVarargsFuncs;

  TsomDynamicSCI         =record
    version             : TCORBA_long;       (* 1 for now *)
    instanceDataSize    : TCORBA_long;       (* true size (incl. embedded objs) *)
    dataAlignment       : TCORBA_long;       (* true alignment *)
    embeddedObjs        : PsomEmbeddedObj; (* array end == null copp *)
  end;
(* to specify dynamically computed information (incl. embbeded objs) *)
  PsomDynamicSCI        =^TsomDynamicSci;


(*
   to specify a DTS class, use the somDTSClass entry in the following
   data structure. This entry is a bit vector interpreted as follows:

   (somDTSClass & 0x0001) == the class is a DTS C++ class
   (somDTSClass & 0x0002) == the class wants the initCtrl entries
                             of the somParentMtabStruct filled in.

*)



(*
 *  The Static Class Info Structure passed to somBuildClass
 *)

  TsomStaticClassInfo   = record
    layoutVersion       : TCORBA_long;  (* this struct defines layout version SOM_SCILEVEL *)
    numStaticMethods    : TCORBA_long;   (* count of smt entries *)
    numStaticOverrides  : TCORBA_long; (* count of omt entries *)
    numNonInternalData  : TCORBA_long; (* count of nit entries *)
    numProcMethods      : TCORBA_long;     (* count of pmt entries *)
    numVarargsFuncs     : TCORBA_long;    (* count of vft entries *)
    majorVersion        : TCORBA_long;
    minorVersion        : TCORBA_long;
    instanceDataSize    : TCORBA_long;   (* instance data introduced by this class *)
    maxMethods          : TCORBA_long;         (* count numStaticMethods and numMethods *)
    numParents          : TCORBA_long;
    classId             : TsomId;
    explicitMetaId      : TsomId;
    implicitParentMeta  : TCORBA_long;
    parents             : PsomId;
    cds                 : PsomClassData;
    ccds                : PsomCClassData;
    smt                 : PsomStaticMethod;    (* basic "static" methods for mtab *)
    omt                 : PsomOverrideMethod;  (* overrides for mtab *)
    nitReferenceBase    : PChar;
    nit                 : PsomNonInternalData; (* datatokens for instance data *)
    pmt                 : PsomProcMethods;     (* Arbitrary ClassData members *)
    vft                 : PsomVarargsFuncs;    (* varargs stubs *)
    cif                 : pointer{^somTP_somClassInitFunc}; (* class init function *)
    (* end of layout version 1 *)

    (* begin layout version 2 extensions *)
    dataAlignment       : TCORBA_long; (* the desired byte alignment for instance data *)
    (* end of layout version 2 *)

//#define SOMSCIVERSION 1

    (* begin layout version 3 extensions *)
    numDirectInitClasses: TCORBA_long;
    directInitClasses   : PsomId;
    numMethods          : TCORBA_long; (* general (including nonstatic) methods for mtab *)
    mt                  : PsomMethods;
    protectedDataOffset : TCORBA_long; (* access = resolve(instanceDataToken) + offset *)
    somSCIVersion       : TCORBA_long;  (* used during development. currently = 1 *)
    numInheritedMethods : TCORBA_long;
    imt                 : PsomInheritedMethod; (* inherited method implementations *)
    numClassDataEntries : TCORBA_long; (* should always be filled in *)
    classDataEntryNames : PsomId; (* either NULL or ptr to an array of somIds *)
    numMigratedMethods  : TCORBA_long;
    mmt                 : PsomMigratedMethod; (* migrated method implementations *)
    numInitializers     : TCORBA_long; (* the initializers for this class *)
    initializers        : PsomId;     (* in order of release *)
    somDTSClass         : TCORBA_long; (* used to identify a DirectToSOM class *)
    dsci                : PsomDynamicSCI;  (* used to register dynamically computed info *)
    (* end of layout version 3 *)
  end;
  PsomStaticClassInfo   =^TsomStaticClassInfo;

(* CORBA section *)

type
  TRepository                            = TRealSOMObject;

(* CORBA 7.6.1, p.139 plus 5.7, p.89 enum Data Type Mapping *)
type
  TCKind                = TCORBA_unsigned_long;
const
  TypeCode_tk_null      = 1;
  TypeCode_tk_void      = 2;
  TypeCode_tk_short     = 3;
  TypeCode_tk_long      = 4;
  TypeCode_tk_ushort    = 5;
  TypeCode_tk_ulong     = 6;
  TypeCode_tk_float     = 7;
  TypeCode_tk_double    = 8;
  TypeCode_tk_boolean   = 9;
  TypeCode_tk_char      = 10;
  TypeCode_tk_octet     = 11;
  TypeCode_tk_any       = 12;
  TypeCode_tk_TypeCode  = 13;
  TypeCode_tk_Principal = 14;
  TypeCode_tk_objref    = 15;
  TypeCode_tk_struct    = 16;
  TypeCode_tk_union     = 17;
  TypeCode_tk_enum      = 18;
  TypeCode_tk_string    = 19;
  TypeCode_tk_sequence  = 20;
  TypeCode_tk_array     = 21;

  TypeCode_tk_pointer   = 101; (* SOM extension *)
  TypeCode_tk_self      = 102; (* SOM extension *)
  TypeCode_tk_foreign   = 103; (* SOM extension *)

(* Short forms of tk_<x> enumerators *)

  tk_null       = TypeCode_tk_null;
  tk_void       = TypeCode_tk_void;
  tk_short      = TypeCode_tk_short;
  tk_long       = TypeCode_tk_long;
  tk_ushort     = TypeCode_tk_ushort;
  tk_ulong      = TypeCode_tk_ulong;
  tk_float      = TypeCode_tk_float;
  tk_double     = TypeCode_tk_double;
  tk_boolean    = TypeCode_tk_boolean;
  tk_char       = TypeCode_tk_char;
  tk_octet      = TypeCode_tk_octet;
  tk_any        = TypeCode_tk_any;
  tk_TypeCode   = TypeCode_tk_TypeCode;
  tk_Principal  = TypeCode_tk_Principal;
  tk_objref     = TypeCode_tk_objref;
  tk_struct     = TypeCode_tk_struct;
  tk_union      = TypeCode_tk_union;
  tk_enum       = TypeCode_tk_enum;
  tk_string     = TypeCode_tk_string;
  tk_sequence   = TypeCode_tk_sequence;
  tk_array      = TypeCode_tk_array;
  tk_pointer    = TypeCode_tk_pointer;
  tk_self       = TypeCode_tk_self;
  tk_foreign    = TypeCode_tk_foreign;

type
  TSOMClass_somOffsets          = record
    cls                         : TRealSOMClass;
    offset                      : TCORBA_long;
  end;

  TCORBA_SEQUENCE_SOMClass      = record
    _maximum                    : TCORBA_unsigned_long;
    _length                     : TCORBA_unsigned_long;
    _buffer                     : PRealSOMClass;
  end;
  PCORBA_SEQUENCE_SOMClass  = ^TCORBA_SEQUENCE_SOMClass;
  T_IDL_SEQUENCE_SOMClass = TCORBA_SEQUENCE_SOMClass;
  P_IDL_SEQUENCE_SOMClass = PCORBA_SEQUENCE_SOMClass;
  TSOMClass_SOMClassSequence    = TCORBA_SEQUENCE_SOMClass;

  TCORBA_SEQUENCE_SOMObject       = record
    _maximum                    : TCORBA_unsigned_long;
    _length                     : TCORBA_unsigned_long;
    _buffer                     : PRealSOMObject;
  end;
  T_IDL_SEQUENCE_SOMObject      = TCORBA_SEQUENCE_SOMObject;
  
(*----------------------------------------------------------------------
 *  Windows extra procedures:
 *)

(*
 *  Replaceable character output handler.
 *  Points to the character output routine to be used in development
 *  support.  Initialized to <somOutChar>, but may be reset at anytime.
 *  Should return 0 (false) if an error occurs and 1 (true) otherwise.
 *)
type
  somTD_SOMOutCharRoutine       =Function(ch: TCORBA_char): TCORBA_long;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}

var
  SOMOutCharRoutine     : somTD_SOMOutCharRoutine; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMOutCharRoutine';{$endif}		

Procedure somSetOutChar(outch:somTD_SOMOutCharRoutine);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function  somMainProgram: TRealSOMClassMgr;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Procedure somEnvironmentEnd;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somAbnormalEnd: TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


(*---------------------------------------------------------------------
 *  Offset-based method resolution.
 *)

Function  somResolve(obj:TRealSOMObject; mdata: TsomMToken): TsomMethodProc; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somParentResolve(parentMtabs: PsomMethodTabs; mToken: TsomMToken): TsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somParentNumResolve(parentMtabs: PsomMethodTabs; parentNum: TCORBA_long; mToken: TsomMToken): TsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somClassResolve(obj:TRealSOMClass; mdata: TsomMToken): TsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somAncestorResolve(obj:TRealSOMObject; var ccds: TsomCClassData; mToken: TsomMToken): TsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somResolveByName(obj: TRealSOMObject; methodName: PCORBA_char): TsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*------------------------------------------------------------------------------
 * Offset-based data resolution
 *)
Function  somDataResolve(obj:TRealSOMObject; dataId: TsomDToken): TsomToken;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somDataResolveChk(obj:TRealSOMObject; dataId: TsomDToken): TsomToken;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*----------------------------------------------------------------------
 *  Misc. procedures:
 *)

(*
 *  Create and initialize the SOM environment
 *
 *  Can be called repeatedly
 *
 *  Will be called automatically when first object (including a class
 *  object) is created, if it has not already been done.
 *
 *  Returns the SOMClassMgrObject
 *)
Function  somEnvironmentNew: TRealSOMClassMgr; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * Test whether <obj> is a valid SOM object. This test is based solely on
 * the fact that (on this architecture) the first word of a SOM object is a
 * pointer to its method table. The test is therefore most correctly understood
 * as returning true if and only if <obj> is a pointer to a pointer to a
 * valid SOM method table. If so, then methods can be invoked on <obj>.
 *)
Function  somIsObj(obj: TsomToken): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * Return the class that introduced the method represented by a given method token.
 *)
Function  somGetClassFromMToken(mToken: TsomMToken):TRealSOMClass;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


(*----------------------------------------------------------------------
 *  String Manager: stem <somsm>
 *)
Function  somCheckID(id: TsomId): TsomId;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* makes sure that the id is registered and in normal form, returns *)
(* the id *)

Function  somRegisterId(id: TsomId): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Same as somCheckId except returns 1 (true) if this is the first *)
(* time the string associated with this id has been registered, *)
(* returns 0 (false) otherwise *)

Function  somIDFromString(aString: TCORBA_string): TsomId;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* caller is responsible for freeing the returned id with SOMFree *)

// Not found
//Function  somIdFromStringNoFree(aString:PChar):somId;  {$ifndef vpc}{$ifdef os2}cdecl;{$endif}{$ifdef win32}stdcall;{$endif}{$endif}
(* call is responsible for *not* freeing the returned id *)

Function  somStringFromId(id: TsomId): TCORBA_string;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Return a string that must never be freed or modified. *)

Function  somCompareIds(id1,id2: TsomId): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* returns true (1) if the two ids are equal, else false (0) *)

Function  somTotalRegIds: TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Returns the total number of ids that have been registered so far, *)
(* you can use this to advise the SOM runtime concerning expected *)
(* number of ids in later executions of your program, via a call to *)
(* somSetExpectedIds defined below *)

Procedure somSetExpectedIds(numIds: TCORBA_unsigned_long);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Tells the SOM runtime how many unique ids you expect to use during *)
(* the execution of your program, this can improve space and time *)
(* utilization slightly, this routine must be called before the SOM *)
(* environment is created to have any effect *)

Function  somUniqueKey(id: TsomId): TCORBA_unsigned_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Returns the unique key for this id, this key will be the same as the *)
(* key in another id if and only if the other id refers to the same *)
(* name as this one *)

Procedure somBeginPersistentIds;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Tells the id manager that strings for any new ids that are *)
(* registered will never be freed or otherwise modified. This allows *)
(* the id manager to just use a pointer to the string in the *)
(* unregistered id as the master copy of the ids string. Thus saving *)
(* space *)
(* Under normal use (where ids are static varibles) the string *)
(* associated with an id would only be freed if the code module in *)
(* which it occurred was unloaded *)

Procedure somEndPersistentIds;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Tells the id manager that strings for any new ids that are *)
(* registered may be freed or otherwise modified.  Therefore the id *)
(* manager must copy the strings inorder to remember the name of an *)
(* id. *)

(*----------------------------------------------------------------------
 *  Class Manager: SOMClassMgrType, stem <somcm>
 *)

(* Global class manager object *)
var
  SOMClassMgrObject     : TRealSOMClassMgr; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMClassMgrObject';{$endif}
  SOMClassMgrObjectPtr  : PRealSOMClassMgr;

(* The somRegisterClassLibrary function is provided for use
 * in SOM class libraries on platforms that have loader-invoked
 * entry points associated with shared libraries (DLLs).
 *
 * This function registers a SOM Class Library with the SOM Kernel.
 * The library is identified by its file name and a pointer
 * to its initialization routine.  Since this call may occur
 * prior to the invocation of somEnvironmentNew, its actions
 * are deferred until the SOM environment has been initialized.
 * At that time, the SOMClassMgrObject is informed of all
 * pending library initializations via the _somRegisterClassLibrary
 * method.  The actual invocation of the library's initialization
 * routine will occur during the execution of the SOM_MainProgram
 * macro (for statically linked libraries), or during the _somFindClass
 * method (for libraries that are dynamically loaded).
 *)
Procedure somRegisterClassLibrary(libraryName: TCORBA_string; libraryInitRun: TsomMethodProc);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*----------------------------------------------------------------------
 * -- somApply --
 *
 * This routine replaces direct use of applyStubs in SOMr1. The reason
 * for the replacement is that the SOMr1 style of applyStub is not
 * generally available in SOMr2, which uses a fixed set of applyStubs,
 * according to method information in the somMethodData. In particular,
 * neither the redispatch stub nor the apply stub found in the method
 * data structure are necessarily useful as such. The method somGetRdStub
 * is the way to get a redispatch stub, and the above function is the
 * way to call an apply stub. If an appropriate apply stub for the
 * method indicated by md is available, then this is invoked and TRUE is
 * returned; otherwise FALSE is returned.
 *
 * The va_list passed to somApply *must* include the target object,
 * somSelf, as its first entry, and any single precision floating point
 * arguments being passed to the the method procedure must be
 * represented on the va_list using double precision values. retVal cannot
 * be NULL.
 *)

Function  somApply(var somSelf: TRealSOMObject; var retVal: TsomToken; mdPtr: PsomMethodData; var ap): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*---------------------------------------------------------------------
 * -- somBuildClass --
 *
 * This procedure automates construction of a new class object. A variety of
 * special structures are used to allow language bindings to statically define
 * the information necessary to specify a class. Pointers to these static
 * structures are accumulated into an overall "static class information"
 * structure or SCI, passed to somBuildClass. The SCI has evolved over time.
 * The current version is defined here.
 *)


Function  somBuildClass(inherit_vars: TCORBA_long; var sci: TsomStaticClassInfo; majorVersion, minorVersion: TCORBA_long):TRealSOMClass;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

  (*
  The arguments to somBuildClass are as follows:

   inherit_vars: a bit mask used to control inheritance of implementation
   Implementation is inherited from parent i iff the bit 1<<i is on, or i>=32.

   sci: the somStaticClassInfo defined above.

   majorVersion, minorVersion: the version of the class implementation.

   *)


(*---------------------------------------------------------------------
 *  Used by old single-inheritance emitters to make class creation
 *  an atomic operation. Kept for backwards compatability.
 *)
type
  somTD_classInitRoutine=Procedure(var a,b:TRealSOMClass);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}

Procedure somConstructClass(classInitRoutine:somTD_ClassInitRoutine;
                            parentClass,metaClass:TRealSOMClass;
                            var cds : TsomClassData);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


(*
 * Uses <SOMOutCharRoutine> to output its arguments under control of the ANSI C
 * style format.  Returns the number of characters output.
 *)
{$ifdef SOM_VARARGS}
Function somPrintf(fmt: TCORBA_string): TCORBA_long; cdecl; varargs;
{$else}
Function somPrintf(fmt: TCORBA_string; args: Array of const): TCORBA_long;
{$endif}

(*
 * vprint form of somPrintf
 *)
Function  somVPrintf(fmt: TCORBA_string; ap: Tva_list): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * Outputs (via somPrintf) blanks to prefix a line at the indicated level
 *) 
Procedure somPrefixLevel(level: TCORBA_long);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * Combines somPrefixLevel and somPrintf
 *)
{$ifdef SOM_VARARGS}
Procedure somLPrintf(level: TCORBA_long; fmt: TCORBA_string); cdecl; varargs;
{$else}
Procedure somLPrintf(level: TCORBA_long; fmt: TCORBA_string; args: Array of const);
{$endif}


type
  TsomLibraryHandle=TCORBA_long;

(*----------------------------------------------------------------------
 * Pointers to routines used to do dynamic code loading and deleting
 *)
type
  somTD_SOMLoadModule           =Function({IN}  Module: TCORBA_string  (* className *);
                                          {IN}FileName: TCORBA_string  (* fileName *);
                                          {IN}FuncName: TCORBA_string  (* functionName *);
                                          {IN}MajorVer: TCORBA_long    (* majorVersion *);
                                          {IN}MinorVer: TCORBA_long    (* minorVersion *);
                                          {OUT}var ref: TsomLibraryHandle (* modHandle *)): TCORBA_long;
  somTD_SOMDeleteModule         =Function({IN} ref: TsomLibraryHandle     (* modHandle *)): TCORBA_long;
  somTD_SOMClassInitFuncName    =Function: TCORBA_string;

var
  SOMLoadModule         :somTD_SOMLoadModule; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMLoadModule';{$endif}
  SOMDeleteModule       :somTD_SOMDeleteModule; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMDeleteModule';{$endif}
  SOMClassInitFuncName  :somTD_SOMClassInitFuncName; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMClassInitFuncName';{$endif}

(*----------------------------------------------------------------------
 *  Replaceable SOM Memory Management Interface
 *
 *  External procedure variables SOMCalloc, SOMFree, SOMMalloc, SOMRealloc
 *  have the same interface as their standard C-library analogs.
 *)

type
  somTD_SOMMalloc               =Function({IN} size_t: TCORBA_long   (* nbytes *)): TsomToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMCalloc               =Function({IN} size_c: TCORBA_long   (* element_count *);
                                          {IN} size_e: TCORBA_long   (* element_size *)): TsomToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMRealloc              =Function({IN}    ref: TsomToken      (* memory *);
                                          {IN}   size: TCORBA_long   (* nbytes *)): TsomToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMFree                 =Procedure({IN}   ref: TsomToken    (* memory *));{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}

var
  SOMCalloc             :somTD_SOMCalloc; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMCalloc';{$endif}
  SOMFree               :somTD_SOMFree; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMFree';{$endif}
  SOMMalloc             :somTD_SOMMalloc; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMMalloc';{$endif}
  SOMRealloc            :somTD_SOMRealloc; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMRealloc';{$endif}

(*----------------------------------------------------------------------
 *  Replaceable SOM Error handler
 *)

type
  somTD_SOMError                =Procedure({IN} code: TCORBA_long    (* code *);
                                           {IN}   fn: TCORBA_string  (* fileName *);
                                           {IN}   ln: TCORBA_long    (* linenum *));

var
  SOMError              :somTD_SOMError; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMError';{$endif}

(*----------------------------------------------------------------------
 *  Replaceable SOM Semaphore Operations
 *
 *  These operations are used by the SOM Kernel to make thread-safe
 *  state changes to internal resources.
 *)

type
  somTD_SOMCreateMutexSem       =Function({OUT}var sem: TsomToken ): TCORBA_long;
  somTD_SOMRequestMutexSem      =Function({IN}sem: TsomToken ): TCORBA_long;
  somTD_SOMReleaseMutexSem      =Function({IN}sem: TsomToken ): TCORBA_long;
  somTD_SOMDestroyMutexSem      =Function({IN}sem: TsomToken ): TCORBA_long;

var
  SOMCreateMutexSem     :somTD_SOMCreateMutexSem; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMCreateMutexSem';{$endif}
  SOMRequestMutexSem    :somTD_SOMRequestMutexSem; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMRequestMutexSem';{$endif}
  SOMReleaseMutexSem    :somTD_SOMReleaseMutexSem; {$ifdef SOM_EXTVAR}external SOMDLL name 'ReleaseMutexSem';{$endif}
  SOMDestroyMutexSem    :somTD_SOMDestroyMutexSem; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMDestroyMutexSem';{$endif}

(*----------------------------------------------------------------------
 *  Replaceable SOM Thread Identifier Operation
 *
 *  This operation is used by the SOM Kernel to index data unique to the
 *  currently executing thread.  It must return a small integer that
 *  uniquely represents the current thread within the current process.
 *)

type
  somTD_SOMGetThreadId          =Function: TCORBA_long;

var
  SOMGetThreadId        :somTD_SOMGetThreadId; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMGetThreadId';{$endif}


(*----------------------------------------------------------------------
 * Externals used in the implementation of SOM, but not part of the
 * SOM API.
 *)

Function  somTestCls(obj:TRealSOMObject; classObj:TRealSOMClass;
                     fileName: TCORBA_string; lineNumber: TCORBA_long):TRealSOMObject; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
					 
Procedure somTest(condition,severity: TCORBA_long;fileName: TCORBA_string;
                  lineNum: TCORBA_long; msg: TCORBA_string); {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Procedure somAssert(condition,ecode: TCORBA_long;
                    fileName: TCORBA_string;lineNum: TCORBA_long; msg: TCORBA_string); {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


type
  TCORBA_exception_type        = (CORBA_NO_EXCEPTION, CORBA_USER_EXCEPTION, CORBA_SYSTEM_EXCEPTION);
  completion_status     = (YES, NO, MAYBE);
  StExcep               = record
    minot               : Cardinal;
    completed           : completion_status;
  end;

  PCORBA_Environment    =^TCORBA_Environment;
  TCORBA_Environment    = record
    _major              : TCORBA_exception_type;
    exception           : record
      _exception_name   : PCORBA_char;
      _params           : Pointer;
    end;
    _somdAnchor         : pointer;
  end;

Function  somExceptionId(var ev: TCORBA_Environment): TCORBA_string;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somExceptionValue(var ev: TCORBA_Environment): Pointer;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Procedure somExceptionFree(ev: PCORBA_Environment);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Procedure somSetException(var ev: TCORBA_Environment; major: TCORBA_exception_type; exception_name: TCORBA_string; params:pointer);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somGetGlobalEnvironment: PCORBA_Environment;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(* Exception function names per CORBA *)
Function  CORBA_exception_id(var ev: TCORBA_Environment): TCORBA_string;
Function  CORBA_exception_value(var ev: TCORBA_Environment):Pointer;
Procedure CORBA_exception_free(ev: PCORBA_Environment);
Procedure CORBA_exception_set(var ev: TCORBA_Environment; major: TCORBA_exception_type; exception_name: TCORBA_string; params:pointer);


(*  Convenience macros for manipulating environment structures
 *
 *  SOM_CreateLocalEnvironment returns a pointer to an Environment.
 *  The other 3 macros all expect a single argument that is also
 *  a pointer to an Environment.  Use the create/destroy forms for
 *  a dynamic local environment and the init/uninit forms for a stack-based
 *  local environment.
 *
 *  For example
 *
 *      var ev: PCORBA_Environment;
 *      begin
 *      ev = SOM_CreateLocalEnvironment ();
 *      ... Use ev in methods
 *      SOM_DestroyLocalEnvironment (ev);
 *      end;
 *
 *  or
 *
 *      var ev: TCORBA_Environment;
 *      begin
 *      SOM_InitEnvironment (@ev);
 *      ... Use &ev in methods
 *      SOM_UninitEnvironment (@ev);
 *      end;
 *)
Function SOM_CreateLocalEnvironment: PCORBA_Environment;

Procedure SOM_DestroyLocalEnvironment(ev: PCORBA_Environment);

Procedure SOM_InitEnvironment(ev: PCORBA_Environment);

Procedure SOM_UninitEnvironment(ev: PCORBA_Environment);

(*----------------------------------------------------------------------
 * Macros are used in the C implementation of SOM... However, Pascal
 * doesn't have macro capability... (from SOMCDEV.H)
 *)

function SOM_Resolve(o: TRealSOMObject; oc: TRealSOMClass; mn: TsomMToken): TsomMethodProc;

{ Change SOM_Resolve(o,ocn,mn) to...
  somTD_ocn_mn(somResolve(SOM_TestCls(o, ocnClassData.classObject), ocnClassData.mn)))

  Change SOM_ResolveNoCheck(o,ocn,mn) to...
  somTD_ocn_mn(somResolve(o,ocnClassData,mn))

  Change SOM_ParentNumResolveCC(pcn,pcp,ocn,mn) to...
  somTD_pcn_mn(somParentNumResolve(ocn_CClassData.parentMtab,pcp,pcnClassData.mn))

  Change SOM_ParentNumResolve(pcn,pcp,mtabs,mn) to...
  somTD_pcn_mn(somParentNumResolve(mtabs,pcp,pcnClassData.mn))

  Change SOM_ClassResolve(cn,class,mn) to...
  somTD_cn_mn(somClassResolve(class,cnClassData.mn))

  Change SOM_ResolveD(o,tdc,cdc,mn) to...
  somTD_tdc_mn(somResolve(SOM_TestCls(o,cdcClassData.classObject), cdcClassData.mn)))

  Change SOM_ParentResolveE(pcn,mtbls,mn) to...
  somTD_pcn_mn(somParentResolve(mtbls,pcnClassData.mn))

  Change SOM_DataResolve(obj,dataId) to...
  somDataResolve(obj, dataId)

  Change SOM_ClassLibrary(name) to...
  somRegisterClassLibrary(name,somMethodProc(SOMInitModule))
}



// Control the printing of method and procedure entry messages,
// 0-none, 1-user, 2-core&user */
var
  SOM_TraceLevel: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_TraceLevel';{$endif}
  SOM_TraceLevelPtr: PCORBA_long;

// Control the printing of warning messages, 0-none, 1-all
var
  SOM_WarnLevel: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_WarnLevel';{$endif}
  SOM_WarnLevelPtr: PCORBA_long;

// Control the printing of successful assertions, 0-none, 1-user, 2-core&user
var
  SOM_AssertLevel: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_AssertLevel';{$endif}
  SOM_AssertLevelPtr: PCORBA_long;

// ToDo: Move this to corresponding place
Procedure somCheckArgs(argc: TCORBA_long; argv: array of pchar);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

{$ifdef notfoundinsomFree}
Procedure somUnregisterClassLibrary (libraryName: TCORBA_string);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somResolveTerminal(x : PRealSOMClass; mdata: TsomMToken): PsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somPCallResolve(obj: PRealSOMObject; callingCls: PRealSOMClass; method: TsomMToken): PsomMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatchA(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): Pointer; varargs; cdecl; {This is actually Optlink version under Win32}
{$endif}

{$ifdef SOM_VARARGS}
Function somva_SOMObject_somDispatchA(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): Pointer; varargs; cdecl;
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatchL(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): Longint; varargs; cdecl; {This is actually Optlink version under Win32}
{$endif}

{$ifdef SOM_VARARGS}
Function somva_SOMObject_somDispatchL(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): TCORBA_long; varargs; cdecl;
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatch(somSelf: PRealSOMObject;
                retValue: PsomToken;
                methodId: TsomId): TCORBA_boolean; varargs; cdecl; {This is actually Optlink version under Win32}
{$endif}

{$ifdef SOM_VARARGS}
Procedure va_SOMObject_somDispatchV(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId); varargs; cdecl; {This is actually Optlink version under Win32}
{$endif}

{$ifdef SOM_VARARGS}
Procedure somva_SOMObject_somDispatchV(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId); varargs; cdecl;
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatchD(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): double; varargs; cdecl; {This is actually Optlink version under Win32}
{$endif}

{$ifdef SOM_VARARGS}
Function somva_SOMObject_somDispatchD(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): double; varargs; cdecl;

Function somva_SOMObject_somDispatch(somSelf: PRealSOMObject;
                retValue: PsomToken;
                methodId: TsomId): TCORBA_boolean; varargs; cdecl;
				
Function somva_SOMObject_somClassDispatch(somSelf: PRealSOMObject;
                clsObj: PRealSOMClass;
                retValue: PsomToken;
                methodId: TsomId): TCORBA_boolean; varargs; cdecl;
{$endif}

type
  TsomVaBuf = TsomToken;

function somVaBuf_create(vb: TsomVaBuf; size: TCORBA_long): TsomVaBuf;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
procedure somVaBuf_get_valist(vb: TsomVaBuf; ap: Pva_list);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
procedure somVaBuf_destroy(vb: TsomVaBuf);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
function somVaBuf_add(vb: TsomVaBuf; arg: TsomToken; typ: TCORBA_long): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
function somvalistGetTarget(ap: Tva_list): TCORBA_unsigned_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
procedure somvalistSetTarget(ap: Tva_list; a: pointer);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


Implementation

{$ifdef vpc}
  {$ifdef os2}
uses
    Os2Def, Os2Base, VPUtils;
  {$endif}
{$endif}
{$ifdef fpc}
  {$ifdef os2}
uses
    doscalls;
  {$endif}
{$endif}

{$ifndef SOM_EXTVAR}
uses
  windows;
{$endif}


function somVaBuf_create(vb: TsomVaBuf; size: TCORBA_long): TsomVaBuf; external SOMTCDLL name 'somVaBuf_create';
procedure somVaBuf_get_valist(vb: TsomVaBuf; ap: Pva_list); external SOMTCDLL name 'somVaBuf_get_valist';
procedure somVaBuf_destroy(vb: TsomVaBuf); external SOMTCDLL name 'somVaBuf_destroy';
function somVaBuf_add(vb: TsomVaBuf; arg: TsomToken; typ: TCORBA_long): TCORBA_long; external SOMTCDLL name 'somVaBuf_add';
function somvalistGetTarget(ap: Tva_list): TCORBA_unsigned_long; external SOMTCDLL name 'somvalistGetTarget';
procedure somvalistSetTarget(ap: Tva_list; a: pointer); external SOMTCDLL name 'somvalistSetTarget';

Procedure somSetOutChar(outch:somTD_SOMOutCharRoutine); external SOMDLL name 'somSetOutChar';
Function  somMainProgram:TRealSOMClassMgr; external SOMDLL name 'somMainProgram';
Procedure somEnvironmentEnd; external SOMDLL name 'somEnvironmentEnd';
Function  somAbnormalEnd: TCORBA_boolean; external SOMDLL name 'somAbnormalEnd';
Function  somResolve(obj:TRealSOMObject; mdata: TsomMToken): TsomMethodProc; external SOMDLL name 'somResolve';
Function  somParentResolve(parentMtabs: PsomMethodTabs; mToken: TsomMToken): TsomMethodProc; external SOMDLL name 'somParentResolve';
Function  somParentNumResolve(parentMtabs: PsomMethodTabs; parentNum: TCORBA_long; mToken: TsomMToken): TsomMethodProc; external SOMDLL name 'somParentNumResolve';
Function  somClassResolve(obj:TRealSOMClass; mdata: TsomMToken): TsomMethodProc; external SOMDLL name 'somClassResolve'; 
Function  somAncestorResolve(obj:TRealSOMObject; var ccds: TsomCClassData; mToken: TsomMToken): TsomMethodProc;  external SOMDLL name 'somAncestorResolve';
Function  somResolveByName(obj: TRealSOMObject; methodName: PCORBA_char): TsomMethodProc; external SOMDLL name 'somResolveByName';
Function  somDataResolve(obj:TRealSOMObject; dataId: TsomDToken): TsomToken; external SOMDLL name 'somDataResolve';
Function  somDataResolveChk(obj:TRealSOMObject; dataId: TsomDToken): TsomToken; external SOMDLL name 'somDataResolveChk';
Function  somEnvironmentNew: TRealSOMClassMgr; external SOMDLL name 'somEnvironmentNew'; 
Function  somIsObj(obj: TsomToken): TCORBA_boolean; external SOMDLL name 'somIsObj';
Function  somGetClassFromMToken(mToken: TsomMToken):TRealSOMClass; external SOMDLL name 'somGetClassFromMToken';
Function  somCheckID(id: TsomId): TsomId; external SOMDLL name 'somCheckId';
Function  somRegisterId(id: TsomId): TCORBA_long; external SOMDLL name 'somRegisterId';
Function  somIDFromString(aString: PCORBA_char): TsomId; external SOMDLL name 'somIdFromString';
Function  somStringFromId(id: TsomId): TCORBA_string; external SOMDLL name 'somStringFromId';
Function  somCompareIds(id1,id2: TsomId): TCORBA_long; external SOMDLL name 'somCompareIds';
Function  somTotalRegIds: TCORBA_long; external SOMDLL name 'somTotalRegIds';
Procedure somSetExpectedIds(numIds: TCORBA_unsigned_long); external SOMDLL name 'somSetExpectedIds';
Function  somUniqueKey(id: TsomId): TCORBA_unsigned_long; external SOMDLL name 'somUniqueKey';
Procedure somBeginPersistentIds; external SOMDLL name 'somBeginPersistentIds';
Procedure somEndPersistentIds; external SOMDLL name 'somEndPersistentIds';
Procedure somRegisterClassLibrary(libraryName: TCORBA_string; libraryInitRun: TsomMethodProc); external SOMDLL name 'somRegisterClassLibrary';
Function  somApply(var somSelf: TRealSOMObject; var retVal: TsomToken; mdPtr: PsomMethodData; var ap): TCORBA_boolean; external SOMDLL name 'somApply';
Function  somBuildClass(inherit_vars: TCORBA_long; var sci: TsomStaticClassInfo; majorVersion,minorVersion: TCORBA_long):TRealSOMClass; external SOMDLL name 'somBuildClass';
Procedure somConstructClass(classInitRoutine:somTD_ClassInitRoutine; parentClass,metaClass:TRealSOMClass; var cds : TsomClassData); external SOMDLL name 'somConstructClass';
Function  somVPrintf(fmt: PCORBA_char; ap: Tva_list): TCORBA_long; external SOMDLL name 'somVprintf';
{$ifdef SOM_VARARGS}
Function  somPrintf(fmt: TCORBA_string): TCORBA_long; cdecl; varargs; external SOMDLL name 'somPrintf';
{$else}
Function  somPrintf(fmt: TCORBA_string; args: array of const): TCORBA_long;
var
  ap: tva_list;
  vb: TsomVaBuf;
  i: integer;
begin
  vb:=somVaBuf_create(nil, 0);
  for i:=Low(args) to High(args) do
  begin
    case args[i].vType of
      vtInteger,vtExtended,vtPointer,vtPChar:
                      begin somVaBuf_add(vb, @args[i].vInteger, tk_long); end;
      vtAnsiString:
                      begin somVaBuf_add(vb, @args[i].vPointer, tk_long); end;
      vtBoolean      : somVaBuf_add(vb, @args[i].vBoolean, tk_octet);
      vtChar         : somVaBuf_add(vb, @args[i].vChar, tk_char);
      vtString       : begin
        args[i].vString^[Length(args[i].vString^)+1] := #0;
        somVaBuf_add(vb, @args[i].vString^[1], tk_pointer);
      end;
//      vtObject,vtClass: buf2^.vInt := 0;
    end;
  end;

   somVaBuf_get_valist(vb, @ap);
   Result:=somVprintf(fmt, ap);
   somVaBuf_destroy(vb);
end;
{$endif}

Procedure somPrefixLevel(level: TCORBA_long); external SOMDLL name 'somPrefixLevel';

{$ifdef SOM_VARARGS}
Procedure somLPrintf(level: TCORBA_long; fmt: TCORBA_string); cdecl; varargs; external SOMDLL name 'somLPrintf';
{$else}
Procedure somLPrintf(level: TCORBA_long; fmt: TCORBA_string; args: array of const);
begin
  somPrefixLevel(Level);
  somPrintf(fmt, args);
end;
{$endif}

Function  somTestCls(obj:TRealSOMObject; classObj:TRealSOMClass; fileName: TCORBA_string; lineNumber: TCORBA_long):TRealSOMObject; external SOMDLL name 'somTestCls';
Procedure somTest(condition,severity: TCORBA_long; fileName: TCORBA_string; lineNum: TCORBA_long; msg: TCORBA_string); external SOMDLL name 'somTest';
Procedure somAssert(condition,ecode: TCORBA_long; fileName: TCORBA_string; lineNum: TCORBA_long; msg: TCORBA_string); external SOMDLL name 'somAssert';
Function  somExceptionId(var ev: TCORBA_Environment): TCORBA_string; external SOMDLL name 'somExceptionId';
Function  somExceptionValue(var ev: TCORBA_Environment):Pointer; external SOMDLL name 'somExceptionValue';
Procedure somExceptionFree(ev: PCORBA_Environment); external SOMDLL name 'somExceptionFree';
Procedure somSetException(var ev: TCORBA_Environment; major: TCORBA_exception_type; exception_name: PCORBA_char;params:pointer); external SOMDLL name 'somSetException';
Function  somGetGlobalEnvironment: PCORBA_Environment; external SOMDLL name 'somGetGlobalEnvironment';
Procedure somCheckArgs(argc: TCORBA_long; argv: array of pchar); external SOMDLL name 'somCheckArgs';
{$ifdef notfoundinsomFree}
Procedure somUnregisterClassLibrary (libraryName: TCORBA_string); external SOMDLL name 'somUnregisterClassLibrary';
Function somResolveTerminal(x : PRealSOMClass; mdata: TsomMToken): PsomMethodProc; external SOMDLL name 'somResolveTerminal';
Function somPCallResolve(obj: PRealSOMObject; callingCls: PRealSOMClass; method: TsomMToken): PsomMethodProc; external SOMDLL name 'somPCallResolve';
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatchA(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): Pointer; varargs; cdecl; external SOMDLL name 'va_SOMObject_somDispatchA';
{$endif}

{$ifdef SOM_VARARGS}
Function somva_SOMObject_somDispatchA(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): Pointer; varargs; cdecl; external SOMDLL name 'somva_SOMObject_somDispatchA';
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatchL(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): Longint; varargs; cdecl; external SOMDLL name 'va_SOMObject_somDispatchL';
{$endif}

{$ifdef SOM_VARARGS}
Function somva_SOMObject_somDispatchL(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): TCORBA_long; varargs; cdecl; external SOMDLL name 'somva_SOMObject_somDispatchL';
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatch(somSelf: PRealSOMObject;
                retValue: PsomToken;
                methodId: TsomId): TCORBA_boolean; varargs; cdecl; external SOMDLL name 'va_SOMObject_somDispatch';
{$endif}

{$ifdef SOM_VARARGS}
Procedure va_SOMObject_somDispatchV(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId); varargs; cdecl; external SOMDLL name 'va_SOMObject_somDispatchV';
{$endif}

{$ifdef SOM_VARARGS}
Procedure somva_SOMObject_somDispatchV(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId); varargs; cdecl; external SOMDLL name 'somva_SOMObject_somDispatchV';
{$endif}

{$ifdef SOM_VARARGS}
Function va_SOMObject_somDispatchD(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): double; varargs; cdecl; external SOMDLL name 'va_SOMObject_somDispatchD';
{$endif}

{$ifdef SOM_VARARGS}
Function somva_SOMObject_somDispatchD(somSelf: PRealSOMObject;
                methodId: TsomId;
                descriptor: TsomId): double; varargs; cdecl; external SOMDLL name 'somva_SOMObject_somDispatchD';
Function somva_SOMObject_somDispatch(somSelf: PRealSOMObject;
                retValue: PsomToken;
                methodId: TsomId): TCORBA_boolean; varargs; cdecl; external SOMDLL name 'somva_SOMObject_somDispatch';
				
Function somva_SOMObject_somClassDispatch(somSelf: PRealSOMObject;
                clsObj: PRealSOMClass;
                retValue: PsomToken;
                methodId: TsomId): TCORBA_boolean; varargs; cdecl; external SOMDLL name 'somva_SOMObject_somClassDispatch';
{$endif}
/////////////////////////////////////////////////////////////////////

function SOM_Resolve(o: TRealSOMObject; oc: TRealSOMClass; mn: TsomMToken): TsomMethodProc;
begin
  //@todo Test_cls here
  {$ifdef SOM_METHOD_THUNKS}
  Result := TsomMethodProc(mn);
  {$else}
  Result := TsomMethodProc(somResolve(o, mn));
  {$endif}
end;


Function CORBA_exception_id(var ev: TCORBA_Environment): PCORBA_char;
begin
  Result := somExceptionId(ev)
end;

Function  CORBA_exception_value(var ev: TCORBA_Environment):Pointer;
begin
  Result := somExceptionValue(ev)
end;

Procedure CORBA_exception_free(ev: PCORBA_Environment);
begin
  somExceptionFree(ev)
end;

Procedure CORBA_exception_set(var ev: TCORBA_Environment; major: TCORBA_exception_type; exception_name: PCORBA_char; params:pointer);
begin
  somSetException(ev, major, exception_name, params);
end;

Function SOM_CreateLocalEnvironment: PCORBA_Environment;
begin
  Result:=SOMCalloc(1, sizeof(TCORBA_Environment))
end;

Procedure SOM_DestroyLocalEnvironment(ev: PCORBA_Environment);
begin
  somExceptionFree(ev);
  if somGetGlobalEnvironment<>ev then SOMFree(ev);
end;

Procedure SOM_InitEnvironment(ev: PCORBA_Environment);
begin
  if somGetGlobalEnvironment<>ev then FillChar(ev^,sizeof(TCORBA_Environment),0);
end;

Procedure SOM_UninitEnvironment(ev: PCORBA_Environment);
begin
  somExceptionFree(ev);
end;

{$ifdef SOM_OBJECTS}

const
  BufSize               = 16;

var
  OldMalloc             : somTD_SOMMalloc;
  OldCalloc             : somTD_SOMCalloc;
  OldRealloc            : somTD_SOMRealloc;
  OldFree               : somTD_SOMFree;

// Our custom memory management. Alow us to store some info about SOM classes and Object Pascal classes linking.


Function MyMalloc(size_t:Integer): TsomToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
begin
  if size_t<=0 then begin
    somPrintf('Z'#13#10);
    Result := nil
  end else begin
    GetMem(Result,size_t + BufSize*2);
    if Result<>nil then begin
      inc(Cardinal(Result),BufSize);
      PCardinal(Cardinal(Result)-4)^ := 0;
      PCardinal(Cardinal(Result)-8)^ := $DEADBEAF;
    end else  
      somprintf('M'#13#10);
  end;
  somprintf('Malloc %08X'#13#10, result);
end;

Function MyCalloc(size_c:Integer; size_e:Integer): TsomToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
begin
  somprintf('Calloc'#13#10);
  Result := somTD_SOMCalloc(OldCalloc)(size_c,size_e);
  somprintf('c'#13#10);
end;

Procedure MyFree(ref: TsomToken);{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
var
  size          : Longint;
begin
  somprintf('Free %08X'#13#10, ref);
  if ref<>nil then begin
    size := PCardinal(Cardinal(ref)-8)^;
    dec(Cardinal(ref),BufSize);
    try
      FreeMem(ref{,size + BufSize*2}); // Possible leak!!!
    except
      somprintf('F'#13#10);
    end;
    somprintf('f'#13#10);
  end;
end;

Function MyRealloc(ref: TsomToken; size:Integer): TsomToken;{$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
var
  oldsize       : Longint;
  //oldtype       : Longint;
begin
//  somprintf('Realloc', []);
  //somprintf('R',nil);
  if (size<=0)or(ref=nil) then begin
    Result := nil;
//    somprintf('N',nil);
    //MyFree(ref);
  end else begin
    oldsize := PCardinal(Cardinal(ref)-8)^;
    if size<>oldsize then begin
      Result := MyMalloc(size);
      if Result<>nil then begin
        try
          if size>oldsize then
            move(ref^,Result^,oldsize)
          else
            move(ref^,Result^,size);
          PCardinal(Cardinal(Result)-4)^:=PCardinal(Cardinal(ref)-4)^;
        except
          //somprintf('V',nil);
        end;
        MyFree(ref);
      end else
      {somprintf('%s',['R'])};
    end;
  end;
  //somprintf('r',nil);
end;
{$endif}

{$ifdef SOM_CORBA_MEM}

type
  somTD_free = procedure(Storage: Pointer);

type
  TCORBA_mem_private = record
	_free            : Pointer;
  end;
  PCORBA_mem_private = ^TCORBA_mem_private;
  
type
  TCORBA_any_private = record
    any              : TCORBA_any;
    _release         : TCORBA_boolean;
  end;
  PCORBA_any_private = ^ TCORBA_any_private;

procedure CORBA_any_free(Storage: Pointer);
begin
  Inc(PCardinal(Storage)^, sizeof(Pointer));
  if PCORBA_any_private(Storage)^._release then
  begin
    CORBA_free(PCORBA_any_private(Storage)^.any._value);
  end;
  Dec(PCardinal(Storage)^, sizeof(Pointer));
  SOMFree(Storage);
end;

procedure CORBA_any_set_release(var any: TCORBA_any; status: TCORBA_boolean);
begin
  PCORBA_any_private(@any)^._release:=status;
end;

function CORBA_any_get_release(var any: TCORBA_any): TCORBA_boolean;
begin
  Result:=PCORBA_any_private(@any)^._release;
end;

function CORBA_any_alloc: PCORBA_any;
begin
  Result:=SOMCalloc(1, sizeof(TCORBA_any_private)+sizeof(Pointer));
  PCORBA_mem_private(Result)^._free:=@CORBA_any_free;
  Inc(PCardinal(Result)^, sizeof(Pointer));
end;

procedure CORBA_string_free(Storage: Pointer);
begin
  SOMFree(Storage);
end;

function CORBA_string_alloc(Len: TCORBA_unsigned_long): TCORBA_string;
begin
  Result:=SOMCalloc(1,len+1+sizeof(Pointer));
  PCORBA_mem_private(Result)^._free:=@CORBA_string_free;
  Inc(PCardinal(Result)^, sizeof(Pointer));
end;

type
  TCORBA_sequence_private = record
    _maximum            : TCORBA_unsigned_long;
    _length             : TCORBA_unsigned_long;
    _buffer             : Pointer;
	_release            : TCORBA_boolean;
  end;
  PCORBA_sequence_private= ^TCORBA_sequence_private;

procedure CORBA_sequence_free(Storage: Pointer);
begin
  Inc(PCardinal(Storage)^, sizeof(Pointer));
  if PCORBA_sequence_private(Storage)^._release then
  begin
    CORBA_free(PCORBA_sequence_private(Storage)^._buffer);
  end;
  Dec(PCardinal(Storage)^, sizeof(Pointer));
  SOMFree(Storage);
end;

function CORBA_sequence_alloc(Len: TCORBA_unsigned_long): PCORBA_sequence_private;
begin
  Result:=SOMCalloc(1, sizeof(TCORBA_sequence_private)+sizeof(Pointer));
  PCORBA_mem_private(Result)^._free:=@CORBA_sequence_free;
  Inc(PCardinal(Result)^, sizeof(Pointer));
end;

function CORBA_sequence_octet__alloc(Len: TCORBA_unsigned_long): PCORBA_sequence_octet;
begin
  Result:=PCORBA_sequence_octet(CORBA_sequence_alloc(Len));
end;

procedure CORBA_sequence_set_release(Sequence: Pointer; status: TCORBA_boolean);
begin
  PCORBA_sequence_private(@Sequence)^._release:=status;
end;

function CORBA_sequence_get_release(Sequence: Pointer): TCORBA_boolean;
begin
  Result:=PCORBA_sequence_private(@Sequence)^._release;
end;

procedure CORBA_sequence_octet_freebuf(Storage: Pointer);
begin
  SOMFree(Storage);
end;

function CORBA_sequence_octet__allocbuf(Len: TCORBA_unsigned_long): PCORBA_octet;
begin
  Result:=SOMCalloc(1, sizeof(TCORBA_octet)*Len+sizeof(Pointer));
  PCORBA_mem_private(Result)^._free:=@CORBA_sequence_octet_freebuf;
  Inc(PCardinal(Result)^, sizeof(Pointer));
end;

procedure CORBA_free(Storage: Pointer);
begin
  if (Storage<>nil) then
  begin
    Dec(PCardinal(Storage)^, sizeof(Pointer));
    somTD_free(PCORBA_mem_private(Storage)^._free)(Storage);
  end;
  Storage:=nil;
end;


{$endif}

// Import of pointers to external variables for OS/2

{$ifdef os2}
const
  ModuleName   : PChar = SOMDLL;                // Name of module
var
  LoadError    : Array[0..255] of Char;         // Area for Load failure information
  ModuleHandle : hModule;                       // Module handle
  ModuleType   : ULong;                         // Module type
  rc           : ApiRet;                        // Return code
{$endif}

{$ifndef SOM_EXTVAR}
var
  hLib1: THandle;
{$endif}
Initialization
{$ifndef SOM_EXTVAR}
  {$ifdef win32}
  hLib1 := LoadLibrary(SOMDLL);
  SOM_MajorVersionPtr := GetProcAddress(hLib1, 'SOM_MajorVersion');
  SOM_MajorVersion:=SOM_MajorVersionPtr^;
  SOM_MinorVersionPtr := GetProcAddress(hLib1, 'SOM_MinorVersion');
  SOM_MinorVersion:=SOM_MinorVersionPtr^;
  SOM_TraceLevelPtr := GetProcAddress(hLib1, 'SOM_TraceLevel');
  SOM_TraceLevel:=SOM_TraceLevelPtr^;
  SOM_WarnLevelPtr := GetProcAddress(hLib1, 'SOM_WarnLevel');
  SOM_WarnLevel:=SOM_WarnLevelPtr^;
  SOM_AssertLevelPtr := GetProcAddress(hLib1, 'SOM_AssertLevel');
  SOM_AssertLevel:=SOM_AssertLevelPtr^;
  SOM_MaxThreadsPtr := GetProcAddress(hLib1, 'SOM_MaxThreads');
  SOM_MaxThreads:=SOM_MaxThreadsPtr^;
  SOMClassMgrObjectPtr := GetProcAddress(hLib1, 'SOMClassMgrObject');
  SOMClassMgrObject := SOMClassMgrObjectPtr^;
  FreeLibrary(hLib1);
  {$endif}
{$else}
  SOM_MajorVersionPtr:=@SOM_MajorVersion;
  SOM_MinorVersionPtr:=@SOM_MinorVersion;
  SOM_TraceLevelPtr:= @SOM_TraceLevel;
  SOM_WarnLevelPtr:= @SOM_WarnLevel;
  SOM_AssertLevelPtr:= @SOM_AssertLevel;
  SOM_MaxThreadsPtr:=@SOM_MaxThreadsPtr;
  SOMClassMgrObjectPtr := @SOMClassMgrObject;
{$endif}

{$ifdef os2}
  //@todo rework to names, because ordinals differs in various OS
  // Query address of ClassData variable
  rc:=DosLoadModule(LoadError,                  // Failure information buffer
      sizeof(LoadError),                        // Size of buffer
      ModuleName,                               // Module to load
      ModuleHandle);                            // Module handle returned

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      70,                                       // No ProcName specified
      nil,                                      // ProcName (not specified)
      Pointer(SOM_MajorVersionPtr));            // Address returned
  SOM_MajorVersion:=SOM_MajorVersionPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      71,                                       // No ProcName specified
      nil,                                      // ProcName (not specified)
      Pointer(SOM_MinorVersionPtr));            // Address returned
  SOM_MinorVersion:=SOM_MinorVersionPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      95,                                       // No ProcName specified
      nil,                                      // ProcName (not specified)
      Pointer(SOM_MaxThreadsPtr));              // Address returned
  SOM_MaxThreads:=SOM_MaxThreadsPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      7,                                        // No ProcName specified
      nil,                                      // ProcName (not specified)
      Pointer(SOMClassMgrObjectPtr));           // Address returned
  SOMClassMgrObject:=SOMClassMgrObjectPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      nil,                                      // ProcName specified
      'SOMClassClassData',                         // ProcName
      Pointer(SOMClassClassDataPtr));           // Address returned
  SOMClassClassData:=SOMClassClassDataPtr^;
  
  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      nil,                                      // ProcName specified
      'SOMObjectClassData',                         // ProcName
      Pointer(SOMObjectClassDataPtr));           // Address returned
  SOMObjectClassData:=SOMObjectClassDataPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      nil,                                      // ProcName specified
      'SOMClassMgrClassData',                         // ProcName
      Pointer(SOMClassMgrClassDataPtr));           // Address returned
  SOMClassMgrClassData:=SOMClassMgrClassDataPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      nil,                                      // ProcName specified
      'SOM_TraceLevel',                         // ProcName
      Pointer(SOM_TraceLevelPtr));           // Address returned
  SOM_TraceLevel:=SOM_TraceLevelPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      nil,                                      // ProcName specified
      'SOM_WarnLevel',                         // ProcName
      Pointer(SOM_WarnLevelPtr));           // Address returned
  SOM_WarnLevel:=SOM_WarnLevelPtr^;

  rc:=DosQueryProcAddr(
      ModuleHandle,                             // Handle to module
      nil,                                      // ProcName specified
      'SOM_AssertLevel',                         // ProcName
      Pointer(SOM_AssertLevelPtr));           // Address returned
  SOM_AssertLevel:=SOM_AssertLevelPtr^;

  rc:=DosFreeModule(ModuleHandle);
{$endif}

{$ifdef SOM_OBJECTS}
  // Play some memory games...
  OldMalloc  := SOMMalloc;
  OldCalloc  := SOMCalloc;
  OldRealloc := SOMRealloc;
  OldFree    := SOMFree;
{$ifdef vpc}
  @SOMFree    := @MyFree;
  @SOMRealloc := @MyRealloc;
  @SOMCalloc  := @MyCalloc;
  @SOMMalloc  := @MyMalloc;
{$else}
  SOMFree    := @MyFree;
  SOMRealloc := @MyRealloc;
  SOMCalloc  := @MyCalloc;
  SOMMalloc  := @MyMalloc;
{$endif}
{$endif}

  SOM_TraceLevelPtr^:=2;
  SOM_WarnLevelPtr^:=2;
  SOM_AssertLevelPtr^:=2;

  somEnvironmentNew;

Finalization

{$ifdef SOM_OBJECTS}
  SOMMalloc  := OldMalloc;
  SOMCalloc  := OldCalloc;
  SOMRealloc := OldRealloc;
  SOMFree    := OldFree;
{$endif}

  somEnvironmentEnd;

(*
³ 00038 ³ somSaveMetrics // not found
³ 00046 ³ somWriteMetrics // not found
³ 00051 ³ somCreateDynamicClass // not found
³ 00056 ³ SOM_IdTable // not found
³ 00057 ³ SOM_IdTableSize // not found
³ 00062 ³ somStartCriticalSection // not found
³ 00063 ³ somEndCriticalSection // not found
³ 00080 ³ somfixMsgTemplate // not found
³ 00087 ³ SOMParentDerivedMetaclassClassData // not found
³ 00132 ³ somFreeThreadData // not found
³ 00135 ³ somIdMarshal  // not found
³ 00361 ³ somMakeUserRdStub // Not found
*)

End.

