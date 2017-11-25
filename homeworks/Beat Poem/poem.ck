//AAAAAAAAAW YEAH!!! POEMS Y'ALL!!!
["dark winter night","I feel my soul, and stuff", "drip drip DRIPPING"," "] @=> string loop1[];
["like a prism prison", "and other metaphors", "and awesome alliteration"," "] @=> string loop2[];
["MAYA ANGELOU!!!!","MAYA ANGELOU!!!!","MAYA ANGELOU!!!!","MAYA ANGELOU!!!!"] @=> string loop3[];
["and Allen Ginsberg", "You saw the best minds of your generation do stuff?","yeah?","was the hard for you?"] @=> string loop4[];
["WELL TOUGH TITTIES!", "YOU DIDN'T EVEN HAVE TO LIVE THROUGH THE BUSH ADMINISTRATION YOU POSER!","GO LISTEN TO YOUR BEBOP RECORDS!","AND TAKE A BUNCH OF BENNIES!"] @=> string loop5[];
["I'm sorry", "That got out of hand", "like the hand of god", "and other metaphors"]@=> string loop6[];

//set time parameter
1.2::second => dur set;

//time array
[set,set,set,set] @=> dur read[];

//reading it out
while( true )
{
    //loop 1
    for ( 0 => int i; i < 4; i++)
    {
        <<< loop1[i] >>>;
        read[i]=>now;
    }
    //loop2
    for ( 0 => int i; i < 4; i++)
    {
        <<< loop2[i] >>>;
        read[i]=>now;
    }
    //loop3
    for ( 0 => int i; i < 4; i++)
    {
        <<< loop3[i] >>>;
        read[i]=>now;
    }
    //loop4
    for ( 0 => int i; i < 4; i++)
    {
        <<< loop4[i] >>>;
        read[i]=>now;
    }
    //loop5
    for ( 0 => int i; i < 4; i++)
    {
        <<< loop5[i] >>>;
        read[i]=>now;
    }
    //loop6
    for ( 0 => int i; i < 4; i++)
    {
        <<< loop6[i] >>>;
        read[i]=>now;
    }





        
}