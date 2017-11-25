//Assignment_1_Blurps_and_Pieces.ck
// Sound Network
SinOsc s => dac;
TriOsc t => dac;
SqrOsc r => dac;
// Setting Sine and Triangle Volume
0.3 => s.gain;
0.3 => t.gain;
0.1 => r.gain;
// Setting Sine, Triangle and Square frequency
220 => s.freq;
50 => t.freq;
51 => r.freq;
// Setting blurpThreshold
300 => int blurpThreshold;
// Setting the globalTime variable which determines the length of composition
now + 30::second => time globalTime;
// Initializing  probability variable
1 => int chance;
// Main Loop
while(now < globalTime) {
    
    // Setting first loop duration
    now + 12::second => time later;
    
    // First part loop
    while(now < later) {
        // Turn off Sine and Square waves
        0 => r.gain;
        0 => s.gain;
        //Turn on Triangular wave
        0.3 => t.gain;
        //Choose random frequency for Triangular wave
        Math.random2(50, 60) => t.freq;
        // Play Triangle wave
        .25::second => now;
        // Determines if Square wave plays
        Math.random2(0,1) => chance;
        if(chance == 1) {
            0.1 => r.gain;
            Math.random2(30, 40) => r.freq;
        }
        else {
            0 => r.gain;
        }
        // Turn on Sine wave
        0.5 => s.gain;
        //Choose a random value for the threshold of blurp
        Math.random2(300, 1000) => blurpThreshold;
        // Make a Blurp
        for(50 => int i; i < blurpThreshold; i++) {
            i => s.freq;
            .001::second => now;
        }
        // Play Sine wave with increased frequency for .25 of a second
        1200 => s.freq;
        .25::second => now;
        0.5 => s.gain;
        .25::second => now;
        
        
    }
    // Setting second part duration
    now + 18::second => later;
    
    // Second part loop
    while(now < later) {
        // Determine if Square wave is turned on
        Math.random2(0,1) => chance;
        Math.random2(90, 100) => t.freq;
        if(chance == 1) {
            // Turn on Square wave
            0.1 => r.gain;
            // Choose random frequency for Square wave
            Math.random2(50, 60) => r.freq;
        }
        else {
            // Turn off Square wave
            0 => r.gain;
        }
        //Turn on Sine and Triangular waves
        0.3 => s.gain;
        0.3 => t.gain;
        //Choose a random value for the threshold of blurp
        Math.random2(300, 1000) => blurpThreshold;
        // Make a blurp
        for(200 => int i; i < blurpThreshold; i++) {
            i => s.freq;
            i - 100 => t.freq;
            .001::second => now;
        }
        // Turn off Sine and Triangular waves for 1 second
        0 => s.gain;
        0 => t.gain;
        1::second => now;
        // Change Sine and Triangular waves frequency and volume and play them for .25 of a second
        0.3 => s.gain;
        0.3 => t.gain;
        440 => s.freq;
        85 => t.freq;
        .25::second => now;
        // Change Sine and Triangular waves frequency and play them for .25 of a second
        880 => s.freq;
        85 => t.freq;
        .25::second => now;
        // Change Sine and Triangular waves frequency and play them for .25 of a second
        1760 => s.freq;
        85 => t.freq;
        3::second => now;
    }
    
}
// The End
