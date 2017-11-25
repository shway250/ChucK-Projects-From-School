//Assignment_6_Bad_rehearsals

// Mike_the_guitar.ck

// sound chain 
HevyMetl guitar => Chorus chorus => NRev rev => Pan2 master  => dac;

// parameter setup
0.01 => rev.mix;
.2 => chorus.modFreq;
.1 => chorus.modDepth;
.3 => chorus.mix;
-.4 => master.pan;
.8 => master.gain;

//timings and counter
int guitar_counter;
now => time start;
.625::second => dur pulse;
4*pulse => dur bar;
//two variables for playing the guitar
.99 => float gate_length;
1.3 => float swing;


[0,0,0, 0, 0, 0, 0,0,0,0,0,53,0,0,0,51] @=> int guitar_pat[]; //wrong one Mike! =)
[0,0,0, 0, 0, 0, 0,0,0,0,0,0,53,0,0,51] @=> int guitar_pat2[]; // Better now...


while (true){
    //These conditionals tell Mike when to switch pattern and what to say
    if ( now - start >= 2*bar){
        guitar_pat2 @=> guitar_pat;
    }
    if ( now - start == 2*bar-pulse){
        <<<"Mike:Ok man, ok! Chill out! Here you go!">>>;
        <<<"Mike (whispering): Pain in the a**!">>>;
    }
    if( now - start == 6*bar+2*pulse){
        <<<"Mike: Hey Sean, you drunk?">>>;
    }
    if( now - start == 7*bar){
        <<<"Mike: Crap Jimmy, he's really drunk!!">>>;
    }
    if (now - start == 9*bar-2*pulse ){
        //Mike had enough of this  bulls**, he is leaving (the shred exits)
        <<<"Mike: I'm leaving too... F** you Sean!">>>;
        me.exit();
    }

    
    //Plays the notes in the pattern with random velocities
    if (guitar_pat[guitar_counter % guitar_pat.cap()]!= 0.){
        Math.mtof(guitar_pat[guitar_counter % guitar_pat.cap()]) => guitar.freq;
        Math.random2f(.6,.9) => guitar.noteOn;
    }
    
    //update the counter
    guitar_counter++;
    
    //Here the time advance happens, the swing parameter controls... the swing! =)
    if (guitar_counter % 2 == 0){
        pulse/2*(2.-swing)*gate_length => now;
        1 => guitar.noteOff;
        pulse/2*(2.-swing)*(1-gate_length) => now;
    }
    else{
        pulse/2*(swing)*gate_length => now;
        1 => guitar.noteOff;
        pulse/2*(swing)*(1-gate_length) => now;
    }
}





