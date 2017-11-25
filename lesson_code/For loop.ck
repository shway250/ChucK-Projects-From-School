//for loop

//the loop
//*for( 0=> int i; i<4; i++ )
//{
//    <<< i >>>; //print value of i
  //  1::second => now; //moves through time
//}
//Sound Chain
SinOsc s => dac;

//for loop
for( 20 => int i; i<400; i++ )
{
    <<< i >>>; //print value of i
    i => s.freq;
    .01::second => now;
}