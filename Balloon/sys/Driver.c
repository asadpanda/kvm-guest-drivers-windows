/**********************************************************************
 * Copyright (c) 2009  Red Hat, Inc.
 *
 * File: driver.c
 *
 * Author(s):
 *  Vadim Rozenfeld <vrozenfe@redhat.com>
 *
 * This file contains balloon driver routines
 *
 * This work is licensed under the terms of the GNU GPL, version 2.  See
 * the COPYING file in the top-level directory.
 *
**********************************************************************/
#include "precomp.h"

#if defined(EVENT_TRACING)
#include "Driver.tmh"
#endif

DRIVER_INITIALIZE DriverEntry;
EVT_WDF_OBJECT_CONTEXT_CLEANUP EvtDriverContextCleanup;

#pragma alloc_text(INIT, DriverEntry)
#pragma alloc_text(PAGE, EvtDriverContextCleanup)

NTSTATUS DriverEntry(
                      IN PDRIVER_OBJECT   DriverObject,
                      IN PUNICODE_STRING  RegistryPath
                      )
{
    WDF_DRIVER_CONFIG      config;
    NTSTATUS               status;
    WDFDRIVER              driver;
    WDF_OBJECT_ATTRIBUTES  attrib;

    WPP_INIT_TRACING( DriverObject, RegistryPath );

    TraceEvents(TRACE_LEVEL_WARNING, DBG_HW_ACCESS, "Balloon driver, built on %s %s\n",
            __DATE__, __TIME__);

    WDF_OBJECT_ATTRIBUTES_INIT(&attrib);
    attrib.EvtCleanupCallback = EvtDriverContextCleanup;

    WDF_DRIVER_CONFIG_INIT(&config, BalloonDeviceAdd);

    status =  WdfDriverCreate(
                      DriverObject,
                      RegistryPath,
                      &attrib,
                      &config,
                      &driver);
    if(!NT_SUCCESS(status))
    {
        TraceEvents(TRACE_LEVEL_ERROR, DBG_PNP,"WdfDriverCreate failed with status 0x%08x\n", status);
        WPP_CLEANUP(DriverObject);
        return status;
    }

    TraceEvents(TRACE_LEVEL_INFORMATION, DBG_PNP,"<-- %s\n", __FUNCTION__);

    return status;
}

VOID
EvtDriverContextCleanup(
    IN WDFDRIVER Driver
    )
{
    PAGED_CODE ();

    TraceEvents(TRACE_LEVEL_INFORMATION, DBG_PNP,"--> %s\n", __FUNCTION__);

    WPP_CLEANUP(WdfDriverWdmGetDriverObject( Driver ));

    TraceEvents(TRACE_LEVEL_INFORMATION, DBG_PNP, "<-- %s\n", __FUNCTION__);
}
