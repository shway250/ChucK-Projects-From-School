/*
* Assignment_5_d2Ftb0E1
* @course 'Coursera - Introduction to Programming for Musicians and Digital Artists - Fall 2013'
* @date 20131124
* @author ****
* @title 'Phrygian Phugetta'
*****************************************
Assignment 5: Unit Generators

requirements:
Use of Oscillator
Use of SndBuf
Use of at least one STK instrument
Use of if/else statements
Use of for loop or while 
Use of variables
Use of comments
Std.mtof()
Random Number
Use of Arrays
Use of Panning
Use of right timing (.75::second quarter notes)
Use of right melodic notes (Db Phrygian scale)
Use of hand-written functions

*/

/*
* debug - set to 1 for debug
*/
0 => int _debug;

/*
* seed random number generator
*/
1618 => Math.srandom;

/*
* Phrygian scale
*/
[49, 50, 52, 54, 56, 57, 59, 61] @=> int Db_PHRYGIAN_MIDIS[];

/*
******* scores
*/
//expo
[45, 52, 54, 50, 49, 56, 57, 54, 52, 59, 61, 57] @=> int expo_mult[];
[57, 61, 59, 52, 54, 57, 56, 49, 50, 54, 52, 59] @=> int expo_vln[];

//episode
[50, 50, 49, 49, 47, 47, 45, 45] @=> int ep_bass[];
[53, 53, 52, 52, 50, 50, 49, 49] @=> int ep_cel[];
[57, 57, 56, 56, 54, 54, 52, 52] @=> int ep_vla[];
[54, 57, 61, 52, 56, 59, 50, 49] @=> int ep_vln[];

//coda
[45, 52, 54, 50, 45] @=> int coda[];

//score lengths
expo_mult.cap() => int EXPO_CAP;
ep_bass.cap() => int EP_CAP;
coda.cap() => int CODA_CAP;

//octave shifts
-12 => int bass_shift;
0 => int cel_shift;
12 => int vla_shift;
24 => int vln_shift;

/*
******** tempo
*/
0.75::second => dur Q_NOTE;

/*
********************* functions
*.

/*
* functions to return note durations
*
* @return - a duration based on the global value of Q_NOTE
*/
fun dur n_1() { return Q_NOTE * 4; }//end fun n_1
fun dur n_2() { return Q_NOTE * 2; }//end fun n_2
fun dur n_4() { return Q_NOTE; }//end fun n_4
fun dur n_dot_8() { return 3 * Q_NOTE / 4; }//end fun n_dot_8
fun dur n_8() { return Q_NOTE / 2; }//end fun n_8
fun dur n_16() { return Q_NOTE / 4; }//end fun n_16

/*
* tapBaton
*
* mimick sound of tapping on music stand with baton
* loads a specific sound file, makes some adjustments to the seetings, and plays
*
* @taps - number of times to tap
* @note_dur - duration of tap cycle
*/
fun void tapBaton(int taps, dur note_dur)
{
    //quick parameter check
    if( taps < 1 || note_dur/second < 0 )
    {
        <<<"Please enter valid parameters">>>;
        return;
    }//end if
    
    //sound chain
    SndBuf sb => NRev rev=> dac;
    //set gain and reverb
    1.1 => sb.gain;
    0.001 => rev.mix;
    
    //load and set up sound file
    me.dir() + "/audio/click_02.wav" => sb.read;
    sb.samples() => sb.pos;
    3 => sb.rate;
    
    //play 
    for( 0 => int i; i < taps; i++ )
    {
        0 => sb.pos;
        note_dur => now;
    }//end for
}//end fun tapBaton

/*
* playTimpani
*
* creates and plays a sound chain to mimick a timpani
*
* @hits - number of times to hit
* @note_dur - duration of hit cycle
* @midi - midi note 
*/
fun void playTimpani( int hits, dur note_dur, int midi )
{
    //sound chain
    TubeBell tb => ResonZ rz => dac;
    
    //filter
    0.003 => tb.lfoSpeed;
    0.6 => tb.lfoDepth;
    
    //gain
    1.3 => tb.gain;
    
    //set freq
    midi => Std.mtof => tb.freq;
    
    //set filter freq
    (midi, 5) => rz.set;//freq, Q
    5 => rz.gain;
    
    //play sound
    for( 0 => int i; i < hits; i++ )
    {
        1 => tb.noteOn;
        0.9::note_dur => now;
        1 => tb.noteOff;
        0.1::note_dur => now;
    }//end for
}//end fun playTimpani

