hook OnPlayerEnterRaceCheckpoint(playerid)
{
    new index = checkpointChains[playerid][CC_CHECKPOINT_INDEX];
    new count = checkpointChains[playerid][CC_CHECKPOINT_COUNT];
    new nextIndex;

    if(index + 1 == count)
    {
        nextIndex = 0;
        checkpointChains[playerid][CC_CHECKPOINT_INDEX] = 0;
    }
    else
    {
        nextIndex = index + 1;
        ++checkpointChains[playerid][CC_CHECKPOINT_INDEX];
    }

    printf("nextIndex: %d", nextIndex);

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