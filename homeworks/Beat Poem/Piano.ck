// piano.ck
//Sound Chain
ModalBar piano[4];
piano[0] => dac.left;
piano[1] => dac;
piano[2] => dac;
piano[3] => dac.right;

//2D chord array
[60,64,67,71] @=> int chordz[];

//loop
while( true )
{
    //build first chord
    for( 0 => int i; i < 4; i++ )
    {
        //run through array and turn notes on
        Std.mtof(chordz[i]) => piano[i].freq;
        Math.random2f(0.5,1.0) => piano[i].noteOn;
        //so many freakin' random params dawg
        Math.random2f(0.0,1.0) => piano[i].stickHardness;
        Math.random2f(0.0,1.0) => piano[i].strikePosition;
        15 => piano[i].vibratoFreq;
        Math.random2f(0.5,1.0) => piano[i].vibratoGain;
        Math.random2(0,16) => piano[i].preset;
        0.01 => piano[1].damp;
    }
    800::ms => now;
    //build second chord
    for( 0 => int i; i < 4; i++ )
    {
        //run through array and turn notes on
        Std.mtof(chordz[i]) => piano[i].freq;
        Math.random2f(0.5,1.0) => piano[i].noteOn;
        //so many freakin' random params dawg
        Math.random2f(0.0,1.0) => piano[i].stickHardness;
        Math.random2f(0.0,1.0) => piano[i].strikePosition;
        15 => piano[i].vibratoFreq;
        Math.random2f(0.5,1.0) => piano[i].vibratoGain;
        Math.random2(0,16) => piano[i].preset;
        0.01 => piano[1].damp;
    }
    175::ms => now;

}