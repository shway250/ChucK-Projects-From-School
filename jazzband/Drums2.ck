//Assignment_6_" not really jazz"


//drums.ck

//sound chain
SndBuf hihat => dac;
SndBuf Kick => dac;

// me.dir(-1)
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;
me.dir(-1) + "/audio/kick_01.wav" => Kick.read;

// globalTime will set time of composition using While loop
now + 15::second => time globalTime;

//loop
while(now < globalTime)
{
    //Hi Hat bidness
    Math.random2f(0.1,0.3) => hihat.gain;
    Math.random2f(.9,1.2) => hihat.rate;
    //Kick bidness
    Math.random2f(0.1,0.2) => Kick.gain;
    Math.random2f(.5,1.0) => Kick.rate;
    .625 * Math.random2f(0.95,1.05) ::second => now;
    0 =>hihat.pos;
    0 =>Kick.pos;

} 