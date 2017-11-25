public class BPM
{
    // Global member vaira bles
    dur myDur[4];
    static dur quarterNote, eighthNote, sixteenthNote, thirtysecondNote;
    
    fun void tempo( float beat )
    {
        ///beat is BPM, example 120 beats per minute
        60.0/(beat) => float SPB; //second per beat
        SPB::second => quarterNote;
        quarterNote*0.5 => eighthNote;
        eighthNote*0.5 => sixteenthNote;
        sixteenthNote*0.5 => thirtysecondNote;
        
        //store data in array
        [quarterNote, eighthNote, sixteenthNote, thirtysecondNote] @=> myDur;
    }
}