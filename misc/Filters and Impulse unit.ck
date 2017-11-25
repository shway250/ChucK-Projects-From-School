Impulse imp => ResonZ filt => dac;
1000.0 => filt.freq;
400 => filt.Q;

while( true )
{
    200.0 => imp.next;//generate 1 for one sample
    Math.random2f(500,2000) => filt.freq;
    Math.random2f(0.1,0.4)::second => now;
}