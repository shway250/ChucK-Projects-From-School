// FILENAME: drums.ck
// Title: Assignment 6 Bb Aeolian Band

// sound chain
SndBuf hihat => dac;
SndBuf snare => dac;

// sound file array
["/audio/hihat_01.wav", "/audio/snare_01.wav", "/audio/stereo_fx_04.wav"] @=> string fileid[];

// load soundfiles
me.dir(-1) + fileid[0] => hihat.read;
me.dir(-1) + fileid[1] => snare.read;

// stretch a stereo file THIS IS A KLUDGE 
SndBuf2 mySound => dac;
me.dir() + fileid[2] => string stereofile;
stereofile => mySound.read; // open the file 
0 => mySound.pos;  // place initial play position
0.4 => mySound.gain;
2400 => int ptrdelta; // change playhead each loop 
ptrdelta => int ptr;  // based on song length of 7 seconds

// set all playheads to end so no sound is made
hihat.samples() => int endhihat; 
snare.samples() => int endsnare; 
endhihat => hihat.pos;
endsnare => snare.pos;


0 => float vol;                // volume 
0.0 => float srate;            // use this to receive rate from random function
0 => int counter;              // initialize beat counter  
now + 30::second => time endsong; // set sound length to 30 seconds
now + 25::second => time fadeout; // set fadeout point 

1::second => now; // startup 

spork ~ kickdrums();

while(now < endsong)
{
  // song fadeout at end
  if ( now > fadeout) {
    vol *.75 => vol;
    vol => hihat.gain;
    vol => snare.gain;
    vol => mySound.gain;      
    }
  else {
    Math.random2f(.15, .2) => vol;
    vol => hihat.gain;
    vol => snare.gain;      
    }

  // establish beat sequence 
  counter % 8 =>  int beat; // 8 positions 0 - 7

  // snare drum on 2 and 6 
  if((beat == 2) || (beat == 6))  {
    Math.random2f(-1.0,1.4) => srate;
    srate => snare.rate;
    if(srate < 0)  endsnare => snare.pos;
    else  0 => snare.pos;
    }

  // hihat for all single beat
  0 => hihat.pos;
  Math.random2f(.2,1.8) => hihat.rate;  

  // play quarter note
  0.31::second => now;  // quarter note

  // increment counters  
  counter++; 
  ptr => mySound.pos;
  ptr + ptrdelta => ptr;
}


// ---------------------------------
// kickdrum function for sporking 
// ---------------------------------
fun void kickdrums() {
  // sound chain
  SndBuf kick => dac; 

  // load soundfiles
  "/audio/kick_01.wav" => string filename;
  me.dir(-1) + filename => kick.read;

  // set all playheads to end so no sound is made
  kick.samples()  => int endkick; 
  endkick => kick.pos;


  0 => float vol;                // volume 
  0.0 => float srate;            // use this to receive rate from random function
  0 => int counter;              // initialize beat counter  
  now + 30::second => time endsong; // set sound length to 30 seconds
  now + 25::second => time fadeout; // set fadeout point 

  1::second => now; // startup 

  while(now < endsong)
  {
     // song fadeout at end
     if ( now > fadeout) {
       vol *.75 => vol;
       vol => kick.gain;
       }
     else {
       Math.random2f(.15, .2) => vol;
       vol => kick.gain;
       }

     // establish beat sequence 
     counter % 8 =>  int beat; // 8 positions 0 - 7

     // bass drum on 0 and 4 
     if((beat == 0) || (beat ==4))  {
       Math.random2f(-1.0,1.7) => srate;
       srate => kick.rate;
       if(srate < 0)  endkick => kick.pos;
       else  0 => kick.pos;
       }

     // play quarter note
     0.31::second => now;  // quarter note

     // increment counters  
     counter++; 
     ptr => mySound.pos;
     ptr + ptrdelta => ptr;
   }
}
