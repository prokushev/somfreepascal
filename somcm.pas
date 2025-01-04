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

Unit SOMCM;

Interface

Uses
  SOM, SOMOBJ;

///////////////////// SOMClassMgr Class //////////////

const
  SOMClassMgr_MajorVersion = 1;
  {$ifdef SOM_VERSION_3}
    SOMClassMgr_MinorVersion = 6;
  {$else}
    {$ifdef SOM_VERSION_2}
      SOMClassMgr_MinorVersion = 4;
    {$else}
      SOMClassMgr_MinorVersion = 1;
    {$endif}
  {$endif}

type
  TSOMClassMgrCClassData   = record
    parentMtab                  : PsomMethodTabs;
    instanceDataToken           : TsomDToken;
  end;

var
  SOMClassMgrCClassData         : TSOMClassMgrCClassData; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMClassMgrCClassData';{$endif}

type
  TSOMClassMgrClassData         = record
    classObject                 : TRealSOMClass;
	// SOM 1 Methods
    somFindClsInFile            : TsomMToken;
    somFindClass                : TsomMToken;
    somClassFromId              : TsomMToken;
    somRegisterClass            : TsomMToken;
    somUnregisterClass          : TsomMToken;
    somLocateClassFile          : TsomMToken;
    somLoadClassFile            : TsomMToken;
    somUnloadClassFile          : TsomMToken;
    somGetInitFunction          : TsomMToken;
    somMergeInto                : TsomMToken;
    somGetRelatedClasses        : TsomMToken;
	// SOM 2 Methods
	{$ifdef SOM_VERSION_2}
    somSubstituteClass          : TsomMToken;
    _get_somInterfaceRepository : TsomMToken;
    _set_somInterfaceRepository : TsomMToken;
    _get_somRegisteredClasses   : TsomMToken;
    somBeginPersistentClasses   : TsomMToken;
    somEndPersistentClasses     : TsomMToken;
    somReleaseClasses           : TsomMToken;
    somRegisterThreadUsage      : TsomMToken;
    somRegisterClassLibrary     : TsomMToken;
    somJoinAffinityGroup        : TsomMToken;
    somUnregisterClassLibrary	: TsomMToken;
	{$endif}
	// SOM 3 Methods
	{$ifdef SOM_VERSION_3}
    somImportObject				: TsomMToken;
    somCIBFromClassId			: TsomMToken;
    somCopyOnImport				: TsomMToken;
	{$endif}
  end;

var
  SOMClassMgrClassData          : TSOMClassMgrClassData; {$ifdef SOM_EXTVAR}external SOMDLL name 'SOMClassMgrClassData';{$endif}
  SOMClassMgrClassDataPtr       : ^TSOMClassMgrClassData;

type
  SOMClassMgr_SOMClassArray = ^TRealSOMClass;

Function SOMClassMgrNewClass(majorVersion,minorVersion: TCORBA_long):TRealSOMClass; {$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}

(*
 * New Method: somLoadClassFile
 *)

(*
 *  Loads the class' code and initializes the class object.
 *)
const
  somMD_SOMClassMgr_somLoadClassFile = '::SOMClassMgr::somLoadClassFile';

type
  somTP_SOMClassMgr_somLoadClassFile = function(somSelf: TRealSOMClassMgr;
    classId: TsomId; majorVersion, minorVersion: TCORBA_long;
    fileName: PCORBA_char): TRealSOMClass; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somLoadClassFile = somTP_SOMClassMgr_somLoadClassFile;

function SOMClassMgr_somLoadClassFile(somSelf: TRealSOMClassMgr; classId: TsomId;
  majorVersion, minorVersion: TCORBA_long; fileName: PCORBA_char): TRealSOMClass;

(*
 * New Method: somLocateClassFile
 *)

(*
 *  Real implementation supplied by subclasses.  Default implementation
 *  will lookup the class name in the Interface Repository (if one is
 *  available) to determine the implementation file name (ie, DLL name).
 *  If this information is not available, the class name itself is
 *  returned as the file name.   Subclasses may use version number
 *  info to assist in deriving the file name.
 *)
const
  somMD_SOMClassMgr_somLocateClassFile = '::SOMClassMgr::somLocateClassFile';

type
  somTP_SOMClassMgr_somLocateClassFile = function(somSelf: TRealSOMClassMgr;
    classId: TsomId; majorVersion, minorVersion: TCORBA_long): PCORBA_char; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somLocateClassFile = somTP_SOMClassMgr_somLocateClassFile;

function SOMClassMgr_somLocateClassFile(somSelf: TRealSOMClassMgr; classId: TsomId;
  majorVersion, minorVersion: TCORBA_long): PCORBA_char;

(*
 * New Method: somRegisterClass
 *)

(*
 *  Lets the class manager know that the specified class is installed
 *  and tells it where the class object is.
 *)
const
  somMD_SOMClassMgr_somRegisterClass = '::SOMClassMgr::somRegisterClass';

type
  somTP_SOMClassMgr_somRegisterClass = procedure(somSelf: TRealSOMClassMgr;
    classObj: TRealSOMClass); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somRegisterClass = somTP_SOMClassMgr_somRegisterClass;

procedure SOMClassMgr_somRegisterClass(somSelf: TRealSOMClassMgr;
  classObj: TRealSOMClass);


(*
 * New Method: somUnloadClassFile
 *)

(*
 *  Releases the class' code and unregisters all classes in the
 *  same affinity group (see somGetRelatedClasses below).
 *)
const
  somMD_SOMClassMgr_somUnloadClassFile = '::SOMClassMgr::somUnloadClassFile';

