// drums.ck
// Insert the title of your piece here

// Part of your composition goes here

Gain BeatMaster => NRev Rev => dac;
SndBuf Hi =>  BeatMaster;
SndBuf Sna => BeatMaster;
SndBuf Ba => BeatMaster;

[1,1,1,1,1,1,1,1] @=> int HiHat[]; // Rhythm chart for hi-hats
[0,0,1,1,0,0,1,1] @=> int Snare[]; // Rhythm chat for snare
[1,0,1,0,1,0,1,0] @=> int Bass[]; // Rhythm chat for Bass

// Loading da sound files
me.dir(-1) + "/audio/snare_02.wav" => Sna.read;
me.dir(-1) + "/audio/hihat_02.wav" => Hi.read;
me.dir(-1) + "/audio/kick_02.wav" => Ba.read;

0.02 => Rev.mix;
0.15 => BeatMaster.gain;

0 => int Count;

fun void HH()
{
    if(HiHat[Count%8] == 1)
    {
        0 => Hi.pos;
        if(Math.random2(0,9) >= 7)
        {
            repeat(3)
            {
                 0 => Hi.pos;
                (0.625/3)::second => now;
            }
        }
    }
}

fun void S()
{
    if(Snare[Count%8] == 1)
    {
        0 => Sna.pos;
        if(Math.random2(0,9) >= 7)
        {
            repeat(2)
            {
                 0 => Sna.pos;
                (0.625/2)::second => now;
            }
        }
    }    
}

fun void B()
{
    if(Bass[Count%8] == 1)
    {
        
        if(Math.random2(0,9) >= 7)
        {
            (0.625/2)::second => now;
            0 => Ba.pos;
        }
    }    
}

while(true)
{    
    Math.random2f(0.12,0.17) => BeatMaster.gain;
    spork ~ HH();
    spork ~ S();
    spork ~ B();
    (0.625/2)::second => now;
    Count++;
}