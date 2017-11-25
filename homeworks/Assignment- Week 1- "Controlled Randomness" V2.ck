//Assignment- Week 1- "Controlled Randomness"

//Oscillators
SinOsc S => dac;
TriOsc T => dac;

//Using loops to make arpeggios


for( 0 => int Q; Q<5; Q++ )
{
    <<< Q >>>;
    1::second;
}

//this if statement choose frequency and time of arp based on Int Q
if( (Q == 0) || (Q == 2) || (Q == 4); 
{
    //Sound only plays for identified even ints
    1::second => now;
    //Makes frequency of Middle C
    440.32 => S.freq;
}