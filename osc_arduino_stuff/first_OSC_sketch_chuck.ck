//Create OSC input
OscIn oscin;
//Create OSC message
OscMsg msg;

//set our port from myRemoteLocation from Processing
12000 => oscin.port;
//tell OSC In to listen to all
oscin.listenAll();

int x;
int y;

fun void oscPoller()
{
    while(true)
    {
        //wait for the osc event
        oscin => now;
        //if there is a message extract them
        while(oscin.recv(msg) != 0)
        {
            //check our message address
            if(msg.address =="/mouse")
            {
                //extract data
                msg.getInt(0) => x;
                msg.getInt(1) => y;
                <<<x, y>>>;
            }
        }
    }
}

//spork your function
spork ~ oscPoller();

//let's make sound
SinOsc sinx => dac;
SinOsc siny => dac;

while(true)
{
    x => sinx.freq;
    y => siny.freq;
    1::second => now;
}