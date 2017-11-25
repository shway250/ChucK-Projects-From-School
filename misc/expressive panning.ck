//sound chain
SinOsc s => Pan2 p => dac;//Pan2 is our panning object

//initialize pan position value
1.0 => float panPosition;

//loop
while( panPosition > -1.0 )
{
    panPosition => p.pan; //pan value
    <<<panPosition >>>;
    panPosition -.01 => panPosition; //each loop with decrease by .01
    .01::second => now; //advance time
}