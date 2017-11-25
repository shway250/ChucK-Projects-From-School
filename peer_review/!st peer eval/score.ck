// Playing the score

//Loading Paths to the chuckfiles

me.dir()+ "/piano.ck" => string pianoPath;
me.dir()+ "/drums.ck" => string drumsPath;
me.dir()+ "/bass.ck" => string bassPath;
me.dir()+ "/flute.ck" => string flutePath;

//Setting up the sound

//Starting with the chords

Machine.add(pianoPath) => int pianoID;
3.75::second => now;

//Adding the Drums

Machine.add(drumsPath) => int drumsID;
3.75::second => now;

//Adding the Bass

Machine.add(bassPath) => int bassID;
3.75::second => now;

// Finally adding the solo

Machine.add(flutePath) => int soloID;
7.5::second => now;

//removing Melody

Machine.remove(soloID);
3.75::second => now;

//removing the bass

Machine.remove(bassID);
3.75::second => now;


//removing the drums

Machine.remove(drumsID);
3.75::second => now;

//removing the chords

Machine.remove(pianoID);




