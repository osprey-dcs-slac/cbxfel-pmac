TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = cbxfelpmac
# cbxfelpmac.dbd will be created and installed
DBD += cbxfelpmac.dbd

# cbxfelpmac.dbd will be made up from these files:
cbxfelpmac_DBD += base.dbd

# Include dbd files from all support applications:
cbxfelpmac_DBD += motorSupport.dbd
cbxfelpmac_DBD += drvAsynPowerPMACPort.dbd
cbxfelpmac_DBD += asyn.dbd

# Add all the support libraries needed by this IOC
cbxfelpmac_LIBS += motor
cbxfelpmac_LIBS += powerPmacAsynPort
cbxfelpmac_LIBS += asyn

# cbxfelpmac_registerRecordDeviceDriver.cpp derives from cbxfelpmac.dbd
cbxfelpmac_SRCS += cbxfelpmac_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
cbxfelpmac_SRCS_DEFAULT += cbxfelpmacMain.cpp
cbxfelpmac_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#cbxfelpmac_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
cbxfelpmac_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

