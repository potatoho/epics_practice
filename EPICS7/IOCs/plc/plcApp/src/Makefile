# SPDX-FileCopyrightText: 2003 Argonne National Laboratory
#
# SPDX-License-Identifier: EPICS

TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = plc
# plc.dbd will be created and installed
DBD += plc.dbd

# plc.dbd will be made up from these files:
plc_DBD += base.dbd
plc_DBD += asyn.dbd
plc_DBD += modbusSupport.dbd
plc_DBD += drvAsynSerialPort.dbd

# Include dbd files from all support applications:
#plc_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#plc_LIBS += xxx
plc_LIBS += modbus
plc_LIBS += asyn

# plc_registerRecordDeviceDriver.cpp derives from plc.dbd
plc_SRCS += plc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
plc_SRCS_DEFAULT += plcMain.cpp
plc_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#plc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
plc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

