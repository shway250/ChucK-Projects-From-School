//sound netweork
SinOsc s => dac;
SqrOsc t => dac;

//only play s
0.5 => s.gain;
0.0 => t.gain;

for( 0 => int i; i < 500; i++ )
{
 i => s.freq;
 .001::second => now;   
}