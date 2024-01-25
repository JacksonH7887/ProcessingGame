class SpriteManager {
    Player player;
    
    ArrayList<Sprite> active = new ArrayList<Sprite>();
    ArrayList<Sprite> destroyed = new ArrayList<Sprite>();
    
    SpriteManager() {
        player = new Player(width / 2, height - 100);
        spawn(player);
    }
    
    void destroy(Sprite target) {
        destroyed.add(target);
    }
    
    void spawn(Sprite obj) {
        active.add(obj);
    }
    
    int respawnTimer = 0;
    int respawnInterval = 1000;
    int lastUpdateTime;
    void manage() {
        moveEverything();
        checkCollisions();    
        bringOutTheDead();
        drawEverything();
        
        respawnTimer += millis() - lastUpdateTime;
        lastUpdateTime = millis();

        if (respawnTimer >= respawnInterval) {
            respawnInvaders();
            respawnTimer = 0;
        }
    }
    
    void respawnInvaders() {
        float rand = random(1);

        if (rand < 0.5) {
            // 50%
            spawn(new Invader(250, 50));
        } else if (rand < 0.85) {
            // 35%
            spawn(new Invader(400, 150));
        } else {
            // 15%
            spawn(new Invader(550, 250));
        }
    }
    
    void moveEverything() {
        for(int i = active.size() - 1; i >= 0; i--) {
            active.get(i).update();           
        }
    }
    
    void drawEverything() {
        for (Sprite s : active)
            s.display();
    }
    
    void checkCollisions() {
        for (int i = 0; i < active.size(); i++) {
            for (int j = i + 1; j < active.size(); j++) {
                Sprite a = active.get(i);
                Sprite b = active.get(j);
                if (a.team != b.team && collision(a, b)) {
                    active.get(i).handleCollision();
                    active.get(j).handleCollision();
                }
            }
        }
    }
    
    void bringOutTheDead() {
        for (int i = 0; i < destroyed.size(); i++) {
            Sprite target = destroyed.get(i);
            active.remove(target);
            destroyed.remove(target);
        }
    }
    
    boolean collision(Sprite a, Sprite b) {
        boolean xOverlap = Math.abs(a.pos.x - b.pos.x) * 2 < (a.size.x + b.size.x);
        boolean yOverlap = Math.abs(a.pos.y - b.pos.y) * 2 < (a.size.y + b.size.y);
        return xOverlap && yOverlap;
    }

}
