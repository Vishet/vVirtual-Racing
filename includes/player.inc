enum PLAYER_MODE
{
    PM_FREE,
    PM_SESSION,
    PM_QUALIFY,
    PM_RACE
}

enum PLAYER_DATA
{
    PD_SESSION_ID,
    PLAYER_MODE:PD_MODE
}

new players[MAX_PLAYERS][PLAYER_DATA];

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