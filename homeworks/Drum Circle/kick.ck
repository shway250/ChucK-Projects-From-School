//kick.ck
//sound chain
SndBuf kick => dac;

me.dir(-1) + "/audio/kick_04.wav" => kick.read;

// create BPM object
BPM tempo;
tempo.tempo(100);

while(true)
{
    tempo.quarterNote => dur quarter;
    
    //play a loop
    for( 0=> int beat; beat <4; beat++)
    {
        0=>kick.pos;
        quarter=>now;
    }
    
}