//sound network
SinOsc s => dac;

//Set frequency and volume
222.45 => s.freq;
0.2 => s.gain;

//chance variable. If I change chance to any number but one 
//the else function goes
0 => int chance;

if( chance == 1 )
{
    //sound will only play if chance is equal to 1
    1::second => now;
}
else
{
    //set new frequency
    440.32 => s.freq;
    //play for 3 seconds
    3::second => now;
}
////////////////////////////
//nested if
if( condition )
{
 //code in here
 if( other condition)
 {
     //more code here
 }   
}


//multiple conditional statements
if( (chance == 1) || (chance == 5) )
{
    //code goes here for "or" statement
}

if( (chance == 1) && (chance == 5) )
{
    //code goes here for "and" statement
}


////////////for loops/////////////////
///will print out "i" and count up in seconds
for( 0 => int i; i < 4; i++ )
{
 <<< i >>>;
 1::second => now;   
}


///Making a sine sweep
//sine bank
SinOsc s => dac;
for( 20 => int i; i < 400; i++ )
{
    <<< i >>>;
    i => s.freq;
    0.1::second => now;   
}


///WHILE LOOPS
while( i < 400 )
{
    //set freq
    i => s.freq;
    //print i
    <<< i >>>;
    //advance time
    0.01::second => now;
    //updated in loop
    i++;
}







