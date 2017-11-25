// FILENAME: drums.ck
// Title: Assignment 6 Bb Aeolian Band
 
Mandolin bass => NRev revb => dac;
// bass setup
0.1 => revb.mix;
0.10 => bass.stringDamping;
0.02 => bass.stringDetune;
0.02 => bass.bodySize;
.25 => float bassGain;
bassGain => bass.gain;



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
      bassGain*.72 => bassGain;
      bassGain => bass.gain;
  }
  notes[offset[notesx]] => int midikey; 
  Std.mtof(midikey-24) => bass.freq; // knock it down two octave
  Math.random2f(0.05,0.5) => bass.pluckPos;
  1 => bass.noteOn;
  0.30 :: second => now;
  1 => bass.noteOff;
   0.1 :: second => now;
  notesx++;
  if(notesx == offset.cap()-1) 0 => notesx;
}

    
 