type
  somTP_SOMClassMgr_somUnloadClassFile = function(somSelf: TRealSOMClassMgr;
    classObj: TRealSOMClass): TCORBA_long; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somUnloadClassFile = somTP_SOMClassMgr_somUnloadClassFile;

function SOMClassMgr_somUnloadClassFile(somSelf: TRealSOMClassMgr;
  classObj: TRealSOMClass): TCORBA_long;

(*
 * New Method: somUnregisterClass
 *)

(*
 *  Free the class object and removes the class from the SOM registry.
 *  If the class caused dynamic loading to occur, it is also unloaded
 *  (causing its entire affinity group to be unregistered as well).
 *)
const
  somMD_SOMClassMgr_somUnregisterClass = '::SOMClassMgr::somUnregisterClass';

type
  somTP_SOMClassMgr_somUnregisterClass = function(somSelf: TRealSOMClassMgr;
    classObj: TRealSOMClass): TCORBA_long; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somUnregisterClass = somTP_SOMClassMgr_somUnregisterClass;

function SOMClassMgr_somUnregisterClass(somSelf: TRealSOMClassMgr;
  classObj: TRealSOMClass): TCORBA_long;


(*
 * New Method: somGetInitFunction
 *)

(*
 *  The name of the initialization function in the class' code file.
 *  Default implementation returns ( * SOMClassInitFuncName)().
 *)

const
  somMD_SOMClassMgr_somGetInitFunction = '::SOMClassMgr::somGetInitFunction';

type
  somTP_SOMClassMgr_somGetInitFunction = function(somSelf: TRealSOMClassMgr):
    PCORBA_char; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somGetInitFunction = somTP_SOMClassMgr_somGetInitFunction;

function SOMClassMgr_somGetInitFunction(somSelf: TRealSOMClassMgr): PCORBA_char;



(*
 * New Method: somGetRelatedClasses
 *)

(*
 *  Returns an array of class objects that were all registered during
 *  the dynamic loading of a class.    These classes are considered to
 *  define an affinity group.  Any class is a member of at most one
 *  affinity group.    The affinity group returned by this call is the
 *  one containing the class identified by classObj.  The first element
 *  in the array is the class that caused the group to be loaded, or the
 *  special value -1 which means that the SOMClassMgr is currently in the
 *  process of unregistering and deleting the affinity group (only
 *  SOMClassMgr subclasses would ever see this value).
 *  The remainder of the array (elements one thru n) consists of
 *  pointers to class objects ordered in reverse chronological sequence
 *  to that in which they were originally registered.  This list includes
 *  the given argument, classObj, as one of its elements, as well as the
 *  class, if any, returned as element[0] above.  The array is terminated
 *  by a NULL pointer as the last element.  Use SOMFree to release the
 *  array when it is no longer needed.  If the supplied class was not
 *  dynamically loaded, it is not a member of any affinity
 *  group and NULL is returned.
 *  [Dynamic Group]
 *)
const
  somMD_SOMClassMgr_somGetRelatedClasses = '::SOMClassMgr::somGetRelatedClasses';

type
  somTP_SOMClassMgr_somGetRelatedClasses = function(somSelf: TRealSOMClassMgr; classObj: TRealSOMClass): SOMClassMgr_SOMClassArray; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somGetRelatedClasses = somTP_SOMClassMgr_somGetRelatedClasses;

function SOMClassMgr_somGetRelatedClasses(somSelf: TRealSOMClassMgr;
  classObj: TRealSOMClass): SOMClassMgr_SOMClassArray;

(*
 * New Method: somClassFromId
 *)

(*
 *  Finds the class object, given its Id, if it already exists.
 *  Does not load the class.  Returns NULL if the class object does
 *  not yet exist.
 *)

const
  somMD_SOMClassMgr_somClassFromId = '::SOMClassMgr::somClassFromId';

type
  somTP_SOMClassMgr_somClassFromId = function(somSelf: TRealSOMClassMgr; classId: TsomId): TRealSOMClass; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somClassFromId = somTP_SOMClassMgr_somClassFromId;

function SOMClassMgr_somClassFromId(somSelf: TRealSOMClassMgr; classId: TsomId): TRealSOMClass;

(*
 * New Method: somFindClass
 *)

(*
 *  Returns the class object for the specified class.  This may result
 *  in dynamic loading.  Uses somLocateClassFile to obtain the name of
 *  the file where the class' code resides, then uses somFindClsInFile.
 *)

const
  somMD_SOMClassMgr_somFindClass = '::SOMClassMgr::somFindClass';

type
  somTP_SOMClassMgr_somFindClass = function(somSelf: TRealSOMClassMgr;
    classId: TsomId; majorVersion, minorVersion: TCORBA_long): TRealSOMClass; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somFindClass = somTP_SOMClassMgr_somFindClass;

function SOMClassMgr_somFindClass(somSelf: TRealSOMClassMgr; classId: TsomId; majorVersion, minorVersion: TCORBA_long): TRealSOMClass;

(*
 * New Method: somFindClsInFile
 *)

(*
 *  Returns the class object for the specified class.  This may result
 *  in dynamic loading.  If the class already exists <file> is ignored,
 *  otherwise it is used to locate and dynamically load the class.
 *  Values of 0 for major and minor version numbers bypass version checking.
 *)

const
  somMD_SOMClassMgr_somFindClsInFile = '::SOMClassMgr::somFindClsInFile';

