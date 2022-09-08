enum CIRCUIT_ID
{
    CID_INVALID,
    CID_LAS_VEGAS
}

enum
{
    X,
    Y,
    Z
}

#define CD_CHECKPOINTS_SIZE MAX_CHECKPOINTS * 3
enum CIRCUIT_DATA
{
    CD_NAME[MAX_CIRCUIT_NAME_SIZE],
    Float:CD_XCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CD_YCHECKPOINTS[MAX_CHECKPOINTS],
    Float:CD_ZCHECKPOINTS[MAX_CHECKPOINTS],
    CD_CHECKPOINTS_COUNT,
    Float:CD_FIRST_ANGLE
}

new Circuits[CIRCUIT_ID][CIRCUIT_DATA];

stock LoadCircuit(CIRCUIT_ID:circuitID, const file[])
{
    new checkpointFile[STRING_SIZE];
    format(checkpointFile, sizeof(checkpointFile), "%s/checkpoints.ini", file);   

    new infoFile[STRING_SIZE];
    format(infoFile, sizeof(infoFile), "%s/info.ini", file);

    stringcpy(Circuits[circuitID][CD_NAME], MAX_CIRCUIT_NAME_SIZE, DOF2_GetString(infoFile, "name"));
    Circuits[circuitID][CD_CHECKPOINTS_COUNT] = DOF2_GetInt(checkpointFile, "count");
    Circuits[circuitID][CD_FIRST_ANGLE] = Float:DOF2_GetFloat(infoFile, "first_angle");

    for(new i = 0; i < Circuits[circuitID][CD_CHECKPOINTS_COUNT]; i++)
    {
        new key[16];

        format(key, sizeof(key), "x[%i]", i);
        Circuits[circuitID][CD_XCHECKPOINTS][i] = DOF2_GetFloat(checkpointFile, key);

        format(key, sizeof(key), "y[%i]", i);
        Circuits[circuitID][CD_YCHECKPOINTS][i] = DOF2_GetFloat(checkpointFile, key);

        format(key, sizeof(key), "z[%i]", i);
        Circuits[circuitID][CD_ZCHECKPOINTS][i] = DOF2_GetFloat(checkpointFile, key);
    }
}

stock CIRCUIT_ID:GetCircuitIDByName(const name[])
{
    if(strcmp("lv", name, true) == 0) return CID_LAS_VEGAS;

    return CID_INVALID;
}