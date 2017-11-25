//Drooms.seekay
//sound chain
Shakers groove => Pan2 Master => dac;

//Global Parameters
//Make it a tambourine
6 => groove.preset;
0.7=> Master.gain;

while( true )
{
    //Make groove turn on and screw with some params
    1=> groove.noteOn;
    Math.random2f(.6,1.0)=>groove.energy;
    0.9=>groove.decay;
    128.0 =>groove.objects;
    250::ms=>now;
    //Turn note off
    0=>groove.noteOn;
    275::ms=>now;
    
    //Make two shorter notes
    1=> groove.noteOn;
    Math.random2f(.4,0.6)=>groove.energy;
    Math.random2f(.04,0.7)=>groove.decay;
    Math.random2f(25.0,100.0) =>groove.objects;
    125::ms=>now;
    //Turn note off
    0=>groove.noteOn;
    150::ms=>now;
    
    //Second shorter note
    1=> groove.noteOn;
    Math.random2f(.4,0.6)=>groove.energy;
    Math.random2f(.04,0.7)=>groove.decay;
    Math.random2f(25.0,100.0) =>groove.objects; 
    100::ms=>now;
    //Turn note off
    0=>groove.noteOn;
    75 ::ms=>now;
}