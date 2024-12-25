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
    SOMDLL='libsom';
  {$ELSE}
    SOMDLL='som.dll';
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
  TCORBA_short   = Integer;
  TCORBA_long    = Longint;
  //TCORBA_long_long = ???;
  TCORBA_unsigned_short = Word;
  TCORBA_unsigned_long    = Cardinal;
  //TCORBA_unsigned_long_long = ???;
  //TCORBA_float = Float;
  TCORBA_Double  = Double;
  //TCORBA_long_double = ???;
  TCORBA_char    = Char;
  //TCORBA_wchar   = ???;
  TCORBA_boolean = ByteBool;
  
  TCORBA_octet   = Byte;
  Tva_list       = PChar;

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
  PSOMClass                             = ^TRealSOMClass;
  PSOMObject                            = ^TRealSOMObject;
  TCORBA_Object                         = TRealSOMObject;    (* in SOM, a CORBA object is a SOM object *)

  somToken              = Pointer;       (* Uninterpretted value   *)
  somId                 = ^PCORBA_char;
  somIdPtr              = ^somId;
  PsomToken             = ^somToken;       (* Uninterpretted value   *)

  somMToken             = somToken;
  somDToken             = somToken;
  somMTokenPtr          = ^somMToken;
  somDTokenPtr          = ^somDToken;

type

  somMethodPtr           = Pointer;
  somBooleanVector       = PCORBA_boolean;
  somCtrlInfo            = somToken;

  somSharedMethodData    = somToken;
  somSharedMethodDataPtr = ^somSharedMethodData;

  somClassInfoPtr        = ^somClassInfo;
  somClassInfo           = somToken;


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

  somRdAppType          = TCORBA_long;       (* method signature code -- see def below *)
  somFloatMap           = Array[0..13] of TCORBA_long; (* float map -- see def below *)
  somFloatMapPtr        = ^somFloatMap;

  somMethodInfoStruct   =record
    callType            : somRdAppType;
    va_listSize         : TCORBA_long;
    float_map           : somFloatMapPtr;
  end;
  somMethodInfo         = somMethodInfoStruct;
  somMethodInfoPtr      = ^somMethodInfo;

  somMethodDataStruct   = record
    id                  : somId;
    ctype               : TCORBA_long;               (* 0=static, 1=dynamic 2=nonstatic *)
    descriptor          : somId;                 (* for use with IR interfaces *)
    mToken              : somMToken;             (* NULL for dynamic methods *)
    method              : somMethodPtr;          (* depends on resolution context *)
    shared              : somSharedMethodDataPtr;
  end;
  somMethodData         = somMethodDataStruct;
  somMethodDataPtr      = ^somMethodDataStruct;

  somMethodProc         = Procedure(somSelf:TRealSOMObject);
  somMethodProcPtr      = ^somMethodProc;


(*---------------------------------------------------------------------
 * C++-style constructors are called initializers in SOM. Initializers
 * are methods that receive a pointer to a somCtrlStruct as an argument.
 *)

  somInitInfo           =record
    cls                 : TRealSOMClass;(* the class whose introduced data is to be initialized *)
    defaultInit         : somMethodProc;
    defaultCopyInit     : somMethodProc;
    defaultConstCopyInit: somMethodProc;
    defaultNCArgCopyInit: somMethodProc;
    dataOffset          : TCORBA_long;
    legacyInit          : somMethodProc;
  end;

  somDestructInfo       =record
    cls                 : TRealSOMClass;(* the class whose introduced data is to be destroyed *)
    defaultDestruct     : somMethodProc;
    dataOffset          : TCORBA_long;
    legacyUninit        : somMethodProc;
  end;

  somAssignInfo         =record
    cls                 : TRealSOMClass;(* the class whose introduced data is to be assigned *)
    defaultAssign       : somMethodProc;
    defaultConstAssign  : somMethodProc;
    defaultNCArgAssign  : somMethodProc;
    udaAssign           : somMethodProc;
    udaConstAssign      : somMethodProc;
    dataOffset          : TCORBA_long;
  end;

  TCORBA_sequence_octet   = record
    _maximum            : TCORBA_unsigned_long;
    _length             : TCORBA_unsigned_long;
    _buffer             : PCORBA_octet;
  end;
  PCORBA_sequence_octet = ^TCORBA_sequence_octet;
  _IDL_SEQUENCE_octet = TCORBA_sequence_octet;
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

  somInitInfoPtr        =^somInitInfo;

  somInitCtrlStruct     =record
    mask                : somBooleanVector;(* an array of booleans to control ancestor calls *)
    info                : somInitInfoPtr;  (* an array of structs *)
    infoSize            : TCORBA_long;         (* increment for info access *)
    ctrlInfo            : somCtrlInfo;
  end;
  somInitCtrl           = somInitCtrlStruct;
  som3InitCtrl          = somInitCtrlStruct;

  somDestructInfoPtr    = ^somDestructInfo;
  somDestructCtrlStruct = record
    mask                : somBooleanVector;(* an array of booleans to control ancestor calls *)
    info                : somDestructInfoPtr;(* an array of structs *)
    infoSize            : TCORBA_long;         (* increment for info access *)
    ctrlInfo            : somCtrlInfo;
  end;
  somDestructCtrl       =somDestructCtrlStruct;
  som3DestructCtrl      =somDestructCtrlStruct;

  somAssignInfoPtr      =^somAssignInfo;
  somAssignCtrlStruct   =record
    mask                : somBooleanVector;(* an array of booleans to control ancestor calls *)
    info                : somAssignInfoPtr;(* an array of structs *)
    infoSize            : TCORBA_long;         (* increment for info access *)
    ctrlInfo            : somCtrlInfo;
  end;
  somAssignCtrl         = somAssignCtrlStruct;
  som3AssignCtrl        = somAssignCtrlStruct;

