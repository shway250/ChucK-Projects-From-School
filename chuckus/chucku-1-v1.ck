//sound chain line
SndBuf s=>Pan2 m=>dac;"special:twopeaks"=>s.read;Math.random2f(-1.0,1.0)=>m.pan;
