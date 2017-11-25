//Assignment 1-Week 1- "Getting a hang of this"

//Oscillators
SinOsc sine => dac;
TriOsc Tri => dac;
//Main pitch variable
110.0 => float melody;

//Gain controls for Tri
0.5 => float onGain;

//On and off duration
0.2::second => dur myDur;

//Only play Tri at first, sweeping pitch upward
1=> Tri.gain;
0=> sine.gain;
while (melody<220.0)
{
    melody => Tri.freq;
    1.0 +=> melody;
    0.01::second => now;
}

//Both Oscs, set up pitches
1 => sine.gain;
110 => sine.freq;
melody => Tri.freq;

//play two notes, 1st twinkle
for (0=> int i; i<2; i++)
{
    onGain => Tri.gain;
    myDur => now;
    0 => Tri.gain;
    myDur => now;
}

// new pitches!
138.6 => sine.freq;
1.5*melody => Tri.freq;

// two more notes, 2nd "twinkle"
for (0 => int i; i< 2; i++)
{
    onGain => Tri.gain;
    myDur => now;
    0 => Tri.gain;
    myDur=>now;
}
// pitches for "little"
146.8=>sine.freq;
1.6837 * melody => Tri.freq;
// play 2 notes for "little"
for(0 => int i; i < 2; i++)
    {
    onGain => Tri.gain;
    myDur => now;
    0 => Tri.gain;
    myDur => now;
}
// setup and play "star!"
138.6 => sine.freq;
1.5*melody => Tri.freq;
onGain => Tri.gain;
second => now;
// end by sweeping both oscillators down to zero
for (330 =>int i; i >0; i--)
{
    i => Tri.freq;
    i*1.333 => sine.freq;
    0.01 :: second => now;
}