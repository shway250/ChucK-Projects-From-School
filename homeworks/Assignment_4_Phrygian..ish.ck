//Assignment 5 - "Phrigian...ish"

//Oscilator Sound Chain
SinOsc sine_osc_1 => ADSR env => NRev sine_rev => Gain master => dac;
(0.05::second, 0.01::second, 0.0, 0.01::second ) => env.set;
0.05 => sine_rev.mix;

//////////////////////////////////Sound Buff Stuff//////////////////////
//SoundBuff Sound Chain
SndBuf click => dac;
SndBuf snare => dac;

//Find Audio Files
me.dir() + "/audio/snare_03.wav" => click.read;
me.dir() + "/audio/snare_02.wav" => snare.read;

//Make samples not play at initialization
click.samples()=> click.pos;
snare.samples()=> snare.pos;

///////////////////////////////////STK INSTRUMENTS!!!///////////////////
//Sitar
Sitar sitar => Gain sitarGain => dac;
sitarGain => Gain sitarFeedback => Delay delay =>sitarGain;
//Shaker
Shakers shaker => master;



///////////////////////////////////Note Arrays//////////////////////////
[49,50,52,54,56,57,59,61] @=> int phryg[];
[49,50,52,56,49,50,52,56] @=> int phryg_mel[];



// globalTime will set time of composition using While loop
now + 30::second => time globalTime;
////////////////////////////////MAIN PROGRAM!!!/////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/////////////
//30 Second While loop
while(now < globalTime)
{





}