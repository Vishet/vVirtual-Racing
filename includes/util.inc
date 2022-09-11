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