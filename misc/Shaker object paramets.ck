//sound chain
Shakers shak => dac;

17 => shak.preset;// quarters in a mug
while( true )
{
    Math.random2f(0.0,128.0 ) => shak.objects
    Math.random2f(0.0, 1.0) => shak.decay;
    1.0 => shak.energy;
    1.0::second =>now;
    
}