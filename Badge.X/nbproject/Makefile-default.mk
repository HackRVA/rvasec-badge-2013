#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/game.o ${OBJECTDIR}/common.o ${OBJECTDIR}/user/user.o ${OBJECTDIR}/main.o ${OBJECTDIR}/RC5_lib.o
POSSIBLE_DEPFILES=${OBJECTDIR}/game.o.d ${OBJECTDIR}/common.o.d ${OBJECTDIR}/user/user.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/RC5_lib.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/game.o ${OBJECTDIR}/common.o ${OBJECTDIR}/user/user.o ${OBJECTDIR}/main.o ${OBJECTDIR}/RC5_lib.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18F2455
MP_PROCESSOR_OPTION_LD=18f2455
MP_LINKER_DEBUG_OPTION= -u_DEBUGCODESTART=0x5dc0 -u_DEBUGCODELEN=0x240 -u_DEBUGDATASTART=0x3f4 -u_DEBUGDATALEN=0xb
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/RC5_lib.o: RC5_lib.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/RC5_lib.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/RC5_lib.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/RC5_lib.lst\" -e\"${OBJECTDIR}/RC5_lib.err\" $(ASM_OPTIONS)  -o\"${OBJECTDIR}/RC5_lib.o\" RC5_lib.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/RC5_lib.o 
	@${FIXDEPS} "${OBJECTDIR}/RC5_lib.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
else
${OBJECTDIR}/RC5_lib.o: RC5_lib.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/RC5_lib.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/RC5_lib.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/RC5_lib.lst\" -e\"${OBJECTDIR}/RC5_lib.err\" $(ASM_OPTIONS)  -o\"${OBJECTDIR}/RC5_lib.o\" RC5_lib.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/RC5_lib.o 
	@${FIXDEPS} "${OBJECTDIR}/RC5_lib.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/game.o: game.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/game.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PICKIT2=1 -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/game.o   game.c 
	@${DEP_GEN} -d ${OBJECTDIR}/game.o 
	@${FIXDEPS} "${OBJECTDIR}/game.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/common.o: common.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/common.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PICKIT2=1 -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/common.o   common.c 
	@${DEP_GEN} -d ${OBJECTDIR}/common.o 
	@${FIXDEPS} "${OBJECTDIR}/common.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/user/user.o: user/user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/user 
	@${RM} ${OBJECTDIR}/user/user.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PICKIT2=1 -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/user/user.o   user/user.c 
	@${DEP_GEN} -d ${OBJECTDIR}/user/user.o 
	@${FIXDEPS} "${OBJECTDIR}/user/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/main.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PICKIT2=1 -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/main.o   main.c 
	@${DEP_GEN} -d ${OBJECTDIR}/main.o 
	@${FIXDEPS} "${OBJECTDIR}/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
else
${OBJECTDIR}/game.o: game.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/game.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/game.o   game.c 
	@${DEP_GEN} -d ${OBJECTDIR}/game.o 
	@${FIXDEPS} "${OBJECTDIR}/game.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/common.o: common.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/common.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/common.o   common.c 
	@${DEP_GEN} -d ${OBJECTDIR}/common.o 
	@${FIXDEPS} "${OBJECTDIR}/common.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/user/user.o: user/user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/user 
	@${RM} ${OBJECTDIR}/user/user.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/user/user.o   user/user.c 
	@${DEP_GEN} -d ${OBJECTDIR}/user/user.o 
	@${FIXDEPS} "${OBJECTDIR}/user/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/main.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION)   -I ${MP_CC_DIR}/../h  -fo ${OBJECTDIR}/main.o   main.c 
	@${DEP_GEN} -d ${OBJECTDIR}/main.o 
	@${FIXDEPS} "${OBJECTDIR}/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  obj/cdc.o obj/i2c_ack.o obj/i2c_clos.o obj/i2c_dtrd.o obj/i2c_eeap.o obj/i2c_eebw.o obj/i2c_eecr.o obj/i2c_eepw.o obj/i2c_eerr.o obj/i2c_eesr.o obj/i2c_gets.o obj/i2c_idle.o obj/i2c_nack.o obj/i2c_open.o obj/i2c_puts.o obj/i2c_read.o obj/i2c_rstr.o obj/i2c_stop.o obj/i2c_strt.o obj/i2c_writ.o obj/usb9.o obj/usbctrltrf.o obj/usbdrv.o obj/usbdsc.o obj/usbmmap.o  18f2455_g.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "18f2455_g.lkr"  -p$(MP_PROCESSOR_OPTION_LD)  -w -x -u_DEBUG   -z__MPLAB_BUILD=1  -u_CRUNTIME -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PICKIT2=1 $(MP_LINKER_DEBUG_OPTION) -l ${MP_CC_DIR}/../lib  -o dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}  obj/cdc.o obj/i2c_ack.o obj/i2c_clos.o obj/i2c_dtrd.o obj/i2c_eeap.o obj/i2c_eebw.o obj/i2c_eecr.o obj/i2c_eepw.o obj/i2c_eerr.o obj/i2c_eesr.o obj/i2c_gets.o obj/i2c_idle.o obj/i2c_nack.o obj/i2c_open.o obj/i2c_puts.o obj/i2c_read.o obj/i2c_rstr.o obj/i2c_stop.o obj/i2c_strt.o obj/i2c_writ.o obj/usb9.o obj/usbctrltrf.o obj/usbdrv.o obj/usbdsc.o obj/usbmmap.o 
else
dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  obj/cdc.o obj/i2c_ack.o obj/i2c_clos.o obj/i2c_dtrd.o obj/i2c_eeap.o obj/i2c_eebw.o obj/i2c_eecr.o obj/i2c_eepw.o obj/i2c_eerr.o obj/i2c_eesr.o obj/i2c_gets.o obj/i2c_idle.o obj/i2c_nack.o obj/i2c_open.o obj/i2c_puts.o obj/i2c_read.o obj/i2c_rstr.o obj/i2c_stop.o obj/i2c_strt.o obj/i2c_writ.o obj/usb9.o obj/usbctrltrf.o obj/usbdrv.o obj/usbdsc.o obj/usbmmap.o 18f2455_g.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "18f2455_g.lkr"  -p$(MP_PROCESSOR_OPTION_LD)  -w    -z__MPLAB_BUILD=1  -u_CRUNTIME -l ${MP_CC_DIR}/../lib  -o dist/${CND_CONF}/${IMAGE_TYPE}/Badge.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}  obj/cdc.o obj/i2c_ack.o obj/i2c_clos.o obj/i2c_dtrd.o obj/i2c_eeap.o obj/i2c_eebw.o obj/i2c_eecr.o obj/i2c_eepw.o obj/i2c_eerr.o obj/i2c_eesr.o obj/i2c_gets.o obj/i2c_idle.o obj/i2c_nack.o obj/i2c_open.o obj/i2c_puts.o obj/i2c_read.o obj/i2c_rstr.o obj/i2c_stop.o obj/i2c_strt.o obj/i2c_writ.o obj/usb9.o obj/usbctrltrf.o obj/usbdrv.o obj/usbdsc.o obj/usbmmap.o 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
