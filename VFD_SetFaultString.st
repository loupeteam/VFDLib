(********************************************************************
 * COPYRIGHT --  Automation Resources Group
 ********************************************************************
 * Library: VFD_Lib
 * File: VFD_SetFaultString.st
 * Author: David
 * Created: October 12, 2010
 ********************************************************************
 * Implementation of library VFD_Lib
 ********************************************************************) 


(************************************************************************)
(* This function sets the error text based on the LFT fault ID input.	*)
(************************************************************************)


(* Functionality		DONE and TESTED DFB *)


FUNCTION VFD_SetFaultString


(************************************************************)
(* Set return value to get rid of compile warning 			*)
(************************************************************)

VFD_SetFaultString:=	FALSE;


(* Set FaultString *)

CASE ID OF
	
	0:	String:=	'"nOF": No fault code saved';
	3:	String:=	'"CFF": Incorrect configuration (parameters)';
	4:	String:=	'"CFI": Invalid configuration (parameters)';
	5:	String:=	'"SLF": Modbus communication interruption';
	6:	String:=	'"ILF": Internal communication interruption';
	7:	String:=	'"CnF": Communication option card';
	8:	String:=	'"EPF": External fault';
	9:	String:=	'"OCF": Overcurrent';
	10:	String:=	'"CrF": Capacitor pre-charge';
	13:	String:=	'"LFF": 4 - 20 mA loss';
	16:	String:=	'"OHF": Drive overheating';
	17:	String:=	'"OLF": Motor overload';
	18:	String:=	'"ObF": DC bus overvoltage';
	19:	String:=	'"OSF": Line supply overvoltage';
	20:	String:=	'"OPF": Motor phase loss';
	21:	String:=	'"PHF": Line phase loss';
	22:	String:=	'"USF": Line supply undervoltage';
	23:	String:=	'"OCF": Motor short-circuit (phase to phase)';
	24:	String:=	'"SOF": Motor overspeed';
	25:	String:=	'"tnF": Auto-tuning was unsuccessful';
	26:	String:=	'"IF1": Unknown rating';
	27:	String:=	'"IF2": MMI card';
	28:	String:=	'"IF3": MMI communication';
	29:	String:=	'"IF4": Industrial EEPROM';
	30:	String:=	'"EEF": EEPROM memory';
	31:	String:=	'"OCF": Impeding short-circuit';
	32:	String:=	'"SCF": Motor short-circuit (to ground)';
	33:	String:=	'"OPF": Motor phase loss - 3 phases';
	34:	String:=	'"COF": Communication interruption, fault line 2 (CANopen)';
	35:	String:=	'"bLF": Brake control';
	36:	String:=	'"OCF": Power module, specific to 15kW drives';
	55:	String:=	'"SCF": Power module or motor short-circuit, detected at power up.';
	ELSE String:=	'Invalid FaultID';
	
END_CASE


END_FUNCTION
