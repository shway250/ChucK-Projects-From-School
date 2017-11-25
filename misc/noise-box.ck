//Sound Bidness
WaveLoop s => PitShift p => Pan2 master;
SinOsc sin1 =>ADSR env => master;
SinOsc sin2 => env => master;
SinOsc sin3 => env => master;
SinOsc sin4 => env => master;
"special:dope" => s.path;
0.0 => float x;

//arrays
[1.0, 1.5, 1.33, 1.25, 1.2, 1.16, 1.142, 1.125] @=> float harmonics[];

//gain management
(Math.random2(40,50)::ms,Math.random2(10,40)::ms, 1.0,Math.random2(10,40)::ms) => env.set;
0.1 => float sineGain;
sineGain => sin1.gain;
sineGain => sin2.gain;
sineGain => sin3.gain;
sineGain => sin4.gain;
master => dac;

//composition
////ascending sine wave thing
fun void sines1()
{
    while(true)
    {
        for( 330 => int i; i< 660; Math.random2(1,20) +=> i)
        {
            1 => env.keyOn;
            i => float freq;
            freq =>sin1.freq;
            freq*harmonics[Math.random2(0,7)] => sin2.freq;
            Math.random2(110,400)::ms => now;
        }
    }
}
/////descending sine wave thing
fun void sines2()
{
    while(true)
    {
        for( 880 => int i; i > 440; Math.random2(1,20) -=> i)
        {
            1 => env.keyOn;
            i => float freq;
            freq =>sin3.freq;
            freq*harmonics[Math.random2(0,7)] => sin4.freq;
            Math.random2(110,400)::ms => now;
        }
    }
}

/////homer simpson noise
fun void noise()
{
    while(true)
    {
        250+250*Math.sin(x) => s.freq;
        x+Math.random2f(.01, 0.1) =>x;
        Math.random2f(0.5,1.0)=> p.mix;
        Math.random2f(1.0,5.0)=> p.shift;
        Math.random2(50,200)::ms => now;
    }
}

spork ~ noise();
spork ~ sines1();
spork ~ sines2();

while(true)
{
    1::ms => now;
}