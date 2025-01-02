{$I som.inc}

uses som, somobj, somcls, somcm, math;

{$ifdef virtualpascal}
procedure Assert(s: boolean; msg: String);
begin
  If not s then
  begin
    WriteLn('Assertion failed: ', msg);
    Halt;
  end;
end;
{$endif}

{$ifdef ver90}
procedure Assert(s: boolean; msg: String);
begin
  If not s then
  begin
    WriteLn('Assertion failed: ', msg);
    Halt;
  end;
end;
{$endif}

Procedure TestTypes;
begin
  WriteLn('Testing types');

  WriteLn('TCORBA_short max: ', High(TCORBA_short)); 
  WriteLn('TCORBA_short min: ', Low(TCORBA_short)); 
  WriteLn('TCORBA_short size: ', SizeOf(TCORBA_short));

  WriteLn('TCORBA_long max: ', High(TCORBA_long)); 
  WriteLn('TCORBA_long min: ', Low(TCORBA_long));
  WriteLn('TCORBA_long size: ', SizeOf(TCORBA_long));

  WriteLn('TCORBA_unsigned_short max: ', High(TCORBA_unsigned_short)); 
  WriteLn('TCORBA_unsigned_short min: ', Low(TCORBA_unsigned_short));
  WriteLn('TCORBA_unsigned_short size: ', SizeOf(TCORBA_unsigned_short));

  WriteLn('TCORBA_unsigned_long max: ', High(TCORBA_unsigned_long)); 
  WriteLn('TCORBA_unsigned_long min: ', Low(TCORBA_unsigned_long)); 
  WriteLn('TCORBA_unsigned_long size: ', SizeOf(TCORBA_unsigned_long));

{$ifdef SOM_LONG_LONG}
  WriteLn('TCORBA_long_long max: ', High(TCORBA_long_long)); 
  WriteLn('TCORBA_long_long min: ', Low(TCORBA_long_long)); 
  WriteLn('TCORBA_long_long size: ', SizeOf(TCORBA_long_long));

  WriteLn('TCORBA_unsigned_long_long max: ', High(TCORBA_unsigned_long_long));
  WriteLn('TCORBA_unsigned_long_long min: ', Low(TCORBA_unsigned_long_long));
  WriteLn('TCORBA_unsigned_long_long size: ', SizeOf(TCORBA_unsigned_long_long));
{$endif}

  WriteLn('TCORBA_float size: ', SizeOf(TCORBA_float));
  WriteLn('TCORBA_double size: ', SizeOf(TCORBA_double));
  WriteLn('TCORBA_long_double size:', SizeOf(TCORBA_long_double));

  WriteLn('TCORBA_char size: ', SizeOf(TCORBA_char));
  WriteLn('TCORBA_octet size: ', SizeOf(TCORBA_octet));
end;

var
  clsmgr: TRealSOMObject;
  tstobj: TRealSOMObject;
  tst: somTD_SOMObject_somDumpSelf;
  a: TSOMClass_SOMClassSequence;
  i: integer;
  m: somTD_SOMObject_somPrintSelf;
  buf : byte;
{$ifdef SOM_OBJECTS}
  cmo: TSOMObject;
{$endif}
  p: pointer;
