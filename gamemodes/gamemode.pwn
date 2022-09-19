#include <a_samp>

#include <zcmd>
#include <sscanf2>
#include "includes/DOF2.inc"
#define YSI_NO_HEAP_MALLOC
#include <YSI_Coding/y_timers>
#include <tick-difference>

#include "includes/timestamp.inc"
#include "includes/config.inc"
#include "includes/colors.inc"
#include "includes/circuits.inc"
#include "includes/session.inc"
#include "includes/player.inc"
#include "includes/checkpoint-chain.inc"
#include "includes/qualify.inc"

#include "includes/util.inc"

#include "modules/admin.pwn"
#include "modules/session.pwn"
#include "modules/checkpoint-chain.pwn"
#include "modules/qualify.pwn"
#include "modules/player.pwn"

main() 
{
}

public OnGameModeInit() 
{
	SetGameModeText("Racing");
	LoadCircuit(CID_LAS_VEGAS, "circuits/las_vegas_street_circuit/");
	LoadCircuit(CID_TEST, "circuits/test_circuit/");
	return 1;
}

public OnGameModeExit()
{
	DOF2_Exit();
	return 1;
}