// sound netwrok
SinOsc s => dac;

// middle C freq (in Hz)
261.63 => float myFreq;
// My Vol
0.6 => float myVol;

// set frequency
myFreq => s.freq;
// set volume
myVol => s.gain;
//one second time
1::second => now;