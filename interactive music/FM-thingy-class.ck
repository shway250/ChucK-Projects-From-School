//Jackson Duhon
//FM Synth
//works best with high notes, low notes get noisey

public class JackFM //extends Chubgraph
{
    // FM oscillators
    SinOsc s => LPF lpf => ADSR adsr => Pan2 master;
    SinOsc a=>s;
    SinOsc d=>s;
    SinOsc f=>a;
    ///oscillator sync modes
    2 => s.sync;
    2 => a.sync;
    2 => d.sync;
    2 => f.sync;
    ///Gain management
    master => dac;
    // FM gain Parameters
    500 => a.gain;
    450 => d.gain;
    800 => f.gain;
   //filter parameters
    1000 => lpf.freq;
    5.5 => lpf.Q;
    //envelope params
    adsr.set(100::ms, 10::ms, 0.7, 500::ms);
        
    // spork functions
    spork ~ mainLoop();
        
    // keyOn// frequency setter
    fun float freq(float f)
    {
        f => s.freq;
        return f;
    }

    fun void keyOn()
    {
        1 => adsr.keyOn;
    }
    
    // keyOff
    fun void keyOff()
    {
        1 => adsr.keyOff;
    }
    
    // control function
    fun void mainLoop()
    {
        while(true)
        {
            ///set up FM frequency bidness
            s.freq() * 2.0 => a.freq;
            s.freq() * Math.sin(now/35::ms*2*pi) => d.freq;
            a.freq() * Math.random2f(1.0,4.0) => f.freq;
            //advance time
            10::ms => now;
        }
    }
}

