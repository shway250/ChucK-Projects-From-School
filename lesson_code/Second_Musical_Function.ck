// Sound Chain
SinOsc s => dac;
SinOsc t => dac;
SinOsc u => dac;

// Function
fun float octave( float originalFreq )
{
   //calculate octave of input freq
   return(originalFreq*2);
    
}

fun float fifth( float originalFreq )
{
    //calculate fifth of input
    return (originalFreq*1.5);
}




/// MAIN PROGRAM!!!!
// Loop
for( 20 => float i; i < 500; i + .5 => i )
{
    i => s.freq;
    //I want to write a fun that will  make the freq of t and octave higher
    octave(i) => t.freq;
    //now I wanna write a function that makes freq a 5th up
    fifth(i) => u.freq;
    <<< s.freq(), t.freq(), u.freq() >>>;
    10::ms => now;
    
}