//sound chain
ModalBar modal => NRev reverb => dac.left;
ModalBar modal2 => NRev reverb2 => dac.right;

//reverb mix
.1=> reverb.mix;
//modal bar parameters
7 => modal.preset;
.9 => modal.strikePosition;

//reverb mix
.1=> reverb2.mix;
//modal bar parameters
5 => modal2.preset;
.9 => modal2.strikePosition;

//call function
spork ~ tune();
spork ~ one();
spork ~ two();
while( true ) 1::second => now;
//////Main program
//loop
fun void one()
{
    while (true)
    {
        //note
        1 => modal.strike;
        300::ms => now;
        //note 2
        .7 => modal.strike;
        300::ms => now;
        
        repeat( 6 )
        {
            //note 2
            .5 => modal.strike;
            100::ms => now;
            
        }
        
    }
}

fun void two()
{
    while (true)
    {
        //offset
        150::ms => now;
        //note
        1 => modal2.strike;
        //wait
        300::ms => now;
        //note
        .7 => modal2.strike;
        //wait
        300::ms => now;//note
        .5 => modal2.strike;
        //wait
        300::ms => now;//note
        .3 => modal2.strike;
        //wait
        300::ms => now;
    }
}

fun void tune()
{
    while( true )
    {
        //update frequency
        84 + Math.sin( now/second*Math.PI*.25 )*2 => Std.mtof =>modal.freq;
        //advance time (update rate)
        5::ms => now;
        
    }
    
}
