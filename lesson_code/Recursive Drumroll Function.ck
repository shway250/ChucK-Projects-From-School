//sound chain
SndBuf snare => dac;

//load sound file
me.dir() + "/audio/snare_01.wav" => snare.read;
//set playhead to end so no sound in beginning
snare.samples() => snare.pos;

//funtion in drumRoll( int index )
fun int drumRoll( int index )
{
    <<< index >>>;
    if( index >= 1 )
    {
        //play sound for duration o findex
        0 => snare.pos;
        index::ms => now;
        //call drumRoll while reducing index
        return drumRoll(index-1);
    }
    else if( index == 0)
    {
        return 0;
    }
}

//Main program
//call recursive function drumRoll
drumRoll(20);