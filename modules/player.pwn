hook OnPlayerRequestClass(playerid, classid)
{
    SetSpawnInfo(
		playerid, 0, 0, 
		1958.3783, 1343.1572, 15.3746, 269.1425, 
		0, 0, 0, 0, 0, 0
	);
	SpawnPlayer(playerid);

    return 1;
}