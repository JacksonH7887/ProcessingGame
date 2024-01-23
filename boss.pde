class boss extends Sprite {
  
    // constructor
    boss(float x, float y) {
        super(x, y, 80, 80);
        vel = new PVector(5, 0); // moving right
    }
    
    @Override // change directions left and right
    void update() {
        //pos.add(vel);
        
        /*if (pos.x < 0 || pos.x > width) {
            vel.x *= -1;
        }*/
    }
    @Override
    void display() {
        fill(255);
        rect(pos.x, pos.y, size.x, size.y);
    }
}
