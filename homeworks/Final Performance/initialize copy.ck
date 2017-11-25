//initialize.ck

//put classes here
Machine.add(me.dir()+"/BPM.ck");


//add score.ck
me.dir()+"/score.ck" => string scorePath;
Machine.add(scorePath);