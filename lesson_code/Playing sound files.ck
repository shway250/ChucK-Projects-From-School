SndBuf my => dac;

me.dir() => string path;
"/audio/snare_01.wav" => string filename;

path+filename => filename;

filename => my.read;

0.5 => my.gain;

0 => my.pos;

3::second => now;
