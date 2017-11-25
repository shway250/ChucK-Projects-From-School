<<< "Assignment_3_the_techno_cathedral" >>>;
// Setup the array of instruments
Gain g => dac;
SndBuf inst1 => g;
SndBuf inst2 => g;
SndBuf inst3 => g;
SndBuf inst4 => g;
SndBuf inst5 => g;
// Reversed instrument
SndBuf revrs => g;
1 => g.gain;
[inst1,inst2,inst3,inst4, inst4 /*same instrument but different pattern! (look below)*/, inst5] @=> SndBuf inst[];
me.dir() => string path;
path + "/audio/snare_01.wav" => revrs.read;
[path + "/audio/kick_01.wav", path + "/audio/kick_05.wav", path + "/audio/kick_02.wav", path + "/audio/clap_01.wav", path + "/audio/clap_01.wav", path + "/audio/hihat_03.wav"] @=> string paths[];

for (0 => int i; i < paths.cap(); i++) 
{
    paths[i] => inst[i].read;
}


// Setup the start time array
// 8 beats * .25::seconds/beat = 2 seconds
8 => int unit; 
// Array of the times when each instrument starts playing
// inst1 and inst2 starts at 0. 
// inst3 starts at 2*unit = 2*2::seconds = at time 4
// inst4 starts at 6*unit = 6*2::seconds = at time 12 ..
[0,0,2*unit,4*unit,6*unit,8*unit] @=> int initTimes[];


// Array of patterns.
// This indicates the gain for each instrument at each beat.
// i.e, instrument 1 has a [1,0] pattern, which means
// that it will play every 2 beats with gain 1, starting at beat 0 (relative
// to its start time, which in this case is 0)
//
// inst2 has the opposite pattern, si it will play every 2 beats
// but this time starting at beat 1 (also relative to its start time)
//
// inst4 will play for 3 beats and then it'll stop.
//
// To mute an instrument the mechanism is the same :
// an initial time and a pattern are efined but this time the pattern will be [0]
// which means "play with gain 0" at any beat..
// (I know it's rather confusing and this may not be the best way to do this, but it's what i've come along :P)
[[1,0],[0,1],[0,1],[1,1,1,0],[0],[1,0]] @=> int patterns[][];


// Start muted.
for(0 => int i; i < inst.cap(); i++) 
{
    inst[i].samples() => inst[i].pos;
}
revrs.samples() => revrs.pos; 
// For the final fade out

// How many times we'll reduce the gain ? 6 last seconds / main pulse
6/.25 => float timeSplit;
// How much we'll reduce gain each time ? 1(original gain)/timeSplit
1/timeSplit => float gainStep;
1 => float gain;


//========================== MAIN LOOP =====================================
// The counter to do the modulos
0 => int counter;
30::second + now => time end;
while(now < end)
{        
    // configure each instrument
    for (0 => int i; i < inst.cap(); i++)
    {
        // Has the time arrived for the instrument to start playing ?
        if (counter >= initTimes[i])
        {
            // Get the pattern assigned to this instrument
            patterns[i] @=> int pattern[];
            // Find the position in the pattern array corresponding to the beat in which we are
            // i.e, if the pattern has 2 positions as is for inst1, if the counter is even we'll be in position 0
            // and if even, in position 1. The same applies for any pattern, regardless of its capacity.
            // It's like splitting the time in sections of pattern.capacity() and find in which position we are..
            counter % pattern.cap() => int patternPos;
            // get the gain established in the pattern.
            pattern[patternPos] => int instGain;
            // If, at this bea, the instrument plays (it has a gain > 0) we must reset SndBuf
            if(instGain > 0)
            {                                                              
                
                if (end - now < 6::second)
                {
                    // At first i intended to use the same instruments that i used 
                    // until now but reversed for the final part, but somehow they didn't sound 
                    // ( i suspect that the queue of the files are non audible and
                    /// 250::ms was not enough time to reach audible notes) so i added a different sample.
                    -1.0 => revrs.rate;   
                    revrs.samples() => revrs.pos; 
                    1 => revrs.gain; 
                    // Also, the rest of the instruments stop playing since pos is not restarted..                                                       
                } 
                else 
                {
                    0 => inst[i].pos;
                }   
                
            } 
            // Finally assign the gain to the instrument.
            instGain => inst[i].gain;
        }
    }
    counter++;        
    // Fade out starting at last 6 seconds
    if(end - now < 6::second) 
    {
        gainStep -=> gain;        
        gain => g.gain;
    }
    
    // .25::second is the compositional pulse
    250::ms => now;
    
}


