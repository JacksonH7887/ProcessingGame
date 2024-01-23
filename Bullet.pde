class Bullet extends Sprite {
    
    Bullet(float x, float y, PVector velocity, int team) {
        super(x, y, 10, 10); // invoke parent constructor
        vel = velocity;
        this.team = team;
    }

    Bullet(PVector pos, PVector vel, int team) {
        // constructor chaining
        this(pos.x, pos.y, vel, team); // invoke another own constructor
        // this refers to the above on line 3
    }
    
    @Override
    void update() {
        pos.add(vel);
    }
    @Override
    void display() {
        fill(255);
        rect(pos.x, pos.y, size.x - 5, size.y + 10);
    }
}
