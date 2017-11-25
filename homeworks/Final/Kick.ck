//Assignment 8 "Final"
// kick.ck
//layering kicks for a big ol' BOOM!
//sound chain
SndBuf kick => dac;
SndBuf kick2 => dac;
me.dir(-2)+"/audio/kick_01.wav" => kick.read;
me.dir(-2)+"/audio/kick_02.wav" => kick2.read;


// make a conductor for our tempo 
// this is set and updated elsewhere
BPM tempo;

while (1)  {
    // update our basic beat each measure
    tempo.quarterNote => dur quarter;
    
    // play a measure of quarter note kicks
    for (0 => int beat; beat < 4; beat++)  {
        0 => kick.pos;
        0 => kick2.pos;
        quarter => now;
    }
}    
