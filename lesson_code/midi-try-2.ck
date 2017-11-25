// Setup MIDI input, set a port number, try to open itMidiIn min;
// MIDI Port (ChucK Menu: Window > Device Browser > MIDI > Input)3=>int port;
// open the port, fail gracefullyif(!min.open(port))
{    <<<"Error: MIDI port did not open on port: ",port>>>;    me.exit();}
// holder for received messagesMidiMsg msg;

// make an instrument to playRhodey piano =>dac;
// loop
while(true)
{    min=>now;
// advance when receive MIDI msg    while(min.recv(msg))    { 
<<<msg.data1,msg.data2,msg.data3>>>; 
if (msg.data1 == 144){ 
    Std.mtof(msg.data2) =>piano.freq; 
    msg.data3/127.0 =>piano.gain;     1 =>piano.noteOn;
}     else {     1 =>piano.noteOff;      } 
}}





