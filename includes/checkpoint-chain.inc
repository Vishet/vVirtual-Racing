enum CHECKPOINT_CHAIN
{
    Float:CC_XCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CC_YCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CC_ZCHECKPOINTS[MAX_CHECKPOINTS],
    CC_CHECKPOINT_COUNT,
    CC_CHECKPOINT_INDEX
}

new checkpointChains[MAX_PLAYERS][CHECKPOINT_CHAIN];

stock SetCheckpointChain(playerId, const Float:xCheckpoints[], const Float:yCheckpoints[], const Float:zCheckpoints[], checkpointCount)
{
    checkpointChains[playerId][CC_CHECKPOINT_INDEX] = 0;
    checkpointChains[playerId][CC_CHECKPOINT_COUNT] = checkpointCount;
    for(new i = 0; i < checkpointCount; i++)
    {
        checkpointChains[playerId][CC_XCHECKPOINTS][i] = xCheckpoints[i];
        checkpointChains[playerId][CC_YCHECKPOINTS][i] = yCheckpoints[i];
        checkpointChains[playerId][CC_ZCHECKPOINTS][i] = zCheckpoints[i];
    }

    SetPlayerRaceCheckpoint(
        playerId, 0, 
        checkpointChains[playerId][CC_XCHECKPOINTS][0], 
        checkpointChains[playerId][CC_YCHECKPOINTS][0], 
        checkpointChains[playerId][CC_ZCHECKPOINTS][0], 
        checkpointChains[playerId][CC_XCHECKPOINTS][1], 
        checkpointChains[playerId][CC_YCHECKPOINTS][1], 
        checkpointChains[playerId][CC_ZCHECKPOINTS][1], 
        CHECKPOINT_SIZE
    );
}