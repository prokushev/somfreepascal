# somFree Pascal Language Mapping

Tested compiler: Free Pascal Compiler 3.2.2, Borland Delphi 2, Borland Delphi 6, Virtual Pascal Compiler 2

Tested platforms: Win32, Linux

Tested SOM: SOM 2.1, SOM 3.0, somFree

Virtual Pascal support limited in variadic functions. _May be_ will be added support
in future verions via array of const.


Some CORBA memory management functions are implemented, such as:

CORBA_T_alloc
CORBA_free
CORBA_T_set_release
CORBA_T_get_release


CORBA::LocalObject is mostly just SOMObject... Not supported yet.

