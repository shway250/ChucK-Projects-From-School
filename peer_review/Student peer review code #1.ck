// Week one
// gain is Volume
// freq is Frequency

/*
SqrOsc s1=> dac;
0.3 => s1.gain;
110 => s1.freq;
1::second =>now;

SinOsc s2=> dac;
0.3 => s2.gain; 
220 => s2.freq;  
1::second =>now;

SawOsc s3=> dac;
0.3 => s3.gain;
330 => s3.freq;
1::second =>now;

TriOsc s4=> dac;
0.3 => s4.gain;
440 => s4.freq;
1::second =>now;

PulseOsc s5=> dac;
0.3 => s5.gain;
550 => s5.freq;
1::second =>now;
Choose two, 30 seconds
*/

SqrOsc s1=> dac;
TriOsc s2=> dac;

100 => int f1;
<<<"Now =",now/second>>>;
for(1=> int i; i<=300; i++)
{       
    <<<i>>>;    
    <<<f1>>>;   
    
    if (i%2>0)  // This is to alternate the two oscillators
    {
        0.6 => s1.gain;     // the volumne wil remanin constant
        100+i  => s1.freq;  // the frequency will increase   
    }                     //  change the value of 100 to lower, is fun
    else
    {
        0.9 => s2.gain;
        100+i => s2.freq;   
    }
    
    0.1::second =>now;
}

<<<"NewNow =",now/second>>>;
<<< "">>>;
<<< " Yupi at lot of FUN!!!! ">>>; 