(*----------------------------------------------------------------------
 *  The Class Data Structures -- these are used to implement static
 *  method and data interfaces to SOM objects.
 *)

type
(* -- (Generic) Class data Structure *)
  somClassDataStructure =record
    classObject         : TRealSOMClass;                 (* changed by shadowing *)
    tokens              : Array[0..0] of somToken;      (* method tokens, etc. *)
  end;
  somClassDataStructurePtr=^somClassDataStructure;

  somInitCtrlPtr        =^somInitCtrl;
  somDestructCtrlPtr    =^somDestructCtrl;
  somAssignCtrlPtr      =^somAssignCtrl;

(* -- For building lists of method tables *)
  somMethodTabPtr       =^somMethodTab;

  somMethodTabs         =^somMethodTabList;
  somMethodTabList      =record
    mtab                :somMethodTabPtr;
    next                :somMethodTabs;
  end;

  somParentMtabStruct   =record
    mtab                : somMethodTabPtr;       (* this class' mtab -- changed by shadowing *)
    next                : somMethodTabs;         (* the parent mtabs -- unchanged by shadowing *)
    classObject         : TRealSOMClass;          (* unchanged by shadowing *)
    somRenewNoInitNoZeroThunk:somTD_somRenewNoInitNoZeroThunk; (* changed by shadowing *)
    instanceSize        : TCORBA_long;               (* changed by shadowing *)
    initializers        : somMethodProcPtr;      (* resolved initializer array in releaseorder *)
    resolvedMTokens     : somMethodProcPtr;      (* resolved methods *)
    initCtrl            : somInitCtrl;           (* these fields are filled in if somDTSClass&2 is on *)
    destructCtrl        : somDestructCtrl;
    assignCtrl          : somAssignCtrl;
    embeddedTotalCount  : TCORBA_long;
    hierarchyTotalCount : TCORBA_long;
    unused              : TCORBA_long;
  end;
  somParentMtabStructPtr=^somParentMtabStruct;

(*
 * (Generic) Auxiliary Class Data Structure
 *)
  somCClassDataStructure=record
    parentMtab          : somParentMtabStructPtr;
    instanceDataToken   : somDToken;
    wrappers            : Array[0..0] of somMethodProc;  (* for valist methods *)
  end;
  somCClassDataStructurePtr=^somCClassDataStructure;


(*----------------------------------------------------------------------
 *  The Method Table Structure
 *)

(* -- to specify an embedded object (or array of objects). *)
  somEmbeddedObjStructPtr=^somEmbeddedObjStruct;
  somEmbeddedObjStruct  =record
    copp                : TRealSOMClass;  (* address of class of object ptr *)
    cnt                 : TCORBA_long;       (* object count *)
    offset              : TCORBA_long;       (* Offset to pointer (to embedded objs) *)
  end;

  somMethodTabStruct    =record
    classObject         : TRealSOMClass;
    classInfo           : somClassInfoPtr;
    className           : TCORBA_string;
    instanceSize        : TCORBA_long;
    dataAlignment       : TCORBA_long;
    mtabSize            : TCORBA_long;
    protectedDataOffset : TCORBA_long;       (* from class's introduced data *)
    protectedDataToken  : somDToken;
    embeddedObjs        : somEmbeddedObjStructPtr;
    (* remaining structure is opaque *)
    entries             :Array[0..0] of somMethodProc;
  end;
  somMethodTab          =somMethodTabStruct;

(* -- For building lists of class objects *)
  somClasses            =^somClassList;
  somClassList          = record
    cls                 : TRealSOMClass;
    next                : somClasses;
  end;

(* -- For building lists of objects *)
  somObjects            =^somObjectList;
  somObjectList         = record
    obj                 : TRealSOMObject;
    next                : somObjects;
  end;



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

  somApRdInfoStruct     =record
    rdStub              :somMethodProc;
    apStub              :somMethodProc;
    stubInfo            :somMethodInfoPtr;
  end;
  somApRdInfo           =somApRdInfoStruct;


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
  somStaticMethodStruct =record
    classData           :somMTokenPtr;
    methodId            :somIdPtr;        (* this must be a simple name (no colons) *)
    methodDescriptor    :somIdPtr;
    method              :somMethodPtr;//somMethodProc;
    redispatchStub      :somMethodPtr;//somMethodProc;
    applyStub           :somMethodPtr;//somMethodProc;
  end;
  somStaticMethod_t     =somStaticMethodStruct;
  somStaticMethod_p     =^somStaticMethod_t;

(* to specify an overridden method *)
  somOverideMethodStruct=record
    methodId            :somIdPtr;        (* this can be a method descriptor *)
    method              :somMethodPtr;//somMethodProc;
  end;
  somOverrideMethod_t   =somOverideMethodStruct;
  somOverrideMethod_p   =^somOverrideMethod_t;

(* to inherit a specific parent's method implementation *)
  somInheritedMethodStruct=record
    methodId            : somIdPtr;      (* identify the method *)
    parentNum           : TCORBA_long;       (* identify the parent *)
    mToken              : somMTokenPtr;  (* for parentNumresolve *)
  end;
  somInheritedMethod_t  =somInheritedMethodStruct;
  somInheritedMethod_p  =^somInheritedMethod_t;

(* to register a method that has been moved from this *)
(* class <cls> upwards in the class hierachy to class <dest> *)
  somMigratedMethodStruct=record
    clsMToken           :somMTokenPtr;
                                (* points into the <cls> classdata structure *)
                                (* the method token in <dest> will copied here *)
    destMToken          :somMTokenPtr;
                                (* points into the <dest> classdata structure *)
                                (* the method token here will be copied to <cls> *)
  end;
  somMigratedMethod_t   =somMigratedMethodStruct;
  somMigratedMethod_p        =^somMigratedMethod_t;

(* to specify non-internal data *)
  somNonInternalDataStruct=record
    classData           : somDTokenPtr;
    basisForDataOffset  : PChar;
  end;
  somNonInternalData_t  =somNonInternalDataStruct;
  somNonInternalData_p  =^somNonInternalData_t;

(* to specify a "procedure" or "classdata" *)
  somProcMethodsStruct  =record
    classData           :somMethodProcPtr;
    pEntry              :somMethodProc;
  end;
  somProcMethods_t      =somProcMethodsStruct;
  somProcMethods_p      =^somProcMethods_t;

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

  somMethodStruct       =record
    mtype               : TCORBA_long;
    classData           :somMTokenPtr;
    methodId            :somIdPtr;
    methodDescriptor    :somIdPtr;
    method              :somMethodProc;
    redispatchStub      :somMethodProc;
    applyStub           :somMethodProc;
  end;
  somMethods_t          =somMethodStruct;
  somMethods_p          =^somMethods_t;

(* to specify a varargs function *)
  somVarargsFuncsStruct =record
    classData           :somMethodProcPtr;
    vEntry              :somMethodProc;
  end;
  somVarargsFuncs_t     =somVarargsFuncsStruct;
  somVarargsFuncs_p     =^somVarargsFuncs_t;

(* to specify dynamically computed information (incl. embbeded objs) *)
  somDynamicSCIPtr      =^somDynamicSci;
  somDynamicSCI         =record
    version             : TCORBA_long;       (* 1 for now *)
    instanceDataSize    : TCORBA_long;       (* true size (incl. embedded objs) *)
    dataAlignment       : TCORBA_long;       (* true alignment *)
    embeddedObjs        : somEmbeddedObjStructPtr; (* array end == null copp *)
  end;


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

  somStaticClassInfoStruct=record
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
    classId             :somId;
    explicitMetaId      :somId;
    implicitParentMeta  : TCORBA_long;
    parents             :somIdPtr;
    cds                 :somClassDataStructurePtr;
    ccds                :somCClassDataStructurePtr;
    smt                 :somStaticMethod_p; (* basic "static" methods for mtab *)
    omt                 :somOverrideMethod_p; (* overrides for mtab *)
    nitReferenceBase    :PChar;
    nit                 :somNonInternalData_p; (* datatokens for instance data *)
    pmt                 :somProcMethods_p; (* Arbitrary ClassData members *)
    vft                 :somVarargsFuncs_p; (* varargs stubs *)
    cif                 :pointer{^somTP_somClassInitFunc}; (* class init function *)
    (* end of layout version 1 *)

    (* begin layout version 2 extensions *)
    dataAlignment       : TCORBA_long; (* the desired byte alignment for instance data *)
    (* end of layout version 2 *)

//#define SOMSCIVERSION 1

    (* begin layout version 3 extensions *)
    numDirectInitClasses: TCORBA_long;
    directInitClasses   :somIdPtr;
    numMethods          : TCORBA_long; (* general (including nonstatic) methods for mtab *)
    mt                  :somMethods_p;
    protectedDataOffset : TCORBA_long; (* access = resolve(instanceDataToken) + offset *)
    somSCIVersion       : TCORBA_long;  (* used during development. currently = 1 *)
    numInheritedMethods : TCORBA_long;
    imt                 :somInheritedMethod_p; (* inherited method implementations *)
    numClassDataEntries : TCORBA_long; (* should always be filled in *)
    classDataEntryNames :somIdPtr; (* either NULL or ptr to an array of somIds *)
    numMigratedMethods  : TCORBA_long;
    mmt                 :somMigratedMethod_p; (* migrated method implementations *)
    numInitializers     : TCORBA_long; (* the initializers for this class *)
    initializers        :somIdPtr;     (* in order of release *)
    somDTSClass         : TCORBA_long; (* used to identify a DirectToSOM class *)
    dsci                :somDynamicSCIPtr;  (* used to register dynamically computed info *)
    (* end of layout version 3 *)
  end;
  somStaticClassInfo    =somStaticClassInfoStruct;
  somStaticClassInfoPtr =^somStaticClassInfoStruct;

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
  SOMClass_somOffsets           = record
    cls                         : TRealSOMClass;
    offset                      : TCORBA_long;
  end;

  _IDL_SEQUENCE_SOMClass        = packed record
    _maximum                    : TCORBA_unsigned_long;
    _length                     : TCORBA_unsigned_long;
    _buffer                     : ^PSOMClass;
  end;
  P_IDL_SEQUENCE_SOMClass=^_IDL_SEQUENCE_SOMClass;

  _IDL_SEQUENCE_SOMObject       = record
    _maximum                    : TCORBA_unsigned_long;
    _length                     : TCORBA_unsigned_long;
    _buffer                     : PSOMObject;
  end;
  SOMClass_SOMClassSequence     = _IDL_SEQUENCE_SOMClass;
  
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

Function  somResolve(obj:TRealSOMObject; mdata:somMToken):somMethodProc; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somParentResolve(parentMtabs:somMethodTabs; mToken:somMToken):somMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somParentNumResolve(parentMtabs:somMethodTabs; parentNum: TCORBA_long; mToken:somMToken): somMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somClassResolve(obj:TRealSOMClass; mdata:somMToken):somMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somAncestorResolve(obj:TRealSOMObject; var ccds:somCClassDataStructure; mToken:somMToken):somMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somResolveByName(obj: TRealSOMObject; methodName: PCORBA_char):somMethodProc;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*------------------------------------------------------------------------------
 * Offset-based data resolution
 *)
Function  somDataResolve(obj:TRealSOMObject; dataId:somDToken):somToken;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function  somDataResolveChk(obj:TRealSOMObject; dataId:somDToken):somToken;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

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
Function  somIsObj(obj:somToken): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * Return the class that introduced the method represented by a given method token.
 *)
Function  somGetClassFromMToken(mToken:somMToken):TRealSOMClass;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


(*----------------------------------------------------------------------
 *  String Manager: stem <somsm>
 *)
Function  somCheckID(id:somId):somId;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* makes sure that the id is registered and in normal form, returns *)
(* the id *)

