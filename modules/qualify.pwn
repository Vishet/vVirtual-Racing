#include <YSI_Coding\y_hooks>

CMD:startqualy(playerid, params[])
{
    if(sessions[playerid][SD_MODE] == SM_UNEXIST)
    {
        SendClientMessage(playerid, COLOR_RED, "Você não é criador de nenhuma sessão");
        return 1;
    }
    else if(sessions[playerid][SD_MODE] != SM_UNSTARTED)
    {
        SendClientMessage(playerid, COLOR_RED, "Você já começou uma classificação");
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

        new Float:x = Circuits[circuitID][CD_XCHECKPOINTS][0];
        new Float:y = Circuits[circuitID][CD_YCHECKPOINTS][0];
        new Float:z = Circuits[circuitID][CD_ZCHECKPOINTS][0];
        new Float:angle = Circuits[circuitID][CD_FIRST_ANGLE];

        SetPlayerPosFindZ(playerid, x, y, z);
        defer delayedVehicle(playerid, 451, x, y, z, angle, 0, 0, -1);
    }

    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    if(checkpointChains[playerid][CC_LAP] > 1)
    {
        SendClientMessage(playerid, COLOR_BLUE, "Lap completed");
    }

    return 1;
}