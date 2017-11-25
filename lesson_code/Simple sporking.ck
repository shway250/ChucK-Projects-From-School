ModalBar one => dac.left;
ModalBar two => dac. right;

//initial parameters
7 => one.preset;
4 => two.preset;
.9 => one.strikePosition => two.strikePosition;
60 => Std.mtof => one.freq;
64 => Std.mtof => two.freq;




fun void butts()
{
    while (true)
    {
        <<< "LOTS AND LOTS OF BUTTS" >>>;
        //note
        1 => one.strike;
        250::ms => now;
        
    }
}
fun void farts()
{
    while (true)
    {
        <<< "farts" >>>;
        //note
        1 => two.strike;
        1::second => now;
        
    }
}
/// spork the function butts() in the same thread
spork ~ butts();
spork ~ farts();

//infinite time loop
//(to keep parent shred alive, in order for children to live)
while( true ) 1::second => now;