type
  somTP_SOMClassMgr_somFindClsInFile = function(somSelf: TRealSOMClassMgr;
    classId: TsomId; majorVersion, minorVersion: TCORBA_long; fileName: PCORBA_char):
    TRealSOMClass; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somFindClsInFile = somTP_SOMClassMgr_somFindClsInFile;

function SOMClassMgr_somFindClsInFile(somSelf: TRealSOMClassMgr; classId: TsomId;
  majorVersion, minorVersion: TCORBA_long; fileName: PCORBA_char): TRealSOMClass;

(*
 * New Method: somMergeInto
 *)

(*
 *  Merges the SOMClassMgr registry information from the receiver to
 *  <targetObj>.  <targetObj> is required to be an instance of SOMClassMgr
 *  or one of its subclasses.  At the completion of this operation,
 *  the <targetObj> should be able to function as a replacement for the
 *  receiver.  At the end of the operation the receiver object (which is
 *  then in a newly uninitialized state) is freed.  Subclasses that
 *  override this method should similarly transfer their sections of
 *  the object and pass this method to their parent as the final step.
 *  If the receiving object is the distinguished instance pointed to
 *  from the global variable SOMClassMgrObject, SOMCLassMgrObject is
 *  then reassigned to point to <targetObj>.
 *)
const
  somMD_SOMClassMgr_somMergeInto = '::SOMClassMgr::somMergeInto';

type
  somTP_SOMClassMgr_somMergeInto = procedure(somSelf: TRealSOMClassMgr; targetObj: TRealSOMObject); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somMergeInto = somTP_SOMClassMgr_somMergeInto;

procedure SOMClassMgr_somMergeInto(somSelf: TRealSOMClassMgr; targetObj: TRealSOMObject);

{$ifdef SOM_VERSION_2}

(*
 * New Method: somSubstituteClass
 *)

(*
 *  This method causes the somFindClass, somFindClsInFile, and
 *  somClassFromId methods to return the class named newClassName
 *  whenever they would have normally returned the class named
 *  origClassName.  This effectively results in class <newClassName>
 *  replacing or substituting itself for class <origClassName>.
 *  Some restrictions are enforced to insure that this works well.
 *  Both class <origClassName> and class <newClassName> must
 *  have been already registered before issuing this method, and newClass
 *  must be an immediate child of origClass.  In addition (although not
 *  enforceable), no instances should exist of either class at the time
 *  this method is invoked.    A return value of zero indicates success;
 *  a non-zero value indicates an error was detected.
 *)

const
  somMD_SOMClassMgr_somSubstituteClass = '::SOMClassMgr::somSubstituteClass';

type
  somTP_SOMClassMgr_somSubstituteClass = function(somSelf: TRealSOMClassMgr;
    origClassName, newClassName: PCORBA_char): TCORBA_long; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somSubstituteClass = somTP_SOMClassMgr_somSubstituteClass;

function SOMClassMgr_somSubstituteClass(somSelf: TRealSOMClassMgr; origClassName, newClassName: PCORBA_char): TCORBA_long;

(*
 * New Method: _get_somInterfaceRepository
 *)

(*
 *  The Repository object that provides access to the Interface Repository,
 *  If no Interface Repository has yet been assigned to this attribute,
 *  and the SOMClassMgr is unable to load and instantiate it, the attribute
 *  will have the value NULL.  When finished using the Repository object
 *  you should release your reference using the somDestruct method with
 *  a non-zero <doFree> parameter.
 *)
const
  somMD_SOMClassMgr__get_somInterfaceRepository = '::SOMClassMgr::_get_somInterfaceRepository';

type
  somTP_SOMClassMgr__get_somInterfaceRepository = function(somSelf: TRealSOMClassMgr): TRepository; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr__get_somInterfaceRepository = somTP_SOMClassMgr__get_somInterfaceRepository;

function SOMClassMgr__get_somInterfaceRepository(somSelf: TRealSOMClassMgr): TRepository;

(*
 * New Method: _set_somInterfaceRepository
 *)

(*
 *  The Repository object that provides access to the Interface Repository,
 *  If no Interface Repository has yet been assigned to this attribute,
 *  and the SOMClassMgr is unable to load and instantiate it, the attribute
 *  will have the value NULL.  When finished using the Repository object
 *  you should release your reference using the somDestruct method with
 *  a non-zero <doFree> parameter.
 *)

const
  somMD_SOMClassMgr__set_somInterfaceRepository = '::SOMClassMgr::_set_somInterfaceRepository';

type
  somTP_SOMClassMgr__set_somInterfaceRepository = procedure(
    somSelf: TRealSOMClassMgr; somInterfaceRepository: TRepository); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr__set_somInterfaceRepository = somTP_SOMClassMgr__set_somInterfaceRepository;
procedure SOMClassMgr__set_somInterfaceRepository(somSelf: TRealSOMClassMgr;
  somInterfaceRepository: TRepository);

(*
 * New Method: _get_somRegisteredClasses
 *)

(*
 *  A list of all classes currently registered in this process.
 *)
const
  somMD_SOMClassMgr__get_somRegisteredClasses = '::SOMClassMgr::_get_somRegisteredClasses';

type
  somTP_SOMClassMgr__get_somRegisteredClasses = function(somSelf: TRealSOMClassMgr): TSOMClass_SOMClassSequence; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr__get_somRegisteredClasses = somTP_SOMClassMgr__get_somRegisteredClasses;

function SOMClassMgr__get_somRegisteredClasses(somSelf: TRealSOMClassMgr): TSOMClass_SOMClassSequence;

(*
 * New Method: somBeginPersistentClasses
 *)

(*
 *  Starts a bracket for the current thread wherein all classes
 *  that are registered are marked as permanant and cannot be
 *  unregistered or unloaded.  Persistent classes brackets may be
 *  nested.
 *)
