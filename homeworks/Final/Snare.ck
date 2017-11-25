//Assignment 8 "Final"
// snare.ck
//sound chain
SndBuf snare => dac;
me.dir(-2)+"/audio/snare_01.wav" => snare.read;
1.5 => snare.gain;
snare.samples() => snare.pos;

// make a conductor for our tempo 
// this is set and updated elsewhere
BPM tempo;

while (1)  {
    // update our basic beat each measure
    tempo.quarterNote => dur quarter;
    
    // Snare play pattern.
    quarter => now;
    0 => snare.pos;
    1.5*quarter => now;
    0 => snare.pos;
    quarter/4.0 => now;
    0 => snare.pos;
    3.0*quarter/4.0 => now;
    0 => snare.pos;
    1.5*quarter => now;
    0 => snare.pos;
    3.0*quarter => now;
    0 => snare.pos;
    
}    
