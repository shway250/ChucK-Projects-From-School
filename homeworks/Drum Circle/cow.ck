//cow.ck
SndBuf cow => dac;
me.dir(-1) +"/audio/cowbell_01.wav" => cow.read;

BPM tempo;

while(true)
{
    tempo.eigthNote => dur eigth;
    
    for( 0=> int beat; beat < 8; beat++)
    {
        if (beat == 7)
        {
            0 => cow.pos;
        }
        eigth => now;
    }
    
}