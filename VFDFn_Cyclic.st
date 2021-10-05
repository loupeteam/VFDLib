(********************************************************************
 * COPYRIGHT --  Automation Resources Group
 ********************************************************************
 * Library: VFD_Lib
 * File: VFDFn_Cyclic.st
 * Author: David
 * Created: September 07, 2010
 ********************************************************************
 * Implementation of library VFD_Lib
 ********************************************************************) 


(********************************************************************)
(* Cyclic function for controlling one VFD 							*)
(********************************************************************)


(* Handling TEST interface						DONE and TESTED DFB 20110512 *)
	(* CMD, PAR									DONE and TESTED DFB 20110511 *)
	(* STAT										DONE and TESTED DFB 20110512 *)

(* Getting status								see VFD_GetStatusFromStatusUINT.st *)

(* Setting machine state						see VFD_SetState.st *)

(* Setting Control Bits							see VFD_SetControlUINT_XXX.st *)
	(* SwOn, Enable	Setting						DONE and TESTED DFB *)

(* Operation when enabled						DONE and TESTED DFB *)

(* Speed scaling								DONE and TESTED DFB *)
	(* Input									DONE and TESTED DFB *)
	(* Output									DONE and TESTED DFB *)
	(* Error checking							DONE and TESTED DFB *)

(* Populating FaultID							DONE and TESTED DFB 20110512 *)
(* Populating FaultString						see VFD_SetFaultString.st *)

(* Encoder handling								see VFD_EncoderFnCyclic.st *)

(* Error reporting								DONE and TESTED DFB 20111220 *)

(* Error acknowledgement						DONE not tested *)
	(* Drive faults								DONE not tested *)
	(* Scaling errors							DONE and TESTED DFB 20111220 *)


FUNCTION VFDFn_Cyclic


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFDFn_Cyclic:=	FALSE;


(****************************************************)
(* Handle TEST interface							*)
(****************************************************)

IF( t.TEST.Enable )THEN


	(* Overwrite IN.CMDs and IN.PARs while in TEST mode *)

	t.IN.CMD:=	t.TEST.CMD;
	t.IN.PAR:=	t.TEST.PAR;	

ELSE


    (* Clear TEST.CMDs and load TEST.PARs from machine while not in TEST mode *)
	
	brsmemset( ADR(t.TEST.CMD), 0, SIZEOF(t.TEST.CMD));
	t.TEST.PAR:=	t.IN.PAR;

END_IF


(************************************************************)
(* Handle internal CMD image resets							*)
(************************************************************)

IF( NOT(t.IN.CMD.Restart) )THEN

	t.Internal.CMD.Restart:=	0;

END_IF


(************************************************************)
(* Set control bits accordingly								*)
(************************************************************)

VFD_SetCMDD_Output_X64( t );


(************************************************************)
(* Get DriveStatus and Extended status						*)
(************************************************************)

VFD_GetDriveStatus( t.IOMap.IN.ETAD_Input, t.OUT.STAT.DriveStatus );
VFD_GetExtendedStatus( t.IOMap.IN.ETI_Input, t.OUT.STAT.Extended );


(************************************************************)
(* Main State Machine										*)
(************************************************************)

(* Set State based on status bits *)

VFD_SetState( t.OUT.STAT );


CASE t.OUT.STAT.State OF

	
	VFD_ST_NOTRDYTOSWON:
	
	
	VFD_ST_SWONDISABLED:
	
	
		(* It is possible to get to this state through a fault condition without disabling the VFD. *)
		(* If this is the case, then bits VFD_CTRLBIT_SWON and VFD_CTRLBIT_ENABLEOPERATION will not be reset. *)
		(* This will make it impossible to leave this state. *)
		(* So, handle a Reset CMD in this state to reset those two bits to get back to VFD_ST_ENABLED. *)
		
		IF( t.IN.CMD.Restart AND NOT(t.Internal.CMD.Restart) )THEN
  
  			t.Internal.CMD.Restart:=	1;
			
			t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_SWON);
			t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_ENABLEOPERATION);
			
		END_IF		
		
		
	VFD_ST_RDYTOSWON:
	
	
		(* If enabled, set SwOn bit *)
		
		IF( t.IN.CMD.Power ) THEN
  			
			t.IOMap.OUT.CMDD_Output:=	BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_SWON);
   
		END_IF			
	
	
	VFD_ST_SWON:
	
	
		(* If enabled, set EnableOp bit *)
		
		IF( t.IN.CMD.Power ) THEN
  			
			t.IOMap.OUT.CMDD_Output:=		BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_ENABLEOPERATION);
   
		END_IF
	
	
	VFD_ST_ENABLED:
		
	
	VFD_ST_QUICKSTOPACTIVE:
	
		
	VFD_ST_FAULTRXNACTIVE:
	
	
	VFD_ST_FAULT:
	
	
END_CASE


(************************************************************)
(* Actual speed input scaling (RPM to Units)				*)
(************************************************************)

t.Internal.ScaleIn.IN.InputValue:=	INT_TO_REAL( t.IOMap.IN.RFRD_Input );


t.Internal.ScaleIn.IN.CFG.Point[0].Input	:=	t.IN.CFG.Scale.MinRPM;
t.Internal.ScaleIn.IN.CFG.Point[0].Output	:=	t.IN.CFG.Scale.MinUnits;
t.Internal.ScaleIn.IN.CFG.Point[1].Input	:=	t.IN.CFG.Scale.MaxRPM;
t.Internal.ScaleIn.IN.CFG.Point[1].Output	:=	t.IN.CFG.Scale.MaxUnits;

