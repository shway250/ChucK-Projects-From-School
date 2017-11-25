//Assignment 4- "Chords 'n Stuff"

//

//Oscillator Sound Chain
TriOsc chord[3];
SqrOsc sqr_osc_1 => Pan2 sqrP => dac;
SinOsc sine_osc_1 => Pan2 sinP => dac;
SinOsc sine_osc_2 =>Pan2 sinP2 => dac;
Gain master => dac;

//For loop to Chuck TriOsc to Master
for( 0 => int i; i < chord.cap(); i++ )
{
    //use array to chuck unit generator to master
    chord[i] => master;
    1.0/chord.cap() => chord[i].gain;
}


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
snare.samples()=> snare.pos;
//osc
0 => sqr_osc_1.gain;
0 => sine_osc_1.gain;
0 => sine_osc_2.gain;
0 => master.gain;

//global variables for drums and chords
[1,1,1,1,1,1,1,1] @=> int kick_ptrn_1[];
[1,0,1,0,1,0,1,0] @=> int kick_ptrn_2[];
[1,0,0,1,1,0,0,1] @=> int click_ptrn_1[];
[1,1,0,1,1,0,1,1] @=> int click_ptrn_2[];
[0,1,0,1,0,1,0,1] @=> int snare_ptrn_1[];

//////Functions**************************************Functions/////////
//MAJOR/MINOR CHORD FUNCTION(this is the chord funtion from the lectures
//Funtion #1
fun void playChord( int root, string quality, float length )
{
    //function will make major or minor chords
    
    //root
    Std.mtof(root) => chord[0].freq;
    
    //third
    if( quality == "major" )
    {
        Std.mtof(root+4) => chord[1].freq;
    }
    else if( quality == "minor" )
    {
        Std.mtof(root+3) => chord[1].freq;
    }
    else
    {
        <<< "must specify major or minor" >>>;
    }
    //fifth
    Std.mtof(root+7) => chord[2].freq;
    
    length::ms => now; 
}
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
// Upward sweep function for Dom7 chord
//function #3
//Third function
fun float third( float originalFreq )
{
    //calculate third of input frequency
    return(originalFreq*1.25);
}

//fifth function
fun float fifth( float originalFreq )
{
    //calculate fifth of input frequency
    return(originalFreq*1.5);
}
//7th function
fun float sev( float originalFreq )
{
    //calculate seventh of input frequency
    return(originalFreq*1.75);
}

// globalTime will set time of composition using While loop
now + 30::second => time globalTime;

//MAIN PROGRAM
//30 SECOND LOOP
while(now < globalTime)
{

//Frequency sweep intro.
for( 20 => float i; i <500; i + .5 => i)
{
    if( i < 500)
    {
        third(i) => sqr_osc_1.freq;
        fifth(i) => sine_osc_1.freq;
        sev(i) => sine_osc_2.freq;
        0.3=>sqr_osc_1.gain;
        0.3=>sine_osc_1.gain;
        0.3=>sine_osc_2.gain;
        Math.random2f(-1.0,1.0)=> sqrP.pan;
        Math.sin(now/1::second*2*pi) => sinP.pan;
        Math.sin(now/1::second*2*pi) => sinP2.pan;
        <<< i >>>;
        10::ms => now;
    }
}
//cut osc gains
0.0=>sqr_osc_1.gain;
0.0=>sine_osc_1.gain;
0.0=>sine_osc_2.gain;

//play drum arrays using function
section(kick_ptrn_1, click_ptrn_1, snare_ptrn_1, .6);
section(kick_ptrn_2, click_ptrn_2, snare_ptrn_1, .6); 
section(kick_ptrn_1, click_ptrn_1, snare_ptrn_1, .6);

//play random chords
while(now<globalTime)
{
playChord(Math.random2(60,72), "minor", 250);
playChord(Math.random2(60,72), "major", 500);
5::second => now;
}
}

