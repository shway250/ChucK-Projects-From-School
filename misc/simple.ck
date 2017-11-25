//simple example of sound making class
class Simple
{
    //sound chain
    Impulse imp => ResonZ filt => dac;
    
    //some default setting
    100.0 => filt.Q => filt.gain;
    1000.0 => filt.freq;
    
    //member function
    fun void freq(float f)
    {
        f => filt.freq;
    }
    
    fun void setQ(float Q)
    {
        Q => filt.Q => filt.gain;
    }
    
    fun void setGain(float g)
    {
        g => imp.gain;
    }
    
    fun void noteOn(float volume)
    {
        volume => imp.next;
    }
    
    /// three ways of setting pitch
    fun float pitch(float freq)
    {
        return (freq => filt.freq);
    }
    
    //another way to set pitch by midi note number
    fun float pitch(int noteNum)
    {
        return (Std.mtof(noteNum) => filt.freq);
        
    }
    
    
    
    
}



///defines class and instantiates the Object "s"
Simple s;

while( true )
{
    //midi note number pitch
    s.pitch(60);
    1 =>s.noteOn;
    1::second => now;
    
    //pitch as float frequency
    s.pitch(440.0);
    1 =>s.noteOn;
    1::second => now;
    
    
}


















