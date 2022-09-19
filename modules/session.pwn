#include <YSI_Coding\y_hooks>

stock KickPlayerFromSession(playerid)
{
    new sessionId = players[playerid][PD_SESSION_ID];

    if(sessionId < 0)
        return -1;

    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    for(new i = 0; i < playerCount; i++)
    {
        if(sessions[sessionId][SD_PLAYERS][i] == playerid)
        {
            sessions[sessionId][SD_PLAYERS][i] = -1;
            return i;
        }
    }

    players[playerid][PD_SESSION_ID] = -1;
    players[playerid][PD_MODE] = PM_FREE;

    new vehicleId = players[playerid][PD_VEHICLE_ID];
    DestroyVehicle(vehicleId);

    SetPlayerVirtualWorld(playerid, -1);

    return -1;
}

stock CreateSession(creatorId, const circuitName[])
{
    new CIRCUIT_ID:circuitId = GetCircuitIDByName(circuitName);
    new sessionId = creatorId;

    sessions[sessionId][SD_CIRCUIT_ID] = circuitId;
    sessions[sessionId][SD_PLAYERCOUNT] = 1;
    sessions[sessionId][SD_PLAYERS][0] = creatorId;
    sessions[sessionId][SD_MODE] = SM_UNSTARTED;

    players[creatorId][PD_SESSION_ID] = sessionId;
    players[creatorId][PD_MODE] = PM_SESSION;

    SetPlayerVirtualWorld(creatorId, sessionId);
}

stock AddPlayerToSession(playerid, sessionId)
{
    players[playerid][PD_SESSION_ID] = sessionId;
    SetPlayerVirtualWorld(playerid, sessionId);

    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    sessions[sessionId][SD_PLAYERS][playerCount] = playerid;

    ++sessions[sessionId][SD_PLAYERCOUNT];
}

CMD:session(playerid, params[])
{
    if(sessions[playerid][SD_MODE] != SM_UNEXIST || players[playerid][PD_SESSION_ID] != -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Você já é criador de uma sessão");
        return 1;
    }

    new circuitName[MAX_CIRCUIT_NAME_SIZE];
    new scanString[STRING_SIZE];
    format(scanString, sizeof(scanString), "s[%d]", MAX_CIRCUIT_NAME_SIZE);
    if(sscanf(params, scanString, circuitName))
        SendClientMessage(playerid, COLOR_RED, "Uso: /session [nome do circuito]");
    else
    {
        new CIRCUIT_ID:circuitID = GetCircuitIDByName(circuitName);
        if(circuitID == CID_INVALID)
            SendClientMessage(playerid, COLOR_RED, "Nome de circuito inválido");
        else
        {
            CreateSession(playerid, circuitName);
            SendClientMessage(playerid, COLOR_BLUE, "Sessão criada");
        }       
    }

    return 1;
}

CMD:joinsession(playerid, params[])
{
    new sessionId;
    if(sscanf(params, "d", sessionId))
        SendClientMessage(playerid, COLOR_RED, "Uso: /joinsession [id do criador da sessão]");
    else if(sessions[sessionId][SD_MODE] == SM_UNEXIST)
        SendClientMessage(playerid, COLOR_RED, "Sessão inexistente");
    else if(sessions[sessionId][SD_MODE] != SM_UNSTARTED)
        SendClientMessage(playerid, COLOR_RED, "A sessão já começou");
    else
    {
        AddPlayerToSession(playerid, sessionId);
        SendClientMessage(playerid, COLOR_BLUE, "Você entrou na sessão");
    }

    return 1;
}

CMD:endsession(playerid, params[])
{
    new sessionId = playerid;

    if(EndSession(sessionId) == -1)
        SendClientMessage(playerid, COLOR_RED, "Você não é criador de nenhuma sessão");
    else
        SendClientMessage(playerid, COLOR_BLUE, "Você terminou a sessão");

    return 1;
}