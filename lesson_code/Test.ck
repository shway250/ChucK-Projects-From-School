//Sound Buff Sound Chain
SndBuf click => dac;
SndBuf kick => dac;
SndBuf kick2 => dac;
SndBuf snare => dac;

//open sound files
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/kick_03.wav" => kick2.read;
me.dir() + "/audio/snare_02.wav" => snare.read;
me.dir() + "/audio/snare_03.wav" => click.read;

//take away playback at initialization and zero out Osc Gain
kick.samples()=>kick.pos;
kick2.samples()=>kick2.pos;
click.samples()=> click.pos;
snare.samples()=> snare.pos;//global variables for drums and chords
[1,1,1,1,1,1,1,1] @=> int kick_ptrn_1[];
[1,0,1,0,1,0,1,0] @=> int kick_ptrn_2[];
[1,0,0,1,1,0,0,1] @=> int click_ptrn_1[];
[1,1,0,1,1,0,1,1] @=> int click_ptrn_2[];
[0,1,0,1,0,1,0,1] @=> int snare_ptrn_1[];
//Sequencer Function
//Function #2
fun void section( int kickArray[], int clickArray[], int snareArray[], float beatz )
{
    //sequencer: for bass drum and snare drum beats
    for( 0 => int i; i < kickArray.cap(); i++ )
    {
        <<< i >>>;
        //if 1 in array than play kick
        if( kickArray[i] == 1 )
        {
            0 => kick.pos;
            0 => kick2.pos;
        }
        //if 1 in array then play click
        if (clickArray[i] == 1)
        {
            0 => click.pos;
        }
        //if 1 in array then play snare
        if (snareArray[i] == 1)
        {
            0 => snare.pos;
        }
        beatz::second => now;
    }
}

while (true)
{
    section(kick_ptrn_1, click_ptrn_1, snare_ptrn_1, .6);
}