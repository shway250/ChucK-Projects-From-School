dac => WvOut2 w => blackhole; 
"chuck-session" => w.autoPrefix; 
"special:auto" => w.wavFilename; 
<<<"writing to file: ", w.filename()>>>; 
.5 => w.fileGain; 
null @=> w;

me.dir() + "/myfile.ck" => string filename;

Machine.add(filename);

while( true ) 1::second => now; 
