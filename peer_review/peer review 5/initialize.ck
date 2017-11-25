// FILENAME: initialize.ck
// Title: Assignment 6 Bb Aeolian Band
<<< "Assignment 6 Bb Aeolian Band">>>;

// ************************************************************************ 
// ASSIGNMENT REQUIREMENTS
// 
// * Create a 30 second composition using concurrency.  
// 
// * Use at least 4 .ck files: initialize.ck, score.ck, and at least 2 composition files 
// 
// * ONLY use these MIDI Notes in your composition: 46, 48, 49, 51, 53, 54, 56, 58 (the Bb Aeolian mode). 
//   You can use octaves above/below by multiplying/dividing Frequency by 2 or adding/subtracting 12
// 
// * Make quarter Notes (main compositional pulse) 0.625::second in your composition
// 
// * -- The first line should include a comment in the first line of each file that 
//      informs your peer how that file should be renamed.
//   -- Your second line should be the title of your piece.
//      If your peer cannot correctly rename files according to the comments, your program will not run. 
//      Please make sure that the title in the comment correctly reflects the title used in the path for Machine.add().
//      For example, in your initialize.ck file, your first two lines of code should appear as follows:
//             // initialize.ck
//             // Assignment_6_ChucK_Corea (or whatever you would like to use as your title)
// 
//   --  Use the same formatting for your score.ck file, and for your 2 or more composition .ck files. 
// 
// *  Use of Machine.add() to launch files
// *  Use of spork ~ to call functions concurrently
// *  Use of Oscillator
// *  Use of SndBuf
// *  Use of at least one STK instrument
// *  Use of at least one STK audio effect (e.g. Chorus, Delay, JCRev)
// *  Use of if/else statements
// *  Use of for loop or while 
// *  Use of variables
// *  Use of comments
// *  Std.mtof()
// *  Random Number
// *  Use of Arrays
// *  Use of Panning
// *  Use of right timing (0.625::second quarter notes)
// *  Use of right melodic notes (Bb Aeolian scale)
// *  Use of at least one hand-written function
// **************************************************************************************************


// Add score file
me.dir() + "/score.ck" => string scoreFile;
<<< "score = ", scoreFile >>>;

Machine.add(scoreFile);

now + 30::second => time endsong;

while(now < endsong) { 1::second => now; }
