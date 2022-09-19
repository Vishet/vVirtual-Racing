timer delayedVehicle[1000](playerid, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
    new oldVehicleId = players[playerid][PD_VEHICLE_ID];
    DestroyVehicle(oldVehicleId);

    new vehicleId = CreatePutVehicle(playerid, vehicletype, x, y, z, rotation, color1, color2, respawn_delay);
    
    new worldId = GetPlayerVirtualWorld(playerid);
    SetVehicleVirtualWorld(vehicleId, worldId);

    players[playerid][PD_VEHICLE_ID] = vehicleId;
}