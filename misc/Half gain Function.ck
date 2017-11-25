//Sound Chain
SinOsc s => dac;

//Function
fun float halfGain( float originalGain )
{
    return (originalGain*.5);
}

//remember that .gain() is a function that is part of SinOsc
<<<"full Gain: " , s.gain() >>>;
1::second => now;

//call halGain()
halfGain(s.gain()) => s.gain;
<<< "Half Gain: ", s.gain() >>>;
1::second => now;