/*
* cycloPan
*
* moves pan back and forth from side to side in increments
*
* @cyclopan - global variable
* @cycloArr[0] has signed float for direction and amount of change
*   value changes sign when pan amount reaches limit. [-1.0,1.0]
* @cycloArr[1] has float for pan amount [-1.0,1.0]
* 
*/
fun void cycloPan( Pan2 pn, float cycloArr[] )
{
    //get current pan
    pn.pan() => float pn_p;
    
    //if change is positive
    if( cycloArr[0] > 0 )
    {
        //change direction if at limit
        if( !(cycloArr[1] > pn_p) )
        {
            -1 *=> cycloArr[0];
        }//end if
    }
    else //change is negative
    {
        //change direction if at limit 
        if( !(-cycloArr[1] < pn_p) )
        {
            -1 *=> cycloArr[0];
        }//end if
    }//end if-else 
    
    // update pan 
    cycloArr[0] +=> pn_p => pn.pan;
}//end fun cycloPan

/*
* getNextIndexIndex
*
* get the next index given the current index and the maximum index value
*
* @current_indx - the current index
* @max_indx - the maximum allowed index
*
* @return - a positive integer for the incremented index, or 0 if current is at maximum or for invalid parameters
*/
fun int getNextIndex( int current_indx, int max_indx )
{
    //quick parameter check
    if( current_indx < 0 || max_indx < 0 )
    {
        <<<"Invalid parameters to getNextIndex">>>;
        return 0;
    }//end if
    
    if( max_indx - current_indx > 0 )
    {
        return current_indx + 1;
    }
    else
    {
        return 0;
    }//end if-else
}//end fum getNextIndex

/*
******************** instruments
*/

/*
********* violin
*/
//violin sound chain
SinOsc vln_mod => SawOsc vln_sig => Envelope vln_env => Chorus vln_chor => JCRev vln_rev => Pan2 vln_pan => dac;
//violin is modulated
2 => vln_sig.sync;
6 => vln_mod.freq;
1 => vln_mod.gain;
0.04 => vln_sig.gain;

//violin envelope
1 => vln_env.keyOff;
n_8() => vln_env.duration;

//violin chorus
0.00 => vln_chor.mix;

//violin rev
0.01618 => vln_rev.mix;

//violin pan
0.6 => vln_pan.pan;
//parameter for cycloPan: delta (+/- dir_amt [-1.0, 1.0]), limit [left/right [-1.0,1.0]
[-0.2, 0.6] @=> float vln_pan_cyclo[];

/*
********* viola
*/
//viola sound chain
Bowed vla => BiQuad vla_bqf => Gain vla_gain => JCRev vla_rev => Pan2 vla_pan => dac;
1.0 => vla.gain;
0.2 => vla.bowPressure;
0.1 => vla.bowPosition;
6.0 => vla.vibratoFreq;
0.007 => vla.vibratoGain;
0.3 => vla.volume;
1 => vla.noteOff;

//viola filter
0.99 => vla_bqf.prad;
1 => vla_bqf.eqzs;
0.2 => vla_bqf.gain;

//viola gain
1.0 => vla_gain.gain;

//viola rev
0.03 => vla_rev.mix;

//viola pan
-0.6 => vla_pan.pan;

/*
********* cello
*/
//cello sound chain
SinOsc cel_mod => SawOsc cel_sig => Envelope cel_env => Chorus cel_chor;
cel_chor => NRev cel_rev => LPF cel_lp => Gain cel_gain => Pan2 cel_pan => dac;

//cello is modulated
2 => cel_sig.sync;
6 => cel_mod.freq;
0.3 => cel_mod.gain;
0.7 => cel_sig.gain;

//cello envelope
1 => cel_env.keyOff;
n_8() => cel_env.duration;

//cello chorus
0.01618 => cel_chor.mix;

//cello rev
0.01618 => cel_rev.mix;

//cello filter
3000 => cel_lp.freq;
0.7 => cel_lp.Q;

//cello gain
0.1 => cel_gain.gain;

//cello pan
0.6 => cel_pan.pan;

/*
********* bass
*/
//bass sound chain
Bowed bass => BiQuad bass_bqf => Gain bass_gain => JCRev bass_rev => dac;
0.9 => bass.gain;
0.5 => bass.bowPressure;
0.0 => bass.bowPosition;
6.0 => bass.vibratoFreq;
0.01 => bass.vibratoGain;
0.7 => bass.volume;
1 => bass.noteOff;

//bass filter
0.99 => bass_bqf.prad;
1 => bass_bqf.eqzs;
0.1 => bass_bqf.gain;

//bass gain
1 => bass_gain.gain;

//bass rev
0.03 => bass_rev.mix;

/*
******************************** output
*/

//time tracker
now => time start;

//counter and index variables
0 => int count => int bass_indx => int cel_indx => int vla_indx => int vln_indx;

/*
******* attention
*/
tapBaton( 4, n_16() );

//add tapping section to count
count++;

