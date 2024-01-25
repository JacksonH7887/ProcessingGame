class Player extends Sprite {
    boolean left, right, up, down;
    
    Player(float x, float y) {
        // super refers to the parent
        // ... I use it here as a constructor
        super(x, y, 40, 40); // in this case, Sprite
        team = 1;
    }
    
    int shotgunCooldown = 0;
    int shotgunCooldownDuration = 1250;
    int lastUpdateTimeShotgun = 0;
    int hp = 3;
    
    @Override
    void update() {
      
        if (mousePressed && mouseButton == LEFT) { fire(); }
        float speed = 1.2;
        if (left)  vel.add(new PVector( -speed, 0));
        if (right) vel.add(new PVector(speed, 0));
        if (up)    vel.add(new PVector(0, -speed));
        if (down)  vel.add(new PVector(0, speed));
        // update the position by velocity
        pos.add(vel);

        //fix bounds
        if(pos.x < 0 + size.x/2) pos.x = size.x/2;
        if(pos.x > width - size.x/2) pos.x = width - size.x/2;
        if(pos.y < 0 + size.y/2) pos.y = size.y/2;
        if(pos.y > height - size.y/2) pos.y = height-size.y/2;
        
        //shotgun timer
        if (shotgunCooldown > 0) {
            shotgunCooldown -= millis() - lastUpdateTimeShotgun;
        }
        lastUpdateTimeShotgun = millis();


        // always try to decelerate
        vel.mult(0.9);
    }

    @Override
    void display() {
        fill(200, 0, 200);
        ellipse(pos.x, pos.y, size.x + 20, size.y + 20);
    
        float sgBarWidth = 5;
    
        if (shotgunCooldown > 0) {
            float cooldownFill = map(shotgunCooldown, 0, shotgunCooldownDuration, 1, 0);
            fill(0, 255, 0);
    
            float sgBarX = pos.x - size.x / 2 - sgBarWidth - 15;
            float sgBarY = pos.y + size.y / 2;
            float sgBarHeight = size.y * cooldownFill;
            rect(sgBarX, sgBarY, sgBarWidth, -sgBarHeight);
        } else {
            fill(0, 255, 0, 50);
            float sgBarX = pos.x - size.x / 2 - sgBarWidth - 15;
            float sgBarY = pos.y + size.y / 2;
            float sgBarHeight = size.y;
            rect(sgBarX, sgBarY, sgBarWidth, -sgBarHeight); 
        }
        float hpBarWidth = 55;
        float hpBarHeight = 10;
        float hpBarX = pos.x - 27.5;
        float hpBarY = pos.y + size.y / 2 + 15;

        fill(0, 0, 0);
        rect(hpBarX, hpBarY, hpBarWidth, hpBarHeight);

        fill(255, 0, 0);
        float remainingHPWidth = map(hp, 0, 3, 0, hpBarWidth);
        rect(hpBarX, hpBarY, remainingHPWidth, hpBarHeight);
    }
    @Override
    void handleCollision() {
        hp--;
        if (hp <= 0) {
            delay(10000); //DEATH
        }
    }

    void keyUp() {
        switch(key) { // key is a global value
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
    void keyDown() {
        switch(key) { // key is a global value
            case 'a':
            case 'A': left = true; break;
            case 's':
            case 'S': down = true; break;
            case 'd':
            case 'D': right = true; break;
            case 'w':
            case 'W': up = true; break;
            case ' ': shotgun(); break;
        }
    }
    int fireStartTime = 0;
    void fire() {
      if(millis() - fireStartTime >= 150){
        fireStartTime = millis();
        PVector mouse = new PVector(mouseX, mouseY);
        PVector direction = PVector.sub(mouse, pos);
        direction.normalize();
        _SM.spawn(new Bullet(pos.x, pos.y, team, direction));
      }
    }
    void shotgun() {
        if (shotgunCooldown <= 0) {
            shotgunCooldown = shotgunCooldownDuration;
            PVector mouse = new PVector(mouseX, mouseY);
            PVector direction = PVector.sub(mouse, pos);
            direction.normalize();
            float spreadAngle = PI / 15; // Adjust the spread angle as needed
            PVector leftBulletDir = direction.copy().rotate(-spreadAngle);
            PVector rightBulletDir = direction.copy().rotate(spreadAngle);
    
            _SM.spawn(new Bullet(pos.x, pos.y, team, direction));
            _SM.spawn(new Bullet(pos.x + 5, pos.y + 7, team, leftBulletDir));
            _SM.spawn(new Bullet(pos.x - 5, pos.y + 7, team, rightBulletDir));
            
            shotgunCooldown = shotgunCooldownDuration;
        }
    }
}
