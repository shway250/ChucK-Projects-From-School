// piano.ck
// Insert the title of your piece here

// Part of your composition goes here
Rhodey pia;
Pan2 p => Gain g => dac;
pia => p;

0.7 => g.gain;
//(0.5, 0.1, 0.7, 0.85) => env.set; // ADSR for main bass
[46, 48, 49, 51, 53, 54, 56, 58] @=> int mA[];

0 => int index;
0 => int Count;
fun void playBass()
{
    if(Math.random2(0,9) >= 7)
    {
        (0.625/3)::second => now;
    }
    Math.random2f(0.3,0.7) => pia.noteOn;
    Std.mtof(mA[Math.random2(0,mA.cap() - 1)]) => pia.freq;
}

while(true)
{
    Math.random2(0,3) => index;
    spork ~ playBass();
    (0.625/2)::second => now;    
    Count++;
}