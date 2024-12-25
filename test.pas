{$ifdef fpc}
{$mode objfpc}
{$endif}

{$H+}
{$X+}

uses sysutils, som, somobj, somcls, somcm;


var
  clsmgr: TRealSOMObject;
  tst: somTD_SOMObject_somDumpSelf;
  a: _IDL_SEQUENCE_SOMClass;
  i: integer;
//  cmo: TSOMObject;
  m: somTD_SOMObject_somPrintSelf;
begin
  writeln('hi');
  // Turn on all debug info
  SOM_TraceLevelPtr^:=2;
  SOM_WarnLevelPtr^:=2;
  SOM_AssertLevelPtr^:=2;

  clsmgr:=somEnvironmentNew;
  // Dump some variables
  WriteLn('SOM API Version: ', SOM_MajorVersion, '.', SOM_MinorVersion);
  WriteLn('SOM MaxThreads: ', SOM_MaxThreads);

  // Check two variables (must be same)
  WriteLn('SOMClassMgr=', inttohex(longint(clsmgr),8));
  WriteLn('SOMClassMgr=', inttohex(longint(SOMClassMgrObject),8));

  // Try var args function
  //somPrintf('somPrintf test: %d %s'#13#10, [123, 'string']);
  SOMObject_somPrintSelf(SOMClassMgrObject);
  // Try to resolve SOMClassManager operation by name
//  somTD_SOMObject_somPrintSelf(somResolveByName(clsmgr, 'somPrintSelf'))(clsmgr);

  // Try to resolve SOMClassManager operation by somMToken
//  tst:=somTD_SOMObject_somDumpSelf(SOM_Resolve(clsmgr, SOMObjectClassData.classObject, SOMObjectClassData.somDumpSelf));
//  tst(clsmgr, 0);
(*
  // Try to resolve SOMClassManager operation by procedural-style bindings
  SOMObject_somPrintSelf(clsmgr); {This is direct call of parent code}
  SOMClassMgr_somPrintSelf(clsmgr); {This is parent call via wrapper}
  // Dump SOMClassMgr instance
  SOMClassMgr_somDumpSelf(SOMClassMgrObject, 0); {This is parent call via wrapper}
  // Now Dump SOMClassMgr class to know _get_somRegisteredClasses method address
  SOMClass_somDumpSelf(SOMClassMgr_somGetClass(SOMClassMgrObject), 0);  {Dump class data}
  // Try to get method and print address
  WriteLn(Inttohex(longint(SOMResolveByName(SOMClassMgrObject, '_get_somRegisteredClasses')),8));
  // And try exec via mapping
  a:=SOMClassMgr__get_somRegisteredClasses(SOMClassMgrObject);
  // Dump sequence info
  WriteLn(a._maximum);
  WriteLn(a._length);
  For I:=0 to Pred(a._length) do
  begin
    WriteLn(IntToHex(longint(a._buffer[i]), 8));
    SOMObject_somDumpSelf(a._buffer[i], 0);
  end;
*)
(*
  // Try via Pascal class
  WriteLn('test object pascal...');
  cmo:=TSOMObject.Create;
  cmo.somDumpSelf(0);
  cmo.somDumpSelfInt(0);
  WriteLn('test casting...');
  cmo.somPrintSelf.somDumpSelf(0);
  cmo.somFree;
  writeln(4);*)
end.
