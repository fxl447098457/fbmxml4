#pragma once
#define MXML_H
#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "crt/string.bi"
#include once "crt/stdarg.bi"
#include once "crt/ctype.bi"
#include once "crt/stdint.bi"
#include once "crt/errno.bi"
#include once "crt/limits.bi"
#include once "crt/locale.bi"
#inclib "mxml4"
#inclib "pthread"
extern "C"

type bool as byte
#define MXML_VERSION "Mini-XML v4.0.4"
#define inline
const HAVE_PTHREAD_H = 1
const MXML_MAJOR_VERSION = 4
const MXML_MINOR_VERSION = 0

type mxml_add_e as long
enum
   MXML_ADD_BEFORE
   MXML_ADD_AFTER
end enum

type mxml_add_t as mxml_add_e

type mxml_descend_e as long
enum
   MXML_DESCEND_FIRST = -1
   MXML_DESCEND_NONE = 0
   MXML_DESCEND_ALL = 1
end enum

type mxml_descend_t as mxml_descend_e

type mxml_sax_event_e as long
enum
   MXML_SAX_EVENT_CDATA
   MXML_SAX_EVENT_COMMENT
   MXML_SAX_EVENT_DATA
   MXML_SAX_EVENT_DECLARATION
   MXML_SAX_EVENT_DIRECTIVE
   MXML_SAX_EVENT_ELEMENT_CLOSE
   MXML_SAX_EVENT_ELEMENT_OPEN
end enum

type mxml_sax_event_t as mxml_sax_event_e

type mxml_type_e as long
enum
   MXML_TYPE_IGNORE = -1
   MXML_TYPE_CDATA
   MXML_TYPE_COMMENT
   MXML_TYPE_DECLARATION
   MXML_TYPE_DIRECTIVE
   MXML_TYPE_ELEMENT
   MXML_TYPE_INTEGER
   MXML_TYPE_OPAQUE
   MXML_TYPE_REAL
   MXML_TYPE_TEXT
   MXML_TYPE_CUSTOM
end enum

type mxml_type_t as mxml_type_e

type mxml_ws_e as long
enum
   MXML_WS_BEFORE_OPEN
   MXML_WS_AFTER_OPEN
   MXML_WS_BEFORE_CLOSE
   MXML_WS_AFTER_CLOSE
end enum

type mxml_ws_t as mxml_ws_e
type mxml_error_cb_t as sub(byval cbdata as any ptr, byval message as const zstring ptr)
type mxml_node_t as _mxml_node_s
type mxml_index_t as _mxml_index_s
type mxml_options_t as _mxml_options_s
type mxml_custfree_cb_t as sub(byval cbdata as any ptr, byval custdata as any ptr)
type mxml_custload_cb_t as function(byval cbdata as any ptr, byval node as mxml_node_t ptr, byval s as const zstring ptr) as bool
type mxml_custsave_cb_t as function(byval cbdata as any ptr, byval node as mxml_node_t ptr) as zstring ptr
type mxml_entity_cb_t as function(byval cbdata as any ptr, byval name as const zstring ptr) as long
type mxml_io_cb_t as function(byval cbdata as any ptr, byval buffer as any ptr, byval bytes as uinteger) as uinteger
type mxml_sax_cb_t as function(byval cbdata as any ptr, byval node as mxml_node_t ptr, byval event as mxml_sax_event_t) as bool
type mxml_strcopy_cb_t as function(byval cbdata as any ptr, byval s as const zstring ptr) as zstring ptr
type mxml_strfree_cb_t as sub(byval cbdata as any ptr, byval s as zstring ptr)
type mxml_type_cb_t as function(byval cbdata as any ptr, byval node as mxml_node_t ptr) as mxml_type_t
type mxml_ws_cb_t as function(byval cbdata as any ptr, byval node as mxml_node_t ptr, byval when as mxml_ws_t) as const zstring ptr