ScaleFnCyclic( t.Internal.ScaleIn );

t.OUT.STAT.ActualVelocity:=		t.Internal.ScaleIn.OUT.OutputValue;
t.OUT.STAT.ActualVelocity_RPM:=	INT_TO_REAL( t.IOMap.IN.RFRD_Input );


(************************************************************)
(* Set speed output scaling (Units to RPM)					*)
(************************************************************)

t.Internal.ScaleOut.IN.InputValue:=	t.IN.PAR.Velocity;

t.Internal.ScaleOut.IN.CFG.Point[0].Input	:=	t.IN.CFG.Scale.MinUnits;
t.Internal.ScaleOut.IN.CFG.Point[0].Output	:=	t.IN.CFG.Scale.MinRPM;
t.Internal.ScaleOut.IN.CFG.Point[1].Input	:=	t.IN.CFG.Scale.MaxUnits;
t.Internal.ScaleOut.IN.CFG.Point[1].Output	:=	t.IN.CFG.Scale.MaxRPM;

ScaleFnCyclic( t.Internal.ScaleOut );

t.IOMap.OUT.LFRD_Output:=	REAL_TO_INT( t.Internal.ScaleOut.OUT.OutputValue );


(************************************************************)
(* Set FaultID and FaultString								*)
(************************************************************)

t.OUT.STAT.DriveStatus.FaultID:=	t.IOMap.IN.LFT_Input;

VFD_SetFaultString( t.OUT.STAT.DriveStatus.FaultID, t.OUT.STAT.DriveStatus.FaultString );


(************************************************************)
(* Encoder handling											*)
(************************************************************)

t.IOMap.OUT.EnableCounter:=	1;

t.Encoder.IN.Counter:=		t.IOMap.IN.Counter;

VFD_EncoderFn_Cyclic( t.Encoder );


(************************************************************)
(* Error reporting and acknowledgement						*)
(************************************************************)


(* Handle CMD.AcknowledgeError - doing this before
	setting Error status gets rid of the one scan toggle on Error. *)
	
(* Wait 50ms before resetting CMD.AcknowledgeError and clearing
	error status. This will allow the VFD time to respond appropriately *)

t.Internal.AckResetTimer.IN:=	t.IN.CMD.AcknowledgeError;
t.Internal.AckResetTimer.PT:=	T#50ms;

t.Internal.AckResetTimer();

IF( t.Internal.AckResetTimer.Q )THEN

	t.IN.CMD.AcknowledgeError:=	0;

	t.OUT.STAT.Error:=			0;
	t.OUT.STAT.ErrorID:=		0;
	t.OUT.STAT.ErrorString:=	'';
	
END_IF


(* Set Error status *)

IF( t.OUT.STAT.DriveStatus.Fault )THEN

	t.OUT.STAT.Error:=			1;
	t.OUT.STAT.ErrorID:=		t.OUT.STAT.DriveStatus.FaultID;
	t.OUT.STAT.ErrorString:=	t.OUT.STAT.DriveStatus.FaultString;

ELSIF( 		t.Internal.ScaleIn.OUT.STAT.Error
		OR	t.Internal.ScaleOut.OUT.STAT.Error
		)THEN

	t.OUT.STAT.Error:=			1;
	t.OUT.STAT.ErrorString:=	'Speed scaling error. Check IN.CFG.Scale.';

ELSIF( t.Encoder.OUT.STAT.Error )THEN

	t.OUT.STAT.Error:=			1;
	t.OUT.STAT.ErrorString:=	'Encoder scaling error. Check Encoder.IN.CFG.Scale.';
	
END_IF


(********************************************************************)
(* Map TEST.STAT items												*)
(********************************************************************)

t.TEST.STAT.ActualVelocity:=		t.OUT.STAT.ActualVelocity;
t.TEST.STAT.ActualVelocity_RPM:=	t.OUT.STAT.ActualVelocity_RPM;
t.TEST.STAT.Error:=					t.OUT.STAT.Error;
t.TEST.STAT.ErrorID:=				t.OUT.STAT.ErrorID;
t.TEST.STAT.ErrorString:=			t.OUT.STAT.ErrorString;
t.TEST.STAT.RdyToSwOn:=				t.OUT.STAT.DriveStatus.RdyToSwOn;
t.TEST.STAT.SwOn:=					t.OUT.STAT.DriveStatus.SwOn;
t.TEST.STAT.OpEnabled:=				t.OUT.STAT.DriveStatus.OpEnabled;
t.TEST.STAT.Fault:=					t.OUT.STAT.DriveStatus.Fault;
t.TEST.STAT.FaultID:=				t.OUT.STAT.DriveStatus.FaultID;
t.TEST.STAT.VoltageDisabled:=		t.OUT.STAT.DriveStatus.VoltageDisabled;
t.TEST.STAT.QuickStop:=				t.OUT.STAT.DriveStatus.QuickStop;
t.TEST.STAT.SwOnDisabled:=			t.OUT.STAT.DriveStatus.SwOnDisabled;
t.TEST.STAT.AlarmPresent:=			t.OUT.STAT.DriveStatus.AlarmPresent;
t.TEST.STAT.RefReached:=			t.OUT.STAT.DriveStatus.RefReached;
t.TEST.STAT.State:=					t.OUT.STAT.State;


END_FUNCTION
