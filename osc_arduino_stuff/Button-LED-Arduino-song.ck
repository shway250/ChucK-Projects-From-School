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

///Composition
//SOUND CHAIN
Pan2 master => dac;
SqrOsc sqr_osc_1 => Pan2 sqrP => master;
SinOsc sine_osc_1 => Pan2 sinP => master;
SinOsc sine_osc_2 =>Pan2 sinP2 => master;


//Initial parameters
0.7=>master.gain;

//////////FUNCTIONS////////////////////
// Upward sweep functions for Dom7 chord
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
//7th function
fun float sev( float originalFreq )
{
    //calculate seventh of input frequency
    return(originalFreq*1.75);
}
///Composition!!!!!
fun void comp()
{
    while( true )
    {
        if (data[0] == 1)
        {
            for( 20 => float i; i <500; i + .5 => i)
            {
                if( i < 500)
                {
                    third(i)*(data[1]*0.1) => sqr_osc_1.freq;
                    fifth(i)*(data[2]*0.05) => sine_osc_1.freq;
                    sev(i)*(data[1]*0.2) => sine_osc_2.freq;
                    0.3=>sqr_osc_1.gain;
                    0.3=>sine_osc_1.gain;
                    0.3=>sine_osc_2.gain;
                    Math.random2f(-1.0,1.0)=> sqrP.pan;
                    Math.sin(now/1::second*3*pi) => sinP.pan;
                    Math.sin(now/1::second*2*pi) => sinP2.pan;
                    <<< i >>>;
                    5::ms => now;
                }
            }
            
        }
        else
        {
            for( 20 => float i; i <500; i + .5 => i)
            {
                if( i < 500)
                {
                    third(i) => sqr_osc_1.freq;
                    fifth(i) => sine_osc_1.freq;
                    sev(i) => sine_osc_2.freq;
                    0.3=>sqr_osc_1.gain;
                    0.3=>sine_osc_1.gain;
                    0.3=>sine_osc_2.gain;
                    Math.random2f(-1.0,1.0)=> sqrP.pan;
                    Math.sin(now/1::second*2*pi) => sinP.pan;
                    Math.sin(now/1::second*2*pi) => sinP2.pan;
                    <<< i >>>;
                    1::ms => now;
                }
            }
        }
    }
}

spork ~ comp();
//make a parent function
now + 30::second => time later;
while( now < later  )
{
    1::ms => now;
}

me.exit();




