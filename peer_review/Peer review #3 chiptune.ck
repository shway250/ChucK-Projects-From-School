<<< "Assignment_1_Bad_Chiptune_Song_42" >>>;

// Setup : create 4 cool oscillators
SinOsc s => dac;
TriOsc t => dac;
SinOsc lead => dac;
SawOsc saw => dac;
0 => saw.gain; // Shut this one up for now


// Init some variables
65.40 => float tfreq; 
0.01 => float tgain;
0.0 => float lgain;
0.15 =>  float sgain; 
349.228 => float lst_note;


// Fixing exact 30 second period of time for our song
now + 30::second => time comp_t;

// Ticking parameters
// Well..I think should be more simple way..
// but for now I made a bunch of tickers, with different mesaure
0 => int m;   // Ticks like (0 1 2 3 4 5 6 7 8 9 10 11 ...)
0 => int k2;  // m modulo 2 (0 1 0 1 0 1 0 1 0 ...)
0 => int k3;  // m modulo 3 (0 1 2 0 1 2 0 1 2 0 1 2 ...)
0 => int k4;  // m modulo 4 (0 1 2 3 0 1 2 3 0 1 2 3)
0 => int k9;  // m modulo 9 
0 => int k10; // m modulo 10  

while ( now < comp_t ) { // This will run for 30 secs
    
    m++; 
    k2++;  if (k2 > 1) { 0 => k2; }
    k3++;  if (k3 > 2) { 0 => k3; }  
    k4++;  if (k4 > 3) { 0 => k4; } 
    k9++;  if (k9 > 8) { 0 => k9; }
    k10++; if (k10 > 9) { 0 => k10; }
    
    ///////// Lead(Sin) /////////////////////////////////////////////
    
    // Lead gain
    if (m > 80) { // fades out after 80th
        if (lgain > 0.01) {
            0.005 -=> lgain; // fade out
        } 
    }
    else {
        if (lgain < 0.3) {
            0.005 +=> lgain; // fade in form start         
        }
    }
    lgain => lead.gain;
    
    // Lead melody, supersimple, maybe later guys will explain how to deal with notes, arpedgios and so on
    if ( k4 == 0 ) { 
        523.251 => lead.freq; // C5 - freq took from wikipedia =)
    } else if (k4 == 1){
        493.883 => lead.freq; // B       
    } else if (k4 == 2) {
        440.000 => lead.freq;  // A
    } else { 
        if (m != 23 ) { 
            lst_note => lead.freq; // Note changes 
            1.06 /=> lst_note; 
            if ( k3 == 1 ) {
                349.228 => lst_note;
            } 
            if ( m > 40 && m < 50) {
                523.251 => lead.freq;
            }
        } else {
            523.251 => lst_note;  
            lst_note => lead.freq;
        }
    } 
    
    /////// Tri //////////////////////////////////////////////////////// 
    
    // Depending on part of song, prepare TriOsc variables
    if ( m < 50 ) {
        if (tgain < 0.05) {
            0.005 +=> tgain; // fade in
        }
    } else {
        if (tgain > 0) {
            0.005 -=> tgain; // fade out           
        }
    }
    
    if ( k2 == 0 ) { 
        523.251 => tfreq;
    } else {
        440.883 => tfreq;
        0.12 *=> tfreq;
    } 
    
    // Set TriOsc variables to parameters
    tfreq => t.freq;
    tgain => t.gain; 
    
    /////// Beat ////////////////////////////////////////////////////////
    
    // Main beat on each 3rd before 68th tick
    if ((k3 == 1 && m < 68) || m == 43) { 
        
        // Woo-woo-woo-woo fx bass
        0.5 => s.gain; 
        4 => int wo_count;
        if ( m == 1 ) { 6 => wo_count; 0.8 => s.gain;} 
        if ( m == 43 ) { 8 => wo_count; } 
        for ( 0 => int b ; b < wo_count ; b++ ) {
            60 => int i;
            while ( i < 80 )
            {
                i*1.2 => s.freq;
                6.5::ms => now;
                if ( m == 1 || m == 43 ) { i*1.6 => s.freq; 6.5::ms => now; } 
                i++;
            }
        }
        
        // Psh-h-h fx beat fades from 60th tick
        if ( m > 58 ) {
            if (sgain > 0.01) {
                0.01 -=> sgain; // fade out
            }
        }
        sgain => s.gain;
        now + 150::ms => time pshh_t;
        while (now < pshh_t) {
            Math.random2f(50,15000) => s.freq;
            5::samp => now;
        }
        0 => s.gain;
        
        // Making pause
        10::ms => now; 
    }
    
    
    if ( (k9 == 7 || k9 == 3) && (m < 68) && (m > 13)) { // Second beat
        0.2 => saw.gain;// Saw on!
        now + 120::ms => time saw_t;
        while (now < saw_t ) {
            Math.random2f(50,15000) => saw.freq;
            5::samp => now;
        } 
        0 => saw.gain;
    } else {
        if ( m > 68 ) {
            100::ms => now;
        } else {
            120::ms => now;         
        }
    }
    
}
