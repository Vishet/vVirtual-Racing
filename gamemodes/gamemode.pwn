#include <a_samp>

#include <YSI_Coding/y_hooks>
#include <zcmd>
#include <sscanf2>
#include "includes/DOF2.inc"
#define YSI_NO_HEAP_MALLOC
#include <YSI_Coding/y_timers>

#include "includes/config.inc"
#include "includes/colors.inc"
#include "includes/util.inc"
#include "includes/circuits.inc"
#include "includes/session.inc"
#include "includes/qualify.inc"
#include "includes/player.inc"
#include "includes/checkpoint-chain.inc"

#include "modules/admin.pwn"
#include "modules/session.pwn"
#include "modules/qualify.pwn"
#include "modules/player.pwn"
#include "modules/checkpoint-chain.pwn"

main() 
{
}

public OnGameModeInit() 
{
	SetGameModeText("Racing");
	LoadCircuit(CID_LAS_VEGAS, "circuits/las_vegas_street_circuit/");
	return 1;
}

public OnGameModeExit()
{
	DOF2_Exit();
	return 1;
}