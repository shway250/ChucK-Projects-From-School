<<< "Apeggatorsaurous" >>>;

// First element in the array is not used so as to fit the note intervals 
[0, 51, 53, 55, 56, 58, 60, 61, 63] @=> int mA[];
// Chords array [ChordPosition I, V, IV etc],[NotePosition in that chord]
[[1, 2, 3, 4, 5],[5, 6, 7, 8, 2], [6, 7, 8, 2, 3], [4, 5, 6, 7, 8]] @=> int Chord[][];

SinOsc Bass => Pan2 p => dac;
TriOsc Melody =>  Pan2 p2 => dac;
Gain BeatMaster => dac;
SndBuf beat =>  BeatMaster;

.65::second => dur Qua;              // For the beat
.065::second => dur ApeggerTime;     // For the apeggio
0 => float SecondsPassed;
now/second => float TimeCapture;
0::second => dur BassTimeKeeper;

// Path of sound files...
"/audio/kick_02.wav" => string loadable;
me.dir() + loadable => beat.read;

// Setting environment...
0.2 => Melody.gain;
0.1 => Bass.gain;
0.8 => beat.gain;
0.8 => BeatMaster.gain;
0 => p.pan;
1.0 => p2.pan;

// Kicking off da notes in Root position
Std.mtof(mA[Chord[0][0]]) => Bass.freq;

fun void Update(dur timeValue)
{
    // Exit if 30 seconds passed
    if(SecondsPassed > 30)
        return;
    if(SecondsPassed < 2)
    {
        // Bringing 'em those noise!
        (SecondsPassed/2) * 0.2 => Melody.gain;
        (SecondsPassed/2) * 0.1 => Bass.gain;

    }
    else if(SecondsPassed > 28)
    {
        // Gettin 'em out!
        0.2 - (SecondsPassed-28)/2 * 0.2 => Melody.gain;
        0.1 - (SecondsPassed-28)/2 * 0.1 => Bass.gain;
    }
    else
    {
        // Setting 'em fine
        0.2 => Melody.gain;
        0.1 => Bass.gain;
    }
    
    // Timing dat beat
    BassTimeKeeper - timeValue => BassTimeKeeper;
    if(BassTimeKeeper <= 0::second)
    {    
        Qua => BassTimeKeeper;
        0 => beat.pos;
    }
    
    // Flip those pa- I mean pan them!
    Math.sin(now/timeValue/pi/2) => p2.pan;
    timeValue => now;
    now/second - TimeCapture => SecondsPassed;
}


fun float RandomNote(int _whichChord)
{
    // Return random notes within the Chord Position and half the freq(an octave lower)
    return Std.mtof(mA[Chord[_whichChord][Std.rand2(0,4)]])/2;
}
fun void UpscaleApeggio(int _whichChord, int _octave, int _count)
{
    // Runnnnnnnnnning up da chord
    Std.mtof(mA[Chord[_whichChord][0]] + _octave) => Melody.freq;
    Update(ApeggerTime);
    Std.mtof(mA[Chord[_whichChord][2]] + _octave) => Melody.freq;
    Update(ApeggerTime);
    Std.mtof(mA[Chord[_whichChord][4]] + _octave) => Melody.freq;
    Update(ApeggerTime);
    if(_count > 0)
    {
        // Until we are up da defined hill
        UpscaleApeggio(_whichChord, _octave + 12, --_count);        
    }
}

fun void DownscaleApeggio(int _whichChord, int _octave, int _count)
{
    // Rollllllllllllling down da chord
    Std.mtof(mA[Chord[_whichChord][4]] + _octave) => Melody.freq;
    Update(ApeggerTime);
    Std.mtof(mA[Chord[_whichChord][2]] + _octave) => Melody.freq;
    Update(ApeggerTime);
    Std.mtof(mA[Chord[_whichChord][0]] + _octave) => Melody.freq;
    Update(ApeggerTime);
    if(_count > 0)
    {
        // Until we hit da floor
        DownscaleApeggio(_whichChord, _octave - 12, --_count);        
    }
}
fun void FullApeggio(int _whichChord, int _octave, int _count)
{
    // Run up!
    UpscaleApeggio(_whichChord,0,_count);
    // The apex note!
    Std.mtof(mA[Chord[_whichChord][0]] + (1 + _count) * 12) => Melody.freq;
    Update(ApeggerTime);            // Update to hear the apex sound!
    
    // Roll down!
    DownscaleApeggio(_whichChord,12*_count,_count);
}

// Keep rollin' until we finish 29s. The 30th second will be faded out by the update wayyy above
while(SecondsPassed < 29)
{
    // Play the apeggio in the chord then change the bass note
    FullApeggio(0,0,2);
    RandomNote(0) => Bass.freq;
    
    FullApeggio(1,0,2);
    RandomNote(1) => Bass.freq;
    
    FullApeggio(2,0,2);
    RandomNote(2) => Bass.freq;
    
    FullApeggio(3,0,2);
    RandomNote(3) => Bass.freq;
}
<<< "...Exit Sequence..." >>>;