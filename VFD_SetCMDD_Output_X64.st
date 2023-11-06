(*
 * File: VFD_SetCMDD_Output_X64.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of VFDLib, licensed under the MIT License.
 *
 *)


(************************************************************************************)
(* This function sets the bits in the control word based on the axis input values.	*)
(************************************************************************************)


(* SwOn, EnableOperation					DONE and TESTED DFB *)
	(* Setting								see VFDFnCyclic.st *)
	(* Resetting							DONE and TESTED DFB *)

(* VoltageDisable							DONE and TESTED DFB *)
				
(* QuickStop								DONE and TESTED DFB *)
				
(* FaultReset								DONE and TESTED DFB *)

(* Reverse									DONE and TESTED DFB *)

(* Stop_Stt									DONE and TESTED DFB *)
			

FUNCTION VFD_SetCMDD_Output_X64


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFD_SetCMDD_Output_X64:=	FALSE;


(****************************************************************************)
(* Switch On and Enable Operation control bits are set in the state machine	*)
(* They are reset here *)

IF( NOT(t.IN.CMD.Power) ) THEN
	
	t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_SWON);
	t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_ENABLEOPERATION);

END_IF


(****************************************************************************)
(* Set VoltageDisable bit based on enable *)
(* 0 = Disable voltage, 1 = Enable Voltage *)

IF( t.IN.CMD.Power )THEN
	
	t.IOMap.OUT.CMDD_Output:=	BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_DISABLEVOLTAGE);
	
ELSE
	
	t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_DISABLEVOLTAGE);
	
END_IF


(****************************************************************************)
(* Set quickstop control bit (no quickstop functionality supported) *)
(* 0 = Quickstop active, 1 = Quickstop inactive *)

t.IOMap.OUT.CMDD_Output:=	BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_QUICKSTOP);


(****************************************************************************)
(* Set Fault Reset and warning reset control bits according to CMD  *)
(* THIS MIGHT ALSO NEED TO BE IN THE STATE MACHINE *)

IF( t.IN.CMD.AcknowledgeError ) THEN

	t.IOMap.OUT.CMDD_Output:=	BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_FAULTRESET);

ELSE

	t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_FAULTRESET);
	
END_IF


(****************************************************************************)
(* Set reverse bit based on command *)
(* THIS MIGHT ALSO NEED TO BE IN THE STATE MACHINE *)

IF( t.IN.CMD.Reverse ) THEN

	t.IOMap.OUT.CMDD_Output:=	BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_REV);

ELSE

	t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_REV);
	
END_IF


(****************************************************************************)
(* Set Stop bit based on command *)
(* THIS MIGHT ALSO NEED TO BE IN THE STATE MACHINE *)

IF( t.IN.CMD.Run ) THEN

	t.IOMap.OUT.CMDD_Output:=	BIT_CLR(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_STOP_STT);

ELSE

	t.IOMap.OUT.CMDD_Output:=	BIT_SET(t.IOMap.OUT.CMDD_Output, VFD_CTRLBIT_STOP_STT);
	
END_IF


END_FUNCTION
