// stereo.ck
// sound chain
SndBuf stereo => dac;

// load files
me.dir(-1) + "/audio/stereo_fx_02.wav" => stereo.read;

0 => stereo.pos; // set stereo to 0
4::second => now; // advance in time