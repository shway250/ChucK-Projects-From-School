// Assignment 5_Superman

//Sound chain
Mandolin man => dac;
ModalBar mod => dac;
SinOsc q => pan2 p => dac;
Shakers shak => dac;

// array declaration 
[49, 52, 52, 52, 56, 56, 50, 54, 54] @=> int A[];
[54, 57, 57, 59, 61, 59, 60] @=> int B[];


// sound chain
Gain master => dac;
SndBuf click => master;
SndBuf snare => master;
SndBuf hihat => master;
SndBuf cowbell => master;


.6 => master.gain; // any other place playing with the gains will be relative to the master gain

// load soundfiles into sndbuf
me.dir() + "/audio/click_04.wav" => click.read;
me.dir() + "/audio/snare_01.wav" => snare.read;
me.dir() + "/audio/hihat_02.wav" => hihat.read;
me.dir() + "/audio/cowbell_01.wav" => cowbell.read;

// global variables
[1,0,0,0,1,0,0,0] @=> int ptrn_1[];
[0,0,1,0,0,0,1,0] @=> int ptrn_2[];
[1,0,1,0,1,0,1,0] @=> int ptrn_3[];
[0,1,1,0,0,1,1,0] @=> int ptrn_4[];

0 => int beat;

// function 
fun void section( int Array1[], int Array2[], float beattime )
{
    // sequencer: for bass drum and snare drum beats
    for( 0 => int i; i < Array1.cap(); i++)
    {
        // if 1 in array then play click
        if( Array1[i] == 1 )
        {
            0 => click.pos;
        }
        // if 1 in array then play snare
        if( Array2[i] == 1 )
        {
            0 => snare.pos;
        }
        // if 1 in array then play click
        if( Array1[i] == 1 )
        {
            0 => cowbell.pos;
        }
        // if 1 in array then play hihat
        if( Array2[i] == 1 )
        {
            0 => hihat.pos;
        }
        
        
        beattime::second => now;
        
    }
}


// Main Program
now + 30::second => time due; // play until 30 seconds

Math.srandom(2); // set seed, which will play the same random series 

while(now < due)
{
    
    // initialize pan position value
    -1.0 => float panPosition;
    
    while( panPosition < 1.0 )
    {
        Math.random2(0,1) => int i; // generate random integer i between 0 amd 1
        if ( i == 1) // if random number is equal 1
        {
            
            for( 0 => int i; i < B.cap(); i++) // set loop for array B
            {
                panPosition => p.pan; // pan value 
                <<< panPosition >>>;
                <<< i, B[i] >>>; //print index and value
                2*Std.mtof(B[i]) => man.freq; // MIDI to frequency
                0.25 => man.pluckPos; // assign position before plucking
                1.0 => man.noteOn; // pluck strings
                0.4 => man.stringDetune;// instruct to be out of tune
                0.2 => man.bodySize;
                Math.random2f(0.2,0.9) => man.gain; // set volume for s
                
                Math.random2f(0.5,0.9) => q.gain;
                Std.mtof(B[i]) => q.freq; // MIDI to frequency
                
                0.75::second => now; //advance time
                
                section(ptrn_3, ptrn_4, .2); 
                
                panPosition + .25 => panPosition; // approaching to 1.0 by 0.25
            }
        }
        else
        { 
            for( 0 => int i; i < A.cap(); i++) // set loop for array A
            {
                <<< i, A[i] >>>; //print index and value
                Math.random2(0,8) => mod.preset;
                Math.random2f(200.0,1000.0) => mod.freq;
                1.0 => mod.noteOn;
                0.4::second => now;
                
                0.1 => man.pluckPos; // assign position before plucking
                1.0 => man.noteOn; // pluck strings
                0.2 => man.stringDetune;// instruct to be out of tune
                0.5 => man.bodySize;
                Std.mtof(A[i]+12) => man.freq; // MIDI to frequency
                Math.random2f(0.3,0.6) => man.gain; // set volume for s
                
                section(ptrn_1, ptrn_2, .15);
                
                Std.mtof(A[i]) => q.freq; // MIDI to frequency
                0.6 => q.gain;
                
                0.75::second => now; //advance time
                panPosition + .25 => panPosition; // approaching to 1.0 by 0.25
                
            }
        }
    }
}
