/**********************************************************************
 * Copyright (c) 2008  Red Hat, Inc.
 *
 * File: quverp.h
 *
 * This file contains version resource related definitions
 *
 * This work is licensed under the terms of the GNU GPL, version 2.  See
 * the COPYING file in the top-level directory.
 *
**********************************************************************/
#include <windows.h>
#include "ntverp.h"

#ifdef VER_COMPANYNAME_STR
#undef VER_COMPANYNAME_STR
#endif
#ifdef VER_LEGALTRADEMARKS_STR
#undef VER_LEGALTRADEMARKS_STR
#endif
#ifdef VER_PRODUCTBUILD
#undef VER_PRODUCTBUILD
#endif
#ifdef VER_PRODUCTBUILD_QFE
#undef VER_PRODUCTBUILD_QFE
#endif
#ifdef VER_PRODUCTMAJORVERSION
#undef VER_PRODUCTMAJORVERSION
#endif
#ifdef VER_PRODUCTMINORVERSION
#undef VER_PRODUCTMINORVERSION
#endif
#ifdef VER_PRODUCTNAME_STR
#undef VER_PRODUCTNAME_STR
#endif
#define VER_COMPANYNAME_STR				"Red Hat Inc."
#define	VER_LEGALTRADEMARKS_STR			""
#define VER_LEGALCOPYRIGHT_STR			"(c) Red Hat Inc."
#define VER_PRODUCTBUILD				_MAJORVERSION_
#define VER_PRODUCTBUILD_QFE			_MINORVERSION_
#define VER_PRODUCTMAJORVERSION			_NT_TARGET_MAJ
#define VER_PRODUCTMINORVERSION			_NT_TARGET_MIN
#undef __BUILDMACHINE__

#define VER_FILETYPE                VFT_DRV
#define VER_FILESUBTYPE             VFT2_DRV_SYSTEM
#define VER_FILEDESCRIPTION_STR     "NDIS Miniport Driver"
#define VER_INTERNALNAME_STR        "netkvm.sys"
#define VER_PRODUCTNAME_STR			"RedHat VirtIO Ethernet Adapter"

#include "common.ver"