enum CHECKPOINT_CHAIN
{
    Float:CC_XCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CC_YCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CC_ZCHECKPOINTS[MAX_CHECKPOINTS],
    CC_COUNT,
    CC_INDEX,
    CC_LAP
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