now + 5::second => time later;

while( now < later )
{
    //print out
    <<< "time left", (later-now)/second >>>;
    //advance time
    1::second => now;
}

<<<"IT'S NOW BITCH!!!">>>;

SinOsc foo => dac;
880 => foo.freq;
2::second => now;