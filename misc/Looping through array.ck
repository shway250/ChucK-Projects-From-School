//sound chain
SqrOsc s => dac;

//array declaration
[54,56,62,54,48,50,52] @=> int A[];
[.5,.2,.4,.6,.5,.3,.4] @=> float notes[];

//A.cap() is max number of elements in A[]
<<<A.cap()>>>;


//loop
for( 0 => int i; i < A.cap(); i++)
{
    <<<i, A[i]>>>; // print index and i
    Std.mtof(A[i]) => s.freq;//MIDI to frequency
    notes[i]::second =>now;//array notes[] decides time passage
}