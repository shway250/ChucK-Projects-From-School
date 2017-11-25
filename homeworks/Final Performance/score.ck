//score.ck

//put in score bidness for copy and pasting.
1::second => now;

//drone
Machine.add(me.dir() + "/Dronev1.ck") => int droneID;
45::second => now;

//sitar
Machine.add(me.dir() + "/sitar.ck") => int sitarID;
75::second => now;

Machine.remove(droneID);
Machine.remove(sitarID);
1::second => now;
