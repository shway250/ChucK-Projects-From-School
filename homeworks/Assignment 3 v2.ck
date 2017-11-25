//Assignment_3_Techno? Yes, techno!
//I borrowed some from the examples in the text book, 

// Define Gains for left, center, right
Gain master[3];
master[0] => dac.left;
master[1] => dac;
master[2] => dac.right;

// Declare SndBufs for drums
// hook them up to pan positions
SndBuf kick => master[1];                             
SndBuf snare => master[1];
SndBuf hihat => master[2];
SndBuf stereo => master[1];

// Use a Pan2 for the hand claps,
SndBuf click => Pan2 clickPan;
clickPan.chan(0) => master[0];
clickPan.chan(1) => master[1];

// load up some samples of those
me.dir()+"/audio/kick_01.wav" => kick.read;
me.dir()+"/audio/kick_03.wav" => kick.read;
me.dir()+"/audio/snare_01.wav" => snare.read;
me.dir()+"/audio/hihat_01.wav" => hihat.read;  
me.dir()+"/audio/click_04.wav" => click.read;
me.dir()+"/audio/stereo_fx_04.wav" => stereo.read;


// array for controlling our cowbell strikes
[0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0] @=> int clickRhythm[];

// controls the overall length of our "measures"
clickRhythm.cap() => int MAX_BEAT;

// modulo number for controlling kick and snare
4 => int MOD;

// overall speed control
0.20 :: second => dur tempo;

// counters: beat within measures, and measure# #D
0 => int beat;
0 => int measure;

//Here comes the drum notes.
now + 30::second => time later;
while( now < later  )
{
    // Four on the floor
    if (beat % 4 == 0)
    { 
        0 => kick.pos;
    }
    // play snare on off beats
    if (beat % 4 == 2 && measure %2 == 1)
    {
        0=> snare.pos;
    }
    //randomly play hihat or Click
    if (measure > 1){
        if (clickRhythm[beat]) { 0 => click.pos;
    }
    else
    {
        Math.random2f(0.3,1.0) => hihat.gain;
    }   }   1 => hihat.pos;
    // after a time, play randomly spaced  at end of measure
    if (beat > 11 && measure > 3)
    {
        Math.random2f(-1.0,1.0) => clickPan.pan;
    }   1 => click.pos;
    -1 => click.rate;
    tempo => now; 
    (beat + 1) % MAX_BEAT => beat;
    if (beat==0)
    {
        measure++;
    }
}

