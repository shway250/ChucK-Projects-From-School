// Bass
Mandolin bass => NRev r => dac;

[46, 48, 49, 51, 53, 54, 56, 58] @=> int scale[]; 

0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
4 => int walkPos;
.5 => bass.gain;


while( true )  
{
    Math.random2(-1,1) +=> walkPos; 
    if (walkPos < 0) 1 => walkPos;
    if (walkPos >= scale.cap()) scale.cap()-2 => walkPos;
    Std.mtof(scale[walkPos]-12) => bass.freq;
    Math.random2f(0.05,0.5) => bass.pluckPos;
    1 => bass.noteOn;
    (0.55) :: second => now;
    1 => bass.noteOff;
    (0.075) :: second => now;
}