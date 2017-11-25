//Assignment 8 "Final"

// score.ck
BPM tempo;
tempo.tempo(120.0);

Machine.add(me.dir()+"/kick.ck") => int kickID;
8.0 * tempo.quarterNote => now;

Machine.add(me.dir()+"/snare.ck") => int snareID;
4.0 * tempo.quarterNote => now;

Machine.add(me.dir()+"/hat.ck") => int hatID;
8.0 * tempo.quarterNote => now;

Machine.add(me.dir()+"/clap.ck") => int clapID;
8.0 * tempo.quarterNote => now;

<<< "Set tempo to 110BPM" >>>;
110.0 => float newtempo;
tempo.tempo(newtempo);
8.0 * tempo.quarterNote => now;

<<< "Gradually decrease tempo" >>>;
while (newtempo > 60.0) 
{
    newtempo - 20 => newtempo;
    tempo.tempo(newtempo);
    <<< "tempo = ", newtempo >>>;
    8.0 * tempo.quarterNote => now;
}

Machine.remove(kickID);
Machine.remove(snareID);
Machine.remove(hatID);
Machine.remove(clapID);