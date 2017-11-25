<<< "Assignment_2_Twisty_Little_Passages" >>>;

// Three oscillators will sound simultaneously to play our melody
// Each will sound in its own octave, and be panned slightly differently
// For a richer timbre and more interesting mix
SqrOsc sq => Pan2 p=>dac;
SinOsc sn => Pan2 p2=>dac;
TriOsc tr => Pan2 p3=>dac;
0.4 => dac.gain;

// store notes of given D Dorian scale in an integer array
[50, 52, 53, 55, 57, 59, 60, 62, 64] @=> int scale[];

// store names of D Dorian scale notes in string array
// so we can look up the note by name and echo it to the console as it plays
["D", "E", "F", "G", "A", "B", "C", "D", "E"] @=> string names[];

// integer array of melody notes to sound in turn
// 0 -> "D", 1-> "E", etc, so we can index the scale[] array with
// these integers to retrieve the midi note for playback
//
// each row requires 4 seconds to play; 7.5 rows -> 30.00 seconds
// playing time per assignment parameters
[
0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3,
6, 5, 4, 3, 6, 5, 4, 3, 6, 5, 4, 3, 5, 4, 3, 1,
0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3,
6, 5, 4, 3, 6, 5, 4, 3, 6, 5, 4, 3, 5, 4, 3, 1,

7, 6, 5, 4, 6, 5, 4, 3, 5, 4, 3, 2, 4, 3, 2, 1,
7, 6, 5, 4, 6, 5, 4, 3, 5, 4, 3, 2, 4, 3, 2, 1,

7, 6, 5, 6, 5, 4, 5, 4, 3, 4, 3, 2, 3, 2, 1, 2,

1, 0, 7, 1, 5, 0, 3, 1, 0
] @=> int notes[];

// set up for a quarter note pulse every 0.25 seconds
0.25::second => dur pulse;

//loop through our notes array
for (0 => int i; i<notes.cap(); i++)
{ 
    // look up name of playing note and log it to the console
    <<< i, "note playing =", names[notes[i]]>>>;
    
    //set up our melody note to sound across three octaves
    //using our stack of three different oscillator types
    Std.mtof(scale[notes[i]])*4 => sq.freq;
    Std.mtof(scale[notes[i]]) => sn.freq;
    Std.mtof(scale[notes[i]]*2) => tr.freq;
    
    if (i<32) {0.2 => sq.gain;} else {0.4 => sq.gain;}
    if (i<64) {0.2 => sn.gain;} else {0.9 => sn.gain;}    
    
    //apply some random gain and panning amounts per oscillator
    //to texture the timbre and pan the mix position of each note
    Math.random2f(-0.9, 0.9) => p.pan;
    Math.random2f(-0.9, 0.9) => p2.pan;
    Math.random2f(0.5, 0.8) => p2.gain;
    Math.random2f(-0.3, 0.3) => p3.pan;
    Math.random2f(0.5, 0.8) => p3.gain;
    
    //advance time by one quarter-note pulse and
    //repeat until our notes array is empty
    pulse => now;
    
    
}