Function  somRegisterId(id:somId): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Same as somCheckId except returns 1 (true) if this is the first *)
(* time the string associated with this id has been registered, *)
(* returns 0 (false) otherwise *)

Function  somIDFromString(aString: TCORBA_string):somId;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* caller is responsible for freeing the returned id with SOMFree *)

// Not found
//Function  somIdFromStringNoFree(aString:PChar):somId;  {$ifndef vpc}{$ifdef os2}cdecl;{$endif}{$ifdef win32}stdcall;{$endif}{$endif}
(* call is responsible for *not* freeing the returned id *)

Function  somStringFromId(id:somId): TCORBA_string;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
(* Return a string that must never be freed or modified. *)

Function  somCompareIds(id1,id2:somId): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
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

Function  somUniqueKey(id:somId): TCORBA_unsigned_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
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
const
  SOMClassMgrObjectPtr: ^TRealSOMClassMgr = @SOMClassMgrObject;

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
Procedure somRegisterClassLibrary(libraryName: TCORBA_string; libraryInitRun: somMethodProc);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

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

Function  somApply(var somSelf:TRealSOMObject; var retVal:somToken; mdPtr:somMethodDataPtr; var ap): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

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


Function  somBuildClass(inherit_vars: TCORBA_long; var sci:somStaticClassInfo; majorVersion, minorVersion: TCORBA_long):TRealSOMClass;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

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
                            var cds :somClassDataStructure);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}


