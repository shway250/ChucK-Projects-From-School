//sound chain
SndBuf click => dac;

//read sound file
me.dir() + "/audio/stereo_fx_01.wav" => click.read;

//set playhead to end of file so no initial sound
click.samples() => click.pos;


//Granular Function
fun void granularize (int steps )
{
    //samples/steps =>grain size
    click.samples()/steps => int grain;
    // randomnly set grain position
   Math.random2(0, click.samples()-grain) => click.pos;
   //advance time
   grain::samp => now;
    
    
}

///MAIN PROGRAM!!!
//infinite loop
while( true )
{
 granularize(70);   
    
    
}



10::second => now;