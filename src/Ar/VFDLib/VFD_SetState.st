(*
 * File: VFD_SetState.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of VFDLib, licensed under the MIT License.
 *
 *)


(********************************************************************)
(* This function sets the state based on the status bits.			*)
(********************************************************************)


(* VFD_ST_NOTRDYTOSWON				DONE and TESTED DFB 20110512 *)
(* VFD_ST_SWONDISABLED				DONE and TESTED DFB 20110512 *)
(* VFD_ST_RDYTOSWON					DONE and TESTED DFB 20110512 *)
(* VFD_ST_SWON						DONE and TESTED DFB 20110512 *)
(* VFD_ST_ENABLED					DONE and TESTED DFB 20110512 *)
(* VFD_ST_QUICKSTOPACTIVE			DONE and TESTED DFB 20110512 *)
(* VFD_ST_FAULTRXNACTIVE			DONE and TESTED DFB 20110512 *)
(* VFD_ST_FAULT						DONE and TESTED DFB 20110512 *)


FUNCTION VFD_SetState


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFD_SetState:=	FALSE;


(************************************************************)
(* Set state 												*)
(************************************************************)

IF( 	(t.DriveStatus.RdyToSwOn = 0)
	AND	(t.DriveStatus.SwOn = 0)
	AND	(t.DriveStatus.OpEnabled = 0)
	AND	(t.DriveStatus.Fault = 0)
	AND	(t.DriveStatus.SwOnDisabled = 0)
	)THEN

	
	t.State:=	VFD_ST_NOTRDYTOSWON;
	

ELSIF(		(t.DriveStatus.RdyToSwOn = 0)
		AND	(t.DriveStatus.SwOn = 0)
		AND	(t.DriveStatus.OpEnabled = 0)
		AND	(t.DriveStatus.Fault = 0)
		AND	(t.DriveStatus.SwOnDisabled = 1)
		)THEN


	t.State:=	VFD_ST_SWONDISABLED;


ELSIF(		(t.DriveStatus.RdyToSwOn = 1)
		AND	(t.DriveStatus.SwOn = 0)
		AND	(t.DriveStatus.OpEnabled = 0)
		AND	(t.DriveStatus.Fault = 0)
		AND	(t.DriveStatus.QuickStop = 1)
		AND	(t.DriveStatus.SwOnDisabled = 0)
		)THEN


	t.State:=	VFD_ST_RDYTOSWON;


ELSIF(		(t.DriveStatus.RdyToSwOn = 1)
		AND	(t.DriveStatus.SwOn = 1)
		AND	(t.DriveStatus.OpEnabled = 0)
		AND	(t.DriveStatus.Fault = 0)
		AND	(t.DriveStatus.QuickStop = 1)
		AND	(t.DriveStatus.SwOnDisabled = 0)
		)THEN


	t.State:=	VFD_ST_SWON;


ELSIF(		(t.DriveStatus.RdyToSwOn = 1)
		AND	(t.DriveStatus.SwOn = 1)
		AND	(t.DriveStatus.OpEnabled = 1)
		AND	(t.DriveStatus.Fault = 0)
		AND	(t.DriveStatus.QuickStop = 1)
		AND	(t.DriveStatus.SwOnDisabled = 0)
		)THEN


	t.State:=	VFD_ST_ENABLED;


ELSIF(	(t.DriveStatus.RdyToSwOn = 1)
		AND	(t.DriveStatus.SwOn = 1)
		AND	(t.DriveStatus.OpEnabled = 1)
		AND	(t.DriveStatus.Fault = 0)
		AND	(t.DriveStatus.QuickStop = 0)
		AND	(t.DriveStatus.SwOnDisabled = 0)
		)THEN


	t.State:=	VFD_ST_QUICKSTOPACTIVE;


ELSIF(		(t.DriveStatus.RdyToSwOn = 1)
		AND	(t.DriveStatus.SwOn = 1)
  		AND	(t.DriveStatus.OpEnabled = 1)
		AND	(t.DriveStatus.Fault = 1)
		AND	(t.DriveStatus.SwOnDisabled = 0)
		)THEN


	t.State:=	VFD_ST_FAULTRXNACTIVE;


ELSIF(	(t.DriveStatus.RdyToSwOn = 0)
		AND	(t.DriveStatus.SwOn = 0)
		AND	(t.DriveStatus.OpEnabled = 0)
		AND	(t.DriveStatus.Fault = 1)
		AND	(t.DriveStatus.SwOnDisabled = 0)
		)THEN


	t.State:=	VFD_ST_FAULT;


END_IF	
	

END_FUNCTION
