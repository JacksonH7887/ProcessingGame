class Invader extends Sprite {
  
    // constructor
    Invader(float x, float y) {
        super(x, y, 40, 40);
        vel = new PVector(5, 0); // moving right
        
    }
    
    @Override // change directions left and right
    void update() {
        PVector aim = new PVector(0, .5);
        pos.add(vel);
        if (pos.x < 0 || pos.x > width - 50) {
            vel.x *= -1;
        }
        if(millis() % 800 >= 0 && millis() % 1000 <= 15){
            _SM.spawn(new Bullet(pos.x, pos.y, team, aim));
        }
    }
    @Override
    void display() {
        fill(255);
        ellipse(pos.x, pos.y, size.x, size.y);
    }
}
