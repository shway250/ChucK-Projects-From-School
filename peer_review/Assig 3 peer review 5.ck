// not much in the way of music but as an excersize
// sound chain
SndBuf drum => dac;

// declaration of array of drum_samples
string drum_samples[3];

// load array with  file paths
me.dir() + "/audio/kick_01.wav" => drum_samples[0];
me.dir() + "/audio/snare_02.wav" => drum_samples[1];
me.dir() + "/audio/snare_03.wav" => drum_samples[2];

// array for repetitive pattern of drums
[0,1,2,0,1,0,1] @=> int s[];

// sound chain
TriOsc song => pan2 p => dac;

// initialising gains
0 => song.gain;
.3 => drum.gain;

// initialise pan position
1.0 => p.pan;

// array of D Dorian notes (tonic to upper octave fifth)

[50, 52, 53, 55, 57, 59, 60, 62, 64, 65, 67, 69] @=> int A[];

// array for repetitive pattern of notes

[0,1,2,3,2,1,0,1,2,1,0,1,2,3] @=> int notes[];

for( 0 => int m; m < 9; m++ )
{
    if( m%2 != 0 )
    {
        -1.0 => p.pan;
    }
    else
    {
        1.0 => p.pan;
    }
    for( 0 => int i; i < notes.cap(); i++ )
    {
        Std.mtof(A[notes[i]+m]) => song.freq;
        .5 => song.gain;
        drum_samples[s[i%7]] => drum.read;
        .25::second => now;
    }
}
