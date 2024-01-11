player player;

void setup(){
  size(800, 600);
  player = new player(width / 2, height / 2);
}

void draw(){
  background(127);
  player.update();
  player.display();
}

void keyPressed(){
  player.keyDown();
}

void keyReleased(){
  player.keyUp();
}
