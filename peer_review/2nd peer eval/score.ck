//Assignment_6_Bad_rehearsals

// score.ck

// paths to chuck files
me.dir() + "/Jimmy_the_bass.ck" => string bassPath;
me.dir() + "/Sean_the_drums.ck" => string drumsPath;
me.dir() + "/Mike_the_guitar.ck" => string guitarPath;

//Some timing variables
.625::second => dur pulse;
pulse*4 => dur bar;
now => time start;

//These guys need a metronome, they just started...
fun void metronome(){
    SndBuf click => dac;
    0.4 => click.gain;
    me.dir(-1) + "/audio/snare_03.wav" => click.read;
    click.samples() => click.pos;
    0 => int i;
    while (now - start< 30*bar){
        0 => click.pos;
        pulse => now;   
    }
}

//Sporking the initial click
spork ~metronome();
bar => now;

//Jimmy and Sean start playing!
Machine.add(bassPath) => int bassID;
Machine.add(drumsPath) => int drumsID;

4*bar + pulse => now;
//And now Mike arrives
Machine.add(guitarPath) => int guitarID;

//Time advance to keep the child shred alive (the metronome...)
8.5*bar => now;