/*
******* expo
*/
while( count < 24 )
{
    //bass
    if( count > 0 )
    {
        //set freq and play
        expo_mult[bass_indx] + bass_shift => Std.mtof => bass.freq;
        0.01 => bass.noteOn;
        //manage bass index
        getNextIndex( bass_indx, EXPO_CAP-1 ) => bass_indx;
    }//end if
    
    //viola
    if( count > 4 )
    {
        //set freq and play
        expo_mult[vla_indx] + vla_shift => Std.mtof => vla.freq;
        0.01 => vla.noteOn;
        //manage viola index
        getNextIndex( vla_indx, EXPO_CAP-1 ) => vla_indx;
    }//end if
    
    //cello
    if( count > 8 )
    {
        //set freq and play
        expo_mult[cel_indx] + cel_shift => Std.mtof => cel_sig.freq;
        1 => cel_env.keyOn;
        //manage cello index
        getNextIndex( cel_indx, EXPO_CAP-1 ) => cel_indx;
    }//end if
    
    //violin
    if( count > 11 )
    {
        //set freq and pan, play
        expo_vln[ Math.random2(0, EXPO_CAP-1) ] + vln_shift => Std.mtof => vln_sig.freq;
        cycloPan( vln_pan, vln_pan_cyclo );
        1 => vln_env.keyOn;
        //fetch next violin index
        getNextIndex( vln_indx, EXPO_CAP-1 ) => vln_indx;
    }//end if
    
    //advance time
    n_dot_8() => now;
    
    //turn cello off
    1 => cel_env.keyOff;
    
    //advance time
    n_16() => now;
    
    //increase count
    count++;
    
    //debug
    if( _debug ) <<<"count:", count>>>;
}//end while

//debug
if( _debug ) <<<"end expo", count>>>;

//reset index variables
0 => bass_indx => cel_indx => vla_indx => vln_indx;

/*
******** episode
*/
while( count < 32 )
{
    //bass
    //set freq and play
    ep_bass[bass_indx] + bass_shift => Std.mtof => bass.freq;
    0.01 => bass.noteOn;
    //fetch next bass index
    getNextIndex( bass_indx, EP_CAP-1 ) => bass_indx;
    
    //viola
    //set freq and play
    ep_vla[vla_indx] + vla_shift => Std.mtof => vla.freq;
    0.01 => vla.noteOn;
    //fetch next viola index
    getNextIndex( vla_indx, EP_CAP-1 ) => vla_indx;
    
    //cello
    //set freq and play    
    ep_cel[cel_indx] + cel_shift => Std.mtof => cel_sig.freq;
    1 => cel_env.keyOn;
    //fetch next cello index
    getNextIndex( cel_indx, EP_CAP-1 ) => cel_indx;
    
    //violin
    //set freq and play
    ep_vln[vln_indx] + vln_shift => Std.mtof => vln_sig.freq;
    1 => vln_env.keyOn;
    //pan
    cycloPan( vln_pan, vln_pan_cyclo );
    //fetch next violin index
    getNextIndex( vln_indx, EP_CAP-1 ) => vln_indx;
    
    //advance time
    n_dot_8() => now;
    
    //turn cello off
    1 => cel_env.keyOff;
    
    //advance time
    n_16() => now;
    
    //increase count
    count++;
    
    //debug
    if( _debug ) <<<"count:", count>>>;
}//end while

//debug
if( _debug ) <<<"end episode", count>>>;

//index variable
0 => int indx;

/*
******* coda
*/
while( count < 38 )
{
    //bass
    //set freq and play
    coda[indx] + bass_shift => Std.mtof => bass.freq;
    0.01 => bass.noteOn;
    
    //viola
    //set freq and play
    coda[indx] + vla_shift => Std.mtof => vla.freq;
    0.01 => vla.noteOn;
    
    //cello
    //set freq and play
    coda[indx] + cel_shift => Std.mtof => cel_sig.freq;
    1 => cel_env.keyOn;
    
    //violin
    //set freq and play
    coda[indx] + vln_shift => Std.mtof => vln_sig.freq;
    1 => vln_env.keyOn;
    //center pan
    0.0 => vln_pan.pan;
    
    //fetch next index
    getNextIndex( indx, CODA_CAP-1 ) => indx;
    
    //advance time
    n_dot_8() => now;
    
    //turn cello off
    1 => cel_env.keyOff;
    
    //advance time
    n_16() => now;
    
    //increase count
    count++;
    
    //debug
    if( _debug ) <<<"count:", count>>>;
}//end while

//debug
if( _debug ) <<<"end coda:", count>>>;

//turn off all instruments
1 => bass.noteOff;
1 => cel_env.keyOff;
1 => vla.noteOff;
1 => vln_env.keyOff;

/*
******* timpani
*/
playTimpani( 1, n_2(), 33 );

//add timpani section to count
2 +=> count;

//debug
if( _debug ) 
{
    <<<"total count:", count>>>;
    <<<"elapsed:", (now-start)/second>>>;
}//end if

//eof
