//Assignment_1_"First Little Ditty"

//Oscillators
SinOsc sine => dac; //sends sine osc named "sine" to the dac
TriOsc Tri => dac;  //sends Tri osc named "Tri" to the dac
//Main pitch variable
40.0 => float melody; //defines a float value named "melody" to be 40

//Gain controls for Tri
0.5 => float onGain; //Defines a float value named "onGain" to be 0.5

//On and off duration
0.4::second => dur onDur; //Defines a duration
0.2::second => dur offDur; //Defines another duration

//Low frequency sweep of TriOsc
1=> Tri.gain; //Gain for "Tri"
0=> sine.gain; //Gain for "sine"

//While Loop. The loop will chucK the value of "melody" as long as its
//value is less than 110.0
while (melody<110.0)
{
    melody => Tri.freq;
    1.0 +=> melody;
    0.03::second => now;
}

//Repeat last While condition with Sine Osc added
//have to redefine another float value
50.0 => float sweep;

//setting gains
0.7=> Tri.gain;
0.3=> sine.gain; 

//This While loop will chucK the value of "sweep" to both oscillators
while (sweep<220.0)
{
    sweep => Tri.freq;
    sweep => sine.freq;
    1.0 +=> sweep;
    0.03::second => now;
}
//One More sweep
//New float
60.0 => float swell;

//setting gains
0.5=> Tri.gain;
0.6=> sine.gain;
//One more While loop
while (swell<440.0)
{
    swell => Tri.freq;
    swell => sine.freq;
    1.0 +=> swell;
    0.01::second => now;
}

//Melody TIME!!!
//Both Oscs, set up pitches for melody
//Tonic is 110, "sweep" is at 220 (the octave)
1 => sine.gain;
110 => sine.freq;
sweep => Tri.freq;
//"Tri" 5 notes over Sine bass with For loop. Defines new int "i" as 0
//and counts "i" up. The loop is true while "i" is less than 5.
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0 => Tri.gain;
    offDur => now;
}

//Next measure
//Both Oscs, Sine plays 5th, "tri" plays tonic
1 => sine.gain;
165 => sine.freq;
sweep => Tri.freq;

//Tri 5 notes over Sine bass with For loop. Same for loop as before.
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0 => Tri.gain;
    offDur => now;
}

//Next Measure
//Both Oscs, new pitches
1 => sine.gain;
145 => sine.freq;
sweep*.75 => Tri.freq;

//Back to the beginning. Tri plays 5 notes. Same for loop as before
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0 => Tri.gain;
    offDur => now;
}

//Both Oscs, set up pitches for melody
1 => sine.gain;
110 => sine.freq;
sweep => Tri.freq;

//Tri 5 notes over Sine bass with For loop. Same for loop as before
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0 => Tri.gain;
    offDur => now;
}


//Gonna start changing up the harmonic rhythm
//Both Oscs, set up pitches for melody
1 => sine.gain;
110 => sine.freq;
sweep*2 => Tri.freq;

//Tri 3 notes over Sine bass with For loop. Changing when the for loop
//is still true changes the number of notes in the loop. In this case
//the loop is true while "i" is less than 3, so it will make 3 notes
for (0=> int i; i<3; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0.3 => Tri.gain;
    offDur => now;
}

//Both Oscs, set up pitches for melody
1 => sine.gain;
138.6 => sine.freq;
sweep*2.5 => Tri.freq;

//Tri 2 notes over Sine bass with For loop. This for loop is similar
//to the last one.
for (0=> int i; i<2; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0.3 => Tri.gain;
    offDur => now;
}

//Both Oscs, sine plays 5th
1 => sine.gain;
145 => sine.freq;
sweep*.75 => Tri.freq;

//Tri plays 5 notes again.
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0.3 => Tri.gain;
    offDur => now;
}
//End with a I chord (melody is at 110)
138.6 => sine.freq; //major third
melody=> Tri.freq;
onGain => Tri.gain;

//Define new integer for if statement
1=> int end;
//If statement says if "end" equals 1 then execute. I defined "end" as
//1, so it will. 
if(end==1)
{
2::second => now;
}

//THE END! Hope you like it! 