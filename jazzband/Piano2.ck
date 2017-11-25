//Assignment_6_" not really jazz"

// piano.ck
//Sound Chain
Rhodey piano[4];
piano[0] => ADSR env1 => dac.left;
piano[1] => ADSR env2 => dac;
piano[2] => ADSR env3 => dac;
piano[3] => ADSR env4 => dac.right;
(0.19::second, 0.7::second, 0.0, 0.3::second ) => env1.set;
(0.2::second, 0.65::second, 0.0, 0.3::second ) => env2.set;
(0.08::second, 0.57::second, 0.0, 0.3::second ) => env3.set;
(0.23::second, 0.7::second, 0.0, 0.3::second ) => env4.set;



//2D chord array
[ [46,49,53,56],[51,54,58,61],[51,53,56,60] ] @=> int chordz[][];

// globalTime will set time of composition using While loop
now + 15::second => time globalTime;

//loop
while(now < globalTime)
{
    //build first chord
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(chordz[0][i]) => piano[i].freq;
        Math.random2f(0.5,1.0) => piano[i].noteOn;
        1 => env1.keyOn;
        1 => env2.keyOn;
        1 => env3.keyOn;
        1 => env4.keyOn;
    }
    .625::second => now;
    //build second chord
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(chordz[1][i]) => piano[i].freq;
        Math.random2f(0.2,0.5) => piano[i].noteOn;
        1 => env1.keyOn;
        1 => env2.keyOn;
        1 => env3.keyOn;
        1 => env4.keyOn;
    }
    .625::second => now;
    //build first chord again
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(chordz[0][i]) => piano[i].freq;
        Math.random2f(0.5,1.0) => piano[i].noteOn;
        1 => env1.keyOn;
        1 => env2.keyOn;
        1 => env3.keyOn;
        1 => env4.keyOn;
    }
    .625::second => now;
    //build second chord again
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(chordz[1][i]) => piano[i].freq;
        Math.random2f(0.2,0.5) => piano[i].noteOn;
        1 => env1.keyOn;
        1 => env2.keyOn;
        1 => env3.keyOn;
        1 => env4.keyOn;
    }
    .312::second => now;
    //build last chord
    for( 0 => int i; i < 4; i++ )
    {
        Std.mtof(chordz[2][i]) => piano[i].freq;
        Math.random2f(0.2,0.5) => piano[i].noteOn;
        1 => env1.keyOn;
        1 => env2.keyOn;
        1 => env3.keyOn;
        1 => env4.keyOn;
    }
    0.313::second => now;
}