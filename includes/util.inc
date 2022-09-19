stock EmptyString(string[], stringSize)
{
    for(new i = 0; i < stringSize; i++)
    {
        string[i] = 0;
    }
    string[0] = '\0';
}

stock stringcpy(dest[], destSize,  const source[])
{
    EmptyString(dest, destSize);
    strins(dest, source, 0, destSize);
}


stock CreatePutVehicle(playerid, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
    new vehicleId = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay);
    PutPlayerInVehicle(playerid, vehicleId, 0);
    return vehicleId;
}

stock GetPositionByPlayerId(playerid)
{
    new sessionId = players[playerid][PD_SESSION_ID];

    if(sessionId == -1)
        return -1;

    for(new i = 0; i < sessions[sessionId][SD_PLAYERCOUNT]; ++i)
    {
        if(sessions[sessionId][SD_PLAYERS][i] == playerid)
        {
            return i + 1;
        }
    }

    return 0;
}

stock SetPlayerPosition(playerid, position)
{
    new sessionId = players[playerid][PD_SESSION_ID];
    if(sessionId == -1 && sessions[sessionId][SD_MODE] != SM_UNSTARTED)
        return 0;

    new oldPlayerPosition = GetPositionByPlayerId(playerid);
    if(position == oldPlayerPosition)
        return 0;

    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    new newPositions[SESSION_MAX_PLAYER];

    for(new i = 0; i < playerCount; i++)
    {

        if(i < position)
        {
            newPositions[i] = sessions[sessionId][SD_PLAYERS][i];
        }
        else if(i == position)
        {
            newPositions[i] = playerid;
        }
        else if(i > position)
        {
            if(i > oldPlayerPosition)
                newPositions[i] = sessions[sessionId][SD_PLAYERS][i];
            else
                newPositions[i] = sessions[sessionId][SD_PLAYERS][i - 1];
        }
    }

    sessions[sessionId][SD_PLAYERS] = newPositions;
    return 1;
}

stock UpdatePlayerPosition(playerid)
{
    new sessionId = players[playerid][PD_SESSION_ID];
    if(sessionId == -1 && sessions[sessionId][SD_MODE] != SM_UNSTARTED)
        return 0;

    new playerLap = checkpointChains[playerid][CC_LAST_LAPTIME];
    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    for(new i = 0; i < playerCount; i++)
    {
        new driverId = sessions[sessionId][SD_PLAYERS][i];
        if(checkpointChains[driverId][CC_LAP] > 1)
        {
            new driverLap = checkpointChains[driverId][CC_LAST_LAPTIME];
            if(playerLap < driverLap)
                SetPlayerPosition(playerid, i);
        }
        else
            SetPlayerPosition(playerid, i);
    }

    return 1;
}

stock ShowSessionPositions(sessionId)
{
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

stock IsAllDriversLapped(sessionId)
{
    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    for(new i = 0; i < playerCount; i++)
    {
        new driverId = sessions[sessionId][SD_PLAYERS][i];
        new currentLap = checkpointChains[driverId][CC_LAP];
        if(currentLap < 2)
            return false;
    }

    return true;
}

stock EndSession(sessionId)
{
    if(sessions[sessionId][SD_MODE] == SM_UNEXIST)
    {
        return -1;
    }
        
    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    for(new i = 0; i < playerCount; i++)
    {
        new driverId = sessions[sessionId][SD_PLAYERS][i];
        players[driverId][PD_SESSION_ID] = -1;
        players[driverId][PD_MODE] = PM_FREE;
        EndCheckpointChain(driverId);
    }

    sessions[sessionId][SD_CIRCUIT_ID] = CID_INVALID;
    sessions[sessionId][SD_MODE] = SM_UNEXIST;

    return 1;
}