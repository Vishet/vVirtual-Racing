timer delayedVehicle[1000](playerId, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
    CreatePutVehicle(playerId, vehicletype, x, y, z, rotation, color1, color2, respawn_delay);
}

CMD:startqualy(playerid, params[])
{
    if(sessions[playerid][SD_MODE] == SM_UNEXIST)
    {
        SendClientMessage(playerid, COLOR_RED, "Você não é criador de nenhuma sessão");
        return 1;
    }    

    sessions[playerid][SD_MODE] = SM_QUALIFY;

    for(new i = 0; i < sessions[playerid][SD_PLAYERSNUMBER]; i++)
    {
        new CIRCUIT_ID:circuitID = sessions[playerid][SD_CIRCUIT_ID];

        new cpCount =  Circuits[circuitID][CD_CHECKPOINTS_COUNT];
        SetCheckpointChain(
            playerid, 
            Circuits[circuitID][CD_XCHECKPOINTS], 
            Circuits[circuitID][CD_YCHECKPOINTS], 
            Circuits[circuitID][CD_ZCHECKPOINTS], 
            cpCount
        );

        new Float:x = Circuits[circuitID][CD_XCHECKPOINTS];
        new Float:y = Circuits[circuitID][CD_YCHECKPOINTS];
        new Float:z = Circuits[circuitID][CD_ZCHECKPOINTS];
        new Float:angle = Circuits[circuitID][CD_FIRST_ANGLE];

        SetPlayerPosFindZ(playerid, x, y, z);
        defer delayedVehicle(playerid, 451, x, y, z, angle, 0, 0, -1);
        printf("X: %f", x);
        printf("Y: %f", y);
        printf("Z: %f", z);
    }

    return 1;
}