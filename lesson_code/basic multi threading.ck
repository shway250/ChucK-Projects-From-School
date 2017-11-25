ModalBar one => dac.left;
ModalBar two => dac.right;

//set inital parameters
7 => one.preset;
4 => two.preset;
.9 => one.strikePosition => two.strikePosition;
60 => Std.mtof =>one.freq;
64 => Std.mtof =>two.freq;



fun void foo()
{
    while( true )
    {
        <<<"foo!", "">>>;
        //note
        1 => one.strike;
        250::ms => now;
    }
}
fun void bar()
{
    while( true ) 
    {
        <<<"BARRR!", "">>>;
        //note1
        1 => two.strike;
        1::second =>now;
    }
}

//spork function foo on a new shred
spork ~ foo();
spork ~ bar();

//parent shred to keep sporked shred alive
while( true ) 1:: second => now;