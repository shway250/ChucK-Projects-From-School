//Assignment_6_Bad_rehearsals

// Sean_the_drums.ck

//timing and counters
.625::second => dur pulse;
pulse*4 => dur bar;
int drum_counter;
int hihat_counter;
int snare_counter;
int kick_counter;
1.3 => float swing;
now => time start;

//a bus reverb
NRev busReverb => dac;
1 => busReverb.mix;

//kick, no reverb
SndBuf kick => Pan2 kick_pan => Pan2 master => dac;
me.dir(-1) + "/audio/kick_01.wav" => kick.read;
kick.samples() => kick.pos;

//snare goes to both reverb and pan
SndBuf snare => Pan2 snare_pan => master;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
snare.samples() => snare.pos;
snare => Pan2 snare_bus => busReverb;
//I don't like much the snare samples, so i decided to add some filtered noise
Noise snare_noise => LPF snare_filter=> ADSR noise_env => snare_pan;
//noise_env => snare_bus;
(2::ms, 100::ms, 0, 0::ms) => noise_env.set;
(5500,1) => snare_filter.set;

//hihat goes to pan and reverb
SndBuf hihat => Pan2 hihat_pan => master;
me.dir(-1) + "/audio/hihat_02.wav" => hihat.read;
hihat.samples() => hihat.pos;
hihat => Pan2 hihat_bus => busReverb;

//setting the relative gains
.1 =>hihat_pan.pan;
.3 =>hihat.gain;
.85 => snare.rate;
.5 => snare_noise.gain;
2 => snare.gain;
.3 => snare_pan.pan;
.3 => master.gain;

//Amount of reverb on the different parts of the drumset
.09 => snare_bus.gain;
.1 => hihat_bus.gain;

//Some patterns
[1,0,1,0,1,1,0,0] @=> int kick_pat[];
[0,0,1,0] @=> int snare_pat[];
[1] @=> int hihat_pat[];

[1,0,1,0,1,1,0,0] @=> int kick_pat1[];
[0,0,1,0] @=> int snare_pat1[];
[1] @=> int hihat_pat1[];

[1,1,1,1] @=> int snare_pat2[];
[1,1,1,1,1,1,1,1] @=> int kick_pat2[];


//I told you Sean has a serious problem, after bar 8 his alcohol level increases linearly...
fun float drunkenness(){
     return Math.min((now-start-8*bar)/bar/40,pulse/1::second*.2);
}
  

while (true){
    //These tell Sean what pattern to play
    if (now-start >= 4*bar && now-start < 5*bar){
        snare_pat2 @=> snare_pat;
        kick_pat2 @=> kick_pat;
    }
    else if (now-start >= 5*bar){
        snare_pat1 @=> snare_pat;
        kick_pat1 @=> kick_pat;
    }
    
    //this part plays the drums!
    if(kick_pat[kick_counter]==1){
        0 => kick.pos;
    }
    if(snare_pat[snare_counter]==1){
        0 => snare.pos;
        1 => noise_env.keyOn;
    }
    if(hihat_pat[hihat_counter]==1){
        //also some random panning of hihats
        Math.random2f(-.6,-.2) => hihat_pan.pan;
        0 => hihat.pos;
    }
     
    
     
    //At the second bar this wreck of a drummer adds a quarter...    
    if (now -start == 2*bar+pulse){
        0 => hihat_counter;
        0 => snare_counter;
        0 => kick_counter;
    }
     
    //...and complains about insults from Jimmy...  
    if (now -start == 4*bar){
        <<<"Sean: Who are you calling monkey?! You a**hole! this is for you, weirdo!">>>;
    }
    
    //resetting the counter after the patterns are played
    if (hihat_counter < hihat_pat.cap()-1 ) hihat_counter++;
    else 0 => hihat_counter;
    if (snare_counter < snare_pat.cap()-1 ) snare_counter++;
    else 0 => snare_counter;
        if (kick_counter < kick_pat.cap()-1 ) kick_counter++;
    else 0 => kick_counter;
    
    
    //time advance with swing        
    if (now - start < 8*bar){
        if (kick_counter % 2 == 0 ){
            pulse/2*(2.-swing) => now;
        }
        else{
            pulse/2*swing => now;
        }
    }
    //Sean's alcoholism is kicking in...
    else if (now - start < 12 *bar){
       
        if (kick_counter % 2 == 0 ){
            pulse/2*(2.-swing)+ Math.random2f(-drunkenness(),drunkenness())::second => now;
        }
        else{
            pulse/2*swing+Math.random2f(-drunkenness(),drunkenness())::second => now;
        }
    }
    else{
        //he can't stand it any more and collapses on the floor...
        <<<"Sean: Don't leave meeeee! I want more beeeeeer!">>>;
        me.exit();
    }
       
}


