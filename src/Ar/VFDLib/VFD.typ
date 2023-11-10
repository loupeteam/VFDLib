(*
 * File: VFD.typ
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of VFDLib, licensed under the MIT License.
 *
 *)


TYPE
	VFD_ST_enum : 
		(
		VFD_ST_NOTRDYTOSWON := 1,
		VFD_ST_SWONDISABLED,
		VFD_ST_RDYTOSWON,
		VFD_ST_SWON,
		VFD_ST_ENABLED,
		VFD_ST_QUICKSTOPACTIVE,
		VFD_ST_FAULTRXNACTIVE,
		VFD_ST_FAULT,
		VFD_ST_
		);
	VFD_Internal_typ : 	STRUCT 
		ScaleIn : Scale_typ;
		ScaleOut : Scale_typ;
		AckResetTimer : TON;
		CMD : VFD_IN_CMD_typ;
	END_STRUCT;
	VFD_TEST_STAT_typ : 	STRUCT 
		ActualVelocity : REAL;
		ActualVelocity_RPM : REAL;
		Error : BOOL;
		ErrorID : UINT;
		ErrorString : STRING[VFD_STRLEN_ERROR];
		RdyToSwOn : BOOL;
		SwOn : BOOL;
		OpEnabled : BOOL;
		Fault : BOOL;
		FaultID : UINT;
		VoltageDisabled : BOOL;
		QuickStop : BOOL;
		SwOnDisabled : BOOL;
		AlarmPresent : BOOL;
		RefReached : BOOL;
		State : DINT;
	END_STRUCT;
	VFD_TEST_typ : 	STRUCT 
		Enable : BOOL;
		CMD : VFD_IN_CMD_typ;
		PAR : VFD_IN_PAR_typ;
		STAT : VFD_TEST_STAT_typ;
	END_STRUCT;
	VFD_OUT_STAT_Extended_typ : 	STRUCT 
		Running : BOOL;
		DCInjection : BOOL;
		Transient : BOOL;
		ThermalOverloadAlarm : BOOL;
		BrakeAlarm : BOOL;
		Accelerating : BOOL;
		Decelerating : BOOL;
		CurrentLimitAlarm : BOOL;
		FastStop : BOOL;
		DirectionReq : BOOL;
	END_STRUCT;
	VFD_OUT_STAT_DriveStatus_typ : 	STRUCT 
		RdyToSwOn : BOOL;
		SwOn : BOOL;
		OpEnabled : BOOL;
		Fault : BOOL;
		FaultID : UINT;
		FaultString : STRING[VFD_STRLEN_ERROR];
		VoltageDisabled : BOOL;
		QuickStop : BOOL;
		SwOnDisabled : BOOL;
		AlarmPresent : BOOL;
		RefReached : BOOL;
		RefExceeded : BOOL;
		StopKey : BOOL;
		DirectionOut : BOOL;
	END_STRUCT;
	VFD_OUT_STAT_typ : 	STRUCT 
		ActualVelocity : REAL;
		ActualVelocity_RPM : REAL;
		DriveStatus : VFD_OUT_STAT_DriveStatus_typ;
		Extended : VFD_OUT_STAT_Extended_typ;
		State : DINT;
		Error : BOOL;
		ErrorID : UINT;
		ErrorString : STRING[VFD_STRLEN_ERROR];
	END_STRUCT;
	VFD_OUT_typ : 	STRUCT 
		STAT : VFD_OUT_STAT_typ;
	END_STRUCT;
	VFD_IN_CFG_Scale_typ : 	STRUCT 
		MinUnits : REAL;
		MinRPM : REAL;
		MaxUnits : REAL;
		MaxRPM : REAL;
	END_STRUCT;
	VFD_IN_CFG_typ : 	STRUCT 
		Scale : VFD_IN_CFG_Scale_typ; (*2-point motor speed scaling*)
	END_STRUCT;
	VFD_IN_PAR_typ : 	STRUCT 
		Velocity : REAL; (*Set motor speed in units.*)
	END_STRUCT;
	VFD_IN_CMD_typ : 	STRUCT 
		Power : BOOL; (*Enable motor output*)
		Run : BOOL; (*Run motor at speed*)
		Reverse : BOOL; (*Run in reverse (must also set Run for motion)*)
		AcknowledgeError : BOOL; (*Reset drive faults*)
		Restart : BOOL; (*Restart drive after recovering from a fault*)
	END_STRUCT;
	VFD_IN_typ : 	STRUCT 
		CMD : VFD_IN_CMD_typ;
		PAR : VFD_IN_PAR_typ;
		CFG : VFD_IN_CFG_typ;
	END_STRUCT;
	VFD_typ : 	STRUCT 
		IN : VFD_IN_typ;
		OUT : VFD_OUT_typ;
		TEST : VFD_TEST_typ;
		IOMap : VFD_IO_typ;
		Encoder : VFD_Encoder_typ;
		Internal : VFD_Internal_typ;
	END_STRUCT;
END_TYPE
