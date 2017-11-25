///BLAH!


["beat","beat","beat","beat","beat","beat"] @=> string loop1[];
.25::second => dur q;
[q, q, q, q, q, q] @=> dur loop2[];


for ( 0 => int i; i < 6; i++)
{

<<< loop1[i] >>>;

loop2[i]=>now;
}