// Assignment_2_-_Dorian_Scale_Melody_WKA
// 2013-11-01
<<< "Assignment 2 Dorian Scale Melody WKA" >>>;

now => time started;

//D,  E,  F,  G,  A,  B,  C,  D
[50, 52, 53, 55, 57, 59, 60, 62] @=> int midiNumbers[];

[0.5, 1, 2] @=> float octaves[];

midiNumbers.cap() => int len;
float freqs[len];
float freqs1[len];
float freqs2[len];
float freqs3[len];
float freqs4[len];
float freqsToPlay[];

[1.0, 1.0, 0.5, 0.5, 1.0,  0.5, 0.5, 0.5, 0.5, 2.0] @=> float rhythym[];
rhythym.cap() => int lenRhythm;

for (0 => int i; i < len; i++)
{
    Std.mtof(midiNumbers[i]) => freqs[i];
    
}

// C D E F E D E
freqs[6] => freqs1[0];
freqs[7] => freqs1[1];
freqs[1] => freqs1[2];
freqs[2] => freqs1[3];
freqs[1] => freqs1[4];
freqs[7] => freqs1[5];
freqs[1] => freqs1[6];
freqs[6] => freqs1[7];

freqs[0] => freqs2[0];
freqs[0] => freqs2[1];
freqs[5] => freqs2[2];
freqs[5] => freqs2[3];
freqs[6] => freqs2[4];
freqs[6] => freqs2[5];
freqs[5] => freqs2[6];
freqs[3] => freqs2[7];

freqs[1] => freqs3[0];
freqs[2] => freqs3[1];
freqs[3] => freqs3[2];
freqs[4] => freqs3[3];
freqs[3] => freqs3[4];
freqs[4] => freqs3[5];
freqs[2] => freqs3[6];
freqs[1] => freqs3[7];

freqs[3] => freqs4[0];
freqs[5] => freqs4[1];
freqs[7] => freqs4[2];
freqs[0] => freqs4[3];
freqs[4] => freqs4[4];
freqs[2] => freqs4[5];
freqs[1] => freqs4[6];
freqs[2] => freqs4[7];


250::ms => dur quarterNote;
SinOsc sin => Pan2 p1 => dac;
SqrOsc sqr => Pan2 p2 => dac;
TriOsc tri => Pan2 p3 => dac;
SawOsc saw => Pan2 p4 => dac;

0.2 => sin.gain;
0.0 => sqr.gain;
0.0 => tri.gain;
0.0 => saw.gain;

now + 28.5::second => time later;
0 => int i;

freqs3 @=> freqsToPlay;

[0.0, 0.10, 0.25, 0.40] @=> float silences[];
float silence;
int index;

while (now < later)
{
    //octaves[Math.random2(0,2)] => float octave;
    [octaves[Math.random2(0,2)], octaves[Math.random2(0,2)], octaves[Math.random2(0,2)], octaves[Math.random2(0,2)]] @=> float sectionOctaves[];
    
    i++;
    i % freqsToPlay.cap() => index;
    
    if (index == 0) 
    {
        // modulate the pan
        Math.sin( now / 1::second * 2 * pi ) => float panValue;
        panValue => p1.pan;            
        panValue => p2.pan;
        panValue => p3.pan;
        panValue => p4.pan;
        
        // choose a random section to play
        Math.random2(0, 3) => int r;
        
        if (r == 0) {
            0.2 => sin.gain;
            0.1 => sqr.gain;
            0.1 => tri.gain;
            0.1 => saw.gain;
            freqs1 @=> freqsToPlay;
        }
        else if (r == 1) {
            0.2 => sin.gain;
            0.1 => sqr.gain;
            0.0 => tri.gain;
            0.1 => saw.gain;
            freqs2 @=> freqsToPlay;
        }
        else if (r == 2) {
            0.2 => sin.gain;
            0.0 => sqr.gain;
            0.1 => tri.gain;
            0.1 => saw.gain;
            freqs3 @=> freqsToPlay;
        }
        else if (r == 3) {
            0.2 => sin.gain;
            0.1 => sqr.gain;
            0.1 => tri.gain;
            0.0 => saw.gain;            
            freqs4 @=> freqsToPlay;
        }
        
        silences[Math.random2(0, 3)] => silence;
    }
    
    
    
    freqsToPlay[index] * sectionOctaves[0] => sin.freq;
    freqsToPlay[index] * sectionOctaves[1] => sqr.freq;
    freqsToPlay[index] * sectionOctaves[2] => tri.freq;
    freqsToPlay[index] * sectionOctaves[3] => saw.freq;
    quarterNote * rhythym[i % lenRhythm] * (1.0 - silence) => now;
    0.0 => sin.freq;
    0.0 => sqr.freq;
    0.0 => tri.freq;
    0.0 => saw.freq;
    quarterNote * rhythym[i % lenRhythm] * silence => now;
}


// echo the last note with decreasing volume
0.5 => silence;
later + 1.5::second => later;
0.1 => float g;
while (now < later)
{
    g => sin.gain;
    g => sqr.gain;
    g => tri.gain;
    g => saw.gain; 
    g * 0.7 => g;
    
    freqsToPlay[index] => sin.freq;
    freqsToPlay[index] => sqr.freq;
    freqsToPlay[index] => tri.freq;
    freqsToPlay[index] => saw.freq;
    quarterNote * (1.0 - silence) => now;
    
    0.0 => sin.freq;
    0.0 => sqr.freq;
    0.0 => tri.freq;
    0.0 => saw.freq;
    quarterNote * silence => now;
}

<<< "time elapsed:", (now - started)/second >>>;
