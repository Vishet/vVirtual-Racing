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

    if(milliseconds < 10)
    {
        if(minutes == 0)
            format(timestamp, sizeof(timestamp), "%d.00%d", seconds, milliseconds);
        else
            format(timestamp, sizeof(timestamp), "%d:%d.00%d", minutes, seconds, milliseconds);
    }      
    else if(milliseconds < 100)
    {
        if(minutes == 0)
            format(timestamp, sizeof(timestamp), "%d.0%d", seconds, milliseconds);
        else
            format(timestamp, sizeof(timestamp), "%d:%d.0%d", minutes, seconds, milliseconds);
    }      
    else
    {
        if(minutes == 0)
            format(timestamp, sizeof(timestamp), "%d.%d", seconds, milliseconds);
        else
            format(timestamp, sizeof(timestamp), "%d:%d.%d", minutes, seconds, milliseconds);
    }

    strcopy(outputString, timestamp, outputSize);
}