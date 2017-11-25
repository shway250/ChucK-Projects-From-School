//////////////////////////////Jackson Duhon/////////////////////
<<< "A Sigh Meant Won" >>>;
<<< "By Jackson Duhon" >>>;

//Sound Network
SinOsc s1 => dac;
SinOsc s2 => dac;
SinOsc s3 => dac;
TriOsc t1 => dac;

//establishing freq, and gain variables for easy composition//
//I might not even use all of these, but I just want them at
//my finger tips.
//Bunch of "As"
110 => int LA1;
220 => int LA2;
440 => int MA;
880 => int HA;

//Bunch of "Cs"
130.813 => float LC1;
261.626 => float LC2;
523.251 => float MC;
1046.502 => float HC;

//Some Gain Presets
0.2 => float LowGain;
0.4 => float MyGain;
0.7 => float HiGain;



/////////////////Starting Gain Values////////////////
0.0 => s1.gain;
0.0 => s2.gain;
0.0 => s3.gain;
0.0 => t1.gain;

//////////composition////////////

//Start out with a frequency sweep
for( 100 => int i; i < 1000; i++)
{
    i => s1.freq;
    i/1.5 => s2.freq;
    i*1.25 => s3.freq;
    LowGain => s1.gain;
    LowGain => s2.gain;
    LowGain => s3.gain;
    .009::second => now;   
}


//Play a note, mute s3
LA1 => s1.freq;
LA1*1.5 => s2.freq;
0.0 => s3.gain;
.65::second => now;

//mute notes
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Play a shorter note, bring gain of oscillators back up
LA1 => s1.freq;
LowGain => s1.gain;
LowGain => s2.gain;
.50::second => now;

//mute again
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Frequency Sweep w/ Tri Osc.
for( 600 => int i; i < 1000; i++)
{
 i => t1.freq;//i sent to t1 freq
 MyGain => t1.gain;//medium gain for t1
 0.0 => s2.gain;//muting the sine waves
 0.0 => s1.gain;
 .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}
//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

/////////////////////////Repeat last theme/////////////////////////
//Play a note, mute t1, turn gain back on for s1, s2
LA1 => s1.freq;
LA1*1.5 => s2.freq;
LowGain => s1.gain;
LowGain => s2.gain;
0.0 => t1.gain;
.65::second => now;

//mute notes
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Play a shorter note, bring gain of oscillators back up
LA1 => s1.freq;
LowGain => s1.gain;
LowGain => s2.gain;
.50::second => now;

//mute again
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Frequency Sweep w/ Tri Osc.
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}
//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

///////////////////////Same idea, different note///////////////
//Play a note, mute t1, turn gain back on for s1, s2
LC1 => s1.freq;
LC1*1.5 => s2.freq;
LowGain => s1.gain;
LowGain => s2.gain;
0.0 => t1.gain;
.65::second => now;

//mute notes
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Play a shorter note, bring gain of oscillators back up
LC1 => s1.freq;
LowGain => s1.gain;
LowGain => s2.gain;
.50::second => now;

//mute again
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Frequency Sweep w/ Tri Osc.
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}
//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

////////////////////////////Next note////////////////////////
//Play a note, mute t1, turn gain back on for s1, s2
LC1 => s1.freq;
LC1*1.5 => s2.freq;
LowGain => s1.gain;
LowGain => s2.gain;
0.0 => t1.gain;
.65::second => now;

//mute notes
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Play a shorter note, bring gain of oscillators back up
LC1 => s1.freq;
LowGain => s1.gain;
LowGain => s2.gain;
.50::second => now;

//mute again
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Frequency Sweep w/ Tri Osc.
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}
//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}

//mute
0.0 => t1.gain;
.05::second => now;

//repeat same sweep
for( 600 => int i; i < 1000; i++)
{
    i => t1.freq;
    MyGain => t1.gain;
    0.0 => s2.gain;
    0.0 => s1.gain;
    .0009::second => now;   
}
/////////////////////Finish by repeating first phrase/////
//Play a note, bring s1 and s2 gain back up, mute t1
LA1 => s1.freq;
LA1*1.5 => s2.freq;
LowGain => s1.gain;
LowGain => s2.gain;
0.0 => t1.gain;
.65::second => now;

//mute notes
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Play a shorter note, bring gain of oscillators back up
LA1 => s1.freq;
LowGain => s1.gain;
LowGain => s2.gain;
.50::second => now;

//mute again
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Downward Frequency Sweep w/ Tri Osc.
for( 1000 => int i; i > 600; i-1 => i)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//Another downward frequency sweep
for( 1000 => int i; i > 600; i-1 => i)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//Another downward frequency sweep
for( 1000 => int i; i > 600; i-1 => i)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//Another downward frequency sweep
for( 1000 => int i; i > 600; i-1 => i)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

//Another downward frequency sweep
for( 1000 => int i; i > 600; i-1 => i)
{
    i => t1.freq;//i sent to t1 freq
    MyGain => t1.gain;//medium gain for t1
    0.0 => s2.gain;//muting the sine waves
    0.0 => s1.gain;
    .001::second => now;   
}

///mute stuff out
0.0 => t1.gain;
.05::second => now;

///end with one long note
//Play a note, bring s1 and s2 gain back up, mute t1
LA1 => s1.freq;
LA1*1.5 => s2.freq;
LowGain => s1.gain;
LowGain => s2.gain;
0.0 => t1.gain;
.65::second => now;

//mute notes
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

//Play a shorter note, bring gain of oscillators back up
LA1 => s1.freq;
LowGain => s1.gain;
LowGain => s2.gain;
.50::second => now;

//mute again
0.0 => s1.gain;
0.0 => s2.gain;
.05::second => now;

LA1 => s1.freq;
LA2 => s3.freq;
LowGain => s1.gain;
LowGain => s2.gain;
LowGain => s3.gain;
4::second => now;

<<< "THE END…SUCKAS!!!!!!!!!!" >>>;