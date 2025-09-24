#ifndef __MINIXML_TOOLS_BI__
#define __MINIXML_TOOLS_BI__

#ifndef MXML_H 
  #include once "minixml.bi"
#endif

' load node from memory (refcount is saet to 1)
function LoadXMLMemory(byval buffer as ubyte ptr,byval parent as mxml_node_t ptr=null) as mxml_node_t ptr
  if buffer=0 then return 0
  return mxmlLoadString(parent,null,buffer)
end function

' load node from file (refcount is saet to 1)
function LoadXMLFile(fileName as string,byval parent as mxml_node_t ptr=null) as mxml_node_t ptr
  var hFile = FreeFile()
  if open(fileName,for binary,access read,as #hFile)<>0 then return 0
  var nBytes = LOF(hFile)
  dim as ubyte ptr buffer = allocate(nBytes+1) ' alloc one byte more "\0"
  get #hFile,,*buffer,nBytes
  close #hFile
  buffer[nBytes]=0
  var node = LoadXMLMemory(buffer,parent)
  deallocate buffer
  return node
end function

' save node to memory (use Free() for deallocation)
function SaveXMLMemory(byval node as mxml_node_t ptr,byref nBytes as long) as ubyte ptr
  nBytes=0 : if node=0 then return 0
  dim as zstring ptr buffer = mxmlSaveAllocString(node,null)
  if buffer=0 then return 0
  nBytes=len(*buffer)
  return buffer
end function

function SaveXMLFile(fileName as string,byval node as mxml_node_t ptr) as long
  if node=0 then return 0
  dim as long nBytes
  ' save/create XML document in memory
  var buffer = SaveXMLMemory(node,nBytes)
  if buffer=0 then return 0
  var hFile = FreeFile()
  if open(fileName,for binary,access write,as #hFile)<>0 then 
    free(buffer) : return 0
  end if
  put #hFile,,*buffer,nBytes
  close #hFile
  free(buffer)
  return nBytes
end function

function NodeTypeAsString(typ as mxml_type_t) as string
   select case as const typ
      case MXML_TYPE_IGNORE    : return "(-1)ignore type"
      case MXML_TYPE_CDATA    :return "(0)CDATA"
      case MXML_TYPE_COMMENT     : return "(1)COMMENT"
      case  MXML_TYPE_DECLARATION   :return "(2)DeclarATION"
     case  MXML_TYPE_DIRECTIVE   :return "(3)directive"
     case MXML_TYPE_ELEMENT    : return "(4) ELEMENT"   
  case MXML_TYPE_INTEGER   : return "(5) INTEGER"
  case MXML_TYPE_OPAQUE    : return "(6) OPAQUE"
  case MXML_TYPE_REAL    : return "(7) REAL"
  case MXML_TYPE_TEXT    : return "(8) TEXT"
  case MXML_TYPE_CUSTOM  : return "(9) CUSTOM"
  case else         : return "(" & typ & ") UNKNOW !"
  end select
end function

#endif ' __MINIXML_TOOLS_BI__
