#!../../bin/rhel6-x86_64/cbxfelpmac

#- You may have to change cbxfelpmac to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/cbxfelpmac.dbd"
cbxfelpmac_registerRecordDeviceDriver pdbbase

# System Location:
epicsEnvSet("IOC_NAME", "SIOC:CBXFEL:PMAC01Test")
epicsEnvSet("LOCATION", "UNDH")

# Number of supported axes
epicsEnvSet("NAXES", "4")

# Build PVs for controller axes
epicsEnvSet("SEGMENT1","CBXFEL1")

# Build PVs for motion controller
epicsEnvSet("CONTR","MOC:${LOCATION}:${SEGMENT1}")

epicsEnvSet("HOSTNAME", "slac-epics-vm")
epicsEnvSet("ENGINEER", "Alex Montironi, Wayne Lewis")

###########################################################
# Initialize all hardware first                           #
###########################################################

# =======================================================
# PowerPMAC controller configuration
# =======================================================

# Create SSH Port
# drvAsynPowerPMACPortConfigure(PortName,     IPAddress  , Username, Password, Priority, DisableAutoConnect, noProcessEos)
drvAsynPowerPMACPortConfigure("PPMACPort", "${HOSTNAME}", "root", "deltatau", "0", "0", "0")

# Configure Model 3 Controller Driver (100 ms poll rate)
# pmacCreateController (ControllerPort, LowLevelDriverPort, Address, Axes, MovingPoll, IdlePoll)
pmacCreateController("PPMAC", "PPMACPort", 0, "${NAXES}", 100, 100)

# Configure Model 3 Axes Driver
# pmacCreateAxes (Controller Port, Axis Count)
pmacCreateAxes("PPMAC", "${NAXES}")


# Setup Asyn
#asynSetTraceMask("PPMAC", 0, 0)
#asynSetTraceMask("PPMACPort", -1, 0)
#asynSetTraceIOMask("PPMACPort", -1, 0)

########################################################################
# BEGIN: Load the record databases
#######################################################################

cd $(TOP)

# =====================================================================
# Load iocAdmin databases to support IOC Health and monitoring
# =====================================================================
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC_NAME}")

#dbLoadRecords("db/iocRelease.db","IOC=${IOC_NAME}")

# =====================================================================
# Load database for autosave status
# =====================================================================
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC_NAME}:")

# =====================================================================
# Load database for reading encoder offsets
# =====================================================================
# Provide PVs for controller
dbLoadRecords("db/cbxfelPmacController.db", "MOC=${CONTR},PORT=PPMAC,N=${NAXES}")
# Provide PVs for axes
dbLoadRecords("db/cbxfelPmacAxes.db", "MOC=${CONTR},PORT=PPMAC,AXIS1=1,AXIS2=2")

# =====================================================================
# Load database for  Asyn communication
# =====================================================================
dbLoadRecords(db/asynRecord.db, "P=${CONTR},R=:ASYN,PORT=PPMACPort,ADDR=0,IMAX=100,OMAX=100")

# END: Loading the record databases
#####################################################################################################

# SAVE - RESTORE SETUP
# ============================================================
# If all PVs don't connect continue anyway
# ============================================================
save_restoreSet_IncompleteSetsOk(1)

# ============================================================
# created save/restore backup files with date string
# useful for recovery.
# ============================================================
#save_restoreSet_DatedBackupFiles(1)

# ============================================================
# Where to find the list of PVs to save
# ============================================================
set_requestfile_path("${IOC_DATA}/${IOC}/autosave-req")

# ============================================================
# Where to write the save files that will be used to restore
# ============================================================
set_savefile_path("${IOC_DATA}/${IOC}", "autosave")

## Restore datasets
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")


# optional, needed if the IOC takes a very long time to boot.
epicsThreadSleep( 1.0)

## --------------------------------------------------------------------------------

# IOCINIT
cd ${TOP}/iocBoot/${IOC}
iocInit

## ===========================================================
## Start autosave routines to save our data
## ===========================================================
# optional, needed if the IOC takes a very long time to boot.
epicsThreadSleep( 1.0)

cd ${IOC_DATA}/${IOC}/autosave-req
iocshCmd("makeAutosaveFiles()")

## Start autosave process:
create_monitor_set("info_settings.req",30,"")
create_monitor_set("info_positions.req",20,"")

## Start any sequence programs
#seq sncxxx,"user=laci"
