#!../../bin/rhel6-x86_64/cbxfelpmac

#- You may have to change cbxfelpmac to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/cbxfelpmac.dbd"
cbxfelpmac_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadRecords("db/xxx.db","user=laci")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=laci"
