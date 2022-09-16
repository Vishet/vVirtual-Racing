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
    if(ccLap > 1 && ccIndex == 1)
    {
        new lapMsg[64];
        new lapTime = checkpointChains[playerid][CC_LAST_LAPTIME];

        new minutes = 0;
        new seconds = 0;
        new milliseconds = 0;
        millisecondsToTimestamp(lapTime, minutes, seconds, milliseconds);

        if(minutes == 0)
            format(lapMsg, sizeof(lapMsg), "Volta terminada: %d.%d", seconds, milliseconds);
        else
            format(lapMsg, sizeof(lapMsg), "Volta terminada: %d:%d.%d", minutes, seconds, milliseconds);
        SendClientMessage(playerid, COLOR_GREEN, lapMsg);

        new sessionId = players[playerid][PD_SESSION_ID];
        new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
        for(new i = 0; i < playerCount; i++)
        {
            new driverId = sessions[sessionId][SD_PLAYERS][i];
            new playerPosition = GetPositionByPlayerId(driverId);

            new playerName[MAX_PLAYER_NAME];
            GetPlayerName(driverId, playerName);

            new currentLap = checkpointChains[driverId][CC_LAP];
            if(currentLap > 1)
            {
                new driverLapTime = checkpointChains[driverId][CC_LAST_LAPTIME];

                new driverLapTimestamp[64];
                GetTimestampString(driverLapTime, driverLapTimestamp, sizeof(driverLapTimestamp));
                new msg[128];
                format(msg, sizeof(msg), "[%d] %s: %s", playerPosition, playerName, driverLapTimestamp);
                SendClientMessageToAll(COLOR_GREEN, msg);
            }       
        }      
    }

    return 1;
}