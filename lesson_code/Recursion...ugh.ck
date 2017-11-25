//Recursion
fun int factorial( int x )
{
    if ( x <= 1 )
    {
        //when reach here, function has a way to end
        return 1;
    }
    else
    {
        //recursive function calls itself
        return(x*factorial(x-1));
    }
    
}


//MAIN PROGRAM!!!
//Call Function
<<< factorial(4) >>>;