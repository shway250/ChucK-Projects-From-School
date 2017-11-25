//sound Chain
SinOsc s => dac;

//global variable
[60,62,63,65,63,64,65,58,57] @=> int A[];

//Function
fun void swell( float begin, float end, float grain )
{
    //this function is going to be a volume sweller
    //swell up
    for( begin => float j; j <end; j+grain => j )
    {
        j => s.gain;//set volume
        .01::second => now; //advance time
    }
    //swell down
    for( end => float j; j > begin; j-grain => j)
    {
        j => s.gain; //set volume
        .01::second => now;
    }
}


//Main Program
//Loop
for( 0 => int i; i < A.cap(); i++ )
{
    Std.mtof(A[i]) => s.freq; //sets frequency for s
    swell(.4,.9,.03); //calls funtion to control volume
    .01::second => now;
}