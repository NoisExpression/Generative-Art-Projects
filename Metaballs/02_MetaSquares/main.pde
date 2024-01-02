CanvasTo canvasTo;
color[][] canva;
color[] toLerpColor = {#000000,  #FFF9F0}; // #A6CAC4,
color[] lerpedColor;
int xpix = 20; int ypix = 20;
int nX, nY;
boolean gate = false; 
boolean inited = false;
ArrayList<Metaballs> metaballs;
ArrayList<Blob> blobs;
FloatList angularVels;
Metaballs metaScheletro;
float contour = 4;
int mbStep = 50;
int s = 20;
int nBalls = 8;
int count = 0;
boolean save = false;
float time = 0;
/**------------------------------------------------------------- */
void setup() {
    size(1400, 1400, P3D);
    colorMode(HSB);
    
    //* _INIT_
    nX = width/xpix; //? calcolo il numero di passi da xpix dentro width
    nY = height/ypix; //? calcolo il numero di passi da ypix dentro height
    canvasTo = new CanvasTo(nX, nY); // inizializzo il convertitore
    metaballs = new ArrayList<Metaballs>();
    angularVels = new FloatList();
    int nStepsPerColorToLerp = (s/(toLerpColor.length)) ;
    float indexStep = ((float)toLerpColor.length/((float)(s)));
    lerpedColor = new color[s];
    // controllo che il contorno associato non sia più grande del passo in pixel da una stampa di shape al successivo
    if(mbStep <= contour) mbStep = (int)contour+1;
    
    for (int i = 0; i < s; ++i) {
        float idx = map(i, 0, s-0.1, 0, (toLerpColor.length)-1);
        int index = (int)idx;
        float amt = idx - index;
        println("index: "+index + " i: "+ i + " toLerp.lenght: "+ toLerpColor.length + " amt: "+amt );
        lerpedColor[i] = lerpColor(toLerpColor[index], toLerpColor[index + 1], amt);
        // creo il contorno
        metaballs.add(new Metaballs(nBalls,10+(int)(s-i)*mbStep, color(0), contour));
        // creo un livello di metabals per ogni sottotono
        metaballs.add(new Metaballs(nBalls,10+(int)((s-i)*(mbStep)), color(lerpedColor[i])));
    }
    metaScheletro = new Metaballs(nBalls); // uso questo come reference per gli altri
}

void draw() {
    background(0);
    noFill();
    stroke(200);
    strokeWeight(2);
    metaScheletro.update();
    blobs = metaScheletro.getBlobList();
    //println(blobs.size(), metaballs.size());
    int i = 0;
    int j = 0;
    for (Metaballs meta : metaballs) { // itero attraverso ogni livello di colore
        float a = map(j, 0, metaballs.size()/2, -1,1);
        meta.setBlobList(blobs);
        meta.show(time, a);
        //time+=0.001;
        j += i%2;
        i++;
    }
    if (gate ) {
        inited = true;
        canva = canvasTo.colorTable(); //converto il canvas in tabella colori
    }
    if (inited) {
        showBlocks();
    }
    //println(metaScheletro.metaballs.size());
    if(save && count < 750){
        count++;
        saveFrame("img0/"+nf(count, 4)+".jpg");
    }
    if(count >=750) noLoop();
    
    time += 0.001*TWO_PI;
}

void mouseDragged() {
    metaScheletro.add(mouseX, mouseY);
    angularVels.append(random(-1.2,1.2));
}

void mouseWheel(){
    if(metaScheletro.metaballs.size() > 0) metaScheletro.delete();
}

void keyPressed() {
    //gate = !gate;
    //if(!gate) inited = false;
    if(key == 's' || key == 'S' ) save = !save;
}

void showBlocks(){
    for (int i = 0; i < nX; ++i) {
        for (int j = 0; j < nY; ++j) {
            fill(canva[j][i]);
            noStroke(); // disegnare i contorni di rect rallenta mbotto il rendering
            rect(i*xpix, j*ypix, xpix, ypix);
        }
    }
}
