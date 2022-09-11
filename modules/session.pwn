#include <YSI_Coding\y_hooks>

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
            sessions[playerid][SD_CIRCUIT_ID] = GetCircuitIDByName(circuitName);
            sessions[playerid][SD_PLAYERSNUMBER] = 1;
            sessions[playerid][SD_PLAYERS][0] = playerid;
            sessions[playerid][SD_MODE] = SM_UNSTARTED;
            players[playerid][PD_SESSION_ID] = playerid;

            SendClientMessage(playerid, COLOR_BLUE, "Sessão criada");
        }       
    }

    return 1;
}