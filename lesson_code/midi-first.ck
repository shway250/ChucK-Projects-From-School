// MIDI out setup, make a MidiOut object, open it on a device MidiOutmout;

////midi port

if(!mout.open(port)) 
{

MidiMsg msg;

{
    128=>msg.data1; 
}
else{
    144=>msg.data1;
}
note => msg.data2;
mout.send(msg);
Math.random2(30,127)=>int velocity;
MIDInote(1,note,velocity); 
.1::second=>now; 
MIDInote(0,note,velocity); 
.1::second=>now;












