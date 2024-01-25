class boss extends Sprite {
    int cooldownTimer = 0;
    int cooldownDuration = 1000;
    boolean isShrinking = false;
    int lastUpdateTime;
    int shrinkStartTime;
    PVector initialPosition;
    float originalSize;
    int hp = 25;

    boss(float x, float y) {
        super(x, y, 80, 80);
        vel = new PVector(5, 0);
        lastUpdateTime = millis();
        shrinkStartTime = 0;
        initialPosition = new PVector(x, y);
        originalSize = Math.max(size.x, size.y);
    }

    void update() {
        cooldownTimer += millis() - lastUpdateTime;
        lastUpdateTime = millis();

        if (cooldownTimer >= cooldownDuration) {
            cooldownTimer = 0;
            shrinkAndGrow();
        }
    }

    void display() {
        fill(255);
        ellipse(pos.x, pos.y, size.x, size.y);
        
        float hpBarWidth = 55;
        float hpBarHeight = 10;
        float hpBarX = pos.x - 27.5;
        float hpBarY = pos.y + size.y / 2 + 15;

        fill(0, 0, 0);
        rect(hpBarX, hpBarY, hpBarWidth, hpBarHeight);

        fill(255, 0, 0);
        float remainingHPWidth = map(hp, 0, 25, 0, hpBarWidth);
        rect(hpBarX, hpBarY, remainingHPWidth, hpBarHeight);
    }

    void shrinkAndGrow() {
        isShrinking = !isShrinking;

        if (isShrinking) {
            float newSize = originalSize * 0.5;
            PVector newSizeVector = new PVector(newSize, newSize);
            PVector offset = PVector.sub(size, newSizeVector).mult(0.5);

            size.set(newSizeVector);
            
            for (int i = 0; i < 8; i++) {
                float angle = PI + i * PI / 4; // Adjust the angle as needed
                PVector direction = new PVector(cos(angle), sin(angle));
                direction.mult(8); // Adjust the speed as needed
                _SM.spawn(new bossBullet(pos.x, pos.y, team, direction));
            }

            // Adjust the position to stay centered
            PVector centerOffset = PVector.sub(initialPosition, pos);
            pos.add(centerOffset);

            shrinkStartTime = millis();
        } else {
            if (millis() - shrinkStartTime >= 500) {
                size = new PVector(originalSize, originalSize);
                pos.set(initialPosition);
            }
        }
    }
    
    @Override
    void handleCollision() {
        hp--;
        if (hp <= 0) {
             _SM.destroy(this);
        }
    }
}
