SndBuf s=>Pan2 m=>dac;
while(1)
{
    Math.random2f(-1.0,1.0)=>m.pan;
    Math.sin((4::ms=>now)/pi::ms)=>s.rate;
    Math.random2(0,1)=>int x;
    if(x==0){
        "special:twopeaks"=>s.read;
    }
    else{
        "special:dope"=>s.read;
    }
    25::ms=>now;
}

//try changing the time chucked to now for different effects.