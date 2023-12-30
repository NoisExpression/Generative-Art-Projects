class Metaballs {

    int numShapes;
    PShape[] circles;
    PShape[] contours;
    ArrayList<Blob> metaballs;
    color colorM;

    Metaballs (int nShapes, int maxRadius, color co) {
        //__INIT__
        numShapes = nShapes;
        colorM = co;
        metaballs = new ArrayList<Blob>();
        circles = new PShape[numShapes];
        contours = new PShape[numShapes];

        for (int i = 0; i < numShapes; ++i) {
            int step = (int)(maxRadius/numShapes);
            circles[i] = createShape(GROUP); 
            //! pshape are rendered in order of definition
            PShape ps = createShape(
                            ELLIPSE, 
                            0, 0, 
                            (float)((i+3)*step), 
                            (float)((i+3)*step)
                            );
            ps.setFill(colorM);
            ps.setStroke(false);
            circles[i].addChild(ps);
        }
    }

    Metaballs (int nShapes, int maxRadius, color co, float contour) {
        //__INIT__
        numShapes = nShapes;
        colorM = co;
        metaballs = new ArrayList<Blob>(); // array of blobs
        circles = new PShape[numShapes];
        contours = new PShape[numShapes];
        // shapes 
        for (int i = 0; i < numShapes; ++i) {
            int step = (int)(maxRadius/numShapes);
            circles[i] = createShape(GROUP); 
            PShape ps = createShape(
                            ELLIPSE, 
                            0, 0, 
                            (float)((i+3)*step) + contour, 
                            (float)((i+3)*step) + contour
                            );
            ps.setFill(colorM);
            ps.setStroke(false);
            circles[i].addChild(ps);
        }

    }

    Metaballs (int nS) {
        //__INIT__
        numShapes = nS;
        metaballs = new ArrayList<Blob>(); // blobs
    }

    void add(float x, float y){
        int index = this.getNormalDistributionIndex(numShapes);
        metaballs.add(new Blob(x, y, index));
    }

    int getNormalDistributionIndex(int arrayLength) {
        float mean = (float)arrayLength / 2.0;
        float stdDev = arrayLength / 4.0;   // modify 4.0 as you like 

        float value = randomGaussian() * stdDev + mean;

        int index = (int)(constrain(value, 0, arrayLength-1));
        return index;
    }

    void show(){
        for (Blob b : metaballs) {
            pushMatrix();
            PVector p = b.getPos().copy();
            translate(p.x, p.y);
            shape(circles[b.getIndex()]);
            popMatrix();
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
