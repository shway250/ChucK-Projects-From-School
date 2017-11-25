// Score

Machine.add(me.dir() + "/Apeggatorsaurous.ck") => int appegID;
Machine.add(me.dir() + "/drums.ck") => int drumID;
Machine.add(me.dir() + "/bass.ck") => int bassID;
6.5::second => now;

Machine.remove(bassID);
Machine.add(me.dir() + "/piano.ck") => int pianoID;
Machine.add(me.dir() + "/flute.ck") => int fluteID;
6.5::second => now;

Machine.remove(fluteID);
Machine.remove(pianoID);
Machine.add(me.dir() + "/pianosolo.ck") => int pianoSoloID;
6.5::second => now;

Machine.remove(drumID);
Machine.add(me.dir() + "/bass.ck") => bassID;
6.5::second => now;

Machine.remove(pianoSoloID);
4::second => now;

Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(fluteID);
Machine.remove(pianoID);
Machine.remove(pianoSoloID);
Machine.remove(appegID);