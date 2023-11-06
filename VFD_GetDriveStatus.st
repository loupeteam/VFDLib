(*
 * File: VFD_GetDriveStatus.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of VFDLib, licensed under the MIT License.
 *
 *)


(********************************************************************)
(* This function unpacks the DriveStatus word						*)
(********************************************************************)


(* Functionality			DONE and TESTED DFB 20110512 *)


FUNCTION VFD_GetDriveStatus


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFD_GetDriveStatus:=	FALSE;


(************************************************************)
(* Unpack DriveStatus				 						*)
(************************************************************)

DriveStatus.RdyToSwOn:=			ETAD_Input.0;
DriveStatus.SwOn:=				ETAD_Input.1;
DriveStatus.OpEnabled:=			ETAD_Input.2;
DriveStatus.Fault:=				ETAD_Input.3;
DriveStatus.VoltageDisabled:=	ETAD_Input.4;
DriveStatus.QuickStop:=			ETAD_Input.5;
DriveStatus.SwOnDisabled:=		ETAD_Input.6;
DriveStatus.AlarmPresent:=		ETAD_Input.7;
DriveStatus.RefReached:=		ETAD_Input.10;
DriveStatus.RefExceeded:=		ETAD_Input.11;
DriveStatus.StopKey:=			ETAD_Input.14;
DriveStatus.DirectionOut:=		ETAD_Input.15;


END_FUNCTION
