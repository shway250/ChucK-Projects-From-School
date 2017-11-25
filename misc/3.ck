chugl gfx;
gfx.openWindow(512, 512);
gfx.width() => float WIDTH;
gfx.height() => float HEIGHT;

chuglImage img;
img.load(me.dir()+"hand.jpg");

while(true)
{
    gfx.translate(WIDTH/2, HEIGHT/2);
    img.draw( -100, -100, 200, 200);
}