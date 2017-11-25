// spork sitar and mandolin
// sound chain
Sitar sitar => dac.right;
Mandolin mand => Pan2 p => dac;

// global variables
[46,48,49,51,53,54,56,58] @=> int f[];

spork ~ one();
spork ~ two();

// loop
while( true ) 1::second => now;

fun void one()
{
    // loop
    while( true )
    {
        Std.mtof(Math.random2(46, 58)) => mand.freq; // convert midi to freq
        0.5 => mand.noteOn; // noteon mandolin
        (0.625/2)::second => now; // advance in time
        
    }
}


fun void two()
{
    while( true )
    {
        Std.mtof(Math.random2(46, 58)) => sitar.freq; // convert midi to freq
        1.5 => sitar.noteOn; // noteon sitar
        (0.625/2)::second => now; // advance in time
        
    }
}