
class BasicMovingSound
{
  BasicMovingSound(int _noteID, PVector _startPosition) 
  {
    noteID = _noteID;
    position = _startPosition;
  }
  
  void update()
  {
    // Move the sound here
    
    // Drop sound
    position.y *= 0.99f;
    
    // Swirl sounds around center
    PVector radial = new PVector(position.x, position.z);
    radial.normalize();
    radial = PVector.mult(radial, 0.02f);
    
    position.x += -radial.y;
    position.z += radial.x;
    
    // Update age
    age += 1.0f / 60.0f;
  }
  
  // The unique id for this sound. Used as a handle to move
  // the sound after it has been triggered
  int     noteID;
  
  // The current Position of the sound
  PVector position;      
  
  // The age of the sound used to tell 
  // when we can remove it from our tracked sounds.
  float age = 0.0f;
}
