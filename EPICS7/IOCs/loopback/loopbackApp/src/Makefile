# SPDX-FileCopyrightText: 1998 Argonne National Laboratory
#
# SPDX-License-Identifier: EPICS

TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET
USR_DBD += stream.dbd
# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += loopbackSupport

# Compile and add code to the support library
loopbackSupport_SRCS += xxxRecord.c
loopbackSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
loopbackSupport_SRCS += dbSubExample.c
loopbackSupport_SRCS += devloopbackVersion.c
loopbackSupport_SRCS += loopbackHello.c
loopbackSupport_SRCS += initTrace.c

loopbackSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = loopbackVersion.h
# Macro name
GENVERSIONMACRO = loopbackVERSION

# Build the IOC application
PROD_IOC = loopback

# loopback.dbd will be created and installed
DBD += loopback.dbd

# loopback.dbd will include these files:
loopback_DBD += base.dbd
loopback_DBD += xxxSupport.dbd
loopback_DBD += dbSubExample.dbd
loopback_DBD += devloopbackVersion.dbd
loopback_DBD += loopbackHello.dbd
loopback_DBD += initTrace.dbd

# loopback_registerRecordDeviceDriver.cpp derives from loopback.dbd
loopback_SRCS += loopback_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
loopback_SRCS_DEFAULT += loopbackMain.cpp
loopback_SRCS_vxWorks += -nil-

# Link in the code from our support library
loopback_LIBS += loopbackSupport
loopback_LIBS += stream
loopback_LIBS += asyn


# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into loopbackSupport
    sncExample_SNCFLAGS += +r
    loopback_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    loopbackSupport_SRCS += sncExample.stt
    loopbackSupport_LIBS += seq pv
    loopback_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    loopback_LIBS += qsrv
    loopback_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    loopback_DBD += PVAServerRegister.dbd
    loopback_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
loopback_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devloopbackVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
