class CanvasTo {
    int numXSteps, numYSteps; // indicano rispettivamente il numero di steps per colonne e righe  
    int xStep, yStep;
    color[][] cTable;
    CanvasTo (int nx, int ny) {
        //__INIT__
        numXSteps = nx;
        numYSteps = ny;
        xStep = (int)(width/numXSteps);
        yStep = (int)(height/numYSteps);
        cTable = new color[numYSteps][numXSteps];  // ny rige e nx colonne
    }

    color[][] colorTable(){
        // converte il canvas attuale in una matrice di colori di 
        for (int x = 0; x < numXSteps; ++x) {
            for (int y = 0; y < numYSteps; ++y) {
                cTable[y][x] = get(x*xStep, y*yStep);
            }
        }
        return cTable;
    }
}
