//sound chain
Noise nois =>  ADSR env => Delay d => dac;
(0.005::second, 0.001::second, 0.0, 0.001::second ) => env.set;
d => d; //feedback loop
0.99 => d.gain;
0.005::second => d.delay;
1 => env.keyOn;
2::second => now;






/*while( true )
{
    Math.random2f(0.01,1.0)::second => now;
    1.0 => imp.next;
}
*/