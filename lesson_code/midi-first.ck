// MIDI out setup, make a MidiOut object, open it on a device MidiOutmout;MidiOut mout;

////midi port4=>int port;
// try to open that port, fail gracefully
if(!mout.open(port)) 
{<<<"Error: MIDI port did not open on port: ",port>>>;me.exit();}
// Make a MIDI msg holder for sending
MidiMsg msg;
// utility function to send MIDI out notesfun void MIDInote(int onoff,int note,int velocity)
{if(onoff==0){
    128=>msg.data1; 
}
else{
    144=>msg.data1;
}
note => msg.data2;velocity => msg.data3; 
mout.send(msg);}// loopwhile(true){Math.random2(60,100)=>int note;
Math.random2(30,127)=>int velocity;
MIDInote(1,note,velocity); 
.1::second=>now; 
MIDInote(0,note,velocity); 
.1::second=>now;}













