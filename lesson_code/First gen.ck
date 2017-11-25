// synthesis patch
TriOsc foo => NRev r => dac;
.5 => foo.gain;
.1 => r.mix;

// an array: add stuff
[ 0,2,4,7,9,11,12 ] @=> int hi[];

while( true )
{
    // change parameters here
    Std.mtof( 45 + Std.rand2(1,3) * 12 +
        hi[Std.rand2(0,hi.cap()-1)] ) => foo.freq;
        
        //different rate
        220::ms=> now;
    }