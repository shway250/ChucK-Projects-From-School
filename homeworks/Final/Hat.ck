//Assignment 8 "Final"
// hat.ck
//soundchain
SndBuf hat => dac;
me.dir(-2)+"/audio/hihat_02.wav" => hat.read;

// make a conductor for our tempo 
// this is set and updated elsewhere
BPM tempo;

while (1)  {
    // update our basic beat each measure
    tempo.eighthNote => dur eighth;
    
    // play a measure of eighth notes
    for (0 => int beat; beat < 8; beat++)  {
        // play mostly, but leave out last eighth
        if (Math.random2(0,7) < 5)
        {
            0 => hat.pos;
        }
        eighth => now;
    }
}    

