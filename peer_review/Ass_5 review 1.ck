//exercise 5 'mandolin meets criteria'
<<< "mandolin meets criteria" >>>;


//Sound chain
Gain master => dac;

//Mandolin parameters
Mandolin mandolin => master;
0.5 => mandolin.pluckPos;
0.1 => mandolin.bodySize;


//SndBuf parameters
SndBuf fx => master;
me.dir() + "/audio/stereo_fx_05.wav"=> string filename;
filename => fx.read;
1 => fx.gain;
fx.samples() => fx.pos;

//Oscillator parameters
Impulse imp => ResonZ filt => Pan2 p => dac;
100 => filt.Q;

//Global Variables
//defining beattime
0.75 => float beattime;

//Notes to be played
[49, 50, 52, 54, 56, 57, 59, 61]@=> int notes[];
//length of notes
[beattime/2, beattime/2, beattime, beattime*0, beattime/2, beattime/2, beattime, beattime*0 ]@=> float length[];
[beattime/2, beattime/2, beattime, beattime*0, beattime*4, beattime*0, beattime*0, beattime*0 ]@=> float length2[];

//Function
//Function for Mandolin string detune 
fun void detune(float begin, float end, float increment)
{
    //print to check that we are in the loop
    <<< "inloop1" >>>;
    for (begin => float f; f > end; f - increment => f)
    {
        //print to check that we are in the second loop
        <<< "inloop2" >>>;
        //set string detune
        f => mandolin.stringDetune;
        <<< f >>>;
        //pluck mandolin
        1 => mandolin.noteOn;
        //advance time
        0.125::second => now;
    }
    1=> mandolin.noteOn;
    3::second => now;
}

//Main Program

//The mandolin prepares for the big loop
detune(1,0,.1);

//Outer while loop for playing notes
1 => int outer;

while (outer < 9)
{
    //for all but last bar use array 'length' for beattime
    if ( outer < 8)
    {
        for (0 => int i; i<notes.cap(); i++)
        {
            //Play SndBuf
            0 => fx.pos;
            //generate impulse
            2500.0 => imp.next;
            //randomly assign freq between 50 - 200 to impulse 
            Math.random2f(50, 200) => filt.freq;
            //Alternate impulse between left and right ear
            Math.random2f(-1.0, 1.0) => p.pan;
            //play random mandolin notes from array 'notes'
            Std.mtof(notes[Math.random2(0,notes.cap()-1)]) => mandolin.freq;
            //print notes for checking
            <<<i, notes[i] >>>;
            //pluck mandolin
            1 => mandolin.noteOn;
            //play notes for beattime from array 'length'
            length[i]::second => now;
        }
    }
    //for last bar use array 'length2' for beattime
    else
    {
        for (0 => int i; i<notes.cap(); i++)
        {
            //Play SndBuf
            0 => fx.pos;
            //generate impulse
            2500.0 => imp.next;
            //randomly assign freq between 50 - 200 to impulse 
            Math.random2f(50, 200) => filt.freq;
            //Alternate impulse between left and right ear
            Math.random2f(-1.0, 1.0) => p.pan;
            //play random mandolin notes from array 'notes'
            Std.mtof(notes[Math.random2(0,notes.cap()-1)]) => mandolin.freq;
            //print notes for checking
            <<<i, notes[i] >>>;
            //pluck mandolin
            1 => mandolin.noteOn;
            //play notes for beattime from array 'length2'
            length2[i]::second => now;
        }
        
    }
    outer + 1 => outer;
    //print iterations in console for checking
    <<< "iteration ", outer >>>;
}
