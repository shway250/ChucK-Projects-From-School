//sound chain
ModalBar modal => NRev reverb => dac.left;
ModalBar modal2 => NRev reverb2 => dac.right;

//reverb mix
.1 => reverb.mix;
//modal  bar params
7 => modal.preset;
.9 => modal.strikePosition;

//reverb mix
.1 => reverb2.mix;
//modal  bar params
7 => modal2.preset;
.9 => modal2.strikePosition;

spork ~ one();
spork ~ two();
spork ~ tune();

while( true ) 1::second => now;

fun void one()
{
    while( true )
    { 
        // offset
        150::ms => now;
        
        //note!
        1 => modal.strike;
        //wait
        300::ms =>now;
        //note
        .7 => modal.strike;
        //wait
        300::ms => now;
        
        repeat( 6 )
        {
            //note
            .5 => modal.strike;
            //wait
            100::ms => now;
        }        
    }
}

fun void two()
{
    while( true )
    {
        //note
        1 => modal2.strike;
        //wait
        300::ms => now;
        //note
        .75 => modal2.strike;
        //wait
        300::ms => now;
        //note
        .5 => modal2.strike;
        //wait
        300::ms => now;
        //note
        .25 => modal2.strike;
        //wait
        300::ms => now;
    }
}

fun void tune()
{
    while( true )
    {
        //update freq
        84 + Math.sin( now/second*Math.PI*.25 ) *2 
        => Std.mtof => modal.freq;
        // advance time (updat rate)
        5::ms => now;
    }
}  