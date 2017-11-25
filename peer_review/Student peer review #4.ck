// Author: Vincenti Zghra Trying out quartertonal scales in ChucK

// sound systems
SawOsc lh => dac;
SinOsc rh => dac;

// assigning some starting point frequencies and volumes
438.0 => float x;
x => lh.freq;
x => rh.freq;
// x will be used later to calculate the next frequency in the harmonic series of quartertones
0.03=> lh.gain;
0.1 => rh.gain;
0.03 => float y;
// starting to go through the first 24 intervals with a constant A=438
for (0 => int i;i < 24;i++)
{
    // printing out the current frequency
    <<< x >>>;
    // calculating the next frequency
    x*Math.pow(2,1.0/24.0) => rh.freq;
    // storing this frequency for the next iteration
    x*Math.pow(2,1.0/24.0) => x;
    // if the note is the octave!
    if (i == 23)
    {
        // play some dotty rhythms in a crecendo fashion 9 times!!
        for (0 => int f; f <= 8; f++)
        {
            // a rest!
            0 => rh.gain;
            0.08::second => now;
            // modest volume increase
            y+0.04 => y;
            y => rh.gain;
            // very short notes
            0.01::second => now;
        }
        // reversing the formula on the octave to get the octave back
        x/Math.pow(2,1.0/24.0) => x;
    }
    0.3::second => now;
}
// with a reversed formula we can play the scale backwards!
for (0=> int i; i<24;i++)
{
    // same as before
    <<< x >>>;
    x/Math.pow(2,1.0/24.0) => lh.freq;
    x/Math.pow(2,1.0/24.0) => x;
    0.125::second => now;
}

<<< "tada!" >>>;
