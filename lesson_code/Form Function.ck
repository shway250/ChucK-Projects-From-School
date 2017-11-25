//global variable
0 => int x;


//functions
fun void funOne() 
{
    x+1 => x;// add one to x
    1::second => now;
    <<< x >>>;
}

fun void funTwo()
{
    x-1 => x; //sub one from x
    1::second => now;
    <<<x>>>;
}

//MAIN PROGRAM
//Infinite Loop
while(true)
{
    funOne();//execute funOne
    funTwo();//Wait until funOne is done then execute funTwo
}