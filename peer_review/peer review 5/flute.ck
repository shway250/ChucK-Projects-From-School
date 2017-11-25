// FILENAME: drums.ck
// Title: Assignment 6 Bb Aeolian Band

// flute.ck
// Our famous headliner flute solo (with EFX)
Flute solo => JCRev rev => dac;
0.1 => rev.mix;
solo => Delay d => d => rev;
0.6 :: second => d.max => d.delay;
0.05 => d.gain;
.3 => float soloGain;
soloGain => solo.gain;


// data offsets into Note array  
[5,1,2,3,4,5,1,1,6,4,5,6,7,8,1,1,4,5,4,3,2,3,4,3,2,1,0,1,2,3,1,3,2,5,1,2,3,4,5,1,1,6,4,5,6,7,8,1,1,4,5,4,3,2,3,4,3,2,1,2,3,2,1,0,1] @=> int offset[];
//(   lower octave             ) (    base notes                ) (  higher octave               ) 
// Bb Aeolian notes array -1 to +1 ocatve
[42, 44, 46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[]; 
0 => int notesx; // index to notes offset array
now + 30::second => time endsong; // set sound length to 30 seconds
now + 25::second => time fadeout; // set fadeout point 
1::second => now; // startup 

while(now < endsong)
{
  if ( now > fadeout) {
      soloGain*.68 => soloGain;
      soloGain => solo.gain;
  }
  notes[offset[notesx]] => int midikey; 
  Std.mtof(midikey+24) => solo.freq; // knock it up two octave
  1 => solo.noteOn;
  0.30 :: second => now;
  1 => solo.noteOff;
  0.1 :: second => now;
  notesx++;
  if(notesx == offset.cap()-1) 0 => notesx;
}

    
 

