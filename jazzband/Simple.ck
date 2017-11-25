//Simple example of sound making class
class Simple
{
    //sound chain
    Impulse imp => ResonZ filt => dac;
    
    //some default settings
    100.0 => filt.Q => filt.gain;
    1000.0 => filt.freq;
    
    fun void freq( float f)
    {
        f => filt.freq;
    }
    
    fun void setQ( float Q)
    {
        Q => filt.Q => filt.gain;
    }
    
    fun void setGain(float g)
    {
        g => imp.gain;
    }
    
    fun void noteOn( float volume)
    {
        volume => imp.next;
    }
    
    //three ways of setting pitch
    // one by float freq
    fun float pitch(float freq)
    {
        return (freq => filt.freq);
    }
    //another way to set pitch by MIDI note number
    fun float pitch( int noteNum)
    {
        return (Std.mtof(noteNum) => filt.freq);
    }
    
}

Simple s;

while(true)
{
    //MIDI note number pitch
    s.pitch(60);
    1 => s.noteOn;
    1::second => now;
    
    // pitch as float frequency
    s.pitch(440.0);
    1 => s.noteOn;
    1::second =>now;
    
    Math.random2f(1100.0,1200.0) => s.freq;
    Math.random2f(1,200) => s.setQ;
    Math.random2f(.2,.8) => s.setGain;
    //play note
    1 => s.noteOn;
    .1::second => now;
    
}








