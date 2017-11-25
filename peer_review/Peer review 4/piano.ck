// piano.ck
// sound chain
Rhodey piano => dac;


// global variables chord array
[46,48,49,51,53,54,56,58] @=> int chordz[];

// loop
while( true )
{
    // loop
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(Math.random2(46, 58)-12) => piano.freq;
        Math.random2f(0.5, 1.0) => piano.noteOn;
        0.625::second => now;        
    }
   
}
