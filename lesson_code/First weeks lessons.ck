<<< "Jackson Duhon - A sign meant won" >>>;

//SinOsc, SqrOsc, SawOsc, TriOsc

//Sound Bank
SinOsc s1 => dac; 
SqrOsc sq1 => dac;

//Volume and Frequency and duration
//Sine gain and frequency
0.6 => float mygain;//Establishing float for gain
mygain => s1.gain;
440 => int myfreq; // establishing int for frequency
myfreq => s1.freq;
//mute square
0.0 => sq1.gain;
220 => sq1.freq;
1::second => now;


//next note
//Mute Sine
0.0 => s1.gain;
440 => s1.freq;
//Bring in the square
0.2 => sq1.gain;
220 => sq1.freq;
1::second => now;