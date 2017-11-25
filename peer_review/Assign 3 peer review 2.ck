//Printing title
<<<"----------------------------">>>;
<<<"|                          |">>>;
<<<"| Assignment_3_JTechno     |">>>;
<<<"|                          |">>>;
<<<"----------------------------">>>;

// sound chain
Gain master => dac; // Creat master to control the fades on every sound
// Drum sequencer
SndBuf kick => master; // Drum Kick
SndBuf hihat => pan2 hat => master; // Hihat with Pan Option
SndBuf snare => pan2 snr => master; // Snare with Pan Option
SndBuf fx =>  master; // Stereo effects
// Oscillators for play sounds
SqrOsc sqr =>  master; // 1st note
SqrOsc tr => master; // 2nd note in harmony (third of the 1st)
SqrOsc qi => master; // 3rd note in harmony (fifht of the 1st)
SawOsc mel => master; // Melody note

// Variable to control the Fade Outs
.2 => float m; // Creating Float with the Master Volume
m => master.gain; // Giving the Master Volume

// Array of avaliable notes
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];
// Array with melody notes
[2,3,1,0,5,3,5,6,5,3,4,6,5,4,3,4] @=> int mel_not[];
// Array with time for the melody notes to play, 1 =Time Unity = 250ms
[6,2,6,2,6,2,2,2,2,2,6,2,4,2,2,7] @=> int mel_tmp[];

// Array of strings to use the 2 samples on the different places of song
string fx_samples[2];

// load soundfiles into
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/hihat_01.wav" => hihat.read;
me.dir() + "/audio/snare_01.wav" => snare.read;
me.dir() + "/audio/stereo_fx_02.wav" => fx_samples[0];
me.dir() + "/audio/stereo_fx_05.wav" => fx_samples[1];

// set all playheads to end to don't play this sounds
kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;

// set the 1st sound gain on .05 and turn of the other by now
.05 => sqr.gain;
0 => tr.gain;
0 => qi.gain;
0 => mel.gain;
// Panning the drum
-.3=>hat.pan; // Panning hihat a little for the left
.3=>snr.pan; // Panning snare a little for the right

Math.srandom(1); // Creat the same random

//Printing Welcome message
<<<"|                          |">>>;
<<<"| Welcome to this sound!!! |">>>;
<<<"|                          |">>>;
<<<"|--------------------------|">>>;

// For loop using the 1st 16ths times (time = 250ms) of the music
for ( 0 => int i; i < 16; i++)
{
    // Fade in on the master 0.025 every time (time = 250ms) of the music to .6 Volume
    if (m < .6)
    {
        m + .025 => m;
        m => master.gain;
    } 
    
    // beat goes from 0 to 7
    i % 8 => int beat;
    
    // bass drum on 0 and 5
    if (( beat == 0 ) || (beat == 5))
    {
        0 => kick.pos; // Prepare kick to play
    }
    
    // snare drum on 2 and 7
    if (( beat == 2 ) || (beat == 7))
    {
        0 => snare.pos; // Prepare Snare to play
        Math.random2f(.6, 1.4) => snare.rate; // Define a random rate (velocity to play) for the snare from (.6, 1.4)
    }
    
    // Play notes like a loop using just some notes of the scale (the number of the beat in the bar (0-3) is the number of the note to play)
    if (( beat == 1 ) || (beat == 3) || (beat == 4) || (beat == 6) || (beat == 7))
    {
        std.mtof(notes[i%4]) => sqr.freq; //Midi to freq
    }
    
    // hihat
    0 => hihat.pos; // Prepare to play
    .2 => hihat.gain; // Set Volume
    Math.random2f(.2, 1.8) => hihat.rate; // Define a random rate (velocity to play) for the hihat from (.2, 1.8)
    250::ms => now; // Play the sounds
}

//Printing message just for fun =)
<<<"|                          |">>>;
<<<"| Let's Begin?!?           |">>>;
<<<"|                          |">>>;
<<<"|--------------------------|">>>;

