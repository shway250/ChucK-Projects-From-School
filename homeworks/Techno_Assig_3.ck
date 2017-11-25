///Assignment_3
<<< "Tech? NOOOOOOOOOOOOOO!!!!!!!!!!" >>>;
<<< "Jackson 'can I borrow like three quarters for the bus?' Duhon" >>>;

///// Gain object that I'll link to dac at the end
Gain gain => dac;

//Setting up my Sound Buffs and Pans
//Making an array of kicks so that a random kick is played
SndBuf kick[2];
kick[0] => gain;//don't need pan 4 the kick, cause of mixing & junk
kick[1] => gain;

//now for snares and whatnot
SndBuf snare => Pan2 pans => gain;
SndBuf hihat => Pan2 panh => gain;
SndBuf click => Pan2 panc => gain;
//Stereo Sound thingy
SndBuf stereo => gain;

//sine osc for the melody array
SinOsc sin => NRev revs => Pan2 sinpan => gain;

//setting overal gain volume
0.5 => gain.gain;
0.2 => sin.gain;
// load up some samples for my beatz
//Placing the kick samples in the right place
me.dir()+"/audio/kick_01.wav" => kick[0].read;
me.dir()+"/audio/kick_03.wav" => kick[1].read;
//Other percussion!!!!!!!!!!!! WAH!!!!
me.dir()+"/audio/snare_01.wav" => snare.read;
me.dir()+"/audio/hihat_01.wav" => hihat.read;  
me.dir()+"/audio/click_04.wav" => click.read;
//Stereo THANG!
me.dir()+"/audio/stereo_fx_04.wav" => stereo.read;

////////////////////////////////////////////////////////////////////

/////////Get stereo FX ready to play backwards
stereo.samples() => int sampnum;

////////////// array for controlling our cowbell strikes///////////////
[0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0] @=> int clickRhythm[];//I ended up not using this
/////////////Phygian Scale////
[49,50,52,54,56,57,59,61] @=> int phryg[];


// controls the overall length of our "measures"
clickRhythm.cap() => int MAX_BEAT;

// overall speed control
0.15 :: second => dur tempo;

// counters: beat within measures, and measure# #D
0 => int beat;
0 => int measure;

//Playing sample backwards before loops starts.
sampnum => stereo.pos;
-1.0 => stereo.rate;

///////////////Here comes the heavily quantized funk.//////////////
now + 30::second => time later;
while( now < later  )
{
        
    // Kick
    if (beat % 4 == 0) 
    { 
        Math.random2(0,kick.cap()-1) => int hubba;
        0 => kick[hubba].pos;
    }
    // after a time, play snare on off beats (2, 6, ...)
    if ((beat % 5 == 2) && (measure % 2 == 1))
    {
        0 => snare.pos;
        Math.random2f(-1.0,1.0) => pans.pan;
    }    
    //Syncopated HH
    if(beat % 9 == 0)
    {
       0 => hihat.pos;
       Math.random2f(-1.0,1.0) => panh.pan;
    }
    //Sincopated click thing-a-ma-jig
    if((beat % 11 == 3) &&( measure % 2 == 0 ) )
    {
        0 => click.pos;
        Math.random2f(-1.0,1.0) => panc.pan;
    }
    //Sine osc playing random notes in array w/ random pan and reverb
    if (beat %4 == 3)
    {
      Std.mtof(phryg[Math.random2(0,7)]) => sin.freq;
      Math.random2f(-1.0,1.0) => sinpan.pan;
       Math.random2f(0,1.0) => revs.mix;
    }
    ////Make measure iterate up
    if (beat==0)
    {
     measure++;   
    }
   
    (beat + 1) % MAX_BEAT => beat;
    
    ///move time forward
    tempo => now;
}