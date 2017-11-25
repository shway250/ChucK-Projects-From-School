// Assignment_3_Space_Industrial

SndBuf mySound1 => dac;

// create path name as a string
me.dir () + "/audio/cowbell_01.wav" => string filename;
// open soundfile
filename => mySound1.read;
// find number of samples
mySound1.samples() => int numSamples;

// loop
now + 2::second => time later1;

while ( now < later1 )
{
    numSamples => mySound1.pos; // set playhead position
    -2.0 => mySound1.rate; // set rate - negative for Reverse
    .25::second => now; // advance time
}

SinOsc s => dac.left;
SqrOsc t => dac.right;

// initialize variable i
500 => int i;

while ( i < 700)
{
    i => s.freq;
    1 => s.gain;
    <<< i >>>;
    .01::second => now;
    i++;
}

500 => int j; 

while ( j < 600)
{
    j => t.freq;
    1 => t.gain;
    <<< i >>>;
    .001::second => now;
    j++;
}

// initializing another sample file
SndBuf mySound2 => Pan2 p1 => dac;

// define the filename
me.dir () + "/audio/clap_01.wav" => string filename1;

// open up soundfile
filename1 => mySound2.read;

//  loop of random numbers
now + 4::second => time later2;

while ( now < later2 )
{
    Math.random2f(.3,.7) => mySound2.gain; // set volume
    Math.random2f(.7,2.1) => mySound2.rate; // set rate
    Math.random2f(-1.0, 1.0) => p1.pan; // set panning
    0 => mySound2.pos; // set playhead position
    .25::second => now; // advance time
}

// drums
Gain master => dac;
SndBuf kick => master;
SndBuf hihat => master;
SndBuf snare => master;

// load soundfiles into sndbufs
me.dir() + "/audio/kick_04.wav" => kick.read;
me.dir() + "/audio/hihat_03.wav" => hihat.read;
me.dir() + "/audio/snare_02.wav" => snare.read;

// initialize counter variable
0 => int counter;

// loop
now + 8::second => time later4;

while ( now < later4 )
{
    // beat goes from 0 to 7 (8 positions)
    counter % 8 => int beat;
    
    // bass drum on 0 and 4
    if ( (beat == 0) || (beat == 4))
    {
        0 => kick.pos;
    }
    // snare drum on 2 and 6
    if ( (beat == 2) || (beat == 6) )
    {
        0 => snare.pos;
        Math.random2f(0.8, 1.8) => snare.rate;
    }
    // hihat
    0 => hihat.pos;
    0.8 => hihat.gain;
    Math.random2f(.6,1.6) => hihat.rate;
    
    counter++; // counter + 1 => counter
    0.25::second => now;
}

// D Dorian scale array declaration 
[50, 53, 52, 53, 55, 59, 57, 59, 60, 59, 62, 59, 57, 59, 60, 59] @=> int A[];
// loop

for ( 0 => int f; f < A.cap (); f++)
{
    
    Std.mtof(A[f]) => s.freq; // MIDI to frequency
    3 => s.gain;
    .25::second => now; // advance time
}

// drums
SndBuf drum => dac;
// array of strings (paths)
string drum_samples[8];
// load array with file paths
me.dir() + "/audio/click_01.wav" => drum_samples[0];
me.dir() + "/audio/kick_02.wav" => drum_samples[1];
me.dir() + "/audio/snare_03.wav" => drum_samples[2];
me.dir() + "/audio/clap_01.wav" => drum_samples[3];
me.dir() + "/audio/kick_03.wav" => drum_samples[4];
me.dir() + "/audio/click_05.wav" => drum_samples[5];
me.dir() + "/audio/snare_01.wav" => drum_samples[6];
me.dir() + "/audio/click_03.wav" => drum_samples[7];

// melody
SndBuf2 mySound3 => dac;

// read the file into string
me.dir() + "/audio/stereo_fx_04.wav" => string filename3;
// open up soundfile
filename3 => mySound3.read;

now + 8::second => time later3;

while ( now < later3 )
{
    // rhythm
    Math.random2(0, drum_samples.cap () - 1) => int which; // 0, 1, or 2
    drum_samples[which] => drum.read;
    .25::second => now; // advance time
    // melody
    Math.random2f(1.9, 3.0) => mySound3.gain; // set volume
    Math.random2f(.8, 2.8) => mySound3.rate;
    0 => mySound3.pos; // sets playhead position
    0.25::second => now; //advance time
}

SinOsc a => dac;
800 => a.freq;
1 => a.gain;
1::second => now;
