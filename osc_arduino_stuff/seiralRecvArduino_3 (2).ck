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
//Sound Chain
SawOsc s => ADSR sEnv=> LPF lpf => Pan2 ps => Pan2 master;
SqrOsc sq => ADSR sqEnv => LPF lpfsq => master;
//setting master gain
0.7 =>master.gain;
master =>dac;
//setting Env and LPF for SawOsc
sEnv.set(0.3::second, 0.1::second,0.1,0.1::second);
600.0 =>lpf.freq;
5.0 => lpf.Q;
//setting Env and LPF for SqrOsc
sqEnv.set(0.05::second, 0.1::second,0.1,0.1::second);
600.0 =>lpfsq.freq;
5.0 => lpfsq.Q;

//melody arrays
[60,63,61,60,65,66,63,70,67,60,72,67,71,69,60,61] @=> int melody[];

//bass function
fun void bass()
{
    while(true)
    {
        Std.mtof(58) => sq.freq;
        Math.sin(((now/second)*0.05*Math.PI)*.001) => sq.gain;
        //turn on envelop
        1=>sqEnv.keyOn;
        Math.random2(250,400)::ms=>now;
        0.0 =>sq.gain;
        Math.random2(100,250)::ms=>now;
    }
}

//function for arduino controlled parameters
fun void arduino()
{
    while (true)
    {
        for( 0 => int i; i < 15; i++)
        {
            //use some data from arduino to control freq and gain
            Std.mtof(melody[i]*(data[1]*0.1))=> s.freq;
            data[0]*Math.random2f(0.08,0.1) => s.gain;
            //turn on envelop
            1=>sEnv.keyOn;
            //if else loop to control panning
            if(i==0||i==2||i==4||i==6||i==8||i==10||i==12||i==14)
            {
                data[2] => ps.pan;
            }
            else
            {
                data[2]*-1 => ps.pan;
            }
            //print out ints from arduino
            <<< data[0], data[1], data[2] >>>;
            Math.random2f(0.25,.5)::second => now;
        }
    }
}
//spork the threads
spork ~ arduino();
spork ~ bass();
//make a parent function
now + 30::second => time later;
while( now < later  )
{
    1::ms => now;
}

me.exit();




