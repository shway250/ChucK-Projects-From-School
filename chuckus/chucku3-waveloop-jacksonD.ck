WaveLoop s=>PitShift p=>dac;
"special:dope" =>s.path;
0.0=>float x;

while(1)
{
    250+250*Math.cos(x) => s.freq;x+.1 =>x;
    Math.random2f(0.5,1.0)=>p.mix;
    Math.random2f(1.0,5.0)=>p.shift;
    150::ms => now;
}