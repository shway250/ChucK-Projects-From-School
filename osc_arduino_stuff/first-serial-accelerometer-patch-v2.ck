SerialIO serial;
string line;
string stringInts[3];
int data[3];

SerialIO.list() @=> string list[];
for( int i; i < list.cap(); i++ )
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}
serial.open(2, SerialIO.B9600, SerialIO.ASCII);

fun void serialPoller(){
    while( true )
    {
        // Grab Serial data
        //This is where serialPrint is picked up by chuck
        serial.onLine()=>now;
        serial.getLine()=>line;
        
        if( line$Object == null ) continue;
        
        0 => stringInts.size;
        
        // Line Parser
        //the "0-9" thing is what tells chuck the number of values it's going to receive
        if (RegEx.match("\\[([0-9]+),([0-9]+),([0-9]+)\\]", line , stringInts))
        {
            for( 1=>int i; i<stringInts.cap(); i++)  
            {
                // Convert string to Integer
                Std.atoi(stringInts[i])=>data[i-1];
            }
        }
    }
}

spork ~ serialPoller();

// COMPOSITION
//sound chain
SinOsc s1 => ADSR env1 => Pan2 master;
SinOsc s2 => env1 => master;
SinOsc s3 => env1 => master;
///ADSR parameters
env1.set(45::ms,10::ms, 0.4,40::ms);

//set overal gain
0.6 => master.gain;
//chuck master to dac
master => dac;

//make a function that prints data and controlls frequency with data
fun void accel()
{
    while(true)
    {
        
        //have data control frequecies
        data[0] => s1.freq;
        data[1] => s2.freq;
        data[2] => s3.freq;
        //key on envelope
        1 => env1.keyOn;
        //print data
        <<< data[0], data[1], data[2] >>>;
        //move time
        .1::second => now;
        
    }
    
}

//spork the function
spork ~ accel();

//make a parent function
now + 30::second => time later;
while( now < later  )
{
    1::ms => now;
}

me.exit();
