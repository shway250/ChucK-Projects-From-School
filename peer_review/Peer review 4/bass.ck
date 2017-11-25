// bass.ck
// sound chain mandolin
Mandolin bass => NRev r => dac;

// scale data
[46,48,49,51,53,54,56,58] @=> int scale[];

// parameter setup
0.1 => r.mix;
0.0 => bass.stringDamping; // set string damping
0.02 => bass.stringDetune; // detune mandolin
0.06 => bass.bodySize; // set body size
4 => int walkPos;

// loop
while( true )
{
    Math.random2(-1, 1) +=> walkPos;
    if (walkPos < 0) 1 => walkPos;
    if (walkPos >= scale.cap()) scale.cap() - 2 => walkPos;
    Std.mtof(scale[walkPos]) => bass.freq;    
    Math.random2f(0.05, 0.5) => bass.pluckPos;
    0.8 => bass.noteOn;
    0.625::second => now;
}
