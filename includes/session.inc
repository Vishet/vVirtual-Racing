enum SESSION_MODE
{
    SM_UNEXIST,
    SM_UNSTARTED,
    SM_QUALIFY,
    SM_RACE
}

enum SESSION_DATA 
{
    CIRCUIT_ID:SD_CIRCUIT_ID,
    SD_PLAYERSNUMBER,
    SD_PLAYERS[SESSION_MAX_PLAYER],
    SESSION_MODE:SD_MODE
}

new sessions[MAX_PLAYERS][SESSION_DATA];