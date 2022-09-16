#include <YSI_Coding\y_hooks>

stock KickPlayerFromSession(playerid)
{
    new pSessionId = players[playerid][PD_SESSION_ID];

    if(pSessionId < 0)
        return -1;

    for(new i = 0; i < sessions[pSessionId][SD_PLAYERCOUNT]; i++)
    {
        if(sessions[pSessionId][SD_PLAYERS][i] == playerid)
        {
            sessions[pSessionId][SD_PLAYERS][i] = -1;
            return i;
        }
    }

    return -1;
}

stock CreateSession(creatorId, const circuitName[])
{
    new CIRCUIT_ID:circuitId = GetCircuitIDByName(circuitName);
    sessions[creatorId][SD_CIRCUIT_ID] = circuitId;
    sessions[creatorId][SD_PLAYERCOUNT] = 1;
    sessions[creatorId][SD_PLAYERS][0] = creatorId;
    sessions[creatorId][SD_MODE] = SM_UNSTARTED;
    players[creatorId][PD_SESSION_ID] = creatorId;
    players[creatorId][PD_MODE] = PM_SESSION;
}

stock AddPlayerToSession(playerid, sessionId)
{
    players[playerid][PD_SESSION_ID] = sessionId;

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
    if(sessions[sessionId][SD_MODE] == SM_UNEXIST)
    {
        SendClientMessage(playerid, COLOR_RED, "Você não é criador de nenhuma sessão");
        return 1;
    }
        
    new playerCount = sessions[sessionId][SD_PLAYERCOUNT];
    for(new i = 0; i < playerCount; i++)
    {
        new driverId = sessions[sessionId][SD_PLAYERS][i];
        players[driverId][PD_SESSION_ID] = -1;
        players[driverId][PD_MODE] = PM_FREE;
        EndCheckpointChain(playerid);
    }

    sessions[sessionId][SD_CIRCUIT_ID] = CID_INVALID;
    sessions[sessionId][SD_MODE] = SM_UNEXIST;

    SendClientMessage(playerid, COLOR_BLUE, "Você terminou a sessão");

    return 1;
}