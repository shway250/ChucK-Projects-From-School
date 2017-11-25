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

//////////////////////// COMPOSITION /////////////////////////////////
//Master Gain
Pan2 master => dac;
0.7 => master.gain;


SawOsc saw => LPF sawFilt => Pan2 sawP => master;
SawOsc saw2 => LPF sawFilt2 => Pan2 sawP2 => master;
SawOsc saw3 => LPF sawFilt3 => Pan2 sawP3 => master;
SawOsc saw4 => LPF sawFilt4 => Pan2 sawP4 => master;

//settinf LPF for SawOsc
sawFilt.set (600,0.2);
sawFilt2.set (600,0.2);
sawFilt3.set (600,0.2);
sawFilt4.set (600,0.2);






/////Functions
//////////FUNCTIONS////////////////////
// Another upward sweep function
fun float third( float originalFreq )
{
    //calculate third of input frequency
    return(originalFreq*1.25);
}

//fifth function
fun float fifth( float originalFreq )
{
    //calculate fifth of input frequency
    return(originalFreq*1.5);
}

///Main Program
//have the pot control frequencies and LED status control panning
fun void pot()
{
    while( true )
    {
        //sawOsc frequency and gain
        data[0]=>saw.freq;
        data[0]*1.5=>saw2.freq;
        0.5 => saw.gain;
        0.5 => saw2.gain;
        //if/else for saw OSC panning
        if( data[2]<127 )
        {
            Math.random2f(-0.7,0.0)=>sawP.pan;
            Math.random2f(0.0,0.7)=>sawP2.pan;
        }
        else
        {
            Math.random2f(0.0,0.7)=>sawP.pan;
            Math.random2f(-0.7,0.0)=>sawP2.pan;
        }
        //print out arduino integers
        <<< data[0], data[1], data[2] >>>;
        //move time
        .2::second => now;
    }
}

fun void sweep()
{
    while( true )
    {
        if (data[1] == 1)
        {
            for( 20 => float i; i <500; i + .5 => i)
            {
                if( i < 500)
                {
                    third(i)*(data[0]) => saw3.freq;
                    fifth(i)*(data[2]) => saw4.freq;
                    0.3=>saw3.gain;
                    0.3=>saw4.gain;
                    Math.random2f(-1.0,1.0)=> sawP3.pan;
                    Math.random2f(-1.0,1.0)=> sawP4.pan;
                    <<< i >>>;
                    5::ms => now;
                }
                
            }
            
        }
        else
        {
            0.0 =>saw3.gain;
            0.0=>saw4.gain;
            5::ms=>now;
        }

    }
}

spork~ pot();
spork~ sweep();


//make a parent function
now + 30::second => time later;
while( now < later  )
{
    1::ms => now;
}

me.exit();




