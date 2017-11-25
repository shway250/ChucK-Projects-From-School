//sitar.ck

SawOsc sitar => LPF sitLpf => ADSR sEnv => NRev sit => dac;

//ADSR Params
sEnv.set(0.15::second, 0.0::second,0.1,0.2::second);

//LPF params
sitLpf.set(600, 0.5);

Math.srandom(12);

//Arrays
[62,62,62,62,63] @=> int tonic[];
[2,4] @=> int subDiv[];
[1.0,0.5,2.0] @=> float oct[];

0.1 => sit.mix;

///classes
BPM temp;
temp.tempo(90);

//composition
while (true)
{
    
    for(0=> int i; i < 6; i++)
    {
        Math.random2(tonic[0], tonic[tonic.cap()-1]) => int note;
        Std.mtof(note)* oct[Math.random2(0,1)] => sitar.freq;
        0.3=> sitar.gain;
        Math.random2f(0.0,0.5)=>sitar.width;
        1=>sEnv.keyOn;
        temp.quarterNote / subDiv[Math.random2(0,1)]=> now;
        
    }
}