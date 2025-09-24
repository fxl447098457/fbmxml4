
#include once "minixml.bi"
#include once "minixml-tools.bi" ' <-- Load/SaveXMLFile, LoadSaveXMLMemory, NodeTypeAsString
#Ifndef __fb_64_bit__
#libpath "lib/win32"
#else
#libpath "lib/win64"
#endif

' shared variable for text combiantion
Dim Shared currentElementText As String
Dim Shared insideElement As Integer
currentElementText = ""
insideElement = 0

Sub parseELEMENT(ByVal node As mxml_node_t Ptr)
  ' print if combined element text exists
  If currentElementText <> "" Then
    Print "value.text.string " & currentElementText
    currentElementText = ""
  End If
  
  Print "value.element.name " & *node->value.element.name
  If node->value.element.num_attrs>0 then
    For i As Long=0 To node->value.element.num_attrs-1
      Print "  attrs[" & i & "].name  = " & *node->value.element.attrs[i].name
      Print "  attrs[" & i & "].value = " & *node->value.element.attrs[i].value
    Next
  End If
  
  insideElement = 1 
End Sub

Sub parseTEXT(ByVal node As mxml_node_t Ptr)
  If node->value.text.string AndAlso Len(*node->value.text.string) Then
    If insideElement = 1 Then
      If currentElementText <> "" Then currentElementText &= " "
      currentElementText &= *node->value.text.string
    Else
      Print "value.text.string " & *node->value.text.string
    End If
  End If
End Sub

Sub ParseNode(ByVal node As mxml_node_t Ptr)
  If node=NULL then Return
  
  Select Case node->type
    Case MXML_TYPE_IGNORE : Print !"\nMXML_IGNORE"
    Case MXML_TYPE_CDATA    : Print !"\nCDATA:" & *mxmlGetCDATA(node)
    Case MXML_TYPE_COMMENT     : Print !"\nCOMMENT:"& *mxmlGetComment(node)
    Case MXML_TYPE_DECLARATION   : Print !"\nDeclarATION" & *mxmlGetDeclaration(node)
    Case MXML_TYPE_DIRECTIVE   : Print !"\ndirective:"&*mxmlGetDirective(node)
    Case MXML_TYPE_ELEMENT : parseELEMENT(node)
    Case MXML_TYPE_INTEGER : Print !"\nMXML_INTEGER" &mxmlGetInteger(node)
    Case MXML_TYPE_OPAQUE  : Print !"\nMXML_OPAQUE" &*mxmlGetOpaque(node)
    Case MXML_TYPE_REAL    : Print !"\nMXML_REAL"   &mxmlGetReal(node)
    Case MXML_TYPE_TEXT    : parseTEXT(node)
    Case MXML_TYPE_CUSTOM  : Print !"\nMXML_CUSTOM"
    Case Else
      Print "unknow node type !"
      Beep: Sleep: End 1
  End Select

  var Child = mxmlGetFirstChild(node)
  While Child
    ParseNode(Child)
    Child = mxmlGetNextSibling(Child)  
  Wend

  If node->type = MXML_TYPE_ELEMENT Then
    If currentElementText <> "" Then
      Print "value.text.string " & currentElementText
      currentElementText = ""
    End If
    insideElement = 0  
  End If
End Sub

ChDir exepath()
var root = LoadXMLFile("test.xml")
If root=NULL then
  Print "error: LoadXMLFile() !"
  Beep: Sleep: End
End If
ParseNode(root)
mxmlRelease(root)
Sleep