const
  somMD_SOMClassMgr_somBeginPersistentClasses = '::SOMClassMgr::somBeginPersistentClasses';

type
  somTP_SOMClassMgr_somBeginPersistentClasses = procedure(somSelf: TRealSOMClassMgr); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somBeginPersistentClasses =
    somTP_SOMClassMgr_somBeginPersistentClasses;

procedure SOMClassMgr_somBeginPersistentClasses(somSelf: TRealSOMClassMgr);

(*
 * New Method: somEndPersistentClasses
 *)

(*
 *  Ends a persistent classes bracket for the current thread.
 *)
const
  somMD_SOMClassMgr_somEndPersistentClasses = '::SOMClassMgr::somEndPersistentClasses';

type
  somTP_SOMClassMgr_somEndPersistentClasses = procedure(somSelf: TRealSOMClassMgr); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somEndPersistentClasses = somTP_SOMClassMgr_somEndPersistentClasses;

procedure SOMClassMgr_somEndPersistentClasses(somSelf: TRealSOMClassMgr);

(*
 * New Method: somRegisterClassLibrary
 *)

(*
 *  Informs the class manager that a class library has been loaded.
 *  "libraryName" is the name associated with the file containing the
 *  implementation(s) of the class(es) in the class library.
 *  "libraryInitRtn" is the entry point of a SOMInitModule function
 *  that can be used to initialize the class library.  For platforms
 *  that have the capability to automatically invoke a library
 *  initialization function whenever a library is loaded, a call
 *  to this method should occur within the library's automatic init
 *  function.
 *)

type
 somTD_SOMInitModule = procedure(majorVersion, minorVersion: TCORBA_long; className: PCORBA_char); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}

const
  somMD_SOMClassMgr_somRegisterClassLibrary = '::SOMClassMgr::somRegisterClassLibrary';

type
  somTP_SOMClassMgr_somRegisterClassLibrary = procedure(somSelf: TRealSOMClassMgr;
    libraryName: PCORBA_char; libraryInitRtn: somTD_SOMInitModule); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somRegisterClassLibrary =
    somTP_SOMClassMgr_somRegisterClassLibrary;

procedure SOMClassMgr_somRegisterClassLibrary(somSelf: TRealSOMClassMgr;
  libraryName: PCORBA_char; libraryInitRtn: somTD_SOMInitModule);

(*
 * New Method: somJoinAffinityGroup
 *)

(*
 *  If <affClass> is a member of an affinity group, and <newClass> is not a
 *  member of any affinity group, this method adds <newClass> to the
 *  same affinity group as <affClass>.  If the method succeeds it returns
 *  TRUE, otherwise it returns FALSE.  Adding a class to an affinity group
 *  effectively equates its lifetime with that of the other members of
 *  the affinity group.
 *  [Access Group]
 *)
const
  somMD_SOMClassMgr_somJoinAffinityGroup = '::SOMClassMgr::somJoinAffinityGroup';

type
  somTP_SOMClassMgr_somJoinAffinityGroup = function(somSelf: TRealSOMClassMgr;
    newClass, affClass: TRealSOMClass): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somJoinAffinityGroup = somTP_SOMClassMgr_somJoinAffinityGroup;

function SOMClassMgr_somJoinAffinityGroup(somSelf: TRealSOMClassMgr;
  newClass, affClass: TRealSOMClass): TCORBA_boolean;

(*
 * New Method: somUnregisterClassLibrary
 *)

(*
 *  Informs the class manager that a class library has been unloaded.
 *  "libraryName" is the name associated with the file containing the
 *  implementation(s) of the class(es) in the class library.
 *  For platforms that have the capability to automatically invoke a
 *  library termination function whenever a library is unloaded, a call
 *  to this method should occur within the library's automatic
 *  termination function.
 *)
const
  somMD_SOMClassMgr_somUnregisterClassLibrary = '::SOMClassMgr::somUnregisterClassLibrary';

