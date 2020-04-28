
/** Import OSC network libraries
*/
import oscP5.*;
import netP5.*;

OscP5       oscP5;
NetAddress  soundscaperAddress;


/** This is the number of sound clips you have loaded into Soundscaper
*/
int    numAvailableClips = 3;


void setup()
{
  size(100, 100);
  frameRate(60);
  
  oscP5 = new OscP5(this,12000);
  soundscaperAddress = new NetAddress("127.0.0.1", 9001);
}

void draw()
{
  // Every 10 frames trigger a random sound
  if (frameCount % 10 == 0)
  {
     PVector randomPosition = new PVector(random(-1.0f, 1.0f),
                                          random(0.0f, 2.0f),
                                          random(-1.0f, 1.0f)); 
     
     int randomIndex = (int)random((float)numAvailableClips);
     
     triggerSoundWithClipIndex(randomIndex, randomPosition);
  }
}



/** This function shows how you can trigger a sound by sending the index
    of the audio file (when loaded in Soundscaper). This might be easier to
    make randomized soundscapes but be aware that the clip indices might change
    if you add more files to your clip folder.
*/
void triggerSoundWithClipIndex(int clipIndex, PVector position)
{
  OscMessage myMessage = new OscMessage("/start");
  
  myMessage.add(clipIndex);   
  myMessage.add(position.x);
  myMessage.add(position.y);
  myMessage.add(position.z);
  
  /* send the message */
  oscP5.send(myMessage, soundscaperAddress); 
}