(*
 * Uses <SOMOutCharRoutine> to output its arguments under control of the ANSI C
 * style format.  Returns the number of characters output.
 *)
Function  somPrintf(fmt: TCORBA_string; buf: Array of const): TCORBA_long; cdecl; {$ifdef fpc}external SOMDLL name 'somPrintf';{$endif}

// vprint form of somPrintf
Function  somVPrintf(fmt: TCORBA_string; var ap): TCORBA_long;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

// Outputs (via somPrintf) blanks to prefix a line at the indicated level
Procedure somPrefixLevel(level: TCORBA_long);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

// Combines somPrefixLevel and somPrintf
Procedure somLPrintf(level: TCORBA_long;fmt: TCORBA_string;var buf);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*----------------------------------------------------------------------
 * Pointers to routines used to do dynamic code loading and deleting
 *)
type
  somTD_SOMLoadModule           =Function({IN}  Module: TCORBA_string  (* className *);
                                          {IN}FileName: TCORBA_string  (* fileName *);
                                          {IN}FuncName: TCORBA_string  (* functionName *);
                                          {IN}MajorVer: TCORBA_long    (* majorVersion *);
                                          {IN}MinorVer: TCORBA_long    (* minorVersion *);
                                          {OUT}var ref: somToken (* modHandle *)): TCORBA_long;
  somTD_SOMDeleteModule         =Function({IN} ref:somToken     (* modHandle *)): TCORBA_long;
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
  somTD_SOMMalloc               =Function({IN} size_t: TCORBA_long   (* nbytes *)):somToken;
  somTD_SOMCalloc               =Function({IN} size_c: TCORBA_long   (* element_count *);
                                          {IN} size_e: TCORBA_long   (* element_size *)):somToken;
  somTD_SOMRealloc              =Function({IN}    ref: somToken      (* memory *);
                                          {IN}   size: TCORBA_long   (* nbytes *)):somToken;
  somTD_SOMFree                 =Procedure({IN}   ref: somToken    (* memory *));

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
  somTD_SOMCreateMutexSem       =Function({OUT}var sem:somToken ): TCORBA_long;
  somTD_SOMRequestMutexSem      =Function({IN}sem:somToken ): TCORBA_long;
  somTD_SOMReleaseMutexSem      =Function({IN}sem:somToken ): TCORBA_long;
  somTD_SOMDestroyMutexSem      =Function({IN}sem:somToken ): TCORBA_long;

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