type
  somTP_SOMClassMgr_somUnregisterClassLibrary = procedure(somSelf: TRealSOMClassMgr;
    libraryName: PCORBA_char); {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somUnregisterClassLibrary =
    somTP_SOMClassMgr_somUnregisterClassLibrary;

procedure SOMClassMgr_somUnregisterClassLibrary(somSelf: TRealSOMClassMgr;
  libraryName: PCORBA_char);

{$endif}

{$ifdef SOM_VERSION_3}

(*
 * New Method: somImportObject
 *)

(*
 *  This method causes the local class manager to load the
 *  dlls that are required for sharing the object <objToBeShared>.
 *  The returned boolean indicates whether or not the operation succeeded.
 *  A return of FALSE (the operation failed) means that it is not safe
 *  to use the object, i.e., invoking a method on the object may lead to
 *  an exception.
 *)
const
  somMD_SOMClassMgr_somImportObject = '::SOMClassMgr::somImportObject';

type
  somTP_SOMClassMgr_somImportObject = function(somSelf: TRealSOMClassMgr;
    objToBeShared: TRealSOMObject): TCORBA_boolean; {$ifndef vpc}{$ifdef SOM_STDCALL}stdcall;{$else}cdecl;{$endif}{$endif}
  somTD_SOMClassMgr_somImportObject = somTP_SOMClassMgr_somImportObject;

function SOMClassMgr_somImportObject(somSelf: TRealSOMClassMgr;
  objToBeShared: TRealSOMObject): TCORBA_boolean;

{$endif}

/////////////// Parent methods ///////////////////////////

procedure SOMClassMgr_somInit(somSelf: TRealSOMClassMgr);
procedure SOMClassMgr_somUninit(somSelf: TRealSOMClassMgr);
procedure SOMClassMgr_somFree(somSelf: TRealSOMClassMgr);
function SOMClassMgr_somGetClass(somSelf: TRealSOMClassMgr): TRealSOMClass;
function SOMClassMgr_somGetClassName(somSelf: TRealSOMClassMgr): PCORBA_char;
function SOMClassMgr_somGetSize(somSelf: TRealSOMClassMgr): TCORBA_long;
function SOMClassMgr_somIsA(somSelf: TRealSOMClassMgr; aClassObj: TRealSOMClass): TCORBA_boolean;
function SOMClassMgr_somIsInstanceOf(somSelf: TRealSOMClassMgr; aClassObj: TRealSOMClass): TCORBA_boolean;
function SOMClassMgr_somRespondsTo(somSelf: TRealSOMClassMgr; mId: TsomId): TCORBA_boolean;
function SOMClassMgr_somPrintSelf(somSelf: TRealSOMClassMgr): TRealSOMObject;
procedure SOMClassMgr_somDumpSelf(somSelf: TRealSOMClassMgr; level: TCORBA_long);
procedure SOMClassMgr_somDumpSelfInt(somSelf: TRealSOMClassMgr; level: TCORBA_long);

{$ifdef SOM_VERSION_2}
procedure SOMClassMgr_somDefaultInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl);
procedure SOMClassMgr_somDestruct(somSelf: TRealSOMClassMgr; doFree: TCORBA_boolean; ctrl: PsomDestructCtrl);
procedure SOMClassMgr_somDefaultCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
function SOMClassMgr_somDefaultAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
procedure SOMClassMgr_somDefaultConstCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
procedure SOMClassMgr_somDefaultVCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
procedure SOMClassMgr_somDefaultConstVCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
function SOMClassMgr_somDefaultConstAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
function SOMClassMgr_somDefaultVAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
function SOMClassMgr_somDefaultConstVAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
function SOMClassMgr_somDispatch(somSelf: TRealSOMClassMgr; var retValue: TsomToken; methodId: TsomId; ap: Tva_list{array of const}): TCORBA_boolean;
function SOMClassMgr_somClassDispatch(somSelf: TRealSOMClassMgr; clsObj: TRealSOMClass; var retValue: TsomToken; methodId: TsomId; ap: tva_list{array of const}): TCORBA_boolean;
function SOMClassMgr_somCastObj(somSelf: TRealSOMClassMgr; castedCls: TRealSOMClass): TCORBA_boolean;
function SOMClassMgr_somResetObj(somSelf: TRealSOMClassMgr): TCORBA_boolean;
{$endif}

{$ifdef SOM_OBJECTS}     
type
  TSOMClassMgr           = Class(TSOMObject)
  public
    Function  somFindClsInFile(classId: TsomId; majorVersion, minorVersion: TCORBA_long; filen:PChar): TSOMClass;
    Function  somFindClass(classId: TsomId; majorVersion, minorVersion: TCORBA_long): TSOMClass;
    Function  somClassFromId(classId: TsomId): TSOMClass;
    Procedure somRegisterClass(classObj: TSOMClass);
    Function  somUnregisterClass(classObj: TSOMClass): TCORBA_long;
    Function  somLocateClassFile(classId: TsomId; majorVersion, minorVersion: TCORBA_long): PChar;
    Function  somLoadClassFile(classId: TsomId; majorVersion, minorVersion: TCORBA_long; filen:PChar): TSOMClass;
    Function  somUnloadClassFile(classObj: TSOMClass): TCORBA_long;
    Function  somGetInitFunction: PChar;
    Procedure somMergeInto(targetObj: TSOMObject);
    Function  somGetRelatedClasses(classObj: TSOMClass): SOMClassMgr_SOMClassArray;
	// SOM 2 Methods
	{$ifdef SOM_VERSION_2}
    Function  somSubstituteClass(origClassName,newClassName:PChar): TCORBA_long;
    Procedure somBeginPersistentClasses;
    Procedure somEndPersistentClasses;
    Procedure somRegisterClassLibrary(libraryName: PChar; libraryInitRtn: somTD_SOMInitModule);
    Function  somJoinAffinityGroup(newClass,affClass : TSOMClass): TCORBA_boolean;
  private
//    Function  _get_somInterfaceRepository: TRepository;
//    Procedure _set_somInterfaceRepository(somInterfaceRepository: TRepository);
    Function  _get_somRegisteredClasses: T_IDL_SEQUENCE_SOMClass;
  public
//    property somInterfaceRepository: TRepository read _get_somInterfaceRepository write _set_somInterfaceRepository;
    property somRegisteredClasses: T_IDL_SEQUENCE_SOMClass read _get_somRegisteredClasses;
	{$endif}
  public//protected
    class function InstanceClass: TRealSOMClass; override;
    class function RegisterClass: TSOMObjectClass; override;
  end;                    
{$endif}

Implementation

{$ifndef SOM_EXTVAR}
uses
  windows;
{$endif}

/////////////////////// SOMClassMgr Class ///////////////////////////

Function SOMClassMgrNewClass(majorVersion,minorVersion:TCORBA_long):TRealSOMClass; external SOMDLL name 'SOMClassMgrNewClass';

function SOMClassMgr_somLoadClassFile(somSelf: TRealSOMClassMgr; classId: TsomId;
  majorVersion, minorVersion: TCORBA_long; fileName: PCORBA_char): TRealSOMClass;
