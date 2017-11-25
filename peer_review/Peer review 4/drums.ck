//sound chain
SndBuf snare => dac;
SndBuf stereo1 => Pan2 p => dac;
SndBuf hihat => dac;

// load array with file paths
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
me.dir(-1) + "/audio/hihat_03.wav" => hihat.read;
me.dir(-1) + "/audio/stereo_fx_02.wav" => stereo1.read;

// set samples to end position so no sound at begining
snare.samples() => snare.pos;
hihat.samples() => hihat.pos;
stereo1.samples() => stereo1.pos;


0 => int d; // set d as 0
0.6 => stereo1.gain; // set voulume of stereo1 as 0.6


while( true )
{
0 => int counter;  // set counter as 0

//loop the hihat and snare sequence 4 times
while( counter < 32 )
{
    counter % 8 => int beat; // calculate remainder of counter when divided by 8
    
    if( ( beat == 0 ) || ( beat == 1 ) || ( beat == 4) || ( beat == 6) )
    {
        0 => hihat.pos; // set hihat pos to 0
        
    }
    
    if( ( beat == 2 ) || ( beat == 3) || ( beat == 5) || ( beat == 7 ) )
    {
        0 => snare.pos; // set snare pos to 0
        Math.random2f(0.5, 1.5) => snare.rate; // random the snare rate
       
    }
    counter++; // increment counter
    0.3125::second => now; // advance in time   
}
}





 