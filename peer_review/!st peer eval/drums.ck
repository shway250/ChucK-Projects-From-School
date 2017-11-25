//Drums.ck

//The Basic for the Drums is a 12/8 Pattern, but simultounasly it is 
//playing a Patter that has one eight less, so that its moving foreward and
//interessting rhyhtms will evolve out of this. A quaternote is 0.625 so an eight
// an eight is 0.3125 and sixteens are 0.15625

// Soundchain for Drums

SndBuf kick => dac.right;
SndBuf clap => dac.left;
SndBuf snare => dac.right;
SndBuf hihat => dac.right;
 
Shakers shak => dac;

0.4 => dac.gain;

// Shaker definition

17 => shak.preset;

// Loading Soundfiles

me.dir(-1) + "/audio/kick_01.wav" => kick.read;
me.dir(-1) + "/audio/clap_01.wav" => clap.read;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;

// Initialize without sound

kick.samples() => kick.pos;
clap.samples() => clap.pos;
snare.samples () => snare.pos;
hihat.samples () => hihat.pos;

//Global Variables

0 => int counter1;

// Rhyhtm Arrays

[1,0,0,0,1,0,0,0,1,0,0,0] @=> int kick_a[]; // like 3 main beats
[1,0,0,1,0,0,1,0,0,1,0,0] @=> int snare_a[]; // like 4 main beats
[1,1,1,1,1,1,1,1,1,1,1,1] @=> int hihat_a[]; // playing all eights
[1,0,1,1,0,1,1,1,0,1,1,0] @=> int clap_a[]; // Clapping Array one
[1,0,1,1,0,1,1,1,0,1,1] @=> int shak_a[]; //Shaker array with one element less so that it
                                          // moves against the others in time



// Drummachine function 1

fun void drums(int kick_array[], int clap_array[], int snare_array[], int hihat_array[], float beattime)
    {
  
        for (0 => int d; d < kick_array.cap(); d++)
        {    
           if ( kick_array[d] == 1)
            {
                0 => kick.pos;
            }
           if ( clap_array[d] == 1)
            {
                0 => clap.pos;
            }
           if ( snare_array[d] == 1)
            {
                0 => snare.pos;
            }     
           if ( hihat_array[d] == 1)
           {
               0 => hihat.pos;
           }

        0.6 => kick.gain;
        0.5 => clap.gain;
        0.8 => snare.gain;
        0.4 => hihat.gain;
            
        beattime::second => now;
        counter1++;
        }
    }

// Shaker Function

fun void shak_it(int shak_array[], float beattime)
    {
        for (0 => int d; d < shak_array.cap(); d++)
        {    
           if ( shak_array[d] == 1)
            {
                Math.random2f(0.0,128.0) => shak.objects;
                Math.random2f(0.0,1.0) => shak.decay;
                1.0 => shak.energy;
            }
            
            beattime::second => now;
            counter1++;
        }
    }
    

// shake it more then once

fun void shake_it_more()
{
    while (true)
    {
        shak_it(shak_a,0.15625);
    }
    
}    
    
//Playing everything together

spork ~  shake_it_more();   
    
    
while (true)
{
    drums(kick_a,clap_a,snare_a,hihat_a,0.15625);
}
    
   