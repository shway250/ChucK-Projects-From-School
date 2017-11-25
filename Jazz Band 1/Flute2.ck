//flute.ck
//soundchain
Moog solo => NRev rev => dac;

//sound parameters
0.1 => rev.mix;
Math.random2f(0.0,0.9) => solo.filterQ;
Math.random2f(0.0,0.9) => solo.filterSweepRate;

//scale
[46,48,49,51,53,54,56,58] @=> int scale[];

//loop
while( true )
{
    (Math.random2f(.625,2.5) * 0.2)::second => now;
    
    //play
    if (Math.random2(0,5) > 1)
    {
        Math.random2(0,scale.cap() -1) => int note;
        Math.mtof(12+ scale[note]) => solo.freq;
        Math.random2f(0.4,0.6) =>solo.noteOn;
    }
    else
    {
        solo.noteOff;   
    }
}