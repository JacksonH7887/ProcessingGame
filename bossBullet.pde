class bossBullet extends Bullet {
    bossBullet(float x, float y, int team, PVector direction) {
        super(x, y, team, direction);
        this.size.mult(5);
        this.vel = direction.copy().mult(1);
    }
    
    @Override
    void handleCollision() {
    }
}
