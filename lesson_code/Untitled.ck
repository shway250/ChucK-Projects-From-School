<<<  "Assignement week 2 : let's go for array!" >>>;

// Set the beginning
now => time lenght;

//Sound chain

SinOsc s => Pan2 p => dac ;

0.8 => s.gain;

// array declaration

[ 53, 52, 53, 50, 52, 60, 62, 50 ] @=> int A[];
[ .125, .25, .5, .125, .125, .25, .5, .125 ] @=> float notes [];


// play melody with quarter notes 0.25
//loop 8 times with a change for 5 and 6
for (0 => int repet; repet < 4; repet ++)
{
    if (repet < 2 || repet > 2)
    {
        for (0 => int i; i<A.cap(); i++)
        {
            Std.mtof (A[i]) => s.freq;
            .25::second => now; 
        }
    }
    
    else
        // use the duration assigned for each note in array
        {
            for (0 => int i; i<A.cap(); i++)
            {
                Std.mtof (A[i]) => s.freq;
                notes [i]::second => now; 
            }
        }
    }
    
    //change 3 notes of array
    
    57 => A [0];
    55 => A [1];
    57 => A [6];
    
    for (0 => int i; i<A.cap(); i++)
    {
        Std.mtof (A[i]) => s.freq;
        .25::second => now;
    }
    for (0 => int i; i<A.cap(); i++)
    {
        Std.mtof (A[i]) => s.freq;
        .25::second => now;
    }
    
    
    //play melody with panning and various height, duration, gain
    
    
    now + 10::second => time later2;
    while (now < later2)
    {
        Math.random2f(0.8, 2) => float octave;
        Math.random2f(0.05, 1) => float volume;
        Math.random2f(0.005, 0.25) => float duration;
        
        
        for (0 => int i; i<A.cap(); i++)
        {
            Std.mtof (A[i]*octave) => s.freq;
            volume => s.gain;
            Math.random2f(-1 , 1) => p.pan;
            duration::second => now;
        }
    }
    
    
    // randomization
    //added sinwave
    TriOsc t => pan2 p2 => dac;
    .4 => t.gain;
    .4 => s.gain;
    
    // randomization
    
    for (0 => int i; i< 40 ; i ++)
    {
        
        Math.random2 (100 ,1000) => int rand;
        Math.random2f(-1 , 1) => p.pan;
        Math.random2f(-1 , 1) => p2.pan;
        rand => t.freq;
        rand => s.freq;
        0.1::second => now;
        
    }
    
    // randomization on scale[50 > 62 ]with panning and fading volume
    
    
    for (1 => float vol; vol > .05; vol - 0.1 => vol)
    {
        vol => s.gain;
        vol => t.gain;
        
        for (0 => int i; i< 20 ; i ++)
        {
            Math.random2 (50,62) => int rand;
            Std.mtof (rand) => t.freq;
            0.05::second => now;
            1 => p2.pan;
            Std.mtof (rand*2) => s.freq;
            0.05::second => now;
            -1 => p.pan;
        }
        vol -.1 => vol;
    }
    
    
    //Print the length of the song                    
    <<< "Length of the song :", (now - lenght)/second >>>;
    
    //Print The End
    <<< " The End ! " >>>;   
