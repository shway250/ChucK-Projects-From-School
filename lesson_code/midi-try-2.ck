// Setup MIDI input, set a port number, try to open it
// MIDI Port (ChucK Menu: Window > Device Browser > MIDI > Input)

{


// make an instrument to play


{
// advance when receive MIDI msg
<<<msg.data1,msg.data2,msg.data3>>>; 
if (msg.data1 == 144){ 
    Std.mtof(msg.data2) =>piano.freq; 
    msg.data3/127.0 =>piano.gain;
}
}




