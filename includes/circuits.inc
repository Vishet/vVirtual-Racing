#define MAX_CHECKPOINTS 30
#define MAX_CIRCUIT_NAME_SIZE 128


enum CIRCUIT_ID
{
    LV
}

enum
{
    X,
    Y,
    Z
}

#define CHECKPOINT_DIMENSIONS 3
#define CHECKPOINTS_SIZE MAX_CHECKPOINTS * CHECKPOINT_DIMENSIONS
#define CHECKPOINTS][%1][%2] CHECKPOINTS][((%1)*CHECKPOINT_DIMENSIONS)+(%2)]
enum CIRCUIT_DATA
{
    NAME[MAX_CIRCUIT_NAME_SIZE],
    Float:CHECKPOINTS[CHECKPOINTS_SIZE],
    CHECKPOINTNUMBER
}

new Circuits[CIRCUIT_ID][CIRCUIT_DATA];

stock LoadCircuit(const file[])
{
    new checkpointFile[128];
    format(checkpointFile, sizeof(checkpointFile), "%s/checkpoints.ini", file);   

    for(new i = 0; i < DOF2_GetInt(checkpointFile, "count"); i++)
    {
        new key[16];

        format(key, sizeof(key), "x[%i]", i);
        Circuits[LV][CHECKPOINTS][i][X] = DOF2_GetFloat(checkpointFile, key);

        format(key, sizeof(key), "y[%i]", i);
        Circuits[LV][CHECKPOINTS][i][Y] = DOF2_GetFloat(checkpointFile, key);

        format(key, sizeof(key), "z[%i]", i);
        Circuits[LV][CHECKPOINTS][i][Z] = DOF2_GetFloat(checkpointFile, key);
    }

    printf("Y: %f", Circuits[LV][CHECKPOINTS][6][Y]);
}