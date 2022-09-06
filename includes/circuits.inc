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
    CHECKPOINTS[CHECKPOINTS_SIZE],
    CHECKPOINTNUMBER
}

new Circuits[CIRCUIT_ID][CIRCUIT_DATA];

stock LoadCircuit(const file[])
{
    Circuits[LV][CHECKPOINTS][0][X] = 3;
    Circuits[LV][CHECKPOINTS][0][Y] = 4;
    Circuits[LV][CHECKPOINTS][0][Z] = 5;

    Circuits[LV][CHECKPOINTS][1][X] = 33;
    Circuits[LV][CHECKPOINTS][1][Y] = 44;
    Circuits[LV][CHECKPOINTS][1][Z] = 55;

    new checkpointFile[128];
    format(checkpointFile, sizeof(checkpointFile), "%s/checkpoints.ini", file);   

    for(new i = 0; i < DOF2_GetInt(checkpointFile, "count"); i++)
    {
        new key[16];

        format(key, sizeof(key), "x%i", i);
        printf("x%i = %f", i, DOF2_GetFloat(checkpointFile, key));

        format(key, sizeof(key), "y%i", i);
        printf("y%i = %f", i, DOF2_GetFloat(checkpointFile, key));

        format(key, sizeof(key), "z%i", i);
        printf("z%i = %f\n", i, DOF2_GetFloat(checkpointFile, key));
    }
}