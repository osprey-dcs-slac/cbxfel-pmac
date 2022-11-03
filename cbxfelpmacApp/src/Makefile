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
cbxfelpmac_DBD += asSupport.dbd
cbxfelpmac_DBD += devIocStats.dbd
cbxfelpmac_DBD += caPutLog.dbd

cbxfelpmac_DBD += asyn.dbd
cbxfelpmac_DBD += busySupport.dbd
cbxfelpmac_DBD += motorSupport.dbd
cbxfelpmac_DBD += pmacAsynIPPort.dbd
cbxfelpmac_DBD += drvAsynPowerPMACPort.dbd
cbxfelpmac_DBD += pmacAsynMotorPort.dbd

# Add all the support libraries needed by this IOC
cbxfelpmac_LIBS += autosave
cbxfelpmac_LIBS += caPutLog
cbxfelpmac_LIBS += devIocStats

cbxfelpmac_LIBS += busy
cbxfelpmac_LIBS += pmacAsynMotorPort
cbxfelpmac_LIBS += powerPmacAsynPort
cbxfelpmac_LIBS += motor
cbxfelpmac_LIBS += pmacAsynIPPort
cbxfelpmac_LIBS += asyn

# cbxfelpmac_registerRecordDeviceDriver.cpp derives from cbxfelpmac.dbd
cbxfelpmac_SRCS += cbxfelpmac_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
cbxfelpmac_SRCS_DEFAULT += cbxfelpmacMain.cpp
cbxfelpmac_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#cbxfelpmac_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# =====================================================
# Path to "NON EPICS" External PACKAGES: USER INCLUDES
# ======================================================
USR_INCLUDES += -I$(SSH2_INCLUDE)
USR_INCLUDES += -I$(ZLIB_INCLUDE)
USR_INCLUDES += -I$(CRYPTO_INCLUDE)

# ======================================================
# PATH TO "NON EPICS" EXTERNAL PACKAGES: USER LIBRARIES
# ======================================================
ssh2_DIR   = $(SSH2_LIB)
crypto_DIR = $(CRYPTO_LIB)
z_DIR      = $(ZLIB_LIB)

# ======================================================
# LINK "NON EPICS" EXTERNAL PACKAGE LIBRARIES STATICALLY
# =======================================================
USR_LIBS_Linux += ssh2 crypto z
USR_SYS_LIBS   += pcre

# Finally link to the EPICS Base libraries
cbxfelpmac_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