0 => sqr.gain; // Turning off the Volume of the Osc
0 => kick.pos; // Preparing kick to play
fx_samples[0] => fx.read; // Preparing the 1st Stereo effect to play

// For loop to make the Fade In of the Stereo effect
for(0 => int j; j < 250; j++)
{
    1 - (j*.01) => fx.gain; // Increase the Fade In every 0.01second
    0.01::second => now; // Play the Sound with the Fade
}

//Printing message just for fun =)
<<<"|                          |">>>;
<<<"| Groove on!!!             |">>>;
<<<"|                          |">>>;
<<<"|--------------------------|">>>;

.6 => fx.gain; // Giving the Fx the .6 Volume
32 => int mel_tm; // Seting the melody time to play
0 => int mel_nt; // Note to play

// Introducing the harmony and before the melody to play
for ( 0 => int i; i < 87; i++)
{
    // Fading out the Stereo effect
    if (m > 0)
    {
        m - .1 => m; // fading out
        m => fx.gain; // seting fade
    } 
    
    // beat goes from 0 to 7
    i % 8 => int beat;
    
    // bass drum on 0 and 4 (but just since the 32 beat)
    if (( beat == 0 ) || ((beat == 4) && ( i > 32 )))
    {
        0 => kick.pos; // Preparing kick to play
    }
    
    // snare drum on 2 and 6
    if (( beat == 2 ) || (beat == 6))
    {
        0 => snare.pos; // Preparing snare to play
        Math.random2f(.6, 1.4) => snare.rate; // Define a random rate (velocity to play) for the snare from (.6, 1.4)
    }
    
    // hihat since the 32 beat, and just on 2 and 4 times of the bar
    if (( i > 32 ) && (( beat % 2 ) == 1))
    {
        0 => hihat.pos; // Preparing hihat to play
        .2 => hihat.gain; // Set Volume
        Math.random2f(.2, 1.8) => hihat.rate; // Define a random rate (velocity to play) for the hihat from (.2, 1.8)
    }
    
    // Defining the Harmomy Rythm, played on the, 1, 3, 4, 6 and 7 beats
    if (( beat == 1 ) || (beat == 3) || (beat == 4) || (beat == 6) || (beat == 7))
    {
        // Seting the 3 notes Volume
        .03 => sqr.gain;
        .03 => tr.gain;
        .03 => qi.gain;
        
        // Defining the beats to play the Dminor chord
        if (( i < 8 ) || (( i > 24) && ( i < 32 )) || (( i > 32) && ( i < 40 )) || (( i > 56) && ( i < 64 )))
        {
            std.mtof(notes[0]) => sqr.freq; //Midi to freq
            std.mtof(notes[2]) * 2 => tr.freq; //Midi to freq
            std.mtof(notes[4]) => qi.freq; //Midi to freq
        }
        // Defining the beats to play the CMajor chord
        if ((( i > 8 ) && ( i < 16 )) || (( i > 40) && ( i < 48 ))  || (( i > 80 ) && ( i < 83 )))
        {
            std.mtof(notes[6]) / 2 => sqr.freq; //Midi to freq
            std.mtof(notes[1]) * 2 => tr.freq; //Midi to freq
            std.mtof(notes[2]) => qi.freq; //Midi to freq
        }
        // Defining the beats to play the Eminor chord
        if ((( i > 16 ) && ( i < 24 )) || (( i > 48) && ( i < 56 )) || (( i > 72 ) && ( i < 80 )))
        {
            std.mtof(notes[1]) => sqr.freq; //Midi to freq
            std.mtof(notes[3]) * 2 => tr.freq; //Midi to freq
            std.mtof(notes[5]) => qi.freq; //Midi to freq
        }
        // Defining the beats to play the FMajor chord
        if (( i > 64 ) && ( i < 72 ))
        {
            std.mtof(notes[2]) => sqr.freq; //Midi to freq
            std.mtof(notes[4]) * 2 => tr.freq; //Midi to freq
            std.mtof(notes[6]) => qi.freq; //Midi to freq
        }
        // Defining the beats to play the BDiminished chord
        if (( i > 83 ) && ( i < 87 ))
        {
            std.mtof(notes[5]) / 2 => sqr.freq; //Midi to freq
            std.mtof(notes[7]) => tr.freq; //Midi to freq
            std.mtof(notes[2]) => qi.freq; //Midi to freq
        }        
    }
    // When it's not the beat to play the Harmony Rythm Silence the Harmony
    else
    {
        0 => sqr.gain;
        0 => tr.gain;
        0 => qi.gain;
    }
    
    if ( i == 32)
    {
        //Printing message on melody begin just for fun =)
        <<<"|                          |">>>;
        <<<"| Yeeeeeeeeeh!!!           |">>>;
        <<<"|                          |">>>;
        <<<"|--------------------------|">>>;
    }
    
    // Play Melody on time
    if ( i == mel_tm)
    {
        std.mtof( notes[ mel_not[ mel_nt ] ] ) * 2 => mel.freq; //Midi to freq of the melody note to play on that time
        mel_tm + mel_tmp[ mel_nt ] => mel_tm; // Set the next time to play the next note
        mel_nt++; // Next note
        .045 => mel.gain; // Set melody Volume
    }
    200::ms => now; // Playing time
    // Silence time on the harmony to fell the beat between repectitions of the the harmony in closer beats
    0 => sqr.gain;
    0 => tr.gain;
    0 => qi.gain;
    50::ms => now; // Playing silence time
    // The sum between hormony playing time and harmony silence time it's always 250ms the beat time
}