var
  mt: somTD_SOMClassMgr_somLoadClassFile;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somLoadClassFile));
  Result := mt(somSelf, classId, majorVersion, minorVersion, fileName);
end;

function SOMClassMgr_somLocateClassFile(somSelf: TRealSOMClassMgr; classId: TsomId; majorVersion, minorVersion: TCORBA_long): PCORBA_char;
var
  mt: somTD_SOMClassMgr_somLocateClassFile;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somLocateClassFile));
  Result := mt(somSelf, classId, majorVersion, minorVersion);
end;

procedure SOMClassMgr_somRegisterClass(somSelf: TRealSOMClassMgr; classObj: TRealSOMClass);
var
  mt: somTD_SOMClassMgr_somRegisterClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somRegisterClass));
  mt(somSelf, classObj);
end;

function SOMClassMgr_somUnloadClassFile(somSelf: TRealSOMClassMgr; classObj: TRealSOMClass): TCORBA_long;
var
  mt: somTD_SOMClassMgr_somUnloadClassFile;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somUnloadClassFile));
  Result := mt(somSelf, classObj);
end;

function SOMClassMgr_somUnregisterClass(somSelf: TRealSOMClassMgr; classObj: TRealSOMClass): TCORBA_long;
var
  mt: somTD_SOMClassMgr_somUnregisterClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somUnregisterClass));
  Result := mt(somSelf, classObj);
end;

function SOMClassMgr_somGetInitFunction(somSelf: TRealSOMClassMgr): PCORBA_char;
var
  mt: somTD_SOMClassMgr_somGetInitFunction;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somGetInitFunction));
  Result := mt(somSelf);
end;

function SOMClassMgr_somGetRelatedClasses(somSelf: TRealSOMClassMgr; classObj: TRealSOMClass): SOMClassMgr_SOMClassArray;
var
  mt: somTD_SOMClassMgr_somGetRelatedClasses;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somGetRelatedClasses));
  Result :=mt(somSelf, classObj);
end;

function SOMClassMgr_somClassFromId(somSelf: TRealSOMClassMgr; classId: TsomId): TRealSOMClass;
var
  mt: somTD_SOMClassMgr_somClassFromId;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somClassFromId));
  Result := mt(somSelf, classId);
end;

function SOMClassMgr_somFindClass(somSelf: TRealSOMClassMgr; classId: TsomId; majorVersion, minorVersion: TCORBA_long): TRealSOMClass;
var
  mt: somTD_SOMClassMgr_somFindClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somFindClass));
  Result := mt(somSelf, classId, majorVersion, minorVersion);
end;

function SOMClassMgr_somFindClsInFile(somSelf: TRealSOMClassMgr; classId: TsomId; majorVersion, minorVersion: TCORBA_long; fileName: PCORBA_char): TRealSOMClass;
var
  mt: somTD_SOMClassMgr_somFindClsInFile;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somFindClsInFile));
  Result := mt(somSelf, classId, majorVersion, minorVersion, fileName);
end;

procedure SOMClassMgr_somMergeInto(somSelf: TRealSOMClassMgr; targetObj: TRealSOMObject);
var
  mt: somTD_SOMClassMgr_somMergeInto;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somMergeInto));
  mt(somSelf, targetObj);
end;

{$ifdef SOM_VERSION_2}

function SOMClassMgr_somSubstituteClass(somSelf: TRealSOMClassMgr; origClassName, newClassName: PCORBA_char): TCORBA_long;
var
  mt: somTD_SOMClassMgr_somSubstituteClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somSubstituteClass));
  Result := mt(somSelf, origClassName, newClassName);
end;

function SOMClassMgr__get_somInterfaceRepository(somSelf: TRealSOMClassMgr): TRepository;
var
  mt: somTD_SOMClassMgr__get_somInterfaceRepository;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData._get_somInterfaceRepository));
  Result := mt(somSelf);
end;

procedure SOMClassMgr__set_somInterfaceRepository(somSelf: TRealSOMClassMgr; somInterfaceRepository: TRepository);
var
  mt: somTD_SOMClassMgr__set_somInterfaceRepository;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData._set_somInterfaceRepository));
  mt(somSelf, somInterfaceRepository);
end;

function SOMClassMgr__get_somRegisteredClasses(somSelf: TRealSOMClassMgr): TSOMClass_SOMClassSequence; 
var
  mt: somTP_SOMClassMgr__get_somRegisteredClasses;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData._get_somRegisteredClasses));
  Result:=mt(somSelf);
end;

procedure SOMClassMgr_somBeginPersistentClasses(somSelf: TRealSOMClassMgr);
var
  mt: somTD_SOMClassMgr_somBeginPersistentClasses;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somBeginPersistentClasses));
  mt(somSelf);
end;

procedure SOMClassMgr_somEndPersistentClasses(somSelf: TRealSOMClassMgr);
var
  mt: somTD_SOMClassMgr_somEndPersistentClasses;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somEndPersistentClasses));
  mt(somSelf);
end;

procedure SOMClassMgr_somRegisterClassLibrary(somSelf: TRealSOMClassMgr;
  libraryName: PCORBA_char; libraryInitRtn: somTD_SOMInitModule);
var
  mt: somTD_SOMClassMgr_somRegisterClassLibrary;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somRegisterClassLibrary));
  mt(somSelf, libraryName, libraryInitRtn);
end;

function SOMClassMgr_somJoinAffinityGroup(somSelf: TRealSOMClassMgr; newClass, affClass: TRealSOMClass): TCORBA_boolean;
var
  mt: somTD_SOMClassMgr_somJoinAffinityGroup;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somJoinAffinityGroup));
  Result := mt(somSelf, newClass, affClass);
