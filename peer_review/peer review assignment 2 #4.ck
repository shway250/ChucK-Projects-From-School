//Assignment2_melody_in_DDorian_by_JDreamer

//sound network

TriOsc tri => Pan2 triPan => dac;
SqrOsc sqr => Pan2 sqrPan => dac;

0.1 => float usualSqrGain;
0.5 => float usualTriGain;

//write the scale to an array, then use not midi notes, 
//but degrees of D Dorian scale to write a melody.
//this approach makes it very easy to change the scale.

/*Note: array elements are counted from zero, but degrees of the scale are counted from 1.
Later in this code I'll refer to specific notes this way: scale[number_of_degree - 1].
I could write simply scale[0] to refer to D, but I write scale[1-1] to show explicitly, 
that D is a first degree of the scale (that's for debugging purposes).
I have to add -1 to refer to the right element of the array*/

[50, 52, 53, 55, 57, 59, 60, 62] @=> int scale[];

//specify the exact length of notes and rests
//only the length of quarterNote is hardcoded, other durations depend on it

.25::second => dur quarterNote;
2*quarterNote => dur halfNote;
halfNote + quarterNote => dur halfNoteDotted;
4*quarterNote => dur wholeNote;
quarterNote/4 => dur sxtnNote;

//will be needed to distinguish durations when the same note is played several times
quarterNote/10 => dur technicalPause;



usualTriGain => tri.gain;
0 => sqr.gain;

//this is needed to check if the length of the melody is exactly 30 seconds
now => time startTime;

//MEASURES 1-6

[scale[1-1], scale[3-1], scale[4-1], scale[1-1], scale[3-1], scale[4-1], scale[6-1], scale[1-1], scale[3-1], scale[4-1], scale[7-1]] @=> int frst6MeasuresPitches[];
[halfNoteDotted, quarterNote, wholeNote, halfNoteDotted, quarterNote, halfNote, halfNote, halfNoteDotted, quarterNote, halfNote, halfNote] @=> dur frst6MeasuresDurations[];

for(0 => int i; i < frst6MeasuresPitches.cap(); i++)
{
    Std.mtof(frst6MeasuresPitches[i]) => tri.freq;
    frst6MeasuresDurations[i] => now;
}

//MEASURES 7-8 - GO DOWN THE D DORIAN SCALE

// we're going from D to D in the octave above
//scale.cap() returns 8, it will be 7 6 5 4 3 2 1 0, all quarter notes


for((scale.cap() - 1) => int i; i >= 0; i--)
{
    //if i is an even number - play the note mostly in left speaker, otherwise - in right speaker
    if(i%2 == 0)
    {
        -0.5 => triPan.pan;
    }
    else
    {
        0.5 => triPan.pan; 
    }
    
    Std.mtof(scale[i]) => tri.freq;
    quarterNote => now;
}




//MEASURES 9-12

usualSqrGain => sqr.gain;

-0.5 => triPan.pan;
0.5 => sqrPan.pan;

//going from A-C (scale[5-1], scale[7-1]) to E-G (scale[2-1] scale [4-1]), one degree lower each measure
//same duration pattern: half note, quarter note, quarter note

// there's a need to pause in order to hear separate durations

for(5 => int i; i >= 2; i--)
{
    //lower frequency in triangle oscillator, higher frequency in square oscillator
    Std.mtof(scale[i-1]) => float triFreq;
    Std.mtof(scale[i+2-1]) => float sqrFreq;
    
    triFreq => tri.freq;
    sqrFreq => sqr.freq;
    halfNote - technicalPause => now;
    
    
    //that's a simple way to include rest without adding a horrible click:
    //set to 0 not gains, but frequencies.
    0 => tri.freq;
    0 => sqr.freq;
    technicalPause => now;
    
    //play same 2 notes on different oscillators
    triFreq => tri.freq;
    sqrFreq => sqr.freq;
    //there's a need to subtract a technicalPause from the duration of the note in order to keep each measure exactly 1 second long     
    quarterNote - technicalPause => now;
    
    //rest again
    0 => tri.freq;
    0 => sqr.freq;
    technicalPause => now;
    
    //play same 2 notes
    triFreq => tri.freq;
    sqrFreq => sqr.freq;    
    quarterNote => now;
    
    //sqr and tri switch locations
    triPan.pan() => float currentTriPan;
    sqrPan.pan() => float currentSqrPan;
    currentTriPan => sqrPan.pan;
    currentSqrPan => triPan.pan;
}

//MEASURES 13-14

Std.mtof(scale[1-1]) => tri.freq;
Std.mtof(scale[3-1]) => sqr.freq;
wholeNote => now;

Std.mtof(scale[1-1]) => tri.freq;
Std.mtof(scale[5-1]) => sqr.freq;
wholeNote => now;


0 => sqr.gain;

//MEASURES 15-16

//going down from D to D again

for((scale.cap() - 1) => int i; i >= 0; i--)
{
    //this sounds different each time you run the code, because "now" will be different
    Math.sin(now/1::second) => triPan.pan;
    Std.mtof(scale[i]) => tri.freq;
    quarterNote => now;
}

//MEASURES 17-24
//random madness

-0.4 => triPan.pan;
0.4 => sqrPan.pan;

//setting seed to make the next 8 measures sound the same each time
Math.srandom(0);

//lasts for 4 measures
for(0 => int i; i < (4*wholeNote)/(sxtnNote/2); i++)
{    
    Std.mtof(scale[Math.random2(0, 3)]) => tri.freq;
    
    sxtnNote/2 => now;
}

usualSqrGain => sqr.gain;

//another 4 measures
for(0 => int i; i < (4*wholeNote)/(sxtnNote/2); i++)
{    
    Std.mtof(scale[Math.random2(0, 3)]) => tri.freq;
    Std.mtof(scale[Math.random2(4, 7)]) => sqr.freq;
    
    sxtnNote/2 => now;
}




//MEASURES 25-30 

usualSqrGain/2 => sqr.gain;

0 => triPan.pan;
0 => sqrPan.pan;

[scale[1-1], scale[1-1], scale[6-1], scale[4-1], scale[1-1], scale[1-1], scale[6-1], scale[4-1], scale[1-1]] @=> int lastMeasuresPitches[];
[halfNote, halfNote, quarterNote, halfNoteDotted, halfNote, halfNote, quarterNote, halfNoteDotted, 2*wholeNote] @=> dur lastMeasuresDurations[];

for(0 => int i; i < lastMeasuresPitches.cap(); i++)
{
    //if the same note repeats twice or more, we need to include a rest in order to hear separate durations
    if((i > 0) && lastMeasuresPitches[i] == lastMeasuresPitches[i-1])
    {
        0 => tri.freq;
        0 => sqr.freq;
        technicalPause => now;
        
        Std.mtof(lastMeasuresPitches[i]) => tri.freq => sqr.freq;
        lastMeasuresDurations[i] - technicalPause => now;
    }
    else
    {
        Std.mtof(lastMeasuresPitches[i]) => tri.freq => sqr.freq;
        lastMeasuresDurations[i] => now; 
    }
    
}


//check if a melody lasts for exactly 30 seconds, print the duration to console
now => time endTime;

<<< (endTime - startTime)/1::second >>>;
