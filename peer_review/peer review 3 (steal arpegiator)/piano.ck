// Piano

Rhodey pia[5];
Pan2 p => Gain g => dac;
pia[0] => p.left;
pia[1] => p;
pia[2] => p;
pia[3] => p.right;

0.4 => g.gain;
[[46,49,54,58],[46,49,53,56],[48,51,53,58],[46,49,53,54]] @=> int mA2[][];

0 => int index;
0 => int Count;
fun void playBass()
{
    if(Math.random2(0,9) >= 7)
    {
        (0.625/3)::second => now;
    }
    for(0 => int i; i < 4; i ++)
    {    
        Math.random2f(0.3,0.7) => pia[i].noteOn;
        Std.mtof(mA2[index][i]) => pia[i].freq;
    }
}

while(true)
{
    Math.random2(0,3) => index;
    if(Count%2 == 0)    spork ~ playBass();
    0.625::second => now;    
    Count++;
}