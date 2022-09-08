CMD:v(playerid, params[]) // /v [vehicleid]
{
    new vehicleType;
    if(sscanf(params, "i", vehicleType))
        SendClientMessage(playerid, COLOR_RED, "Uso: /v [id do veiculo]");
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
    SendClientMessage(playerid, COLOR_BLUE, msgX);
    SendClientMessage(playerid, COLOR_BLUE, msgY);
    SendClientMessage(playerid, COLOR_BLUE, msgZ);

    printf("X: %f", x);
    printf("Y: %f", y);
    printf("Z: %f\n", z);

    SetPlayerCheckpoint(playerid, x, y, z, CHECKPOINT_SIZE);

    return 1;
}

CMD:getang(playerid, params[])
{
    new Float:angle;
    GetPlayerFacingAngle(playerid, angle);
    printf("Angle: %f", angle);

    return 1;
}
