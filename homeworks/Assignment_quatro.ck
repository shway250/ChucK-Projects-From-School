<<< "Assignment Four: The ChucKening" >>>;
<<<"By Jackson 'Let Go of my Purse' Duhon" >>>;

//Sound Chain
SinOsc Chords[4];
Pan2 master => dac;
for( 0 => int i; i < Chords.cap(); i++ )
{
    //use array to chuck unit generator to master
    Chords[i] => master;
    0.5/Chords.cap() => Chords[i].gain;    
}
SinOsc tri => master;
SqrOsc sqr_osc_1 => Pan2 sqrP => master;
SinOsc sine_osc_1 => Pan2 sinP => master;
SinOsc sine_osc_2 =>Pan2 sinP2 => master;

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

//take away playback at initialization
kick.samples()=>kick.pos;
kick2.samples()=>kick2.pos;
click.samples()=> click.pos;
snare.samples()=> snare.pos;


/////////////////////GLOBAL VARIABLES!!!!\\\\\\\\\\\\\\\\\\\\\\\\\\\
//Arrays
[50,52,54,56,57,59,61,62] @=> int lydian[];
[52,54,56,57,59,61,62,64] @=> int mixo[];
[50,50,56,57,56,57,62,50] @=> int bass1[];
[52,52,56,57,56,57,62,52] @=> int bass2[];
//global variables for drums and chords
[1,1,1,1, 1,1,1,1] @=> int kick_ptrn_1[];
[1,0,1,0, 1,0,1,0] @=> int kick_ptrn_2[];
[1,0,0,1, 1,0,0,1] @=> int click_ptrn_1[];
[1,1,0,1, 1,0,1,1] @=> int click_ptrn_2[];
[0,1,0,1, 0,1,0,1] @=> int snare_ptrn_1[];


/////////////////////////FUNCTIONS!!!!!!\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Chord Function
//Function #1
fun void playChord( int root, int quality, int topNote, float length )
{
    // function will make major or minor chards
    
    //root position
    Std.mtof(root) => Chords[0].freq;
    
    //third
    if( quality == 4 )
    {
        Std.mtof(root+4) => Chords[1].freq;  
    }
    else if( quality == 3 )
    {
        Std.mtof(root+3) => Chords[1].freq;
    }
    else
    {
        <<< "must specify major or minor" >>>;
    }
    
    //fifth
    Std.mtof(root+7) => Chords[2].freq;
    
    //Seventh or octave
    if( topNote == 10 )
    {
        Std.mtof(root+10) => Chords[3].freq;
    }
    else if( topNote == 11 )
    {
        Std.mtof(root+11) => Chords[3].freq;
    }
    else if(topNote == 12 )
    {
        Std.mtof(root+12) => Chords[3].freq;
    }
    else
    {
        <<< "must specify seventh or octave" >>>;
    }
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



////Main program!!!!
//set gain a little low at beginning
0.7=>master.gain;

0.4 => tri.gain;

///while loop will last 30 seconds, all the code will be in while loop
now + 30::second => time later;
while( now < later  )
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
    //Turn off oscilators
0 => sqr_osc_1.gain;
0 => sine_osc_1.gain;
0 => sine_osc_2.gain;

    //Play some chords
   for( 0=> int i; i < lydian.cap(); i++)
    {
        
        if( i == 1 || i == 5 )
        {
            playChord(lydian[i], 4, 11, 1000);
        }
        else if( i == 8)
        {
            playChord(lydian[i], 4, 12, 250);
        }

        else if( i == 2)
        {
            playChord(lydian[i], 4, 10, 250);
        }
        else if( i == 3 || i == 6 || i == 7 )
        {
            playChord(lydian[i], 3, 10, 500);
        }
        else if(i == 4 )
        {
            playChord(lydian[i], 3, 12, 125);
        }
        bass1[i] => tri .freq;
}
//Random Drum Beat
section(kick_ptrn_1, click_ptrn_1, snare_ptrn_1, .2);

    //Play some mixo chords chords
    for( 0=> int i; i < mixo.cap(); i++)
    {

        
        if( i == 1 || i == 5 )
        {
            playChord(mixo[i], 4, 11, 1000);
        }
        else if( i == 8)
        {
            playChord(mixo[i], 4, 12, 250);
        }
        
        else if( i == 2)
        {
            playChord(mixo[i], 4, 10, 500);
        }
        else if( i == 3 || i == 6 || i == 7 )
        {
            playChord(mixo[i], 3, 10, 250);
        }
        else if(i == 4 )
        {
            playChord(mixo[i], 3, 12, 125);
        }
        bass2[i] => tri .freq;
}

    //Another random drum beat
section(kick_ptrn_2, click_ptrn_2, snare_ptrn_1, .15); 
//Play some  more random chords  chords chords chords
for( 0=> int i; i < lydian.cap(); i++)
{
    
    if( i == 1 || i == 4 )
    {
        playChord(lydian[i], 4, 11, 1000);
    }
    else if( i == 7)
    {
        playChord(lydian[i], 4, 12, 250);
    }
    
    else if( i == 2)
    {
        playChord(lydian[i], 4, 10, 250);
    }
    else if( i == 3 || i == 6 || i == 8 )
    {
        playChord(lydian[i], 3, 10, 500);
    }
    else if(i == 5 )
    {
        playChord(lydian[i], 3, 12, 125);
    }
    bass1[i] => tri .freq;
}

    //Another random drum beat
section(kick_ptrn_2, click_ptrn_2, snare_ptrn_1, .05);
//Play some mixo chords chords
for( 0=> int i; i < mixo.cap(); i++)
{
    
    
    if( i == 1 || i == 5 )
    {
        playChord(mixo[i], 4, 11, 500);
    }
    else if( i == 8)
    {
        playChord(mixo[i], 4, 12, 250);
    }
    
    else if( i == 2)
    {
        playChord(mixo[i], 4, 10, 500);
    }
    else if( i == 3 || i == 6 || i == 7 )
    {
        playChord(mixo[i], 3, 10, 250);
    }
    else if(i == 4 )
    {
        playChord(mixo[i], 3, 12, 125);
    }
    bass2[i] => tri .freq;
}
//Another random drum beat
section(kick_ptrn_2, click_ptrn_2, snare_ptrn_1, .01);
//Just the bass line
for( 0=> int i; i < bass2.cap(); i++)
{
bass2[i] => tri.freq;
0.5 => tri.gain;
.25::second=>now;
}
    
   3::second =>now; 
}

