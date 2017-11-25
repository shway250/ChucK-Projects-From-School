// score.ck

// paths to chuck files
me.dir() + "/piano.ck" => string pianoPath;
me.dir() + "/bass.ck" => string bassPath;
me.dir() + "/drums.ck" => string drumsPath;
me.dir() + "/stereo.ck" => string stereoPath;
me.dir() + "/spork.ck" => string sporkPath;

Machine.add(stereoPath) => int stereoID; // add stereo
4::second => now;

Machine.add(drumsPath) => int drumsID; // add drums
5::second => now;

Machine.remove(drumsID); // remove drums

// start piano
Machine.add(bassPath) => int bassID; // add bass
4::second => now;

Machine.add(stereoPath) => stereoID; // add stereo

// start drums
Machine.add(drumsPath) => drumsID;  // add drums
10::second => now;

Machine.remove(bassID);  // remove basss
 
Machine.add(sporkPath) => int sporkID;  // add spork
6::second => now;

Machine.remove(sporkID); // remove spork

Machine.add(bassPath) => bassID; // add bass
8::second => now;

Machine.remove(bassID); // remove bass
5::second => now;

Machine.remove(drumsID); // remove drums









