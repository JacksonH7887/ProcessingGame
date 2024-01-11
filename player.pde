class player{
  PVector pos, vel, size;
  boolean left, right, up, down;
  int team = 0;
  
  player(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    size = new PVector(50, 50);
  }
  ll
  void display(){
    ellipse(pos.x, pos.y, 50, 50);
    fill(0, 0, 0);
  }
  
  void update(){
    float speed = 1.2;
    if (left) vel.add(new PVector(-speed, 0));
    if (right) vel.add(new PVector(speed, 0));
    if (up) vel.add(new PVector(0, -speed));
    if (down) vel.add(new PVector(0, speed));
    
    pos.add(vel);

    //bounds
    
    if(pos.x < 0 + size.x/2) pos.x = size.x/2;
    if(pos.x > width - size.x/2) pos.x = width - size.x/2;
    if(pos.y < 0 + size.y/2) pos.y = size.y/2;
    if(pos.y > height - size.y/2) pos.y = height - size.y/2;

    vel.mult(0.9);

}
  
  void keyUp(){
    switch(key){
    case 'a':
    case 'A': left = false; break;
    case 's':
    case 'S': down = false; break;
    case 'd':
    case 'D': right = false; break;
    case 'w':
    case 'W': up = false; break;
    }
  }
  
  void keyDown(){
    switch(key){
    case 'a':
    case 'A': left = true; break;
    case 's':
    case 'S': down = true; break;
    case 'd':
    case 'D': right = true; break;
    case 'w':
    case 'W': up = true; break;
    }
  }
  
  
  
}
