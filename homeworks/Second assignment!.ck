//Assignment NUMERO DOS!!!!

//Oscillators
SinOsc sine_osc_1 => dac;
TriOsc tri_osc_1 => Pan2 p => dac;

//Array Declaration for Dorian Scale
[50,52,53,55,57,59,60,62] @=> int A[];
[50,52,53,53,57,59,60,62] @=> int B[];
[38,41,45,48] @=> int i7[]; //i7 arp
[40,43,47,48] @=> int ii7[]; //ii7 arp
[55,59,62,64] @=> int IV7[]; //IV7 arp
[59,62,65,69] @=> int vio7[]; //vidim7 arp

//Quarter note, half note, eigth note durations.
0.25::second => dur q;
0.5::second => dur h;
0.125::second => dur e;

//Rhythm Arrays
[q,q,q,q] @=> dur quarters[];
[h,e,e,q] @=> dur patern_one[];

//initialize Pan position
1.0 => float panPosition;

for (0 => int i; i < 4; i++)
{
    Std.mtof(i7[i]) => sine_osc_1.freq;
    0.3 => sine_osc_1.gain;
    patern_one[i] => now;
    
    0.1=> sine_osc_1.gain;
    250::ms => now;
    
    //panning for tri osc
    Math.random2f(-1.0,1.0)=> p.pan;
    Std.mtof(i7[i]) => tri_osc_1.freq;
    //tri_osc_1.freq*12 => tri_osc_1.freq;
    0.3 => tri_osc_1.gain;
    quarters[i] =>now;
    
    0.1=> tri_osc_1.gain;
    250::ms => now;
    
    }
for (0 => int i; i < 4; i++)
{
    Std.mtof(i7[i]) => sine_osc_1.freq;
    0.3 => sine_osc_1.gain;
    patern_one[i] => now;
    
    0.1=> sine_osc_1.gain;
    250::ms => now;
}

for (0 => int i; i < 4; i++)
{
    Std.mtof(ii7[i]) => sine_osc_1.freq;
    0.3 => sine_osc_1.gain;
    patern_one[i] => now;
    
    0.1=> sine_osc_1.gain;
    250::ms => now;
}
for (0 => int i; i < 4; i++)
{
    Std.mtof(i7[i]) => sine_osc_1.freq;
    0.3 => sine_osc_1.gain;
    patern_one[i] => now;
    
    0.1=> sine_osc_1.gain;
    250::ms => now;
}
