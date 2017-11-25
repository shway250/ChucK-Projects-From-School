// FILENAME: score.ck
// Title: Assignment 6 Bb Aeolian Band
// composition files  

me.dir() + "/oscs.ck" => string oscFile;
<<< "osc = ", oscFile >>>;
Machine.add(oscFile) => int oscID;


1.5::second => now;

me.dir() + "/drums.ck" => string drumFile;
<<< "drums = ", drumFile >>>;
Machine.add(drumFile) => int drumID;
Machine.add(me.dir() + "/bass.ck") => int bassID; 
Machine.add(me.dir() + "/flute.ck") => int fluteID;


//Machine.remove(drumID);
//Machine.remove(bassID);
//Machine.remove(fluteID);
//Machine.remove(pianoID);