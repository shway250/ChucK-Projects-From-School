class Spencethizer extends Chubgraph
{
    
    SinOsc m2=>SinOsc m => SinOsc s => LPF filter => ADSR adsr => outlet;
    ADSR env2 => blackhole;
    SinOsc lfo => blackhole;
    SinOsc lfo2 => blackhole;
    s => HPF filter2 => adsr;
    s => BPF filter3 => adsr;
    
    2 => s.sync;
    2 => m.sync;
    
    //modulator frequency and gain
    1000 => m.gain;
    10000 => m2.gain;
    2 => float ratio;
    3 => float ratio2;
    48 => Std.mtof => s.freq;
    //modulator params
    s.freq()*ratio => m.freq;
    s.freq()*ratio2 => m2.freq;
    
    s.freq()*2 => filter.freq;
    
    //filter resonance
    5=> filter.Q;
    4 =>filter2.Q;
    10 =>filter3.Q;
    
    //envelope set
    adsr.set(10::ms, 100::ms, 0.5, 20::ms);
    env2.set(5::ms, 20::ms, 0.1, 20::ms);
    //lfo freq
    0.25 => lfo.freq;
    0.7 =>lfo2.freq;
    
    //key on
    fun void keyon()
    {
        1 => adsr.keyOn;
        1 => env2.keyOn;
    }
    spork ~ controlRate();
    
    
    .01::second => now;
    
    fun void keyOff()
    {
        1 => adsr.keyOff;
        1 => env2.keyOff;
    }
    
    .01::second => now;
    
    spork ~ controlRate();
    
    fun void controlRate()
    {
        while(true)
        {
            //scaling LFO value
            s.freq() + (1+lfo.last())/2.0*1000 => filter2.freq;
            //scaling LFO value
            s.freq() + (1+lfo2.last())/2.0*1000 => filter3.freq;
            //taking s.freq, and scaling between 0-1000
            s.freq() + env2.value()*1000 => filter.freq;
            5::ms => now;
        }
    }
}

Spencethizer s => dac;
s.keyon();
25::second => now;

s.keyOff();
.25::second => now;
