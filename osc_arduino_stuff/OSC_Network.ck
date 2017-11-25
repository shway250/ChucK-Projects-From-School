//prefix for sending messabges
"/chuck" => string prefix;

//osc send to hub
OscSend xmit;

//set address to send to owen
xmit.setHost("169.254.11.219", 8000);
xmit;

//Me!!!!! My address
8002 => int incoming; //me
OscRecv recv;
incoming => recv.port;
recv.listen();

<<<"listening for messages on port:", incoming>>>;



fun void listen()
{
    recv.event("/chuck", "i") @=> OscEvent oe;
    int id;
    
    while(1)
    {
        oe => now;
        
        while(oe.nextMsg() !=0)
        {
            oe.getInt() => int id;
            <<<id>>>;
        }
    }
}

spork ~ listen();

fun void send()
{
    while(1)
    {
        xmit.startMsg(prefix, "i");
        //I'm JACKSON!!!
        2 => xmit.addInt;
        1::second =>now;
    }
}

spork ~ send();

while(true)
{
    1::second => now;
}

