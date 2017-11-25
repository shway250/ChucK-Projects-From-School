// poly.ck
// date: 2015-3-2
// Spencer Salazar | ssalazar@calarts.edu
// Example of polyphonic synthesizer with keyboard controller. 
// This program needs spencethizer.ck to be sporked first, as it defines the Spencethizer chubgraph. 

// maximum number of simultaneous voices/notes
// increase to have more simultaneous voices
// decrease to have better performance
16 => int NUM_VOICES;

// array of available voices
// initially every item here is an available voice
// NB: can replace Spencethizer with any ugen/public chubgraph that has setFreq/keyOn/keyOff
JacksonTable poly[NUM_VOICES];
// map of MIDI key => voice
// initially every item is null, i.e. just a placeholder
// this makes sense because no keys are pressed at program start!
JacksonTable @ keys[127];

// initialize each voice
for(0 => int i; i < poly.size(); i++)
{
    // connect to dac
    poly[i] => dac;
    // set gain somewhat low to compensate for multiple voices
    0.3 => poly[i].gain;
}

// midi input
MidiIn min;
// midi message
MidiMsg msg;
// change this the name of your MIDI device
// or the device number (from chuck --probe)
// (but using the name is nicer)
min.open("MPK49");

// infinite loop
while(true)
{
    // get MIDI input
    min => now;
    while(min.recv(msg))
    {
        // Compare upper 4-bits (& 0xF0) of data1 to the upper 4-bits of a noteOn message.
        // & 0xF0 zeros-out the lower 4-bits (which is the midi channel),
        // thereby ignoring MIDI channel information.
        if((msg.data1 & 0xF0) == 0x90) // noteOn = 0x9c (where c is the channel)
        {
            <<< "noteOn", msg.data2 >>>;
            
            // get note
            msg.data2 => int note;
            // get available voice to use
            // store in reference
            getVoice(note) @=> JacksonTable @ voice;
            if(voice != null)
            {
                // set frequency of voice
                note => Std.mtof => voice.freq;
                // trigger voice
                voice.keyOn();
            }
        }
        // compare upper 4-bits (& 0xF0) of data1 to the upper 4-bits of a noteOff message
        // & 0xF0 zeros-out the lower 4-bits (which is the midi channel),
        // thereby ignoring MIDI channel information.
        else if((msg.data1 & 0xF0) == 0x80) // noteOff = 0x8c (where c is the channel)
        {
            <<< "noteOff", msg.data2 >>>;
            
            // get note
            msg.data2 => int note;
            // set voice for this note as available
            putBack(note);
        }
    }
}

// -- function --
// fun Spencethizer getVoice(int note)
// Get the next available voice, to play the specified note. 
// An available voice is one that is not currently triggered
// and is not associated with any other note. 
// Returns null if no voice is available. 
fun JacksonTable getVoice(int note)
{
    // placeholder for the voice, if we find one
    JacksonTable @ voice;
    // placeholder for the index of the voice in poly (if we find one)
    0 => int index;
    
    // search through all voices in poly for first available. 
    // if poly[i] is not null, then poly[i] is considered available. 
    for(0 => int i; i < poly.size(); i++)
    {
        if(poly[i] != null)
        {
            // found a voice; track it in placeholder variables
            poly[i] @=> voice;
            i => index;
            break;
        }
    }
    
    if(voice == null)
    {
        // TODO: some way to "steal" a voice from a currently playing note
        // if there is no voice that is legimately available
    }
    
    // if we found a voice...
    if(voice != null)
    {
        // mark it as unavailable
        null @=> poly[index];
        // store the voice and associate it with the note that it is playing
        voice @=> keys[note];
    }
    
    // return voice (if any)
    return voice;
}

// -- function --
// fun void putBack(int note)
// Put back the voice associated with note (if any) back into the pool of available voices. 
// This will also keyOff the voice for this note. 
fun void putBack(int note)
{
    // lookup voice for this note
    keys[note] @=> JacksonTable @ voice;
    // if it exists...
    if(keys[note] != null)
    {
        // turn it off (triggering ADSR release, etc.) 
        voice.keyOff();
        // find first available slot in poly
        // i.e. the first slot that is null
        for(0 => int i; i < poly.size(); i++)
        {
            if(poly[i] == null)
            {
                // stash the voice back here
                voice @=> poly[i];
                break;
            }
        }
        
        // this clears the association between this note and this voice
        null @=> keys[note];
    }
}

