//score.ck

// paths to chuck files

me.dir() + "/poem.ck" => string poemPath;
me.dir() + "/bass.ck" => string bassPath;
me.dir() + "/drums.ck" => string drumsPath;
me.dir() + "/piano.ck" => string pianoPath;


//start poem
Machine.add(poemPath) => int poemID;
0.01::second => now;

//start drums
Machine.add(drumsPath) => int drumsID;
7.8::second => now;

//start bass
Machine.add(bassPath) => int bassID;
3.9::second => now;

//start piano
Machine.add(pianoPath) => int pianoID;
7.8::second => now;

//remove piano
Machine.remove(pianoID);
3.9::second => now;

//start piano
Machine.add(pianoPath) => pianoID;
7.8::second => now;

//remove piano
Machine.remove(drumsID);
Machine.remove(bassID);
Machine.remove(pianoID);
Machine.remove(poemID);
3.9::second => now;