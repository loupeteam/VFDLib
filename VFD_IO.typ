(*
 * File: VFD_IO.typ
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of VFDLib, licensed under the MIT License.
 *
 *)

TYPE
	VFD_IO_OUT_typ : 	STRUCT 
		CMDD_Output : UINT;
		CMI_Output : UINT;
		LFRD_Output : INT;
		IOLR_Output_Bool : ARRAY[0..9] OF BOOL;
		DigitalOutput01 : BOOL;
		EnableCounter : BOOL;
	END_STRUCT;
	VFD_IO_IN_ModuleInfo_typ : 	STRUCT 
		SerialNumber : UDINT;
		ModuleID : UINT;
		HardwareVariant : UINT;
		FirmwareVersion : UINT;
		ACPi_ModuleID : UDINT;
		ACPi_SerialNumber : UDINT;
	END_STRUCT;
	VFD_IO_IN_typ : 	STRUCT 
		ModuleOK : BOOL;
		ModuleInfo : VFD_IO_IN_ModuleInfo_typ;
		ETAD_Input : UINT;
		ETI_Input : UINT;
		RFRD_Input : INT;
		OTR_Input : INT;
		LCR_Input : UINT;
		THD_Input : UINT;
		THR_Input : UINT;
		IOLR_Input_Bool : ARRAY[0..9] OF BOOL;
		ERRD_Input : UINT;
		LFT_Input : INT;
		StatusDigitalOutput01 : BOOL;
		Counter : DINT;
	END_STRUCT;
	VFD_IO_typ : 	STRUCT 
		IN : VFD_IO_IN_typ;
		OUT : VFD_IO_OUT_typ;
	END_STRUCT;
END_TYPE
