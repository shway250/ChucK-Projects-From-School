// Create Osc Input object
OscIn oscin;
// Create osc message
OscMsg msg;
// Set our port from myRemote Location from Processing
12000 => oscin.port;
// Tell OscIn to listen to all messages
oscin.listenAll();
// Creat variables to store our incoming values
int x;
int y;
float z;
float q;
// Create a function we can spork that will listen for our messages
fun void oscPoller()
{
    // We want our function to run without stopping so we use while(true)
    while(true)
    {
        // wait for the osc event
        oscin => now;
        
        // if there is message extract them
        while( oscin.recv(msg) != 0)
        {
            // check our essage address
            if(msg.address == "/snow")
            {
                // extract data
                msg.getInt(0) => x;
                msg.getInt(1) => y;
                msg.getInt(2) => z;
            }
        }
    }
}
// Spork our Poller
spork ~ oscPoller();
// Let's make sound
TriOsc sinx => dac;
TriOsc siny => dac;
while(true)
{
    ///use OSC variables to control sound parameters
    x*y => sinx.freq;
    y*x => siny.freq;
    z => sinx.gain, siny.gain;
    75::ms => now; 
}