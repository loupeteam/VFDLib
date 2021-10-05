(********************************************************************
 * COPYRIGHT --  Automation Resources Group
 ********************************************************************
 * Library: VFD_Lib
 * File: VFDEncoder.typ
 * Author: David
 * Created: September 09, 2010
 ********************************************************************
 * Data types of library VFD_Lib
 ********************************************************************)

TYPE
	VFD_Encoder_Internal_typ : 	STRUCT 
		RTInfo : RTInfo;
		SpeedEst : SpeedEst;
		ScaleOut : Scale_typ;
	END_STRUCT;
	VFD_Encoder_OUT_STAT_typ : 	STRUCT 
		Error : BOOL;
	END_STRUCT;
	VFD_Encoder_OUT_typ : 	STRUCT 
		SpeedUnits : REAL;
		SpeedCounts : REAL;
		STAT : VFD_Encoder_OUT_STAT_typ;
	END_STRUCT;
	VFD_Encoder_IN_CFG_Scale_typ : 	STRUCT 
		MinUnits : REAL;
		MinCounts : REAL;
		MaxUnits : REAL;
		MaxCounts : REAL;
	END_STRUCT;
	VFD_Encoder_IN_CFG_typ : 	STRUCT 
		Scale : VFD_Encoder_IN_CFG_Scale_typ;
		tf : REAL;
		deadband : DINT;
		K : REAL;
	END_STRUCT;
	VFD_Encoder_IN_typ : 	STRUCT 
		Counter : DINT;
		CFG : VFD_Encoder_IN_CFG_typ;
	END_STRUCT;
	VFD_Encoder_typ : 	STRUCT 
		IN : VFD_Encoder_IN_typ;
		OUT : VFD_Encoder_OUT_typ;
		Internal : VFD_Encoder_Internal_typ;
	END_STRUCT;
END_TYPE
