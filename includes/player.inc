enum PLAYER_DATA
{
    PD_SESSION_ID
}

new players[MAX_PLAYERS][PLAYER_DATA];

stock KickPlayerFromSession(playerid)
{
    new pSessionId = players[playerid][PD_SESSION_ID];

    if(pSessionId < 0)
        return -1;

    for(new i = 0; i < sessions[pSessionId][SD_PLAYERSNUMBER]; i++)
    {
        if(sessions[pSessionId][SD_PLAYERS][i] == playerid)
        {
            sessions[pSessionId][SD_PLAYERS][i] = -1;
            return i;
        }
    }

    return -1;
}