//Assignment_6_" not really jazz"


//bass.ck
// sound chain (mandolin for bass)
Bowed bass => NRev r => dac;

//Scale data (Not whole aeolian mode)
[46,49,53,54,58] @=> int scale[];

//control parameter setup
0.09=> r.mix;
0.5 => bass.bowPressure;
Math.random2f(0.0,0.1) =>bass.vibratoFreq;
Math.random2f(0.0,0.05) =>bass.vibratoGain;
4 => int walkPos;

// globalTime will set time of composition using While loop
now + 20::second => time globalTime;

//loop
while(now < globalTime)
{
    Math.random2(-1,1) => walkPos;
    if ( walkPos < 0) 1 => walkPos;
    if (walkPos >= scale.cap() ) scale.cap() -2 => walkPos;
    Std.mtof(scale[walkPos] -12) => bass.freq;
    Math.random2f(0.05,0.5) => bass.bowPosition;
    1 =>bass.noteOn;
    0.6 :: second => now;
    1 =>bass.noteOff;
    0.025:: second => now;
}