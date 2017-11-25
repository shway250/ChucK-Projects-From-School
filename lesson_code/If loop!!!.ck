//sound chain
SinOsc s => dac;
220.0 => s.freq;
0.6 => s.gain;
1 => int chance;
if ((chance==1) || (chance==3))
{
    1::second=>now;
}
else
{
330.0=>s.freq;
4::second=>now;
}