end;


procedure SOMClassMgr_somUnregisterClassLibrary(somSelf: TRealSOMClassMgr; libraryName: PCORBA_char);
var
  mt: somTD_SOMClassMgr_somUnregisterClassLibrary;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somUnregisterClassLibrary));
  mt(somSelf, libraryName);
end;

{$endif}

{$ifdef SOM_VERSION_3}

function SOMClassMgr_somImportObject(somSelf: TRealSOMClassMgr; objToBeShared: TRealSOMObject): TCORBA_boolean;
var
  mt: somTD_SOMClassMgr_somImportObject;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  {$ifdef fpc}TsomMethodProc(mt):={$else}@mt:=Pointer{$endif}(SOM_Resolve(somSelf, SOMClassMgrClassData.classObject, SOMClassMgrClassData.somImportObject));
  Result := mt(somSelf, objToBeShared);
end;

{$endif}

////////////// SOMClassMgr parent methods ////////////////////////////////////

procedure SOMClassMgr_somInit(somSelf: TRealSOMClassMgr);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somInit(somSelf);
end;

procedure SOMClassMgr_somUninit(somSelf: TRealSOMClassMgr);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somUninit(somSelf);
end;

procedure SOMClassMgr_somFree(somSelf: TRealSOMClassMgr);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somFree(somSelf);
end;

function SOMClassMgr_somGetClass(somSelf: TRealSOMClassMgr): TRealSOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somGetClass(somSelf);
end;

function SOMClassMgr_somGetClassName(somSelf: TRealSOMClassMgr): PCORBA_char;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somGetClassName(somSelf);
end;

function SOMClassMgr_somGetSize(somSelf: TRealSOMClassMgr): TCORBA_long;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somGetSize(somSelf);
end;

function SOMClassMgr_somIsA(somSelf: TRealSOMClassMgr; aClassObj: TRealSOMClass): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMClassMgr_somIsA(somSelf, aClassObj);
end;

function SOMClassMgr_somIsInstanceOf(somSelf: TRealSOMClassMgr; aClassObj: TRealSOMClass): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somIsInstanceOf(somSelf, aClassObj);
end;

function SOMClassMgr_somRespondsTo(somSelf: TRealSOMClassMgr; mId: TsomId): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somRespondsTo(somSelf, mId);
end;

function SOMClassMgr_somPrintSelf(somSelf: TRealSOMClassMgr): TRealSOMObject;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somPrintSelf(somSelf);
end;

procedure SOMClassMgr_somDumpSelf(somSelf: TRealSOMClassMgr; level: TCORBA_long);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDumpSelf(somSelf, level);
end;

procedure SOMClassMgr_somDumpSelfInt(somSelf: TRealSOMClassMgr; level: TCORBA_long);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDumpSelfInt(somSelf, level);
end;

{$ifdef SOM_VERSION_2}

procedure SOMClassMgr_somDefaultInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDefaultInit(somSelf, ctrl);
end;


procedure SOMClassMgr_somDestruct(somSelf: TRealSOMClassMgr; doFree: TCORBA_boolean; ctrl: PsomDestructCtrl);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDestruct(somSelf, doFree, ctrl);
end;

procedure SOMClassMgr_somDefaultCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDefaultCopyInit(somSelf, ctrl, fromObj);
end;

function SOMClassMgr_somDefaultAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somDefaultAssign(somSelf, ctrl, fromObj);
end;

procedure SOMClassMgr_somDefaultConstCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDefaultConstCopyInit(somSelf, ctrl, fromObj);
end;

procedure SOMClassMgr_somDefaultVCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDefaultVCopyInit(somSelf, ctrl, fromObj);
end;

procedure SOMClassMgr_somDefaultConstVCopyInit(somSelf: TRealSOMClassMgr; ctrl: PsomInitCtrl; fromObj: TRealSOMObject);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMObject_somDefaultConstVCopyInit(somSelf, ctrl, fromObj);
end;

function SOMClassMgr_somDefaultConstAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somDefaultConstAssign(somSelf, ctrl, fromObj);
end;

function SOMClassMgr_somDefaultVAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somDefaultVAssign(somSelf, ctrl, fromObj);
end;

function SOMClassMgr_somDefaultConstVAssign(somSelf: TRealSOMClassMgr; ctrl: PsomAssignCtrl; fromObj: TRealSOMObject): TRealSOMObject;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somDefaultConstVAssign(somSelf, ctrl, fromObj);
end;

function SOMClassMgr_somDispatch(somSelf: TRealSOMClassMgr; var retValue: TsomToken; methodId: TsomId; ap: Tva_list{array of const}): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somDispatch(somSelf, retValue, methodId, ap);
end;

function SOMClassMgr_somClassDispatch(somSelf: TRealSOMClassMgr; clsObj: TRealSOMClass; var retValue: TsomToken; methodId: TsomId; ap: tva_list{array of const}): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somClassDispatch(somSelf, clsObj, retValue, methodId, ap);
end;

function SOMClassMgr_somCastObj(somSelf: TRealSOMClassMgr; castedCls: TRealSOMClass): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somCastObj(somSelf, castedCls);
end;

function SOMClassMgr_somResetObj(somSelf: TRealSOMClassMgr): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In '+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result:=SOMObject_somResetObj(somSelf);
end;

{$endif}

{$ifdef SOM_OBJECTS}     

const
  RSOMClassMgr          : VPSOMRECORD = (
    VPCls               : TSOMClassMgr;
    SOMCls              : @SOMClassMgrClassData);

