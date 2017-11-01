//Midterm Project by Richelle Newby

//This project creates pointillism paintings of four black women
//to the song 'Superwoman' by Alicia Keys

//Pressing 'T' changes the drawing to triangles
//Pressing 'R' changes the drawing to rectangles
//Pressing 'C' changes the drawing to circles

//Clicking the screen changes the painting

//Pressing the spacebar plays/pauses the song

//Inspired by Daniel Shiffman's Pointillism






//Import Minim library
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer song;
FFT         fft;

PImage[] images = new PImage[4]; //array of images

int choice= 0; //allows for choosing different drawing primitives
int imagecount=0;

void setup()
{
    size(640, 827, P3D);
    
    for (int i = 0; i < images.length; i ++ ) {  //loads the images into the array
    images[i] = loadImage( "img" + (i+1) + ".png" );
  }
  


  minim = new Minim(this);
 
 
  
  // specify that we want the audio buffers of the Audiosong
  // to be 1024 samples long because our FFT needs to have 
  // a power-of-two buffer size and this is a good size.
  song = minim.loadFile("Superwoman.mp3", 2048);
  frameRate(1000);
  // loop the file indefinitely
  song.loop();
  
  imageMode(CENTER);
  noStroke();
  background(0);
  
  // creates an FFT object that has a time-domain buffer 
  // the same size as song's sample buffer
 
  fft = new FFT( song.bufferSize(), song.sampleRate() );
  
}

void draw()

//Inspired by Daniel Shiffman's Pointillism 
{
  int x = int(random(images[imagecount].width)); //chooses random x location
  int y = int(random(images[imagecount].height)); //chooses random y location

  color pix = images[imagecount].get(x, y);  //gets the color from a specific location
  fill(pix, 128);
  if (choice==1){
 triangle(x, y, x+5, y+5, x+15, y-1);   //draws triangles
  }
  else if (choice==2){
 ellipse(x, y, 12,12);}// draws circles
 
 else if (choice==0)
 {
 rect(x,y,10,10);   //draws rectangles
  
}

  
  
  // perform a forward FFT on the samples in song's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( song.mix );
  
 
}

void keyPressed(){
 if (keyCode==32 )   //press spacebar to pause/play music

{
  if ( song.isPlaying() )
  {
    song.pause();
  }
  else
  {
    // simply call loop again to resume playing from where it was paused
    song.loop();
  }
}
// Changes the drawing tools
if (key == 't' || key == 'T') {  
   background(0);
  choice=1;
}
  if (key == 'c' || key == 'C') {
     background(0);
  choice=2;
}

 if (key == 'r' || key == 'R') {
    background(0);  
  choice=0;
}
}

void mousePressed()
{
  background(0);
  
  imagecount= (imagecount+1) %4; //loops through the pictures

}
