enum CHECKPOINT_CHAIN
{
    Float:CC_XCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CC_YCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CC_ZCHECKPOINTS[MAX_CHECKPOINTS],
    CC_COUNT,
    CC_INDEX,
    CC_LAP,
    CC_START_TICK,
    CC_LAST_LAPTIME
}

new checkpointChains[MAX_PLAYERS][CHECKPOINT_CHAIN];

stock SetCheckpointChain(playerid, const Float:xCheckpoints[], const Float:yCheckpoints[], const Float:zCheckpoints[], checkpointCount)
{
    checkpointChains[playerid][CC_INDEX] = 0;
    checkpointChains[playerid][CC_COUNT] = checkpointCount;
    for(new i = 0; i < checkpointCount; i++)
    {
        checkpointChains[playerid][CC_XCHECKPOINTS][i] = xCheckpoints[i];
        checkpointChains[playerid][CC_YCHECKPOINTS][i] = yCheckpoints[i];
        checkpointChains[playerid][CC_ZCHECKPOINTS][i] = zCheckpoints[i];
    }

    SetPlayerRaceCheckpoint(
        playerid, 0, 
        checkpointChains[playerid][CC_XCHECKPOINTS][0], 
        checkpointChains[playerid][CC_YCHECKPOINTS][0], 
        checkpointChains[playerid][CC_ZCHECKPOINTS][0], 
        checkpointChains[playerid][CC_XCHECKPOINTS][1], 
        checkpointChains[playerid][CC_YCHECKPOINTS][1], 
        checkpointChains[playerid][CC_ZCHECKPOINTS][1], 
        CHECKPOINT_SIZE
    );
}

stock SetCheckpointChainIndex(playerid, index)
{
    new count = checkpointChains[playerid][CC_COUNT];
    if(index < count)
    { 
        new nextIndex = index + 1;
        if(nextIndex == count)
        {
            nextIndex = 0;
        }
        checkpointChains[playerid][CC_INDEX] = index;
        SetPlayerRaceCheckpoint(
            playerid, 0, 
            checkpointChains[playerid][CC_XCHECKPOINTS][index], 
            checkpointChains[playerid][CC_YCHECKPOINTS][index], 
            checkpointChains[playerid][CC_ZCHECKPOINTS][index], 
            checkpointChains[playerid][CC_XCHECKPOINTS][nextIndex], 
            checkpointChains[playerid][CC_YCHECKPOINTS][nextIndex], 
            checkpointChains[playerid][CC_ZCHECKPOINTS][nextIndex], 
            CHECKPOINT_SIZE
        );
    } 
}

stock EndCheckpointChain(playerid)
{
    new checkpointCount = checkpointChains[playerid][CC_COUNT];
    for(new i = 0; i  < checkpointCount; i++)
    {
        checkpointChains[playerid][CC_XCHECKPOINTS][i] = 0;
        checkpointChains[playerid][CC_YCHECKPOINTS][i] = 0;
        checkpointChains[playerid][CC_ZCHECKPOINTS][i] = 0;
    }
    checkpointChains[playerid][CC_COUNT] = 0;
    checkpointChains[playerid][CC_INDEX] = 0;
    checkpointChains[playerid][CC_LAP] = 0;
    checkpointChains[playerid][CC_LAST_LAPTIME] = 0;
    DisablePlayerRaceCheckpoint(playerid);
}

stock DisableCheckpointChain(playerid)
{
    DisablePlayerRaceCheckpoint(playerid);
}

stock EnableCheckpointChain(playerid)
{
    new cpCount = checkpointChains[playerid][CC_COUNT];
    if(cpCount == 0)
        return -1;

    SetPlayerRaceCheckpoint(
        playerid, 0, 
        checkpointChains[playerid][CC_XCHECKPOINTS][index], 
        checkpointChains[playerid][CC_YCHECKPOINTS][index], 
        checkpointChains[playerid][CC_ZCHECKPOINTS][index], 
        checkpointChains[playerid][CC_XCHECKPOINTS][nextIndex], 
        checkpointChains[playerid][CC_YCHECKPOINTS][nextIndex], 
        checkpointChains[playerid][CC_ZCHECKPOINTS][nextIndex], 
        CHECKPOINT_SIZE
    );

    return 1;
}