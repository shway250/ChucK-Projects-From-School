// Assignment_5_InToTheCave
// Unit Generators

// Sound Chain

Flute FF => Pan2 p =>  NRev rev => Gain FFGain => Gain master => dac;
BeeThree B3 => Pan2 pp => Gain B3Gain => master;
ModalBar M => Gain MGain => NRev rev2 => master;
Shakers SH => Gain SHGain => master;
SinOsc s => dac.left;
SndBuf BD => NRev rev3 => dac.right;

0.9 => master.gain; // Set master vol

0.3 => FF.gain; // Set Flute vol
0.6 => B3.gain; // set B3 vol
4 => M.preset; // perc sound selection (vibes)
22 => SH.preset; // Shakers preset (water)
0.1 => s.gain; // Set Osc Volume

0.2 => rev.mix; // Flute reverb
0.1 => rev2.mix; // ModalBarr reverb
0.3 => rev3.mix; // bass drum reverb

// flute settings
0.02 => FF.noiseGain;
0.1 => FF.rate;
0.8 => FF.pressure;

// load sample
me.dir() +"/audio/kick_03.wav" => BD.read;
// set playhead to end of certain samples, so no sound in beginning
BD.samples() => BD.pos;

// Db49, D50, E52, Gb54, Ab56, A57,B 59, Db61, D62 (the Db Phrygian mode)
[61,62, 61,57, 56,54, 54,56, 56,49, 50,54, 56,57, 56,54] @=> int frase1[]; // notes array




<<< "ASSIGNMENT 5" >>>;
<<< "InToTheCave" >>>;

now => time start;
while(now - start < 10::second) // set first loop
{
    1 => M.noteOn;
    Std.mtof(frase1[0]) => M.freq; // vibes hit Db at the begining of every phrase
    <<< "Db" >>>; // print at the start of every melody
    
    for(0 => int i; i < frase1.cap(); i++)
    {
        1 => FF.noteOn;
        1 => B3.noteOn;
        Std.mtof(frase1[i]) => FF.freq;
        Std.mtof(frase1[i]-24) => B3.freq;
        Std.mtof(frase1[i]+12) => s.freq;
        Math.random2f(0, 1) => p.pan;
        Math.random2f(-1, 0) => pp.pan;
        Math.random2f(-1, 1) => B3.controlOne; // controls organ distortion
        Math.random2f(0.1, 0.3) => FF.jetDelay;
        
        0.375::second => now;
    }
}

1 => FF.noteOff; // turn flute off
0.3 => B3.gain; // keep organ On with the last random ControlOne with new Vol
0 => s.gain; // mute Osc.

now => time start2;
while(now - start2 < 3::second) // play melody at 0.75 sec
{
    <<< "long phrase" >>>; // print part
    1 => M.noteOn;
    1 => SH.noteOn;
    Std.mtof(frase1[9]-24) => SH.freq; 
    for(0 => int i; i < frase1.cap(); i++)
    {
        1 => M.noteOn;
        Std.mtof(frase1[i]) => M.freq;        
        0.75::second => now;
    }
}


1 => B3.noteOff; // turn Organ Off
now => time start3;
while(now - start3 < 4::second)
{
    1 => M.noteOn;
    1 => SH.noteOn;
    Std.mtof(frase1[9]-12) => M.freq;
    Std.mtof(frase1[0]) => SH.freq;
    1.25::second => now;
}    

0 => BD.pos; // set Bass drum sample in position
1 => M.noteOn; // vibes last note
1 => SH.noteOn; // "water" last note
Std.mtof(frase1[9]-12) => M.freq;
Std.mtof(frase1[0]) => SH.freq;
2::second => now;
<<< " END" >>>;
