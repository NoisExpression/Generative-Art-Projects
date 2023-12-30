class Blob {
    PVector vel;
    PVector pos;   
    float radius = 0;
    int index;

    Blob (float x, float y, float r) {
        pos = new PVector(x, y);
        vel = PVector.random2D();
        vel.mult(random(2,5));
        radius = r;
    }

    Blob (float x, float y, int index) {// questo costruttore lo si usa per le pshape 
    // in cui in base all'indice passato posso calcolare il raggio 
    // ma dato che non mi serve calcolarlo in questa classe non lo faccio
        pos = new PVector(x, y);
        vel = PVector.random2D();
        vel.mult(random(2,5));
        this.index = index;
    }

    void update(){
        edgeDetection();
        pos.add(vel);
    }

    void edgeDetection(){
        if(pos.x > width || pos.x < 0) vel.x *= -1;
        if(pos.y > height || pos.y < 0) vel.y *= -1;
    }
    void show(){
        circle(pos.x, pos.y, radius);
    }
    PVector getPos(){
        return pos;
    }
    int getIndex(){
        return index;
    }

}
