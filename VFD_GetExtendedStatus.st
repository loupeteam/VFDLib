(********************************************************************
 * COPYRIGHT --  Automation Resources Group
 ********************************************************************
 * Library: VFD_Lib
 * File: VFD_GetExtendedStatus.st
 * Author: David
 * Created: May 12, 2011
 ********************************************************************
 * Implementation of library VFD_Lib
 ********************************************************************) 


(********************************************************************)
(* This functions unpacks the Extended status word 					*)
(********************************************************************)


(* Functionality		DONE and TESTED DFB 20110512 *)


FUNCTION VFD_GetExtendedStatus


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFD_GetExtendedStatus:=	FALSE;


(************************************************************)
(* Unpack ExtendedStatus				 					*)
(************************************************************)

ExtendedStatus.Running:= 				ETI_Input.4;
ExtendedStatus.DCInjection:= 			ETI_Input.5;
ExtendedStatus.Transient:= 				ETI_Input.6;
ExtendedStatus.ThermalOverloadAlarm:= 	ETI_Input.7;
ExtendedStatus.BrakeAlarm:= 			ETI_Input.8;
ExtendedStatus.Accelerating:= 			ETI_Input.9;
ExtendedStatus.Decelerating:=		 	ETI_Input.10;
ExtendedStatus.CurrentLimitAlarm:= 		ETI_Input.11;
ExtendedStatus.FastStop:= 				ETI_Input.12;
ExtendedStatus.DirectionReq:= 			ETI_Input.15;


END_FUNCTION