begin
  // Disable buffering...
  SetTextBuf(Output,buf,sizeof(buf));

  TestTypes;

  Flush(Output);

  // Try var args function
  somPrintf('somPrintf test: %d %s'#13#10, {$ifndef SOM_VARARGS}[{$endif}123, 'string'{$ifndef SOM_VARARGS}]{$endif});

  somPrintf('Test trace level control support'#13#10);
  SOM_TraceLevelPtr^:=2;
  SOM_WarnLevelPtr^:=2;
  SOM_AssertLevelPtr^:=2;

  somPrintf('Init SOM runtime'#13#10);
  clsmgr:=somEnvironmentNew;

  // Dump some variables
  somPrintf('SOM API Version: %d.%d'#13#10, SOM_MajorVersion, SOM_MinorVersion);
  somPrintf('SOM MaxThreads: %d'#13#10, SOM_MaxThreads);

  // Check two variables (must be same)
  somPrintf('SOMClassMgr=0X%08X'#13#10, longint(clsmgr));
  somPrintf('SOMClassMgr=0X%08X'#13#10, longint(SOMClassMgrObject));
  somPrintf('SOMClassMgrObject.somPrintSelf'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  SOMObject_somPrintSelf(SOMClassMgrObject);

  somPrintf('Try to resolve SOMClassManager operation by name'#13#10);
  somTD_SOMObject_somPrintSelf(somResolveByName(clsmgr, 'somPrintSelf'))(clsmgr);

  somPrintf('Try to resolve SOMClassManager operation by somMToken'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  somPrintf('SOMClassMgr.somDumpSelf'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  {$ifdef fpc}TsomMethodProc(tst):={$else}@tst:=Pointer{$endif}(SOM_Resolve(clsmgr, SOMObjectClassData.classObject, SOMObjectClassData.somDumpSelf));
  tst(clsmgr, 0);
  somPrintf('Try to resolve SOMClassManager operation by procedural-style bindings'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  SOMObject_somPrintSelf(clsmgr); {This is direct call of parent code}
  SOMClassMgr_somPrintSelf(clsmgr); {This is parent call via wrapper}
  somPrintf('Dump SOMClassMgr instance'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  SOMClassMgr_somDumpSelf(SOMClassMgrObject, 0); {This is parent call via wrapper}
  somPrintf('Now Dump SOMClassMgr class to know _get_somRegisteredClasses method address'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  SOMClass_somDumpSelf(SOMClassMgr_somGetClass(SOMClassMgrObject), 0);  {Dump class data}
  somPrintf('Try to get method and print address'#13#10);
  somPrintf('0X%8d'#13#10, longint(SOMResolveByName(SOMClassMgrObject, '_get_somRegisteredClasses')));
  somPrintf('And try exec via mapping'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  a:=SOMClassMgr__get_somRegisteredClasses(SOMClassMgrObject);
  // Aaaand...  Trap under Linux... cdecl struct return problem???
  // Dump sequence info
  somPrintf('%d'#13#10, a._maximum);
  somPrintf('%d'#13#10, a._length);
  For I:=0 to Pred(a._length) do
  begin
    somPrintf('0X%08X'#13#10, longint(a._buffer[i]));
{
    p:=a._buffer[i];
    Dec(Cardinal(p), 4);
    somPrintf('0X%08X'#13#10, PCardinal(Cardinal(p))^);
    Dec(Cardinal(p), 4);
    somPrintf('0X%08X'#13#10, PCardinal(Cardinal(p))^);
}
    SOMObject_somDumpSelf(a._buffer[i], 0);
  end;
//exit;
  somPrintf('test create SOMObject'#13#10);
//  SOMObjectNewClass(SOMObject_MajorVersion,SOMObject_MinorVersion);
  tstobj:=SOMClass_somNewNoInit(SOMObjectClassData.classObject);
  somObject_somInit(tstobj);
  somObject_somDumpSelf(tstobj, 0);
  somPrintf('test destroy SOMObject'#13#10);
  somObject_somUnInit(tstobj);
  SOMObject_somFree(tstobj);

{$IFDEF SOM_OBJECTS}
  somPrintf('test create TSOMObject'#13#10);
  cmo:=TSOMObject.Create;
  somPrintf('dump TSOMObject'#13#10);
  cmo.somDumpSelf(0);
//  somPrintf('0X%08X'#13#10, longint(cmo));
//  somPrintf('0X%08X'#13#10, longint(TSOMObject));
//  somPrintf('0X%08X'#13#10, longint(cmo.somGetClass));
  cmo.somGetClass.somPrintSelf;
  somPrintf('test destroy TSOMObject'#13#10);
  cmo.Destroy;


  somPrintf('test object pascal...'#13#10);
  cmo:=TSOMObject.Create;
  SOMClassMgr_somDumpSelf(SOMClassMgrObject, 0);
  cmo.somDumpSelf(0);
  cmo.somDumpSelfInt(0);
  somPrintf('testing GetClass and type casting'#13#10);
  cmo.somGetClass.somPrintSelf;
  cmo.Destroy;
{$endif}

  somPrintf('Shutdown SOM runtime'#13#10);
//  somEnvironmentEnd;
  somPrintf('Finished'#13#10);
end.
