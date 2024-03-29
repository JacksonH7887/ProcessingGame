class Bullet extends Sprite {

    PVector vel; // Velocity vector

    Bullet(float x, float y, int team, PVector direction) {
        super(x, y, 10, 10); // invoke parent constructor
        this.team = team;
        this.vel = direction.copy().mult(15); // Adjust the speed as needed
    }

    Bullet(PVector pos, int team, PVector direction) {
        this(pos.x, pos.y, team, direction);
    }

    @Override
    void update() {
        pos.add(vel);
    }

    @Override
    void display() {
        float direction = atan2(vel.y, vel.x);

        pushMatrix();
        translate(pos.x, pos.y);
        rotate(direction - PI / 2);

        fill(255);
        triangle(-size.x / 2, -size.y / 2, size.x / 2, -size.y / 2, 0, size.y + 10);

        popMatrix();
    }
}
