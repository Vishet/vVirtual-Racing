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

stock millisecondsToTimestamp(time, &minutes, &seconds, &milliseconds)
{
    minutes = time / 60000;
    seconds = (time / 1000) - (minutes * 60);
    milliseconds = time - (seconds * 1000) - (minutes * 60000);
}

stock GetTimestampString(time, outputString[], outputSize)
{
    new minutes = time / 60000;
    new seconds = (time / 1000) - (minutes * 60);
    new milliseconds = time - (seconds * 1000) - (minutes * 60000);

    new timestamp[64];
    if(minutes == 0)
        format(timestamp, sizeof(timestamp), "%d.%d", seconds, milliseconds);
    else
        format(timestamp, sizeof(timestamp), "%d:%d.%d", minutes, seconds, milliseconds);

    strcopy(outputString, timestamp, outputSize);
}