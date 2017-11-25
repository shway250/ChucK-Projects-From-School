///Author: Jackson Duhon
// Date: 10/21/2013

// sound network
SinOsc yup => dac;

//prints program name
<<< "Hello Sine!" >>>;

//set volume to .6
0.6 => yup.gain;
// set frequency to 220Hz
220 => yup.freq;
// set time to 1 second
1::second => now;

// set volume to 0.5
0.5 => yup.gain;
// set frequency to 440Hz
440 => yup.freq;
// set time to 2 seconds
2::second => now;

// set volume to 0.3
0.3 => yup.gain;
// set frequency to 330 Hz
330 => yup.freq;
// set time to 3 seconds
3::second => now;