declare sub mxmlAdd(byval parent as mxml_node_t ptr, byval add as mxml_add_t, byval child as mxml_node_t ptr, byval node as mxml_node_t ptr)
declare sub mxmlDelete(byval node as mxml_node_t ptr)
declare sub mxmlElementClearAttr(byval node as mxml_node_t ptr, byval name as const zstring ptr)
declare function mxmlElementGetAttr(byval node as mxml_node_t ptr, byval name as const zstring ptr) as const zstring ptr
declare function mxmlElementGetAttrByIndex(byval node as mxml_node_t ptr, byval idx as uinteger, byval name as const zstring ptr ptr) as const zstring ptr
declare function mxmlElementGetAttrCount(byval node as mxml_node_t ptr) as uinteger
declare sub mxmlElementSetAttr(byval node as mxml_node_t ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare sub mxmlElementSetAttrf(byval node as mxml_node_t ptr, byval name as const zstring ptr, byval format as const zstring ptr, ...)
declare function mxmlFindElement(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval element as const zstring ptr, byval attr as const zstring ptr, byval value as const zstring ptr, byval descend as mxml_descend_t) as mxml_node_t ptr
declare function mxmlFindPath(byval node as mxml_node_t ptr, byval path as const zstring ptr) as mxml_node_t ptr
declare function mxmlGetCDATA(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetComment(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetCustom(byval node as mxml_node_t ptr) as const any ptr
declare function mxmlGetDeclaration(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetDirective(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetElement(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetFirstChild(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetInteger(byval node as mxml_node_t ptr) as clong
declare function mxmlGetLastChild(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetNextSibling(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetOpaque(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetParent(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetPrevSibling(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetReal(byval node as mxml_node_t ptr) as double
declare function mxmlGetRefCount(byval node as mxml_node_t ptr) as uinteger
declare function mxmlGetText(byval node as mxml_node_t ptr, byval whitespace as bool ptr) as const zstring ptr
declare function mxmlGetType(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxmlGetUserData(byval node as mxml_node_t ptr) as any ptr
declare sub mxmlIndexDelete(byval ind as mxml_index_t ptr)
declare function mxmlIndexEnum(byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlIndexFind(byval ind as mxml_index_t ptr, byval element as const zstring ptr, byval value as const zstring ptr) as mxml_node_t ptr
declare function mxmlIndexGetCount(byval ind as mxml_index_t ptr) as uinteger
declare function mxmlIndexNew(byval node as mxml_node_t ptr, byval element as const zstring ptr, byval attr as const zstring ptr) as mxml_index_t ptr
declare function mxmlIndexReset(byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlLoadFd(byval top as mxml_node_t ptr, byval options as mxml_options_t ptr, byval fd as long) as mxml_node_t ptr
declare function mxmlLoadFile(byval top as mxml_node_t ptr, byval options as mxml_options_t ptr, byval fp as FILE ptr) as mxml_node_t ptr
declare function mxmlLoadFilename(byval top as mxml_node_t ptr, byval options as mxml_options_t ptr, byval filename as const zstring ptr) as mxml_node_t ptr
declare function mxmlLoadIO(byval top as mxml_node_t ptr, byval options as mxml_options_t ptr, byval io_cb as mxml_io_cb_t, byval io_cbdata as any ptr) as mxml_node_t ptr
declare function mxmlLoadString(byval top as mxml_node_t ptr, byval options as mxml_options_t ptr, byval s as const zstring ptr) as mxml_node_t ptr
declare sub mxmlOptionsDelete(byval options as mxml_options_t ptr)
declare function mxmlOptionsNew() as mxml_options_t ptr
declare sub mxmlOptionsSetCustomCallbacks(byval options as mxml_options_t ptr, byval load_cb as mxml_custload_cb_t, byval save_cb as mxml_custsave_cb_t, byval cbdata as any ptr)
declare sub mxmlOptionsSetEntityCallback(byval options as mxml_options_t ptr, byval cb as mxml_entity_cb_t, byval cbdata as any ptr)
declare sub mxmlOptionsSetErrorCallback(byval options as mxml_options_t ptr, byval cb as mxml_error_cb_t, byval cbdata as any ptr)
declare sub mxmlOptionsSetSAXCallback(byval options as mxml_options_t ptr, byval cb as mxml_sax_cb_t, byval cbdata as any ptr)
declare sub mxmlOptionsSetTypeCallback(byval options as mxml_options_t ptr, byval cb as mxml_type_cb_t, byval cbdata as any ptr)
declare sub mxmlOptionsSetTypeValue(byval options as mxml_options_t ptr, byval type as mxml_type_t)
declare sub mxmlOptionsSetWhitespaceCallback(byval options as mxml_options_t ptr, byval cb as mxml_ws_cb_t, byval cbdata as any ptr)
declare sub mxmlOptionsSetWrapMargin(byval options as mxml_options_t ptr, byval column as long)
declare function mxmlNewCDATA(byval parent as mxml_node_t ptr, byval string as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewCDATAf(byval parent as mxml_node_t ptr, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewComment(byval parent as mxml_node_t ptr, byval comment as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewCommentf(byval parent as mxml_node_t ptr, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewCustom(byval parent as mxml_node_t ptr, byval data as any ptr, byval free_cb as mxml_custfree_cb_t, byval free_cbdata as any ptr) as mxml_node_t ptr
declare function mxmlNewDeclaration(byval parent as mxml_node_t ptr, byval declaration as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewDeclarationf(byval parent as mxml_node_t ptr, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewDirective(byval parent as mxml_node_t ptr, byval directive as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewDirectivef(byval parent as mxml_node_t ptr, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewElement(byval parent as mxml_node_t ptr, byval name as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewInteger(byval parent as mxml_node_t ptr, byval integer as clong) as mxml_node_t ptr
declare function mxmlNewOpaque(byval parent as mxml_node_t ptr, byval opaque as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewOpaquef(byval parent as mxml_node_t ptr, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewReal(byval parent as mxml_node_t ptr, byval real as double) as mxml_node_t ptr
declare function mxmlNewText(byval parent as mxml_node_t ptr, byval whitespace as bool, byval string as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewTextf(byval parent as mxml_node_t ptr, byval whitespace as bool, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewXML(byval version as const zstring ptr) as mxml_node_t ptr
declare function mxmlRelease(byval node as mxml_node_t ptr) as long
declare sub mxmlRemove(byval node as mxml_node_t ptr)
declare function mxmlRetain(byval node as mxml_node_t ptr) as long
declare function mxmlSaveAllocString(byval node as mxml_node_t ptr, byval options as mxml_options_t ptr) as zstring ptr
declare function mxmlSaveFd(byval node as mxml_node_t ptr, byval options as mxml_options_t ptr, byval fd as long) as bool
declare function mxmlSaveFile(byval node as mxml_node_t ptr, byval options as mxml_options_t ptr, byval fp as FILE ptr) as bool
declare function mxmlSaveFilename(byval node as mxml_node_t ptr, byval options as mxml_options_t ptr, byval filename as const zstring ptr) as bool
declare function mxmlSaveIO(byval node as mxml_node_t ptr, byval options as mxml_options_t ptr, byval io_cb as mxml_io_cb_t, byval io_cbdata as any ptr) as bool
declare function mxmlSaveString(byval node as mxml_node_t ptr, byval options as mxml_options_t ptr, byval buffer as zstring ptr, byval bufsize as uinteger) as uinteger
declare function mxmlSetCDATA(byval node as mxml_node_t ptr, byval data as const zstring ptr) as bool
declare function mxmlSetCDATAf(byval node as mxml_node_t ptr, byval format as const zstring ptr, ...) as bool
declare function mxmlSetComment(byval node as mxml_node_t ptr, byval comment as const zstring ptr) as bool
declare function mxmlSetCommentf(byval node as mxml_node_t ptr, byval format as const zstring ptr, ...) as bool
declare function mxmlSetDeclaration(byval node as mxml_node_t ptr, byval declaration as const zstring ptr) as bool
declare function mxmlSetDeclarationf(byval node as mxml_node_t ptr, byval format as const zstring ptr, ...) as bool
declare function mxmlSetDirective(byval node as mxml_node_t ptr, byval directive as const zstring ptr) as bool
declare function mxmlSetDirectivef(byval node as mxml_node_t ptr, byval format as const zstring ptr, ...) as bool
declare function mxmlSetCustom(byval node as mxml_node_t ptr, byval data as any ptr, byval free_cb as mxml_custfree_cb_t, byval free_cbdata as any ptr) as bool
declare function mxmlSetElement(byval node as mxml_node_t ptr, byval name as const zstring ptr) as bool
declare function mxmlSetInteger(byval node as mxml_node_t ptr, byval integer as clong) as bool
declare function mxmlSetOpaque(byval node as mxml_node_t ptr, byval opaque as const zstring ptr) as bool
declare function mxmlSetOpaquef(byval node as mxml_node_t ptr, byval format as const zstring ptr, ...) as bool
declare function mxmlSetReal(byval node as mxml_node_t ptr, byval real as double) as bool
declare sub mxmlSetStringCallbacks(byval strcopy_cb as mxml_strcopy_cb_t, byval strfree_cb as mxml_strfree_cb_t, byval str_cbdata as any ptr)
declare function mxmlSetText(byval node as mxml_node_t ptr, byval whitespace as bool, byval string as const zstring ptr) as bool
declare function mxmlSetTextf(byval node as mxml_node_t ptr, byval whitespace as bool, byval format as const zstring ptr, ...) as bool
declare function mxmlSetUserData(byval node as mxml_node_t ptr, byval data as any ptr) as bool
declare function mxmlWalkNext(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval descend as mxml_descend_t) as mxml_node_t ptr
declare function mxmlWalkPrev(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval descend as mxml_descend_t) as mxml_node_t ptr

#define MXML_DEBUG(__VA_ARGS__...)
const MXML_ALLOC_SIZE = 16
const MXML_TAB = 8

type _mxml_attr_s
   name as zstring ptr
   value as zstring ptr
end type

type _mxml_attr_t as _mxml_attr_s

type _mxml_element_s
   name as zstring ptr
   num_attrs as uinteger
   attrs as _mxml_attr_t ptr
end type

type _mxml_element_t as _mxml_element_s

type _mxml_text_s
   whitespace as bool
   string as zstring ptr
end type

type _mxml_text_t as _mxml_text_s

type _mxml_custom_s
   data as any ptr
   free_cb as mxml_custfree_cb_t
   free_cbdata as any ptr
end type

type _mxml_custom_t as _mxml_custom_s

union _mxml_value_u
   cdata as zstring ptr
   comment as zstring ptr
   declaration as zstring ptr
   directive as zstring ptr
   element as _mxml_element_t
   integer as clong
   opaque as zstring ptr
   real as double
   text as _mxml_text_t
   custom as _mxml_custom_t
end union

type _mxml_value_t as _mxml_value_u

type _mxml_node_s
   as mxml_type_t type
   next as _mxml_node_s ptr
   prev as _mxml_node_s ptr
   parent as _mxml_node_s ptr
   child as _mxml_node_s ptr
   last_child as _mxml_node_s ptr
   value as _mxml_value_t
   ref_count as uinteger
   user_data as any ptr
end type

type _mxml_global_s
   strcopy_cb as mxml_strcopy_cb_t
   strfree_cb as mxml_strfree_cb_t
   str_cbdata as any ptr
end type

type _mxml_global_t as _mxml_global_s

type _mxml_index_s
   attr as zstring ptr
   num_nodes as uinteger
   alloc_nodes as uinteger
   cur_node as uinteger
   nodes as mxml_node_t ptr ptr
end type

type _mxml_options_s
   loc as lconv ptr
   loc_declen as uinteger
   custload_cb as mxml_custload_cb_t
   custsave_cb as mxml_custsave_cb_t
   cust_cbdata as any ptr
   entity_cb as mxml_entity_cb_t
   entity_cbdata as any ptr
   error_cb as mxml_error_cb_t
   error_cbdata as any ptr
   sax_cb as mxml_sax_cb_t
   sax_cbdata as any ptr
   type_cb as mxml_type_cb_t
   type_cbdata as any ptr
   type_value as mxml_type_t
   wrap as long
   ws_cb as mxml_ws_cb_t
   ws_cbdata as any ptr
end type

declare function _mxml_global() as _mxml_global_t ptr
declare function _mxml_entity_string(byval ch as long) as const zstring ptr
declare function _mxml_entity_value(byval options as mxml_options_t ptr, byval name as const zstring ptr) as long
declare sub _mxml_error(byval options as mxml_options_t ptr, byval format as const zstring ptr, ...)
declare function _mxml_strcopy(byval s as const zstring ptr) as zstring ptr
declare sub _mxml_strfree(byval s as zstring ptr)

end extern
