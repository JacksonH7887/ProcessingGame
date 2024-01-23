class Player extends Sprite {
    boolean left, right, up, down;
    
    Player(float x, float y) {
        // super refers to the parent
        // ... I use it here as a constructor
        super(x, y, 40, 40); // in this case, Sprite
        team = 1;
    }

    @Override
    void update() {
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

        // always try to decelerate
        vel.mult(0.9);
    }

    @Override
    void display() {
        fill(200, 0, 200);
        ellipse(pos.x, pos.y, size.x + 20, size.y + 20);
    }

    @Override
    void handleCollision() {
        // don't die.
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
            case 'f': fire(); break;
        }
    }
    int fireStartTime = 0;
    void fire() {
      if(millis() - fireStartTime >= 750){
        fireStartTime = millis();
        int burstTimer = 0;
        PVector aim = new PVector(0, -10); // up
       /* _SM.spawn(new Bullet(pos.x, pos.y, aim, team));
        if(millis() - burstTimer >= 300){
          _SM.spawn(new Bullet(pos.x - 10, pos.y, aim, team));
          if(millis() - burstTimer >= 600){
            _SM.spawn(new Bullet(pos.x + 10, pos.y, aim, team));
            burstTimer = millis();
          }
        }*/
    }
    }
    int shotgunStartTime = 0;
    void shotgun() {
        if(millis() - shotgunStartTime >= 1250 ){
          shotgunStartTime = millis();
          PVector aim = new PVector(0, -10); // up
          PVector Laim = new PVector(-2, -10);
          PVector Raim = new PVector(2, -10);
          _SM.spawn(new Bullet(pos.x, pos.y, aim, team));
          _SM.spawn(new Bullet(pos.x + 25, pos.y + 7, Raim, team));
          _SM.spawn(new Bullet(pos.x - 25, pos.y + 7, Laim, team));
        }
    }
}