function SOM_Resolve(o: TRealSOMObject; oc: TRealSOMClass; mn: somMToken): somMethodProc;

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

const
  SOM_TraceLevelPtr: PCORBA_long = @SOM_TraceLevel;

// Control the printing of warning messages, 0-none, 1-all
var
  SOM_WarnLevel: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_WarnLevel';{$endif}
const
  SOM_WarnLevelPtr: PCORBA_long = @SOM_WarnLevel;

// Control the printing of successful assertions, 0-none, 1-user, 2-core&user
var
  SOM_AssertLevel: TCORBA_long; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOM_AssertLevel';{$endif}
const
  SOM_AssertLevelPtr: PCORBA_long = @SOM_AssertLevel;

// ToDo: Move this to corresponding place
Procedure somCheckArgs(argc: TCORBA_long; argv: array of pchar);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Procedure somUnregisterClassLibrary (libraryName: TCORBA_string);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somResolveTerminal(x : PSOMClass; mdata: somMToken): somMethodProcPtr;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somPCallResolve(obj: PSOMObject; callingCls: PSOMClass; method: somMToken): somMethodProcPtr;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function va_SOMObject_somDispatchA(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Pointer;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somva_SOMObject_somDispatchA(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Pointer;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function va_SOMObject_somDispatchL(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Longint;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somva_SOMObject_somDispatchL(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Longint;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function va_SOMObject_somDispatch(somSelf: PSOMObject;
                retValue: PsomToken;
                methodId: somId;
                args: array of const): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Procedure va_SOMObject_somDispatchV(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Procedure somva_SOMObject_somDispatchV(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const);{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function va_SOMObject_somDispatchD(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): double;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

Function somva_SOMObject_somDispatchD(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): double;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
Function somva_SOMObject_somDispatch(somSelf: PSOMObject;
                retValue: PsomToken;
                methodId: somId;
                args: array of const): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}
				
Function somva_SOMObject_somClassDispatch(somSelf: PSOMObject;
                clsObj: PSOMClass;
                retValue: PsomToken;
                methodId: somId;
                args: array of const): TCORBA_boolean;{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

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

Procedure somSetOutChar(outch:somTD_SOMOutCharRoutine); external SOMDLL name 'somSetOutChar';
Function  somMainProgram:TRealSOMClassMgr; external SOMDLL name 'somMainProgram';
Procedure somEnvironmentEnd; external SOMDLL name 'somEnvironmentEnd';
Function  somAbnormalEnd: TCORBA_boolean; external SOMDLL name 'somAbnormalEnd';
Function  somResolve(obj:TRealSOMObject; mdata:somMToken):somMethodProc; external SOMDLL name 'somResolve';
Function  somParentResolve(parentMtabs:somMethodTabs; mToken:somMToken):somMethodProc; external SOMDLL name 'somParentResolve';
Function  somParentNumResolve(parentMtabs:somMethodTabs; parentNum:Longint;mToken:somMToken):somMethodProc; external SOMDLL name 'somParentNumResolve';
Function  somClassResolve(obj:TRealSOMClass; mdata:somMToken):somMethodProc; external SOMDLL name 'somClassResolve'; 
Function  somAncestorResolve(obj:TRealSOMObject; var ccds:somCClassDataStructure; mToken:somMToken):somMethodProc;  external SOMDLL name 'somAncestorResolve';
Function  somResolveByName(obj: TRealSOMObject; methodName: PCORBA_char):somMethodProc; external SOMDLL name 'somResolveByName';
Function  somDataResolve(obj:TRealSOMObject; dataId:somDToken):somToken; external SOMDLL name 'somDataResolve';
Function  somDataResolveChk(obj:TRealSOMObject; dataId:somDToken):somToken; external SOMDLL name 'somDataResolveChk';
Function  somEnvironmentNew: TRealSOMClassMgr; external SOMDLL name 'somEnvironmentNew'; 
Function  somIsObj(obj:somToken): TCORBA_boolean; external SOMDLL name 'somIsObj';
Function  somGetClassFromMToken(mToken:somMToken):TRealSOMClass; external SOMDLL name 'somGetClassFromMToken';
Function  somCheckID(id:somId):somId; external SOMDLL name 'somCheckId';
Function  somRegisterId(id:somId):Longint; external SOMDLL name 'somRegisterId';
Function  somIDFromString(aString: PCORBA_char):somId; external SOMDLL name 'somIdFromString';
Function  somStringFromId(id:somId): TCORBA_string; external SOMDLL name 'somStringFromId';
Function  somCompareIds(id1,id2:somId): TCORBA_long; external SOMDLL name 'somCompareIds';
Function  somTotalRegIds: TCORBA_long; external SOMDLL name 'somTotalRegIds';
Procedure somSetExpectedIds(numIds: TCORBA_unsigned_long); external SOMDLL name 'somSetExpectedIds';
Function  somUniqueKey(id:somId): TCORBA_unsigned_long; external SOMDLL name 'somUniqueKey';
Procedure somBeginPersistentIds; external SOMDLL name 'somBeginPersistentIds';
Procedure somEndPersistentIds; external SOMDLL name 'somEndPersistentIds';
Procedure somRegisterClassLibrary(libraryName: TCORBA_string; libraryInitRun:somMethodProc); external SOMDLL name 'somRegisterClassLibrary';
Function  somApply(var somSelf:TRealSOMObject; var retVal:somToken; mdPtr:somMethodDataPtr; var ap): TCORBA_boolean; external SOMDLL name 'somApply';
Function  somBuildClass(inherit_vars:Longint; var sci:somStaticClassInfo; majorVersion,minorVersion:Longint):TRealSOMClass; external SOMDLL name 'somBuildClass';
Procedure somConstructClass(classInitRoutine:somTD_ClassInitRoutine; parentClass,metaClass:TRealSOMClass; var cds :somClassDataStructure); external SOMDLL name 'somConstructClass';
{$ifndef fpc}
Function  somPrintf(fmt: PCORBA_char; buf: Array of const): TCORBA_long;external SOMDLL name 'somPrintf';
{$endif}
Function  somVPrintf(fmt: PCORBA_char; var ap): TCORBA_long; external SOMDLL name 'somVprintf';
Procedure somPrefixLevel(level: TCORBA_long); external SOMDLL name 'somPrefixLevel';
Procedure somLPrintf(level: TCORBA_long; fmt: TCORBA_string; var buf); external SOMDLL name 'somLPrintf';
Function  somTestCls(obj:TRealSOMObject; classObj:TRealSOMClass; fileName: TCORBA_string; lineNumber: TCORBA_long):TRealSOMObject; external SOMDLL name 'somTestCls';
Procedure somTest(condition,severity: TCORBA_long; fileName: TCORBA_string; lineNum: TCORBA_long; msg: TCORBA_string); external SOMDLL name 'somTest';
Procedure somAssert(condition,ecode: TCORBA_long; fileName: TCORBA_string; lineNum: TCORBA_long; msg: TCORBA_string); external SOMDLL name 'somAssert';
Function  somExceptionId(var ev: TCORBA_Environment): TCORBA_string; external SOMDLL name 'somExceptionId';
Function  somExceptionValue(var ev: TCORBA_Environment):Pointer; external SOMDLL name 'somExceptionValue';
Procedure somExceptionFree(ev: PCORBA_Environment); external SOMDLL name 'somExceptionFree';
Procedure somSetException(var ev: TCORBA_Environment; major: TCORBA_exception_type; exception_name: PCORBA_char;params:pointer); external SOMDLL name 'somSetException';
Function  somGetGlobalEnvironment: PCORBA_Environment; external SOMDLL name 'somGetGlobalEnvironment';
Procedure somCheckArgs(argc: longint; argv: array of pchar); external SOMDLL name 'somCheckArgs';
Procedure somUnregisterClassLibrary (libraryName: TCORBA_string); external SOMDLL name 'somUnregisterClassLibrary';
Function somResolveTerminal(x : PSOMClass; mdata: somMToken): somMethodProcPtr; external SOMDLL name 'somResolveTerminal';
Function somPCallResolve(obj: PSOMObject; callingCls: PSOMClass; method: somMToken): somMethodProcPtr; external SOMDLL name 'somPCallResolve';
Function va_SOMObject_somDispatchA(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Pointer;
  external SOMDLL name 'va_SOMObject_somDispatchA';
Function somva_SOMObject_somDispatchA(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Pointer;
  external SOMDLL name 'somva_SOMObject_somDispatchA';
Function va_SOMObject_somDispatchL(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Longint;
  external SOMDLL name 'va_SOMObject_somDispatchL';
Function somva_SOMObject_somDispatchL(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): Longint;
  external SOMDLL name 'somva_SOMObject_somDispatchL';

Function va_SOMObject_somDispatch(somSelf: PSOMObject;
                retValue: PsomToken;
                methodId: somId;
                args: array of const): TCORBA_boolean; external SOMDLL name 'va_SOMObject_somDispatch';

Procedure va_SOMObject_somDispatchV(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const); external SOMDLL name 'va_SOMObject_somDispatchV';

Procedure somva_SOMObject_somDispatchV(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const); external SOMDLL name 'somva_SOMObject_somDispatchV';

Function va_SOMObject_somDispatchD(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): double; external SOMDLL name 'va_SOMObject_somDispatchD';

Function somva_SOMObject_somDispatchD(somSelf: PSOMObject;
                methodId: somId;
                descriptor: somId;
                args: array of const): double; external SOMDLL name 'somva_SOMObject_somDispatchD';
Function somva_SOMObject_somDispatch(somSelf: PSOMObject;
                retValue: PsomToken;
                methodId: somId;
                args: array of const): TCORBA_boolean; external SOMDLL name 'somva_SOMObject_somDispatch';
				
Function somva_SOMObject_somClassDispatch(somSelf: PSOMObject;
                clsObj: PSOMClass;
                retValue: PsomToken;
                methodId: somId;
                args: array of const): TCORBA_boolean; external SOMDLL name 'somva_SOMObject_somClassDispatch';

/////////////////////////////////////////////////////////////////////

function SOM_Resolve(o: TRealSOMObject; oc: TRealSOMClass; mn: somMToken): somMethodProc;
begin
  //@todo Test_cls here
  {$ifdef SOM_METHOD_THUNKS}
  Result := somMethodProc(mn);
  {$else}
  Result := somMethodProc(somResolve(o, mn));
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
  BufSize               = 8;

var
  OldMalloc             : somTD_SOMMalloc;
  OldCalloc             : somTD_SOMCalloc;
  OldRealloc            : somTD_SOMRealloc;
  OldFree               : somTD_SOMFree;

// Our custom memory management. Alow us to store some info about SOM classes and Object Pascal classes linking.


Function MyMalloc(size_t:Integer):somToken;
begin
//  somprintf('Malloc', []);
  if size_t<=0 then begin
    somPrintf('%s',['Z']);
    Result := nil
  end else begin
    GetMem(Result,size_t + 2*BufSize);
    if Result<>nil then begin
      inc(Cardinal(Result),BufSize);
      PCardinal(Cardinal(Result)-4)^ := 0;
      PCardinal(Cardinal(Result)-8)^ := size_t;
    end else  
    somprintf('%s', ['M']);
  end;
//  somprintf('%08X', [result]);
end;

Function MyCalloc(size_c:Integer; size_e:Integer):somToken;
begin
//  somprintf('Calloc', []);
  Result := somTD_SOMCalloc(OldCalloc)(size_c,size_e);
  //somprintf('c',[]);
end;

Procedure MyFree(ref:somToken);
var
  size          : Longint;
begin
//  somprintf('Free %08X', [ref]);
  if ref<>nil then begin
    size := PCardinal(Cardinal(ref)-8)^;
    dec(Cardinal(ref),BufSize);
    try
      FreeMem(ref,size + BufSize*2); // Possible leak!!!
    except
      somprintf('%s',['F']);
    end;
    //somprintf('f', []);
  end;
end;

Function MyRealloc(ref:somToken; size:Integer):somToken;
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
      somprintf('%s',['R']);
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
  ModuleName   : PChar = SOMDLL;             // Name of module
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
Begin
  somEnvironmentNew;
{$ifndef SOM_EXTVAR}
  {$ifdef win32}
  hLib1 := LoadLibrary(SOMDLL);
  SOMClassMgrObjectPtr := GetProcAddress(hLib1, 'SOMClassMgrObject');
  SOMClassMgrObject := SOMClassMgrObjectPtr^;
  SOM_MajorVersionPtr := GetProcAddress(hLib1, 'SOM_MajorVersion');
  SOM_MajorVersion:=SOM_MajorVersionPtr^;
  SOM_MinorVersionPtr := GetProcAddress(hLib1, 'SOM_MinorVersion');
  SOM_MinorVersion:=SOM_MinorVersionPtr^;
  SOM_MaxThreadsPtr := GetProcAddress(hLib1, 'SOM_MaxThreads');
  SOM_MaxThreads:=SOM_MaxThreadsPtr^;
  SOM_TraceLevelPtr := GetProcAddress(hLib1, 'SOM_TraceLevel');
  SOM_TraceLevel:=SOM_TraceLevelPtr^;
  FreeLibrary(hLib1);
  {$endif}
{$else}
  SOM_MajorVersionPtr:=@SOM_MajorVersion;
  SOM_MinorVersionPtr:=@SOM_MinorVersion;
  SOM_TraceLevelPtr:= @SOM_TraceLevel;
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

  SOMFree    := @MyFree;
  SOMRealloc := @MyRealloc;
  SOMCalloc  := @MyCalloc;
  SOMMalloc  := @MyMalloc;

{ Place to our exit proc
  SOMMalloc  := somTD_SOMMalloc(OldMalloc);
  SOMCalloc  := somTD_SOMCalloc(OldCalloc);
  SOMRealloc := somTD_SOMRealloc(OldRealloc);
  SOMFree    := somTD_SOMFree(OldFree);
}
{$endif}

(*
� 00038 � somSaveMetrics // not found
� 00046 � somWriteMetrics // not found
� 00051 � somCreateDynamicClass // not found
� 00056 � SOM_IdTable // not found
� 00057 � SOM_IdTableSize // not found
� 00062 � somStartCriticalSection // not found
� 00063 � somEndCriticalSection // not found
� 00080 � somfixMsgTemplate // not found
� 00087 � SOMParentDerivedMetaclassClassData // not found
� 00132 � somFreeThreadData // not found
� 00135 � somIdMarshal  // not found
� 00361 � somMakeUserRdStub // Not found
*)

End.
