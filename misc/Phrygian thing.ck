// our signal graph (patch)
SqrOsc s => JCRev r => dac;
// set gain
.2 => s.gain;
// set dry/wet mix
.1 => r.mix;

// an array of pitch classes (in half steps)
[ 0, 1, 4] @=> int hi[];

// infinite time loop
while( true )
{
    // choose a note, shift registers, convert to frequency
    Std.mtof( 45 + Std.rand2(0,3) * 12 +
    hi[Std.rand2(0,hi.cap()-1)] ) => s.freq;
    
    // advance time by 120 ms
    120::ms => now;
}