//Printing message just for fun =)
<<<"|                          |">>>;
<<<"| Closer to the end!!!     |">>>;
<<<"|                          |">>>;
<<<"|--------------------------|">>>;

0 => kick.pos; // Preparing kick to play

// Preparing Dminor chord to finish the song
std.mtof(notes[0]) => sqr.freq; //Midi to freq
std.mtof(notes[2]) * 2 => tr.freq; //Midi to freq
std.mtof(notes[4]) => qi.freq; //Midi to freq

// Setting Volumes
.04 => sqr.gain;
.04 => tr.gain;
.04 => qi.gain;       
.06 => mel.gain;

// Play the kick on the begin the chord and a Snare Ruff
for(0 => int f; f<25; f++)
{
    // Division of the beat by 5
    f % 5 => int division;
    
    
    0 => snare.pos; // Preparing Snare to Play
    .1 + (f*.02) => master.gain; // Fading In the Master Volume
    
    // Playing Hihat on Upbeat of the Snare Ruff
    if (( f % 10 ) == 4)
    {
        0 => hihat.pos; // Preparing Hihat to Play
    }
    
    // Seting Volume for the Snare with accent on the 1st of the 5ths
    if ( division == 0 )
    {
        .45 => snare.gain; // Acentuation Volume
    }
    else
    {
        .15 => snare.gain; // Other notes Volume
    }
    
    50::ms => now; // Playing time (every 5 repetitions make the 250ms beat time
}

// Playing Kick
0 => kick.pos;
250::ms => now;
// Playing Strong Snare
1 => snare.gain;
0 => snare.pos;
250::ms => now;

//Printing End message
<<<"|                          |">>>;
<<<"| ------ The End!!! ------ |">>>;
<<<"|                          |">>>;
<<<"|--------------------------|">>>;

// Silence the Harmony and notes
0 => sqr.gain;
0 => tr.gain;
0 => qi.gain; 
0 => mel.gain;

// Playing Kick
0 => kick.pos;

// Play a reverse Snare
snare.samples() => snare.pos; // Setting snare sound on the end
-.6 => snare.rate; // Play to back with minus

fx_samples[1] => fx.read; // Play 2nd Stereo effect
2.5 => fx.rate; // Define a high rate (velocity to play)
.3 => fx.gain; // Fx Volume

750::ms => now; // Playing time

//Printing greetings message
<<<"|                          |">>>;
<<<"| Hope you enjoyed!!! =D   |">>>;
<<<"|                          |">>>;
<<<"|--------------------------|">>>;

/*End*/
