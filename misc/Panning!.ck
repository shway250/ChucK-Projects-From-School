//set s to left speaker, t to right

SinOsc s => dac.left;
SinOsc t => dac.right;

//set frequencies
220.35 => s.freq;
330.67 => t.freq;

//advance time
1::second => now;