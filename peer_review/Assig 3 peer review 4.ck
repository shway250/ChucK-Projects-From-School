//Assignment 3
<<<"Assignment 3 - rev 3 patterns then random" >>>;

//Setup sound chain
SndBuf mysound1 => Pan2 pan1 => dac;
SawOsc saw1 => Pan2 panSaw  => dac;
SqrOsc sqr1 => Pan2 panSqr  => dac;

// turn all oscillators down

0 => saw1.gain;
0 => sqr1.gain;

//Setup String Paths for use in string Array
me.dir() => string path;
"/audio/hihat_02.wav" => string f1;
path + f1 => f1;
"/audio/kick_04.wav" => string f2;
path + f2 => f2;
"/audio/snare_01.wav" => string f3;
path + f3 => f3;
f3 => mysound1.read;

//setup whle loop int count to count 5 backwards snare beats, panning from left to center during loop
<<< "Reverse the Snare and Panning - Intro" >>>; 

0  =>  int count;
-1 => float panner;
while ( count < 5 )
{
    panner => pan1.pan;
    11056 => mysound1.pos;
    -1 => mysound1.rate;
    .25::second => now;
    panner + 0.20 =>   panner; 
    count++;
}
//Section 1
<<<"Section 1 - Drum Pattern 1">>>;
//Set up bass line Array into integer bs
[57, 50, 50, 50, 50, 57, 57, 50] @=> int bs[];
//Set up Bass note Durations for stacato 1/4 notes or longer 1/4 notes
[.25, .25, .125, .125, .25, .125, .125, .125 ] @=> float basdur[];
//Set up array for playing samples f1, f2, f3
//this is my String Array also is Drum Pattern #1
[ f2, f1, f3, f1, f2, f1, f3, f1 ] @=> string files1[];

//Set up for loop for 32 beats of sequencer at .25 second 1/4 notes
for ( 0 => int i1; i1 < 32 ; i1++ )
    // play Sample from files1 string
    {
        i1 % 8 => int i2;
        files1[i2] => mysound1.read;
        0 => mysound1.pos;
        1.0 => mysound1.rate;
        
        // 2 if statements for different bass note durations
        if (basdur[i2] == .125)
        { 
            .15 =>sqr1.gain;
            Std.mtof(bs[i2])/2 => sqr1.freq;
            .125::second => now;
            0 => sqr1.gain;
            .125::second => now;
        }
        
        if (basdur[i2] == .25)
        {
            .15 =>sqr1.gain;
            Std.mtof(bs[i2])/2 => sqr1.freq;
            .25::second => now;
            0 => sqr1.gain;
        }
    }
    
    //Section 2
    <<<"Section 2 - Drum Pattern 2">>>;
    //Set up array for playing samples f1, f2, f3 - new drum pattern
    [ f2, f2, f3, f1, f1, f2, f3, f3 ] @=> string files2[];
    
    //Set up for loop for 32 beats of sequencer at .25 second 1/4 notes
    for ( 0 => int i1; i1 < 32 ; i1++ )
        // play Sample from files1 string
        {
            i1 % 8 => int i2;
            files2[i2] => mysound1.read;
            0 => mysound1.pos;
            1.0 => mysound1.rate;
            // 2 if statements for different bass note durations
            // this if statement repeats the drum sample so it plays twice
            if (basdur[i2] == .125)
            { 
                .15 =>sqr1.gain;
                Std.mtof(bs[i2])/2 => sqr1.freq;
                .125::second => now;
                0 => sqr1.gain;
                0 => mysound1.pos;
                1.0 => mysound1.rate;
                .125::second => now;
            }
            if (basdur[i2] == .25)
            {
                .15 =>sqr1.gain;
                Std.mtof(bs[i2])/2 => sqr1.freq;
                .25::second => now;
                0 => sqr1.gain;
            }
        }
        
        //Section 3
        <<<"Section 3 - Drum Pattern 3">>>;
        //Set up array for playing samples f1, f2, f3 - new drum pattern
        [ f2, f3, f3, f1, f2, f2, f1, f3 ] @=> string files3[];
        //Please note that I did use all of the Dorian notes within the two arrays
        //Set up of Array into integer n
        [50, 59, 53, 52, 55, 59, 60, 62] @=> int n[];
        //Set up for loop for 48 beats of sequencer at .25 second 1/4 notes
        for ( 0 => int i1; i1 < 48 ; i1++ )
            // play Sample from files1 string
            {
                i1 % 8 => int i2;
                files3[i2] => mysound1.read;
                0 => mysound1.pos;
                1.0 => mysound1.rate;
                //start top melody at beat 16 playing saw 1
                if (i1 > 16)
                {
                    Std.mtof(n[i2]) => saw1.freq;
                    .2 => saw1.gain;
                }    
                // 2 if statements for different bass note durations
                // this if statement repeats the drum sample so it plays twice
                if (basdur[i2] == .125)
                { 
                    .15 =>sqr1.gain;
                    Std.mtof(bs[i2]) => sqr1.freq;
                    .125::second => now;
                    0 => sqr1.gain;
                    0 => saw1.gain;
                    0 => mysound1.pos;
                    1.0 => mysound1.rate;
                    .125::second => now;
                }
                //this if statement makes a muted note this time
                if (basdur[i2] == .25)
                {
                    .25::second => now;
                    0 => saw1.gain;
                    0 => sqr1.gain;
                }
                
            }
            //random samples playing outro - at 16th notes - panning randomly, rate randomly
            <<<"Outro of Random, Rate, Pan, and Sample File at 16th notes">>>;
            for ( 0 => int i1; i1 < 16 ; i1++)
            {
                Math.random2(0,7) => int rndfile;
                Math.random2f(-1.0,1.0) => float rndPan;
                Math.random2f(.8,2.3) => float rndrate;
                
                files3[rndfile] => mysound1.read;
                0 => mysound1.pos;
                rndPan => pan1.pan;
                rndrate => mysound1.rate;
                .0625::second => now;
                
            }
            
