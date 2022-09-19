#include <YSI_Coding\y_hooks>

CMD:startqualy(playerid, params[])
{
    new sessionId = playerid;

    if(sessions[sessionId][SD_MODE] == SM_UNEXIST)
    {
        SendClientMessage(playerid, COLOR_RED, "Você não é criador de nenhuma sessão");
        return 1;
    }
    else if(sessions[sessionId][SD_MODE] != SM_UNSTARTED)
    {
        SendClientMessage(playerid, COLOR_RED, "Você já começou uma classificação");
        return 1;
    }

    sessions[sessionId][SD_MODE] = SM_QUALIFY;
    SendClientMessage(playerid, COLOR_BLUE, "A Classificação começou");

    return 1;
}

CMD:joinqualy(playerid, params[])
{
    new sessionId = players[playerid][PD_SESSION_ID];
    if(sessionId == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Você não está em uma sessão");
        return 1;
    }
    else if(sessions[sessionId][SD_MODE] == SM_UNSTARTED)
    {
        SendClientMessage(playerid, COLOR_RED, "A classificação não começou");
        return 1;
    }
    else if(players[playerid][PD_MODE] == PM_QUALIFY)
    {
        SendClientMessage(playerid, COLOR_RED, "Você já está na classificação");
        return 1;
    }

    players[playerid][PD_MODE] = PM_QUALIFY;

    new CIRCUIT_ID:circuitID = sessions[sessionId][SD_CIRCUIT_ID];
    new cpCount =  Circuits[circuitID][CD_CHECKPOINTS_COUNT];
    SetCheckpointChain(
        playerid, 
        Circuits[circuitID][CD_XCHECKPOINTS], 
        Circuits[circuitID][CD_YCHECKPOINTS], 
        Circuits[circuitID][CD_ZCHECKPOINTS], 
        cpCount
    );

    new lastCheckpointIndex = cpCount - 1;
    new Float:x = Circuits[circuitID][CD_XCHECKPOINTS][lastCheckpointIndex];
    new Float:y = Circuits[circuitID][CD_YCHECKPOINTS][lastCheckpointIndex];
    new Float:z = Circuits[circuitID][CD_ZCHECKPOINTS][lastCheckpointIndex];
    new Float:angle = Circuits[circuitID][CD_FIRST_ANGLE];

    SetPlayerPosFindZ(playerid, x, y, z);
    defer delayedVehicle(playerid, 451, x, y, z, angle, 0, 0, -1);

    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    new ccIndex = checkpointChains[playerid][CC_INDEX];
    new ccLap = checkpointChains[playerid][CC_LAP];

    if(ccLap == 1 && ccIndex == 1)
    {
        SendClientMessage(playerid, COLOR_GREEN, "Volta iniciada");
    }
    else if(ccLap >= 2 && ccIndex == 1)
    {
        new lapTime = checkpointChains[playerid][CC_LAST_LAPTIME];
        new lapTimestamp[64];
        GetTimestampString(lapTime, lapTimestamp, sizeof(lapTimestamp));

        new lapMsg[128];
        format(lapMsg, sizeof(lapMsg), "Volta terminada: %s", lapTimestamp);
        SendClientMessage(playerid, COLOR_GREEN, lapMsg);

        UpdatePlayerPosition(playerid);

        new sessionId = players[playerid][PD_SESSION_ID];
        if(IsAllDriversLapped(sessionId))
        {
            ShowSessionPositions(sessionId);
            EndSession(sessionId);
        }
    }

    return 1;
}

