Unknown place yet...

(* -- For building lists of class objects *)
  PsomClasses            =^TsomClassList;
  TsomClassList          = record
    cls                 : TRealSOMClass;
    next                : PsomClasses;
  end;

(* -- For building lists of objects *)
  PsomObjects            =^TsomObjectList;
  TsomObjectList         = record
    obj                 : TRealSOMObject;
    next                : PsomObjects;
  end;

type
  NamedValue            =record
    name                : Identifier;
    argument            : TCORBA_any;
    len                 : Longint;
    arg_modes           : TFlags;
  end;

(*----------------------------------------------------------------------
 *  Typedefs for pointers to functions
 *)

  Contained_Description         = record
    name                        : Identifier;
    value                       : TCORBA_any;
  end;

  InterfaceDef_FullInterfaceDescription = record
    name                : Identifier;
    id, defined_in      : RepositoryId;
    {operation           : IDL_SEQUENCE_OperationDef_OperationDescription;
    attributes          : IDL_SEQUENCE_AttributeDef_AttributeDescription;}
  end;

  InterfaceDef_InterfaceDescription = record
    name                : Identifier;
    id, defined_in      : RepositoryId;
  end;

type
  RepositoryId                = PCORBA_char;

  ImplId                      = ^PCORBA_char;
  AttributeDef_AttributeMode  = Cardinal;
  OperationDef_OperationMode  = Longint;
  ParameterDef_ParameterMode  = Cardinal;


  Identifier            = PChar;         (* CORBA 7.5.1, p. 129 *)

type
  ReferenceData         =_IDL_SEQUENCE_octet;
