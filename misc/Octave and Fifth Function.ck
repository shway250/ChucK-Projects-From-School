//sound chain
SinOsc s => dac;
SinOsc t => dac;
SinOsc u => dac;

//Function
//Third function
fun float third( float originalFreq )
{
    //calculate third of input frequency
    return(originalFreq*1.25);
}

//fifth function
fun float fifth( float originalFreq )
{
    //calculate fifth of input frequency
    return(originalFreq*1.5);
}
//7th function
fun float sev( float originalFreq )
{
    //calculate seventh of input frequency
    return(originalFreq*1.75);
}


//MAIN PROGRAM
//LOOP
for( 20 => float i; i <500; i + .5 => i)
{
    i => s.freq;
    octave(i) => t.freq;
    fifth(i) => u.freq;
    <<< s.freq(), t.freq(), u.freq() >>>;
    10::ms => now;
    
}