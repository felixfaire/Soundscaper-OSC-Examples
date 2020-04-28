
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

// Keep track of our existing sounds
ArrayList<BasicMovingSound> allSounds = new ArrayList<BasicMovingSound>();
int                         currentNoteID = 0;
float                       maxMovementDuration = 5.0f;


void setup()
{
  size(100, 100);
  frameRate(60);
  
  oscP5 = new OscP5(this,12000);
  soundscaperAddress = new NetAddress("127.0.0.1", 9001);
}


void draw()
{
  // Every 1 second trigger a new sound
  if (frameCount % 30 == 0)
  {
     int noteID = currentNoteID;
     PVector position = new PVector(random(-1.0f, 1.0f),
                                    random(1.9f, 2.0f),
                                    random(-1.0f, 1.0f)); 
     
     // Make a new sound object to keep track of our sounds
     BasicMovingSound newSound = new BasicMovingSound(noteID, position);

     // Start the new sound with a note ID so we can control the sound later on
     triggerSoundWithClipIDAndNoteID(demoClipID, newSound.noteID, newSound.position);
     
     // Add to our list of sounds
     allSounds.add(newSound);
     
     // Increment the note ID counter for the next note
     currentNoteID++;
  }
  
  for (int i = 0; i < allSounds.size(); ++i)
  {
    // Update the position
    allSounds.get(i).update(); 

    // Update the soundscape
    updateSoundPosition(allSounds.get(i).noteID, allSounds.get(i).position);
  }  
  
  // Cleanup sounds older than the duration limit
  for (int i = allSounds.size() - 1; i >= 0; --i)
    if (allSounds.get(i).age > maxMovementDuration)
      allSounds.remove(i);
}


void triggerSoundWithClipIDAndNoteID(String sound, int noteID, PVector position)
{
  OscMessage myMessage = new OscMessage("/start");
  
  myMessage.add(sound);   
  myMessage.add(noteID);   
  myMessage.add(position.x);
  myMessage.add(position.y);
  myMessage.add(position.z);
  
  /* send the message */
  oscP5.send(myMessage, soundscaperAddress); 
}


void updateSoundPosition(int noteID, PVector position)
{
  OscMessage myMessage = new OscMessage("/update");
  
  myMessage.add(noteID);   
  myMessage.add(position.x);
  myMessage.add(position.y);
  myMessage.add(position.z);
  
  /* send the message */
  oscP5.send(myMessage, soundscaperAddress); 
}
