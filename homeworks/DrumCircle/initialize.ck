//initialize.ck 
<<<"Jackson 'hey, does anyone want to do lazer tag this weekend?' Duhon" >>>;

//classes here
Machine.add(me.dir()+"/BPM.ck");

// add score.ck
me.dir() + "/score.ck" => string scorePath;
Machine.add(scorePath);