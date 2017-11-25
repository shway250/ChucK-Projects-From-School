// Piano Chords

// Preparing soundchain

Rhodey piano[4];
piano[0] => dac.left;
piano[1] => dac;
piano[2] => dac;
piano[3] => dac.right;

0.4 => dac.gain;

// 2d Array for chords

[[37,44,49,53],[37,46,49,53],[37,46,49,54],[36,44,48,51]] @=> int chord_a[][];

// Looping the chords 0.9375

while( true )
{
    //build 1st chord
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(chord_a[0][i]) => piano[i].freq;
        Math.random2f(0.2,0.4) => piano[i].noteOn;
    }
    0.9375::second => now;
    
    
    //build 2nd chord
   
    for(0 => int i; i < 4; i++)
    {
        Std.mtof(chord_a[1][i]) => piano[i].freq;
        Math.random2f(0.2,0.4) => piano[i].noteOn;
    }
    0.9375::second => now;
    
    //build 3rd chord
   
    for(0 => int i; i < 4; i++)
    {
        Std.mtof(chord_a[2][i]) => piano[i].freq;
        Math.random2f(0.2,0.4) => piano[i].noteOn;
    }
    0.9375::second => now;
    
    //build 4rd chord
   
    for(0 => int i; i < 4; i++)
    {
        Std.mtof(chord_a[3][i]) => piano[i].freq;
        Math.random2f(0.2,0.4) => piano[i].noteOn;
    }
    0.9375::second => now;
    
}