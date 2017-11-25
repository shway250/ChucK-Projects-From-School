//kick.ck

//sound chain
SndBuf kick => dac;
me.dir(-1)+"audio/kick_01.wav" => kick.read;

//initialize BPM class
BPM tempo;

while(true)
{
    //update our basic beat each measure
    tempo.quarterNote => dur quarter;
    
    // play a measure of quarter note kicks
    for (0 => int beat; beat < 4; beat++)
    {
        0 => kick.pos;
        quarter => now;
    }
}