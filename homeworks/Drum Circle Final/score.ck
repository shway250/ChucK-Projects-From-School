//score.ck

//put in score bidness for copy and pasting.
1::second => now;

//kick
Machine.add(me.dir() + "/Dronev1.ck") => int droneID;
1::second => now;

Machine.remove(droneID);
1::second => now;
