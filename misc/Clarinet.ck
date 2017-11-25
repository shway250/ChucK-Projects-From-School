//sound chain
Flute f => dac;

440 => f.freq;

while( true )
{
    Math.random2f(0.1,1.0) => f.noteOn; //start blowing random amounts of air
    Math.random2f(0.1,1.0) => f.jetDelay;//Change embouchere
    0.2::second => now;
    
    1=> f.noteOff;
    0.5::second => now;
}