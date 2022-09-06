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

CMD:v(playerid, params[]) // /v [vehicleid]
{
    new vehicleType;
    if(sscanf(params, "i", vehicleType))
        SendClientMessage(playerid, RED, "Uso: /v [id do veiculo]");
    else
    {
        new Float:x, Float:y, Float:z, Float:angle;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);
        new vehicleId = CreateVehicle(vehicleType, x, y, z, angle, 0, 0, -1);
        PutPlayerInVehicle(playerid, vehicleId, 0);
    }

    return 1;
}

CMD:testcheckpoint(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new msgX[64], msgY[64], msgZ[64];
    format(msgX, sizeof(msgX), "[ADMIN] X: %f", x);
    format(msgY, sizeof(msgY), "[ADMIN] Y: %f", y);
    format(msgZ, sizeof(msgZ), "[ADMIN] Z: %f", z);
    SendClientMessage(playerid, BLUE, msgX);
    SendClientMessage(playerid, BLUE, msgY);
    SendClientMessage(playerid, BLUE, msgZ);

    printf("X: %f", x);
    printf("Y: %f", y);
    printf("Z: %f\n", z);

    SetPlayerCheckpoint(playerid, x, y, z, 20);

    return 1;
}
