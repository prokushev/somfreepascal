{$I som.inc}

uses sysutils, som, somobj, somcls, somcm, math;

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

var
  clsmgr: TRealSOMObject;
  tst: somTD_SOMObject_somDumpSelf;
  a: TSOMClass_SOMClassSequence;
  i: integer;
//  cmo: TSOMObject;
  m: somTD_SOMObject_somPrintSelf;
  buf : byte;
begin
  // Disable buffering...
  SetTextBuf(Output,buf,sizeof(buf));
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
//  Assert(SizeOf(TCORBA_long_double)=8, 'TCORBA_long_double size');

  WriteLn('TCORBA_char size: ', SizeOf(TCORBA_char));
  WriteLn('TCORBA_octet size: ', SizeOf(TCORBA_octet));

  WriteLn('Test trace level control support');
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
  Flush(Output);
  // Try var args function
  somPrintf('somPrintf test: %d %s'#13#10, {$ifndef SOM_VARARGS}[{$endif}123, 'string'{$ifndef SOM_VARARGS}]{$endif});
  somPrintf('SOMClassMgrObject.somPrintSelf'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  SOMObject_somPrintSelf(SOMClassMgrObject);
  // Try to resolve SOMClassManager operation by name
//  somTD_SOMObject_somPrintSelf(somResolveByName(clsmgr, 'somPrintSelf'))(clsmgr);

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
//  somPrintf('Try to get method and print address');
//  WriteLn(Inttohex(longint(SOMResolveByName(SOMClassMgrObject, '_get_somRegisteredClasses')),8));
  somPrintf('And try exec via mapping'#13#10 {$ifndef SOM_VARARGS}, [nil]{$endif});
  a:=SOMClassMgr__get_somRegisteredClasses(SOMClassMgrObject);
  // Dump sequence info
  somPrintf('%d'#13#10, a._maximum);
  somPrintf('%d'#13#10, a._length);
  For I:=0 to Pred(a._length) do
  begin
    somPrintf('%s'#13#10, PChar(IntToHex(longint(a._buffer[i]), 8)));
    SOMObject_somDumpSelf(a._buffer[i], 0);
  end;
exit;

  // Try via Pascal class
{  WriteLn('test object pascal...');
  cmo:=TSOMObject.Create;
  cmo.somDumpSelf(0);
  cmo.somDumpSelfInt(0);
  WriteLn('test casting...');
  cmo.somPrintSelf.somDumpSelf(0);
  cmo.somFree;}
  somEnvironmentEnd;
end.
