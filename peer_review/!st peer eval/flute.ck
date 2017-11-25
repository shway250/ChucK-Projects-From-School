//Flute solist

//soundchain

Flute solo => NRev rev => dac;



// Solo melody

[68,68,68,66,66,66,65,63,61,63,65,66,66,66,68,66,65,63,61,63,60,56,56,56] @=> int melody[];


// Counter variable

0 => int counter1;

// Flute function

fun void melody_p(float beattime)
{
    while (true)
    {
        counter1 % 24 => int beat1;
        melody[beat1] => int ba;
        Std.mtof(ba) => solo.freq;
        0.2 => solo.noteOn;
        counter1++;
        beattime::second => now;
               
    }
     
}

// Playing the sound

while (true)
{
    melody_p(0.3125);
}
