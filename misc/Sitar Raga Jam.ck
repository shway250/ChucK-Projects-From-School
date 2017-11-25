//Raga Jam

//Sound Chain For sitar
Sitar sitar => Gain sitarGain => Gain master => dac;
sitarGain => Gain sitarFeedback => Delay delay =>sitarGain;

//Drums
Shakers shaker => master;

//Drone
VoicForm singerDrones[4];
NRev droneRev => master;
for ( 0=> int i; i < singerDrones.cap(); i++ )
{
    singerDrones[i] => droneRev;
    (.5/singerDrones.cap()) => singerDrones[i].gain;
}

//global variables
[62,63,65,67,69,70,72,74] @=> int raga[];
[26,38,45,50] @=> int drone[];

// timing parament
.2 => float beattime;

//Sitar Feedback Parameters
beattime::second => delay.max;
beattime::second => delay.delay;
.75 => sitarFeedback.gain;

// singer parameters (drone)
.5 => droneRev.mix;
for( 0 => int i; i < singerDrones.cap(); i++)
{
    .02 => singerDrones[i].vibratoGain;
    "lll" => singerDrones[i].phoneme;
    Std.mtof(drone[i]) =>singerDrones[i].freq;
}

//MAIN PROGRAM

//drone solo
5::second => now;

while( true )
{
    //time variation
    Math.random2(1,3) => int factor;
    //Loop
    for( 0 => int i; i < raga.cap(); i++ )
    {
        
        //Sitar Controls
        Std.mtof(raga[Math.random2(0,raga.cap()-1)]) => sitar.freq;
        sitar.noteOn(Math.randomf());
        
        //Drum Control
        Math.random2(1,2) => shaker.preset;
        Math.random2f(60.0, 128.0) => shaker.objects;
        Math.random2f(.8,1.0) => shaker.decay;
        shaker.noteOn (Math.random2f(0.0, 4.0));
        
        //Advance Time
        beattime::second*factor => now;
    }
}