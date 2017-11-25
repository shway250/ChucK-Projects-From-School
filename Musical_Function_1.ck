// Soudn Chain
SinOsc s => dac;

//First Function
fun float halfGain( float originalGain )
{
    //takes float value and multiplies is by .5, returns that number
    return (originalGain*.5);   
    
}

//remember that .gain() is a function that is part of SinOsc
<<< "Full Gain: ", s.gain() >>>;
1::second => now;

// call halfGain() function
//calling gain with brackets recalls data, without chucks data into it
halfGain(s.gain()) => s.gain;
<<<"Half Gain: ", s.gain() >>>;
1::second => now;