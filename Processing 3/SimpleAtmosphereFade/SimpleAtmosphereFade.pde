
/** Import OSC network libraries
*/
import oscP5.*;
import netP5.*;

OscP5       oscP5;
NetAddress  soundscaperAddress;

/* The string ID of the sound file as shown in Soundscaper.
   This is basically the filename with '_' instead of spaces.
*/
String atmosphereID = "knock_sample";



void setup()
{
  size(100, 100);
  frameRate(60);
  
  oscP5 = new OscP5(this,12000);
  soundscaperAddress = new NetAddress("127.0.0.1", 9001);
}

void draw()
{
  float time = millis() * 0.001f;
  
  // Example of 2 slowly moving values
  float val1 = 0.5 + 0.5 * sin(time * 0.2f);
  float val2 = 0.5 + 0.5 * sin(time * 0.3f);
  
  // Update the first 2 atmospheres by index
  updateAtmosphereLevel(0, val1);
  updateAtmosphereLevel(1, val2);
}


void updateAtmosphereLevel(int atmosIndex, float atmosLevel)
{
  OscMessage myMessage = new OscMessage("/atmosphere");
  
  myMessage.add(atmosIndex);   
  myMessage.add(atmosLevel);
  
  /* send the message */
  oscP5.send(myMessage, soundscaperAddress); 
}
