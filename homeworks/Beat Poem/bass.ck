//Base.ccccccccccccccccccccccck
//Sound Chain
StifKarp bass =>Pan2 Master => dac;

//Parameters!!!!!
1.0 => bass.pickupPosition;
0.6 => bass.sustain;
1.0 => bass.stretch;
0.1 => bass.pluck;
0.3 =>Master.gain;
Math.random2f(-0.4,0.4)=>Master.pan;

//bass line
[60,69,68,62,61,67,66,59,60] @=> int lowEnd[];

while( true )
{
    for( 0=>int i; i < 8; i++)
    {
        if( i==0 || i==2 || i==4 ||i==6 ||i == 8)
        {
            Std.mtof(lowEnd[i]-12)=> bass.freq;
            1=>bass.noteOn;
            525::ms => now;
            //turn note off for a sec
            1=>bass.noteOff;
            50::ms => now;
        }
        else
        {
            Std.mtof(lowEnd[i]-12)=> bass.freq;
            1=>bass.noteOn;
            400::ms => now;
            //turn note off for a sec
            1=>bass.noteOff;
            50::ms => now;
        }
        
        
    }
}