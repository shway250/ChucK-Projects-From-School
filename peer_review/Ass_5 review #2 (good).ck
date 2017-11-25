<<<"Assignment_5_ElectroGeneratorUnit">>>;

// The beat is exactly 0.75sec beat. It quanted to 0.25sec-triplets
// STK-Instruments: BeeThree and Moog

SndBuf kick  => dac;
SndBuf hihat => dac;
SndBuf snare => dac;

me.dir() + "/audio/hihat_01.wav"=> hihat.read;
me.dir() + "/audio/kick_01.wav"=> kick.read;
me.dir() + "/audio/snare_01.wav"=> snare.read;

0 => kick.gain;
0 => hihat.gain;
0 => snare.gain;


// Saw-Oscilators for Fat-Synth
SawOsc saw1 => Pan2 saw1Pan => dac;
SawOsc saw2 => Pan2 saw2Pan => dac;
SawOsc saw3 => Pan2 saw3Pan => dac;

0 => saw1.gain;
0 => saw2.gain;
0 => saw3.gain;

// Hammond.Organ with reverb-triplets
BeeThree b3 => Pan2 b3Pan => NRev r  => dac;
0.2 => b3.gain;
0.1 => r.mix;

// Moog for random Melody
Moog moog => Pan2 moogPan => dac;
0 => moog.gain;

// play chords with organ
BeeThree organ1 => Pan2 orgPan1 => dac; 
BeeThree organ2 => Pan2 orgPan2 => dac;
BeeThree organ3 => Pan2 orgPan3 => dac;
0 => organ1.gain;
0 => organ2.gain;
0 => organ3.gain;

//[49, 50, 52, 54, 56, 57, 59, 61] @=> int tone[];

[49, 56, 61, 49, 56, 61, 49, 56, 61, 49, 56, 61,  // triplets
52, 56, 61, 52, 56, 61, 52, 56, 61, 52, 56, 61, 
47, 49, 54, 47, 49, 54, 47, 49, 54, 47, 49, 54,
45, 47, 52, 45, 47, 52, 45, 47, 52, 45, 47, 52] @=> int tone[];

[49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, // Bass-line
45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45,
42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 
40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40] @=> int synth[];

[49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, // organ - chords
49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49,
47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 
45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45] @=> int org1[];

[52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 
54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 
49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49] @=> int org2[];

[56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 
57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54 ] @=> int org3[];

[49, 50, 52, 54, 56, 57, 59, 61] @=> int melod[]; // for random melody



// rythm
[1,1,0, 0,0,0, 1,1,0, 0,1,0] @=> int bassdrum[];
[0,0,0, 1,0,0, 0,0,0, 1,0,0] @=> int snaredrum[];
[1,1,1, 1,1,1, 1,1,1, 1,1,1] @=> int hihatdrum[];

// plays random melody with moog
fun void rand_melod(float gain)
{
    [49, 52, 54, 56, 57, 59, 61] @=> int melod[];
    gain => moog.gain;
    moog.noteOn(1.0);
    Std.mtof(melod[Math.random2(0,6)])*2 => moog.freq;
}

// play ryth
fun void rythm(int bass_dr, int snare_dr, int hihat_dr, float bgain, float sgain, float hgain)
{
    bgain => kick.gain;
    sgain => snare.gain;
    hgain => hihat.gain;
    if (bass_dr == 1) 0 => kick.pos;
    if (hihat_dr == 1)    0 => hihat.pos;
    if (snare_dr == 1)    0 => snare.pos;
}

// play Bass-line
fun void fatSynth(int note, float detune, float gain)
{
    gain => saw1.gain; gain => saw2.gain; gain => saw3.gain;
    Std.mtof(note)/2 => float freq;
    freq => saw1.freq;
    freq-detune => saw2.freq;
    freq+detune => saw3.freq;
    Math.random2f(-1,1) => saw1Pan.pan;
    -1. => saw2Pan.pan;
    1. => saw3Pan.pan;
}

// play chord
fun void chord (int n1, int n2, int n3, float gain)
{
    gain => organ1.gain;
    gain => organ2.gain;
    gain => organ3.gain;
    organ1.noteOn(1);
    organ2.noteOn(1);
    organ3.noteOn(1);
    Std.mtof(n1) => organ1.freq;;
    Std.mtof(n2) => organ2.freq;;
    Std.mtof(n3) => organ3.freq;;
}


// begin of playing
for (0 => int i; i< 120; i++)
{
    i%12 => int beat;
    i%tone.cap() => int part;
    
    if (i>=12)
        chord (org1[part], org2[part], org3[part], 0.1);
    if (i>=36 && i<108)
        fatSynth(synth[part], 0.5, 0.1);
    else
        fatSynth(synth[part], 0.5, 0.0);
    if (i>=tone.cap()-3 && i<108)
        rythm(bassdrum[beat],snaredrum[beat], hihatdrum[beat], 0.3, 0.7, 0.2);
    
    if (i>=72)
        rand_melod(0.6);
    
    
    // play triplets
    Std.mtof(tone[part])*2 => b3.freq;
    b3.noteOn(1);
    Math.random2f(-1, 1) => b3Pan.pan;
    
    
    0.25::second => now; // triplet-time (3x) = .75 quarter-note
}