class function TSOMClassMgr.InstanceClass: TRealSOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgrClassData.classObject;
end;

class function TSOMClassMgr.RegisterClass: TSOMObjectClass;
const
  firsttime     : Boolean       = True;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  if (SOMClassMgrClassData.classObject=nil)or firsttime then begin
    firsttime := false;
    inherited RegisterClass;
    if (SOMClassMgrClassData.classObject=nil) then SOMClassMgrNewClass(SOMClassMgr_MajorVersion,SOMClassMgr_MinorVersion);
    CastClass(SOMClassMgrClassData.classObject, TSOMClass.RegisterClass);   // SOM Metaclass is SOMClass
  end;
  RegisterVPClass(RSOMClassMgr);
  Result := TSOMObjectClass(TSOMClassMgr);
end;

Function TSOMClassMgr.somLoadClassFile(classId: TsomId; majorVersion,minorVersion: TCORBA_long; filen:PChar): TSOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := ResolveClass(SOMClassMgr_somLoadClassFile(somSelf,classId,majorVersion,minorVersion,filen)) as TSOMClass;
end;

Function TSOMClassMgr.somLocateClassFile(classId: TsomId; majorVersion, minorVersion: TCORBA_long): PChar;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somLocateClassFile(somSelf,classId,majorVersion,minorVersion);
end;

Procedure TSOMClassMgr.somRegisterClass(classObj: TSOMClass);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMClassMgr_somRegisterClass(somSelf,classObj.somSelf);
end;

Procedure TSOMClassMgr.somRegisterClassLibrary(libraryName:PChar; libraryInitRtn: somTD_SOMInitModule);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMClassMgr_somRegisterClassLibrary(somSelf,libraryName, libraryInitRtn);
end;

Function TSOMClassMgr.somUnloadClassFile(classObj: TSOMClass): TCORBA_long;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somUnloadClassFile(somSelf,classObj.somSelf);
end;

Function TSOMClassMgr.somUnregisterClass(classObj: TSOMClass): TCORBA_long;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somUnregisterClass(somSelf,classObj.somSelf);
end;

Procedure TSOMClassMgr.somBeginPersistentClasses;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMClassMgr_somBeginPersistentClasses(somSelf);
end;

Procedure TSOMClassMgr.somEndPersistentClasses;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMClassMgr_somEndPersistentClasses(somSelf);
end;

Function TSOMClassMgr.somJoinAffinityGroup(newClass,affClass: TSOMClass): TCORBA_boolean;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somJoinAffinityGroup(somSelf,newClass.somSelf,affClass.somSelf);
end;

Function TSOMClassMgr.somGetInitFunction: PChar;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somGetInitFunction(somSelf);
end;

Function TSOMClassMgr.somGetRelatedClasses(classObj: TSOMClass):SOMClassMgr_SOMClassArray;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somGetRelatedClasses(somSelf,classObj.somSelf);
end;

Function TSOMClassMgr.somClassFromId(classId: TsomId): TSOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := ResolveClass(SOMClassMgr_somClassFromId(somSelf,classId)) as TSOMClass;
end;

Function TSOMClassMgr.somFindClass(classId: TsomId; majorVersion,minorVersion: TCORBA_long): TSOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := ResolveClass(SOMClassMgr_somFindClass(somSelf,classId,majorVersion,minorVersion)) as TSOMClass;
end;

Function TSOMClassMgr.somFindClsInFile(classId: TsomId; majorVersion,minorVersion: TCORBA_long;filen:PChar): TSOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := ResolveClass(SOMClassMgr_somFindClsInFile(somSelf,classId,majorVersion,minorVersion,filen)) as TSOMClass;
end;

Procedure TSOMClassMgr.somMergeInto(targetObj: TSOMObject);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMClassMgr_somMergeInto(somSelf,targetObj.somSelf);
end;

Function TSOMClassMgr.somSubstituteClass(origClassName,newClassName:PChar): TCORBA_long;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr_somSubstituteClass(somSelf,origClassName,newClassName);
end;

(*
Function TSOMClassMgr._get_somInterfaceRepository: TRepository;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := ResolveClass(SOMClassMgr__get_somInterfaceRepository(somSelf)) as TRepository;
end;

Procedure TSOMClassMgr._set_somInterfaceRepository(somInterfaceRepository: TRepository);
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  SOMClassMgr__set_somInterfaceRepository(somSelf,somInterfaceRepository.somSelf);
end;
*)
Function TSOMClassMgr._get_somRegisteredClasses: T_IDL_SEQUENCE_SOMClass;
begin
    {$ifdef SOM_DEBUG}
    if SOM_TraceLevel>1 then somPrintf('"'+{$I %FILE%}+'": '+{$I %LINE%}+':'#9'In TSOMClassMgr.'+{$I %CURRENTROUTINE%}+#13#10);
    {$endif}
  Result := SOMClassMgr__get_somRegisteredClasses(somSelf);
end;
{$endif}

{$ifndef SOM_EXTVAR}
var
  hLib1: THandle;
{$endif}
Begin
{$ifndef SOM_EXTVAR}
  hLib1 := LoadLibrary(SOMDLL);
  SOMClassMgrClassDataPtr := GetProcAddress(hLib1, 'SOMClassMgrClassData');
  SOMClassMgrClassData:=SOMClassMgrClassDataPtr^;
  FreeLibrary(hLib1);
{$else}  
  SOMClassMgrClassDataPtr := @SOMClassMgrClassData;
{$endif}
  RegisterVPClass(RSOMClassMgr);
End.
