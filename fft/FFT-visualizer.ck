adc => FFT fft => blackhole;
2048 => fft.size;
Windowing.hann(fft.size()/2) => fft.window;

chugl gfx;
gfx.openWindow(512,512);
gfx.width() => float WIDTH;
gfx.height() => float HEIGHT;

gfx.hsv(Math.random2f(0, 1), Math.random2f(0.7, 0.9), Math.random2f(0.7, 0.9));

while(true)
{
    fft.upchuck();
    for(0 => int i; i < fft.size()/2; i++)
    {
        (i$float)/(fft.size()/2)*WIDTH => float x;
        fft.fval(i) => float mag;
        100+20*Math.log10(mag) => float magdB;
        magdB/100.0*HEIGHT => float y;
        gfx.line(x, 0, x, y);
    }
    (1.0/30.0)::second => now;
}