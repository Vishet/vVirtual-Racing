#include <YSI_Coding\y_hooks>

hook OnPlayerEnterRaceCP(playerid)
{
    new index = checkpointChains[playerid][CC_INDEX] + 1;
    new count = checkpointChains[playerid][CC_COUNT];
    new nextIndex = index + 1;

    if(nextIndex == count)
    {
        nextIndex = 0;
    }
    else if(index == count)
    {
        index = 0;
        nextIndex = 1;
    }

    if(checkpointChains[playerid][CC_INDEX] == 0)
    {
        ++checkpointChains[playerid][CC_LAP];
        new startTick = checkpointChains[playerid][CC_START_TICK];
        new currentTick = GetTickCount();
        checkpointChains[playerid][CC_LAST_LAPTIME] = GetTickCountDifference(currentTick, startTick);
        checkpointChains[playerid][CC_START_TICK] = currentTick;
    }
        
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


    checkpointChains[playerid][CC_INDEX] = index;

    return 1;
}