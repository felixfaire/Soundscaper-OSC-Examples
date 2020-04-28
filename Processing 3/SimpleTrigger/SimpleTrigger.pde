
/** Import OSC network libraries
*/
import oscP5.*;
import netP5.*;

OscP5       oscP5;
NetAddress  soundscaperAddress;

/* The string ID of the sound file as shown in Soundscaper.
   This is basically the filename with '_' instead of spaces.
*/
String demoClipID = "knock_sample";



void setup()
{
  size(100, 100);
  frameRate(60);
  
  oscP5 = new OscP5(this,12000);
  soundscaperAddress = new NetAddress("127.0.0.1", 9001);
}

void draw()
{
  if (frameCount % 10 == 0)
  {
     PVector randomPosition = new PVector(random(-1.0f, 1.0f),
                                          random(0.0f, 2.0f),
                                          random(-1.0f, 1.0f)); 
     
     // Trigger the sound with the clip id (hover the clip item in Soundscaper to see this id)
     triggerSoundWithClipID(demoClipID, randomPosition);
  }
}


/** This function shows how you can trigger a sound by sending the name
    of the file (as shown when loaded in Soundscaper).
*/
void triggerSoundWithClipID(String address, PVector position)
{
  OscMessage myMessage = new OscMessage("/start");
  
  myMessage.add(address);   
  myMessage.add(position.x);
  myMessage.add(position.y);
  myMessage.add(position.z);
  
  /* send the message */
  oscP5.send(myMessage, soundscaperAddress); 
}
