class Metaballs {

    int numShapes;
    PShape[] rects;
    PShape[] contours;
    ArrayList<Blob> metaballs;
    color colorM;
    

    Metaballs (int nShapes, int maxRadius, color co) {
        //__INIT__
        numShapes = nShapes;
        colorM = co;
        metaballs = new ArrayList<Blob>(); // creo l'array di blobs
        rects = new PShape[numShapes];
        contours = new PShape[numShapes];

        for (int i = 0; i < numShapes; ++i) {
            int step = (int)(maxRadius/numShapes);
            rects[i] = createShape(GROUP); // nel for sotto raggruppo 
            //! pshape are rendered in order of definition
            PShape ps = createShape(
                            RECT, 
                            -(float)((i+3)*step)/2.0, 
                            -(float)((i+3)*step)/2.0,
                            (float)((i+3)*step), 
                            (float)((i+3)*step)
                            );
            ps.setFill(colorM);
            ps.setStroke(false);
            rects[i].addChild(ps);
        }

    }

    Metaballs (int nShapes, int maxRadius, color co, float contour) {
        //__INIT__
        numShapes = nShapes;
        colorM = co;
        metaballs = new ArrayList<Blob>(); // creo l'array di blobs
        rects = new PShape[numShapes];
        contours = new PShape[numShapes];
        // qui creo le shapes con contorno aggiuntivo in modo che sia uniforme per ogni forma
        for (int i = 0; i < numShapes; ++i) {
            int step = (int)(maxRadius/numShapes);
            rects[i] = createShape(GROUP); // nel for sotto raggruppo 
            //! pshape are rendered in order of definition
            PShape ps = createShape(
                            RECT, 
                            -(float)((i+3)*step + contour)/2.0, 
                            -(float)((i+3)*step + contour )/2.0,
                            (float)((i+3)*step + contour), 
                            (float)((i+3)*step + contour)
                            );
            ps.setFill(colorM);
            ps.setStroke(false);
            rects[i].addChild(ps);
        }

    }

    Metaballs (int nS) {
        //__INIT__
        numShapes = nS;
        metaballs = new ArrayList<Blob>(); // creo l'array di blobs
    }

    void add(float x, float y){
        int index = this.getNormalDistributionIndex(numShapes);
        metaballs.add(new Blob(x, y, index));
    }

    // Funzione per ottenere un indice distribuito in modo normale
    int getNormalDistributionIndex(int arrayLength) {
        float mean = (float)arrayLength / 2.0;
        float stdDev = arrayLength / 4.0; // Modifica il valore a tuo piacimento

        // Genera un numero casuale distribuito in modo normale
        float value = randomGaussian() * stdDev + mean;

        // Assicurati che l'indice sia all'interno dei limiti dell'array
        int index = (int)(constrain(value, 0, arrayLength-1));
        return index;
    }

    void show(float time, float av){ 
        // stampo tutte le componenti presenti sullo stesso livello
        float t = 0;
        for (Blob b : metaballs) {
            pushMatrix();
            PVector p = b.getPos().copy();
            translate(p.x, p.y);
            //rotateZ(time*av + t);
            if(noise(time, av,  time + t) > 0.5) shape(rects[b.getIndex()]);
            popMatrix();
            t+=1;
        }
    }

    void update(){
        for (Blob b : metaballs) {
            b.update();
        }
    }

    ArrayList<Blob> getBlobList(){
        return metaballs;
    }

    void setBlobList(ArrayList<Blob> m){
        metaballs = m;
    }
    void delete(){
        metaballs.remove(0);
    }

}
