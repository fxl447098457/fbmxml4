#include once "minixml.bi"
#include once "minixml-tools.bi" ' <-- Load/SaveXMLFile, LoadSavewXMLMemory, NodeTypeAsString
chdir exepath()
#Ifndef __fb_64_bit__
#libpath "lib/win32"
#libpath "lib/win64"
#endif
var root = LoadXMLFile("test.xml")
If root=0 Then
  print "error: LoadXMLFile() !"
  beep: sleep : end
end if

print "type    : " & NodeTypeAsString(mxmlGetType(root))
print "refCount: " & mxmlGetRefCount(root)
mxmlRelease(root)
print "refCount: " & mxmlGetRefCount(root)
sleep

