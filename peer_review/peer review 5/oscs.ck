// FILENAME: oscs.ck
// Title: Assignment 6 Bb Aeolian Band
//========================================================================================================

// data offsets into Note array  
[5,1,2,3,4,5,1,1,6,4,5,6,7,8,1,1,4,5,4,3,2,3,4,3,2,1,0,1,2,3,1,3,2,5,1,2,3,4,5,1,1,6,4,5,6,7,8,1,1,4,5,4,3,2,3,4,3,2,1,2,3,2,1,0,1] @=> int offset[];
//(   lower octave             ) (    base notes                ) (  higher octave               ) 
// Bb Aeolian notes array -1 to +1 ocatve
[42, 44, 46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[]; 

TriOsc chord[3];    //  chord
Gain master => dac; // master chord volume control 
0 => master.gain;   // set master volume to off
SinOsc s => Pan2 p => dac; // intro oscillator with Panning
// panning 
-1 => float panval;
0.25 => float panchange;
panval => p.pan;


for(0=> int i; i < chord.cap(); i++)
{
  // use array to chuck unit generator to master
  chord[i] => master; 
}


now + 30::second => time endsong; // set sound length to 30 seconds
now + 24::second => time fadeout; // set fadeout point 
0.06 => float mastergain;

//====================================
// playChord function from Lecture
//====================================
fun void playChord( int offndx, string quality, float length)
{
  // root is bass note of the chord it is the index into the offset array
  // quality is major or minor
  // lenght time of chord
  // function will make major or minor chords
  notes[offset[offndx]] => int midikey; 
  Std.mtof(midikey) => chord[0].freq;
    
  //fifth - add 7 to get fifth above the root 
  Std.mtof(midikey+7) => chord[2].freq;
  
  //third this determines if the chord is major or minor
  if(quality == "major")
  { // add 4 to get a major third 
    Std.mtof(midikey+4) => chord[1].freq;
  }
  else if(quality == "minor")
  { // add 3 to get a minor  third
    Std.mtof(midikey+3) => chord[1].freq;
  }
  else  
  {  
    <<< "must say major or minor">>>; 
  }

  length::second => now; 
}


//====================================
// Play Intro custom function
//====================================
fun void playIntro(int note, float vol, float vmod, float len) 
{
 for(0 => int i; i < note; i++ )
  {
    vol=> s.gain;
    Std.mtof( notes[offset[i]] ) => s.freq;
    len::second => now;  // quarter note
    vol+vmod => vol; // change volume for next note
      }
  0 => s.gain; // kill volume
  // cycle pan left to right using panval and panchange
  panval + panchange => panval;
  panval => p.pan;
  if(panval > 0.999) -0.25 => panchange;
  else if(panval < -0.999) 0.25 => panchange;

 }
    

//==============================
// Play Main Tune
//==============================
playIntro(8, .06, .08, .31);  // function to play intro 
mastergain => master.gain;      // bring up chord volume 
  
while(now < endsong) {
  for(0 => int i; i < offset.cap()-1; i++ )
  {
    playChord(i, "minor", .31);
    if (now >= endsong) break;
    else if ( now > fadeout)
      { 
        // fade out the song 
        mastergain*.65 => mastergain;
        mastergain => master.gain;      // bring down chord volume 
      }
  }
}
