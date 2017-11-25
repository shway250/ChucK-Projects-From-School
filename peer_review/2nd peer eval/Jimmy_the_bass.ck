//Assignment_6_Bad_rehearsals

// Jimmy_the_bass.ck

// sound chain (mandolin for bass)
Mandolin bass => LPF filter => NRev r => dac;

// parameter setup
0.02 => r.mix;
0.01 => bass.stringDamping;
0.009 => bass.stringDetune;
0.02 => bass.bodySize;
.3 => bass.gain;
(1000,1) => filter.set;

//counters and timing
int bass_counter;
now => time start;
.625::second => dur pulse;
pulse*4 => dur bar;
.99 => float gate_length;
1.3 => float swing;


//patterns
[0,51,58, 60, 61, 63, 65,61,63,0,0,0,53,0,0,51] @=> int bass_pat2[];
[0,51,58, 60, 61, 63, 65,61,63,58,0,0,0,0,53,0,0,51] @=> int bass_pat3[];
[0,65,65, 0, 65, 0, 65,0,63,58,0,0,53,0,0,51] @=> int bass_pat4[];
bass_pat2 @=> int bass_pat[];


while (true){
    
    //The conditionals tell Jimmy when to switch pattern and what to say!
    if (now-start >= 2*bar){
        bass_pat3 @=> bass_pat;
    }
    if (now-start >= 4*bar+pulse){
        bass_pat2 @=> bass_pat;
    }
    if (now-start >= 6*bar+pulse){
        bass_pat4 @=> bass_pat;
    }
    if (now-start >= 8*bar+pulse){
        bass_pat2 @=> bass_pat;
    }
    if (now -start == 2*bar + 2*pulse){
        <<<"Jimmy: Hey man, you added a quarter note!!! Drummers, they're like monkeys...">>>;
    }
    if (now -start == 2*bar + 3*pulse){
        <<<"Jimmy: I'll add a pause...">>>;
    }
    if (now -start == 5*bar + 3*pulse){
        <<<"Jimmy: And now the other genius...">>>;
    }
    if (now -start == 5*bar + 3*pulse){
        <<<"Jimmy: Mike, you fool, you anticipated your part!! One eigth later you tool!">>>;
    }
    if (now -start == 8*bar + 1*pulse){
        <<<"Jimmy: Better now...">>>;
    }
    if (now -start == 11*bar + 2*pulse){
        <<<"Jimmy: Yeah he is! Unbelievable!">>>;
    }
    if (now -start == 12*bar + 1*pulse){
        //Jimmy had enough of this  bulls**, he is leaving (the shred exits)
        <<<"Jimmy: F*** you guys! I'm leaving! Go to hell!">>>;
        me.exit();
    }

//plays the notes in the pattern
    if (bass_pat[bass_counter]!= 0.){
        Math.mtof(bass_pat[bass_counter]-12) => bass.freq;
        1 => bass.noteOn;
    }    
    
    //reinitializes the counter if all the notes of the pattern are played
    if (bass_counter < bass_pat.cap()-1 ) bass_counter++;
    else 0 => bass_counter;
    
    
    //Time advance with swing!
    if (bass_counter % 2 == 0){
        pulse/2*(2.-swing)*gate_length => now;
        1 => bass.noteOff;
        pulse/2*(2.-swing)*(1-gate_length) => now;
    }
    else{
        pulse/2*(swing)*gate_length => now;
        1 => bass.noteOff;
        pulse/2*(swing)*(1-gate_length) => now;
    }
}





