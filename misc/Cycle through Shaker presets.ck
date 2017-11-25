//sound chain
Shakers shak => dac;

for( 0 => int i; i < 23; i++)
{
    i => shak.preset;
    1.0 => shak.noteOn;
    1.0::second =>now;
    
}