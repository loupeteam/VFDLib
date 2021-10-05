![Automation Resources Group](http://automationresourcesgroup.com/images/arglogo254x54.png)

#VFDLib Library
The VFDLib library provides a clean interface for basic control of variable frequency drives (VFDs).

#Usage
The VFDLib functionality can be integrated into any project using a data structure and a function call. For an example of how to use this in a project, please see the ARG Automation Studio Starter Project at [https://github.com/autresgrp/StarterProject](https://github.com/autresgrp/StarterProject).

##Initialization
To use the VFDLib functionality, a variable must be declared of type **VFD_typ**. This variable should then be initialized in the INIT routine of your program. This initialization consists of setting configuration settings and initial motion parameters.

	VFD.IN.CFG.Scale.MinUnits:=	0;
	VFD.IN.CFG.Scale.MinRPM:=	0;
	VFD.IN.CFG.Scale.MaxUnits:=	1500;
	VFD.IN.CFG.Scale.MaxRPM:=	1500;
	
	VFD.IN.PAR.Velocity:=		100;

The interface from the VFD variable to the VFD hardware is done via IO mappings. All necessary IO points are contained in the VFD.IOMap structure. These IO points are named consistently with the IO mapping entry names for the VFDs.

##Cyclic Operation
To control the axis cyclically, the **VFDFn_Cyclic()** function must be called in the CYCLIC routine of your program, once every scan, unconditionally. This function should not be called on the same VFD variable more than once per scan.

	VFDFn_Cyclic( VFD );

The VFD variable can then be used as an interface for higher level motion sequencing programs.

#Reference

##VFD Data Structure
The main data structure of the VFDLib library is the VFD structure (VFD_typ datatype). This provides the interface to higher level programs and also stores all necessary internal information. It is divided into inputs (VFD.IN), outputs (VFD.OUT), a test interface (VFD.TEST), IO points (VFD.IOMap), an encoder structure (VFD.Encoder) and internals (VFD.Internal).

###Inputs
The VFD inputs are divided into commands (IN.CMD), parameters (IN.PAR), and configuration settings (IN.CFG). Commands are used to initiate operations, and parameters and configuration settings determine how the commands will be processed. The difference between parameters and configuration settings is that configuration settings are generally set only once, while parameters might be set any time a command is issued.

####Commands
* **Power** - Power the motor. If set to 1, the motor will be powered. If set to 0, the motor will be depowered.
* **Run** - Run the motor at speed. If set to 1, the motor will run at the specified **Velocity**. If set to 0, the motor will stop.
* **Reverse** - Reverse the direction of motion.
* **AcknowledgeError** - Acknowledge any errors on the VFD.
* **Restart** - Restart the VFD after a fault has occurred.

####Parameters
* **Velocity** - Velocity for motion. [units]

####Configuration Settings
* **Scale** - These settings specify the scaling between velocity units and the native VFD units, RPM. The four settings constitute a point pair used for linear scaling.

###Outputs
The VFD outputs contain status information (OUT.STAT).

* **ActualVelocity** - Current motor velocity. [units]
* **ActualVelocity_RPM** - Current motor velocity. [RPM]
* **DriveStatus**, **Extended** - Extended drive status information. See the ACOPOSinverter help for details.
* **State** - Current VFD state.
* **Error** - An error exists for the axis. **Error** is reset with the **AcknowledgeError** command.
* **ErrorID** - Current error ID number.
* **ErrorString** - Current error text.

###Test Interface
The test interface gives you direct access to the axis commands and parameters, interrupting any commands from higher level programs. This allows for easy testing of the axis during machine commissioning or servicing. **The test commands and parameters are intended for use in an Automation Studio watch window and SHOULD NOT BE SET IN PROGRAMS**.

* **Enable** - If set to 1, TEST.CMD and TEST.PAR take priority over IN.CMD and IN.PAR. If set to 0, then TEST.CMD and TEST.PAR are ignored.
* **CMD** - Test commands. See above for a full list of commands.
* **PAR** - Test parameters. See above for a full list of parameters.
* **STAT** - A reduced set of status information that is always available whether test mode is enabled or not.

###Encoder
The VFD.Encoder structure is divided into inputs (Encoder.IN), and outputs (Encoder.OUT)

####Encoder Inputs
* **Counter** - Encoder position input. **THIS VARIABLE SHOULD NOT BE MAPPED TO IO OR SET IN PROGRAMS. It is automatically set to VFD.IOMap.IN.Counter.**
* **CFG.Scale** - These specify the scaling between velocity units and encoder counts per second. The four settings constitute a point pair for linear scaling.
* **CFG.tf**, **CFG.deadband**, **CFG.K** - These settings configure the internal speed estimator used to report the current encoder speed. For details on these parameters, please see the documentation for the SpdEstLib library.

####Encoder Outputs
* **SpeedUnits** - Encoder speed in units/s.
* **SpeedCounts** - Encoder speed in counts/s.
* **STAT.Error** - Encoder scaling error exists. **Error** is automatically reset when the scaling error is corrected.

##Error ID Numbers
* 3 - "CFF": Incorrect configuration (parameters)
* 4 - "CFI": Invalid configuration (parameters)
* 5 - "SLF": Modbus communication interruption
* 6 - "ILF": Internal communication interruption
* 7 - "CnF": Communication option card
* 8 - "EPF": External fault
* 9 - "OCF": Overcurrent
* 10 - "CrF": Capacitor pre-charge
* 13 - "LFF": 4 - 20 mA loss
* 16 - "OHF": Drive overheating
* 17 - "OLF": Motor overload
* 18 - "ObF": DC bus overvoltage
* 19 - "OSF": Line supply overvoltage
* 20 - "OPF": Motor phase loss
* 21 - "PHF": Line phase loss
* 22 - "USF": Line supply undervoltage
* 23 - "OCF": Motor short-circuit (phase to phase)
* 24 - "SOF": Motor overspeed
* 25 - "tnF": Auto-tuning was unsuccessful
* 26 - "IF1": Unknown rating
* 27 - "IF2": MMI card
* 28 - "IF3": MMI communication
* 29 - "IF4": Industrial EEPROM
* 30 - "EEF": EEPROM memory
* 31 - "OCF": Impeding short-circuit
* 32 - "SCF": Motor short-circuit (to ground)
* 33 - "OPF": Motor phase loss - 3 phases
* 34 - "COF": Communication interruption, fault line 2 (CANopen)
* 35 - "bLF": Brake control
* 36 - "OCF": Power module, specific to 15kW drives
* 55 - "SCF": Power module or motor short-circuit, detected at power up.