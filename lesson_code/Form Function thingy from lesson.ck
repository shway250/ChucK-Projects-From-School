//sound chain
SndBuf click => dac;
SndBuf kick => dac;

//open sound files
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/snare_03.wav" => click.read;
//take away playback
kick.samples() => kick.pos;
click.samples() => click.pos;

//Global variables

[1,0,0,0, 1,0,0,0] @=> int kick_ptrn1[];
[0,0,1,0, 0,0,1,0] @=> int kick_ptrn2[];
[1,0,1,0, 1,0,1,0] @=> int click_ptrn1[];
[1,1,1,1, 1,1,1,1] @=> int click_ptrn2[];


//Function
fun void section( int kickArray[], int clickArray[], float beatTime )
{
    // sequencer for bass drum and snare drum beatz
    for( 0 => int i; i < kickArray.cap(); i++ )
    {
        //if 1 in aaray than play kick
        if( kickArray[i] == 1 )
        {
            0 => kick.pos;   
        }
        //if 1 in array then play kick
        if( clickArray[i] == 1 )
        {
            0 => click.pos;   
        }
        beatTime::second => now;
    }
}



//MAIN PROGRAM!!!!

//infinite loop
while( true )
{
    // procedural: ABA form
    section(kick_ptrn1, click_ptrn1, .2);
    section(kick_ptrn2, click_ptrn2, .2);
    section(kick_ptrn1, click_ptrn1, .4);
    
}