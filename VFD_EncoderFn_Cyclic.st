(********************************************************************
 * COPYRIGHT --  Automation Resources Group
 ********************************************************************
 * Library: VFD_Lib
 * File: VFD_EncoderFn_Cyclic.st
 * Author: David
 * Created: September 09, 2010
 ********************************************************************
 * Implementation of library VFD_Lib
 ********************************************************************) 


(********************************************************************)
(* Cyclic function for getting VFD speed from encoder feedback 		*)
(********************************************************************)


(* RTInfo FUB		DONE and TESTED DFB *)
(* SpdEst FUB		DONE and TESTED DFB *)
(* Scaling			DONE and TESTED DFB *)
(* Outputs			DONE and TESTED DFB *)


FUNCTION VFD_EncoderFn_Cyclic


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFD_EncoderFn_Cyclic:=	FALSE;


(************************************************************)
(* Find period using RTInfo FUB					 			*)
(************************************************************)

t.Internal.RTInfo.enable:=	1;

t.Internal.RTInfo();


(************************************************************)
(* SpdEst FUB									 			*)
(************************************************************)

t.Internal.SpeedEst.Position:=	t.IN.Counter;
t.Internal.SpeedEst.T:=			UDINT_TO_REAL(t.Internal.RTInfo.cycle_time) / 1000000.0;	(* sample period [s] *)


(* Default tf to 100ms *)

IF( t.IN.CFG.tf = 0 )THEN
	t.Internal.SpeedEst.tf:=	0.1;
ELSE
	t.Internal.SpeedEst.tf:=	t.IN.CFG.tf;
END_IF

t.Internal.SpeedEst.deadband:=	t.IN.CFG.deadband;
t.Internal.SpeedEst.K:=			t.IN.CFG.K;

t.Internal.SpeedEst();


(************************************************************)
(* Scaling										 			*)
(************************************************************)

t.Internal.ScaleOut.IN.InputValue:=	t.Internal.SpeedEst.Speed_est;

t.Internal.ScaleOut.IN.CFG.Point[0].Input:=		t.IN.CFG.Scale.MinCounts;
t.Internal.ScaleOut.IN.CFG.Point[0].Output:=	t.IN.CFG.Scale.MinUnits;
t.Internal.ScaleOut.IN.CFG.Point[1].Input:=		t.IN.CFG.Scale.MaxCounts;
t.Internal.ScaleOut.IN.CFG.Point[1].Output:=	t.IN.CFG.Scale.MaxUnits;

ScaleFnCyclic( t.Internal.ScaleOut );


(************************************************************)
(* Encoder outputs								 			*)
(************************************************************)

t.OUT.SpeedUnits:=	t.Internal.ScaleOut.OUT.OutputValue;
t.OUT.SpeedCounts:=	t.Internal.SpeedEst.Speed_est;

IF( (t.Internal.RTInfo.status <> 0)			OR
	(t.Internal.ScaleOut.OUT.STAT.Error)	)THEN

	t.OUT.STAT.Error:=	1;
	
ELSE
		
	t.OUT.STAT.Error:=	0;
	
END_IF


END_FUNCTION
