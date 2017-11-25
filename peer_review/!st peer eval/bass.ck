// Bass player

// Soundchain

Mandolin bass => NRev r => dac;

//Parameters for better sound

0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;

//volume

0.5 => bass.gain;

//counter 

0 => int counter1;

//Array with notes and Rhythm

[41,41,39,37,37,39,41,41,42,44,44,46,46,46,44,46,46,48,48,48,46,44,44,42] @=> int bass_a[];

// Function to play the bass

fun void bass_p(float beattime)
{
    while (true)
    {
        counter1 % 24 => int beat1;
        bass_a[beat1] => int ba;
        Std.mtof(ba) => bass.freq;
        0.5 => bass.noteOn;
        counter1++;
        beattime::second => now;
               
    }
    
    
}

// Playing the bass

while (true)
{
    bass_p(0.3125);
}
