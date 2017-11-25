// Date: Oct. 23rd

// sound network

// print out title of assignment 1
<<< "Assignment 1 - Playing with randomness" >>>;

// sine oscillator foo
SinOsc foo => dac;
// Triangle oscillator bar
TriOsc bar => dac;

// Define some variables to be used in the loop
now + 5::second => time section;
now + 30::second => time finish;
100 => int freq;
500::ms => dur advance;
1 => int turn;

// loop for 30 seconds
while (now < finish) {
    // every 5 seconds is a section
    if (now < section) {
        while (now < section) {
            // generate a random frequency between freq and 500+freq
            Math.random2f( freq, 500 + freq) => float foofreq;
            foofreq => foo.freq;
            // generate a random gain between 0.2 and 0.8
            Math.random2f(0.2, 0.8) => foo.gain;
            
            // assign a major third of foofreq to bar.freq
            foofreq * 1.2599 => bar.freq;
            Math.random2f(0.2, 0.8) => bar.gain;
            
            // let the two oscs play for "advance" amount of time
            advance => now;
            
            // decide whether the amount of "advance" should be
            // increased or reduced
            if (turn) {
                advance - 20::ms => advance;
            } else {
                advance + 20::ms => advance;
            }
            
            // increase the base frequency every time
            // if it goes beyond threshold, rewind back
            freq + 10 => freq;
            if (freq > 10000)
                freq - 9900 => freq;
            
            // If the amount of "advance" goes beyond or below
            // Threshold, switch it's going direction
            if (advance < 1::ms) {
                1::ms => advance;
                0 => turn;
            }
            if (advance > 500::ms)
                1 => turn;
        }
    } else {
        // the program reaches here every 5 seconds
        section + 5::second => section;
    }
}
