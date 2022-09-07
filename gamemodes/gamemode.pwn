#include <a_samp>

#include <YSI_Coding/y_hooks>
#include <zcmd>
#include <sscanf2>
#include "includes/DOF2.inc"

#include "includes/colors.inc"
#include "includes/circuits.inc"

#include "modules/admin.pwn"

main() 
{
}

public OnGameModeInit() 
{
	SetGameModeText("Racing");
	LoadCircuit("circuits/las_vegas_street_circuit/");
	return 1;
}

public OnGameModeExit()
{
	DOF2_Exit();
	return 1;
}