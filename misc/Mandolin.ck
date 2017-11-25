//sound chain
Mandolin m => dac;

0.25 => m.pluckPos;//sets pluck position
1.0 => m.noteOn; //pluck strings

0.01 => m.stringDetune;
500 => m.freq;
0.7 => m.bodySize;

2.0::second => now;