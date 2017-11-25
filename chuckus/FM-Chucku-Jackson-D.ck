SinOsc s=>dac;SinOsc a=>s;SinOsc d=>s;SinOsc f=>a;1=>s.gain;99=>a.gain;
while(1){for(45=>int i;i<500;i++){Math.random2(1,7)=>int x;i=>s.freq;i*x=>a.freq;
i*x=>d.freq;i*x=>f.freq;250=>d.gain;250=>f.gain;100::ms=>now;}}