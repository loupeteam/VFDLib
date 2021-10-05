(********************************************************************
 * COPYRIGHT --  Automation Resources Group
 ********************************************************************
 * Library: VFD_Lib
 * File: VFD_Lib.fun
 * Author: David
 * Created: September 03, 2010
 ********************************************************************
 * Functions and function blocks of library VFD_Lib
 ********************************************************************)

FUNCTION VFDFn_Cyclic : BOOL (*Cyclic function for controlling one VFD*)
	VAR_IN_OUT
		t : VFD_typ; (*VFD control object*)
	END_VAR
END_FUNCTION

FUNCTION VFD_SetCMDD_Output_X64 : BOOL (*This function sets the bits in the control word based on the axis input values*)
	VAR_IN_OUT
		t : VFD_typ; (*VFD control object*)
	END_VAR
END_FUNCTION

FUNCTION VFD_GetDriveStatus : BOOL (*This function unpacks the DriveStatus word*)
	VAR_INPUT
		ETAD_Input : UINT; (*DriveStatus word*)
	END_VAR
	VAR_IN_OUT
		DriveStatus : VFD_OUT_STAT_DriveStatus_typ; (*DriveStatus structure*)
	END_VAR
END_FUNCTION

FUNCTION VFD_GetExtendedStatus : BOOL (*This functions unpacks the Extended status word*)
	VAR_INPUT
		ETI_Input : UINT; (*Drive Extended status word*)
	END_VAR
	VAR_IN_OUT
		ExtendedStatus : VFD_OUT_STAT_Extended_typ; (*Extended status structure*)
	END_VAR
END_FUNCTION

FUNCTION VFD_SetState : BOOL (*This function sets the state based on the status bits*)
	VAR_IN_OUT
		t : VFD_OUT_STAT_typ; (*VFD status output structure*)
	END_VAR
END_FUNCTION

FUNCTION VFD_SetFaultString : BOOL (*This function sets the error text based on the LFT fault ID input.*)
	VAR_INPUT
		ID : UINT; (*FaultID*)
	END_VAR
	VAR_IN_OUT
		String : STRING[80]; (*FaultString*)
	END_VAR
END_FUNCTION

FUNCTION VFD_EncoderFn_Cyclic : BOOL (*Cyclic function for getting VFD speed from encoder feedback*)
	VAR_IN_OUT
		t : VFD_Encoder_typ; (*VFD_Encoder control object*)
	END_VAR
END_FUNCTION
