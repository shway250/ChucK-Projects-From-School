adc => FFT fft =^ Centroid cent => blackhole;
fft =^ RMS rms;
fft =^ RollOff roff50 => blackhole;


0.5 => roff50.percent;



OscOut osc;
//port I'm sending to
osc.dest("localhost", 12001);

512 => fft.size;

Windowing.hann(512) => fft.window;

/////THIS IS HOW YOU GET YOUR SAMPLING RATE!!!!////////
second/ samp => float srate;

while(true)
{
    //grab value from FFT and stores in in array
    cent.upchuck();
    //call rms
    rms.upchuck() @=>UAnaBlob blob;
    
    roff50.upchuck();
    //send rms to processing
    oscOut("/rms",Std.rmstodb(blob.fval(0)));
    
    oscOut("/rolloff50", roff50.fval(0));
    
    //we call our first array value
    //<<< cent.fval(0)*(srate/2.0) >>>;
    
    //call osc function
    oscOut("/centroid", cent.fval(0) * 360);
    fft.size()::samp =>now;
    
}

fun void oscOut(string addr, float val)
{
    osc.start(addr);
    osc.add(val);
    osc.send();
}







