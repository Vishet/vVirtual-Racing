#include <YSI_Coding\y_hooks>

hook OnPlayerRequestClass(playerid, classid)
{
	players[playerid][PD_SESSION_ID] = -1;

    SetSpawnInfo(
		playerid, 0, 0, 
		1958.3783, 1343.1572, 15.3746, 269.1425, 
		0, 0, 0, 0, 0, 0
	);
	SpawnPlayer(playerid);

    return 1;
}

hook OnPlayerConnect(playerid)
{
	players[playerid][PD_SESSION_ID] = -1;
	players[playerid][PD_MODE] = PM_FREE;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	KickPlayerFromSession(playerid);
	players[playerid][PD_SESSION_ID] = -1;
	players[playerid][PD_MODE] = PM_FREE;
	return 1;
}