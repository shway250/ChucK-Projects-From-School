<<< "Assignment 5 - Phrigian...ish" >>>;
<<<"By Jackson 'is there wheat flour in this soup?' Duhon">>>;

//Oscilator Sound Chain
PulseOsc Pulse => Pan2 PulP => dac;
SinOsc sine_osc_1 => Pan2 sinP => dac;
SinOsc sine_osc_2 =>Pan2 sinP2 => dac;
SinOsc sine_osc_3 => dac;

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
Sitar sitar => dac;
0.5 => sitar.gain;
//Shaker
Shakers shaker => dac;
4 => shaker.preset; //rain drops preset


///////////////////////////////////Note Arrays//////////////////////////
[49,50,52,54,56,57,59,61] @=> int phryg[];
[49,50,52,56,49,50,52,56] @=> int phryg_mel1[];
[49,50,49,50,57,56,57,56] @=> int phryg_mel2[];
[49,52,54,59,49,52,54,59] @=> int phryg_mel3[];

/////////////////////////////Function//////////////////////////////////
//THis funtion will 
fun float third( float originalFreq )
{
    //calculate third of input frequency
    return(originalFreq*1.25);
}

//fifth function
fun float fifth( float originalFreq )
{
    //calculate fifth of input frequency
    return(originalFreq*1.5);
}
//7th function
fun float sev( float originalFreq )
{
    //calculate seventh of input frequency
    return(originalFreq*1.75);
}

//Define Quarter Note
.75 => float beattime;
// globalTime will set time of composition using While loop
now + 30::second => time globalTime;
////////////////////////////////MAIN PROGRAM!!!/////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/////////////
//30 Second While loop
while(now < globalTime)
{
    
    
    //Frequency Sweep Intro
    for( 20 => float i; i <500; i + .5 => i)
    {
        if( i < 500)
        {
                0.0=>sine_osc_3.gain;

            //Using functions
            third(i) => Pulse.freq;
            fifth(i) => sine_osc_1.freq;
            sev(i) => sine_osc_2.freq;
            //Gain staging Oscillators
            0.3=>Pulse.gain;
            0.3=>sine_osc_1.gain;
            0.3=>sine_osc_2.gain;
            //Doing some stuff with the panning
            Math.random2f(-1.0,1.0)=> PulP.pan;
            Math.sin(now/1::second*2*pi) => sinP.pan;
            Math.sin(now/1::second*2*pi) => sinP2.pan;
            //PULSE WIDTH MODULATION!!!!!
            Math.random2f(0.01,0.5) => Pulse.width;
                       5::ms => now;
        }
    }
    //cut osc gains
    0.0=>Pulse.gain;
    0.0=>sine_osc_1.gain;
    0.0=>sine_osc_2.gain;
    0.0=>sine_osc_3.gain;

    ////Start things off with the whole scale
        for( 0 => int i; i < phryg.cap(); i++ )
        {
            //SndBuf
            0=>click.pos;
            0=>snare.pos;
            Math.random2f(0.0, 0.1) => click.gain;
            Math.random2f(0.0, 0.1) => snare.gain;
            //Sitar Controls
            Std.mtof(phryg[Math.random2(0,phryg.cap()-1)]) => sitar.freq;
            sitar.noteOn(Math.random2f(0.4,1.0));
            //Sine Osc 3 droning the tonic.
            Std.mtof(37) => sine_osc_3.freq;
            0.5=>sine_osc_3.gain;
     
            //Drum Controls
            Math.random2f(60.0, 128.0) => shaker.objects;
            Math.random2f(.8,1.0) => shaker.decay;
            shaker.noteOn (Math.randomf());
            1.0 => shaker.energy;
            
            <<<"loop 1">>>;
            beattime::second => now;

        }
        ///Start using just a couple scale notes
        for( 0 => int i; i < phryg_mel1.cap(); i++ )
        {
            //Sitar Controls
            Std.mtof(phryg_mel1[Math.random2(0,phryg_mel1.cap()-1)]) => sitar.freq;
            sitar.noteOn(Math.random2f(0.4,1.0));
            //Sine Osc 3 droning the tonic.
            Std.mtof(40) => sine_osc_3.freq;
            0.5=>sine_osc_3.gain;
            
            //Drum Controls
            Math.random2f(60.0, 128.0) => shaker.objects;
            Math.random2f(.8,1.0) => shaker.decay;
            1.0 => shaker.noteOn;
            1.0 => shaker.energy;

            <<<"loop2" >>>;
            beattime::second => now;
          }
        ///some different notes
        for( 0 => int i; i < phryg_mel2.cap(); i++ )
        {
            //SndBuf
            0=>click.pos;
            0=>snare.pos;
            Math.random2f(0.0, 0.1) => click.gain;
            Math.random2f(0.0, 0.1) => snare.gain;
            //Sitar Controls
            Std.mtof(phryg_mel2[Math.random2(0,phryg_mel2.cap()-1)]) => sitar.freq;
            sitar.noteOn(Math.random2f(0.4,1.0));
            //Sine Osc 3 droning the 2nd.
            Std.mtof(38) => sine_osc_3.freq;
            0.5=>sine_osc_3.gain;
            
            //Drum Controls
            Math.random2f(60.0, 128.0) => shaker.objects;
            Math.random2f(.8,1.0) => shaker.decay;
            1.0 => shaker.noteOn;
            1.0 => shaker.energy;
            
            <<<"loop3" >>>;
            beattime::second => now;
        }
        ///Finish loops with some different notes
        for( 0 => int i; i < phryg_mel3.cap(); i++ )
        {
            //Sitar Controls
            Std.mtof(phryg_mel3[Math.random2(0,phryg_mel3.cap()-1)]) => sitar.freq;
            sitar.noteOn(Math.random2f(0.4,1.0));
            //Sine Osc 3 droning the tonic.
            Std.mtof(37) => sine_osc_3.freq;
            0.5=>sine_osc_3.gain;
            
            //Drum Controls
            Math.random2f(60.0, 128.0) => shaker.objects;
            Math.random2f(.8,1.0) => shaker.decay;
            1.0 => shaker.noteOn;
            1.0 => shaker.energy;
            
            <<<"loop4" >>>;
            beattime::second => now;
        }
        //And end on the tonic!
        Std.mtof(49) => sitar.freq;
        0.6 =>sitar.gain;
        sitar.noteOn(1.0);
        1.5::second =>now;



<<<"the end">>>;


}