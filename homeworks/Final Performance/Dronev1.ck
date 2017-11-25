///sound chain
Pan2 master => dac;

SinOsc mod2;
SinOsc mod1;
SinOsc sin1;

mod2 => ADSR mod2env => mod1;
mod1 => ADSR mod1env => sin1;
sin1 => ADSR sin1env => NRev reverb => master;

mod2env.set(7::second, 5::second, 0.3, 3::second);
mod1env.set(3::second, 4::second, 0.6, 5::second);
sin1env.set(0.3::second, 0.1::second, 0.5, 0.6::second);


//reverb params
0.1 => reverb.mix;

///global variables
146.83 => float tonic;

//main program
for( 0 => int i; i < 3; i++ )
{
    (tonic)*2 => sin1.freq;
    0.4=> sin1.gain;
    2 => sin1.sync;
    1=> sin1env.keyOn;
    
    (tonic*2)*1.5 => mod1.freq;
    500 => mod1.gain;
    2 => mod1.sync;
    1=> mod1env.keyOn;
    
    (tonic*2)*1.75 => mod2.freq;
    300 => mod2.gain;
    2 => mod2.sync;
    1=> mod2env.keyOn;
    
    <<<i>>>;
    15::second => now;
    
}

for( 0 => int i; i < 3; i++ )
{
    (tonic)*2 => sin1.freq;
    0.4=> sin1.gain;
    2 => sin1.sync;
    1=> sin1env.keyOn;
    
    (tonic*2)*1.5 => mod1.freq;
    Math.random2(200,500) => mod1.gain;
    2 => mod1.sync;
    1=> mod1env.keyOn;
    
    (tonic*2)*1.75 => mod2.freq;
    Math.random2(300,400) => mod2.gain;
    2 => mod2.sync;
    1=> mod2env.keyOn;
    
    <<<i>>>;
    15::second => now;
    
}


