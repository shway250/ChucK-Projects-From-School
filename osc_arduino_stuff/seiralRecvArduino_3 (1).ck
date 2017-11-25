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


while (true)
{
    <<< data[0], data[1], data[2] >>>;
    .5::second => now;
}
