//Assignment_6_" not really jazz"


//score.ck

// paths to chuck files
me.dir() + "/piano2.ck" => string pianoPath;
me.dir() + "/bass2.ck" => string bassPath;
me.dir() + "/drums2.ck" => string drumsPath;
me.dir() + "/moog.ck" => string moogPath;

//start piano
Machine.add(pianoPath) => int pianoID;
2.5::second => now;

//start drums
Machine.add(drumsPath) => int drumsID;
5::second => now;

//start bass
Machine.add(bassPath) => int bassID;
5::second => now;

//remove piano
Machine.remove(pianoID);
2.5::second => now;

//start moog solo
Machine.add(moogPath) => int fluteID;
5::second => now;

//start piano
Machine.add(pianoPath) => pianoID;
2.5::second => now;

//remove drums
Machine.remove(drumsID);
5::second => now;

//start drums
Machine.add(drumsPath) => drumsID;
5::second => now;