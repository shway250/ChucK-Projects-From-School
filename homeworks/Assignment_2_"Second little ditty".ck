//Assignment NUMERO DOS!!!! "second little ditty"

//Oscillators
SinOsc mod => SinOsc sine_osc_1 => Pan2 sinp => dac;
SinOsc sine_osc_2 =>Pan2 sinp2 => dac;
TriOsc tri_osc_1 => Pan2 trip => dac;
TriOsc tri_osc_2 => Pan2 ptrip2 => dac;

//Quarter note, half note, eigth note durations.
0.25::second => dur q;
0.5::second => dur h;
0.125::second => dur e;

//Bass Medlody Arrays
[38,41,45,48,38,41,45,48,40,43,47,48,38,41,45,48] @=> int Loop1[];
[43,47,50,38,43,47,50,38,47,50,53,45,43,47,50,38] @=> int Loop2[];
//Bass Rhythm Arrays
[h,e,e,q,h,q,e,e,h,q,e,e,h,e,e,q] @=> dur patern_one[];

//Some variable goodness
20=>int intro;

// globalTime will set time of composition using While loop
now + 30::second => time globalTime;

//main loop
while(now < globalTime) {
    0 => sine_osc_2.gain;
    0 => tri_osc_2.gain;
    //Intro thang (yes, thang not thing) Using while loop to sweep up
    //freq for tri oscillator
    while (intro<110.0)
    {
        intro => tri_osc_1.freq;
        1 +=> intro;
        0.1::second => now;
        0 => sine_osc_1.gain;
        Math.sin(now/1::second*2*pi) => trip.pan;
    10::ms =>now;

    }
0 => tri_osc_1.gain;
    //using for loop to play ints in Loop1 Array
    for (0 => int i; i < 16; i++)
    {
        //MIDI to Freq for ints in Array 
        Std.mtof(Loop1[i]) => sine_osc_1.freq;
        0.8 => sine_osc_1.gain;
        //modulator frequency
        Math.random2f(1.0,30.0) => mod.freq;
        //index of modulation
        200 => mod.gain;
        Math.random2f(-0.5,0.5) => sinp.pan;
        Math.sin(now/1::second*2*pi) => sine_osc_1.gain;
        patern_one[i] => now;//patern_one array makes dur for Loop1
                
    }
    
    //using for loop to play ints in Loop1 Array
    for (0 => int i; i < 16; i++)
    {
        Std.mtof(Loop1[i]) => sine_osc_1.freq;
        0.8 => sine_osc_1.gain;
         Math.random2f(-0.5,0.5) => sinp.pan;
         Math.sin(now/1::second*2*pi) => sine_osc_1.gain;
        patern_one[i] => now;//patern_one array makes dur for Loop1
        
            }
    //using for loop to play ints in Loop2 Array
    for (0 => int i; i < 16; i++)
    {
        Std.mtof(Loop2[i]) => sine_osc_1.freq;
        0.8 => sine_osc_1.gain;
        Std.mtof(Loop2[i]) => mod.freq;
        Math.random2f(-0.5,0.5) => sinp.pan;
        Math.tan(now/1::second*2*pi) => sine_osc_1.gain;
        patern_one[i] => now;//patern_one array makes dur for Loop1
        
            }
    //using for loop to play ints in Loop1 Array
    for (0 => int i; i < 16; i++)
    {
        Std.mtof(Loop1[i]) => sine_osc_1.freq;
        0.8 => sine_osc_1.gain;
        Std.mtof(Loop1[i]) => mod.freq;
         Math.random2f(-0.5,0.5) => sinp.pan;
        patern_one[i] => now;//patern_one array makes dur for Loop1
       
    }
    //end with some chords and random panning for a couple of bars
//Tonic    
Std.mtof(50) => sine_osc_1.freq;
0.25 => sine_osc_1.gain;
Math.random2f(-1.0,1.0) => sinp.pan;
//Third
Std.mtof(53) => sine_osc_2.freq;
0.25 => sine_osc_2.gain;
Math.random2f(-1.0,1.0) => sinp2.pan;
//fifth
Std.mtof(57) => tri_osc_1.freq;
0.25 => tri_osc_1.gain;
Math.random2f(-1.0,1.0) => trip.pan;
//seventh
Std.mtof(57) => tri_osc_2.freq;
0.25 => tri_osc_2.gain;
Math.random2f(-1.0,1.0) => trip.pan;
1::second => now;

//Tonic    
Std.mtof(50) => sine_osc_1.freq;
0.25 => sine_osc_1.gain;
Math.random2f(-1.0,1.0) => sinp.pan;
//Third
Std.mtof(53) => sine_osc_2.freq;
0.25 => sine_osc_2.gain;
Math.random2f(-1.0,1.0) => sinp2.pan;
//fifth
Std.mtof(57) => tri_osc_1.freq;
0.25 => tri_osc_1.gain;
Math.random2f(-1.0,1.0) => trip.pan;
//seventh
Std.mtof(57) => tri_osc_2.freq;
0.25 => tri_osc_2.gain;
Math.random2f(-1.0,1.0) => trip.pan;
1::second => now;

//Tonic    
Std.mtof(50) => sine_osc_1.freq;
0.25 => sine_osc_1.gain;
Math.random2f(-1.0,1.0) => sinp.pan;
//Third
Std.mtof(53) => sine_osc_2.freq;
0.25 => sine_osc_2.gain;
Math.random2f(-1.0,1.0) => sinp2.pan;
//fifth
Std.mtof(57) => tri_osc_1.freq;
0.25 => tri_osc_1.gain;
Math.random2f(-1.0,1.0) => trip.pan;
//seventh
Std.mtof(57) => tri_osc_2.freq;
0.25 => tri_osc_2.gain;
Math.random2f(-1.0,1.0) => trip.pan;
1::second => now;
       
 //Tonic    
Std.mtof(50) => sine_osc_1.freq;
0.25 => sine_osc_1.gain;
Math.random2f(-1.0,1.0) => sinp.pan;
//Third
Std.mtof(53) => sine_osc_2.freq;
0.25 => sine_osc_2.gain;
Math.random2f(-1.0,1.0) => sinp2.pan;
//fifth
Std.mtof(57) => tri_osc_1.freq;
0.25 => tri_osc_1.gain;
Math.random2f(-1.0,1.0) => trip.pan;
//seventh
Std.mtof(57) => tri_osc_2.freq;
0.25 => tri_osc_2.gain;
Math.random2f(-1.0,1.0) => trip.pan;
1.5::second => now;
      

}
//The End