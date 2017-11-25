//Sound Chain
SinOsc s => dac;
TriOsc T2 => dac;
SawOsc S2 => dac;

//Setting gain for Oscs
0.4 => s.gain;
0.4 => T2.gain;
0.2 => S2.gain;

//defining ints
20 => int i;
20 => int q;
20 => int w;

//while loop for sine
while( i<100 )
{
    <<< i >>>; //print value of i
    i => s.freq;
    i++;
    .02::second => now;
}
//while loop for tri
while( q<400 )
{
    q => T2.freq;
    q++;
    .01::second => now;
}
//while loop for Saw
while( w<300 )
{
    w => S2.freq;
    w++;
    .01::second => now;
}