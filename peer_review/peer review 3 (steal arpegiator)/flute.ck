// flute.ck
// Our famous headliner flute solo (with EFX)
Flute solo => JCRev rev => dac;
0.05 => rev.mix;
0.5 => solo.gain;

// shared jazz scale data
[46, 48, 49, 51, 53, 54, 56, 58] @=> int scale[]; 

// then our main loop headliner flute soloist
while (1)  
{
    (
    Math.random2(1, 4) * 0.125) :: second => now;
    
    if (
        Math.random2(0,9) > 2) {
        Math.random2(0, scale.cap()-1) => int note;
        Math.mtof(24 + scale[note])=> solo.freq;
        Math.random2f(0.3, 0.7) => solo.noteOn;
    }
    else 1 => solo.noteOff;
}
