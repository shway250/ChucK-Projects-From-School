//Assignment 1-Week 1- "Getting a hang of this"

//Oscillators
SinOsc sine => dac;
TriOsc Tri => dac;
//Main pitch variable
40.0 => float melody;

//Gain controls for Tri
0.5 => float onGain;

//On and off duration
0.4::second => dur onDur;
0.2::second => dur offDur;

//Low frequency sweep of TriOsc
1=> Tri.gain;
0=> sine.gain;
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
//While loop
while (sweep<220.0)
{
    sweep => Tri.freq;
    sweep => sine.freq;
    1.0 +=> sweep;
    0.03::second => now;
}
//One more upward sweep
//New float
60.0 => float swell;

//setting gains
0.7=> Tri.gain;
0.3=> sine.gain;

//while loop
while (swell<440.0)
{
    swell => Tri.freq;
    swell => sine.freq;
    1.0 +=> swell;
    0.01::second => now;
}



//Melody TIME!!!
//Both Oscs, set up pitches for melody
//Tonic is 110, sweep is at 220 (the octave)
1 => sine.gain;
110 => sine.freq;
sweep => Tri.freq;

//Tri 5 notes over Sine bass with For loop
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0 => Tri.gain;
    offDur => now;
}

//Both Oscs, Sine plays 5th
1 => sine.gain;
165 => sine.freq;
sweep => Tri.freq;

//Tri 5 notes over Sine bass with For loop
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0 => Tri.gain;
    offDur => now;
}

//Both Oscs, new pitches
1 => sine.gain;
145 => sine.freq;
sweep*.75 => Tri.freq;

//Back to the beginning. Tri plays 5 notes
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

//Tri 5 notes over Sine bass with For loop
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

//Tri 5 notes over Sine bass with For loop
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

//Tri 5 notes over Sine bass with For loop
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

//Tri plays 5 notes
for (0=> int i; i<5; i++)
{
    onGain => Tri.gain;
    onDur => now;
    0.1 => Tri.gain;
    offDur => now;
}
//End with a I chord (melody is at 110)
138.6 => sine.freq;
melody=> Tri.freq;
onGain => Tri.gain;
2::second => now;

/*
// end by sweeping both oscillators down to zero
for (330 =>int i; i >0; i--)
{
    i => Tri.freq;
    i*1.333 => sine.freq;
    0.01 :: second => now;
}*/