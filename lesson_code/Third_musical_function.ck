//soundchain
SinOsc s => dac;

//global variables
[60,62,63,65,63,64,65,58,57] @=> int A[];


//function swell
//void makes funtion not return anything
fun void swell( float begin, float end, float grain )
{
    //this function is going to be a volume swell
    
    //swell up
    for( begin => float j; j < end; j+grain => j )
    {
        j => s.gain;//set volume
        .01::second => now;//advance time   
    }   
    //swell down
    for ( end => float j; j > begin; j-grain => j)
    {
        j => s.gain;//set volume
        .01::second => now;//advance time
        
    }
}

// MAIN PROGRAM!!!!!
//Loop
for( 0 => int i; i < A.cap(); i++ )
{
    Std.mtof(A[i]) => s.freq; // sets freq using array A
    swell(.2,1.0,.01); //calls function to control volume
    .1::second => now;   //advance time
    
    
}