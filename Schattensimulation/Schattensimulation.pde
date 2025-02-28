int achsenLaenge = 1000;
boolean buffer = true;
boolean stationaer = false;

float frameCounter = 0;

PVector Quelle = new PVector(175, -150, 300);
PVector originaleQuelle = new PVector(175, -150, 300);
float z = 0;

int hoehe = 100;

PVector[] HausPunkt = new PVector[10];


void setup() {
  size(1000, 800, P3D);

  HausPunkt[0] = new PVector(50, 50, 0);
  HausPunkt[1] = new PVector(150, 50, 0);
  HausPunkt[2] = new PVector(150, 150, 0);
  HausPunkt[3] = new PVector(50, 150, 0);
  HausPunkt[4] = new PVector(50, 50, hoehe);
  HausPunkt[5] = new PVector(150, 50, hoehe);
  HausPunkt[6] = new PVector(150, 150, hoehe);
  HausPunkt[7] = new PVector(50, 150, hoehe);
  HausPunkt[8] = new PVector(50, 100, hoehe+50);
  HausPunkt[9] = new PVector(150, 100, hoehe+50);
}

void draw() {
  //println(frameCount+ "\n"+ z + "\n");
  if (!stationaer) {  
    frameCounter += 0.4;
  }

  Quelle = kreisfoermigeQuelle(Quelle);

  if (keyPressed) {
    if (key == 's'){
      stationaer = true;
    } else if (key == 'b'){
      stationaer = false;
    }
  }

  //println(z);


  strokeWeight(3);
  translate(int(width/2), int(height/2)+200, 0);
  background(0);
  rotateX(radians(90));

  //rotateZ(radians(z%360));
  rotateZ(radians(32));

  stroke(255);
  noFill();


  // Achsen
  pushMatrix();
  beginShape();
  strokeWeight(6);
  stroke(255, 0, 255);
  vertex(0, 0, 0);
  vertex(0, 0, achsenLaenge);
  vertex(0, 0, 0);
  vertex(0, achsenLaenge, 0);
  vertex(0, 0, 0);
  vertex(achsenLaenge, 0, 0);
  endShape();
  popMatrix();
  stroke(255);

  strokeWeight(3);



  // Quelle
  pushMatrix();
  translate(int(Quelle.x), int(Quelle.y), int(Quelle.z));
  sphere(10);
  popMatrix();

  // Haus
  beginShape();
  stroke(255);

  //Boden
  vertex(int(HausPunkt[0].x), int(HausPunkt[0].y), int(HausPunkt[0].z));
  vertex(int(HausPunkt[1].x), int(HausPunkt[1].y), int(HausPunkt[1].z));
  vertex(int(HausPunkt[2].x), int(HausPunkt[2].y), int(HausPunkt[2].z));
  vertex(int(HausPunkt[3].x), int(HausPunkt[3].y), int(HausPunkt[3].z));
  vertex(int(HausPunkt[0].x), int(HausPunkt[0].y), int(HausPunkt[0].z));

  //Decke
  vertex(int(HausPunkt[4].x), int(HausPunkt[4].y), int(HausPunkt[4].z));
  vertex(int(HausPunkt[5].x), int(HausPunkt[5].y), int(HausPunkt[5].z));
  vertex(int(HausPunkt[6].x), int(HausPunkt[6].y), int(HausPunkt[6].z));
  vertex(int(HausPunkt[7].x), int(HausPunkt[7].y), int(HausPunkt[7].z));
  vertex(int(HausPunkt[4].x), int(HausPunkt[4].y), int(HausPunkt[4].z));

  //Wände
  vertex(int(HausPunkt[5].x), int(HausPunkt[5].y), int(HausPunkt[5].z));
  vertex(int(HausPunkt[1].x), int(HausPunkt[1].y), int(HausPunkt[1].z));
  vertex(int(HausPunkt[2].x), int(HausPunkt[2].y), int(HausPunkt[2].z));
  vertex(int(HausPunkt[6].x), int(HausPunkt[6].y), int(HausPunkt[6].z));
  vertex(int(HausPunkt[7].x), int(HausPunkt[7].y), int(HausPunkt[7].z));
  vertex(int(HausPunkt[3].x), int(HausPunkt[3].y), int(HausPunkt[3].z));

  // Dach
  vertex(int(HausPunkt[0].x), int(HausPunkt[0].y), int(HausPunkt[0].z));
  vertex(int(HausPunkt[4].x), int(HausPunkt[4].y), int(HausPunkt[4].z));
  vertex(int(HausPunkt[8].x), int(HausPunkt[8].y), int(HausPunkt[8].z));
  vertex(int(HausPunkt[7].x), int(HausPunkt[7].y), int(HausPunkt[7].z));
  vertex(int(HausPunkt[8].x), int(HausPunkt[8].y), int(HausPunkt[8].z));
  vertex(int(HausPunkt[9].x), int(HausPunkt[9].y), int(HausPunkt[9].z));
  vertex(int(HausPunkt[5].x), int(HausPunkt[5].y), int(HausPunkt[5].z));
  vertex(int(HausPunkt[9].x), int(HausPunkt[9].y), int(HausPunkt[9].z));
  vertex(int(HausPunkt[6].x), int(HausPunkt[6].y), int(HausPunkt[6].z));
  endShape();


  // Schattenvektoren && Vektoren von Quelle zu den Punkten
  for (int i = 0; i < HausPunkt.length; i++) {
    lichtVektor(Quelle, HausPunkt[i]);
    drawSchattenVektor(schattenVektor(Quelle, HausPunkt[i], 0), HausPunkt[i]);
  }


  // Schatten
  PVector[] schattenVektorEndpunkt = new PVector[HausPunkt.length];
  for (int i = 0; i < HausPunkt.length; i++) {
    schattenVektorEndpunkt[i] = schattenVektor(Quelle, HausPunkt[i], 0);
  }
  schattenVektorFill(schattenVektorEndpunkt);

  z += 0.2;
}

void lichtVektor(PVector tmpQuelle, PVector Punkt) {
  pushMatrix();
  beginShape();
  stroke(255, 255, 0);
  vertex(tmpQuelle.x, tmpQuelle.y, tmpQuelle.z);
  vertex(Punkt.x, Punkt.y, Punkt.z);
  vertex(Punkt.x, Punkt.y, Punkt.z);
  endShape();
  popMatrix();
}

PVector schattenVektor(PVector tmpQuelle, PVector tmpPunkt, int BodenZ) {

  PVector schattenVektorR = new PVector();
  PVector sVektor = new PVector();

  sVektor.x = tmpPunkt.x - tmpQuelle.x;
  sVektor.y = tmpPunkt.y - tmpQuelle.y;
  sVektor.z = tmpPunkt.z - tmpQuelle.z;


  float t = (- tmpPunkt.z)/( sVektor.z);

  schattenVektorR.x = int(tmpPunkt.x + t * sVektor.x);
  schattenVektorR.y = int(tmpPunkt.y + t * sVektor.y);
  schattenVektorR.z = BodenZ;

  return(schattenVektorR);
}

void drawSchattenVektor(PVector schattenVektor, PVector tmpPunkt) {
  pushMatrix();
  beginShape();
  stroke(255, 0, 0);
  vertex(tmpPunkt.x, tmpPunkt.y, tmpPunkt.z);
  vertex(schattenVektor.x, schattenVektor.y, schattenVektor.z);
  vertex(schattenVektor.x, schattenVektor.y, schattenVektor.z);
  endShape();
  popMatrix();
}

void schattenVektorFill(PVector[] Punkte) {
  pushMatrix();
  beginShape();
  stroke(125, 125, 125);
  for (int i = 0; i < 10; i++) {

    for (int j = 0; j < 10; j++) {
      vertex(Punkte[i].x, Punkte[i].y, Punkte[i].z);
      vertex(Punkte[j].x, Punkte[j].y, Punkte[j].z);
    }
  } 
  endShape();
  popMatrix();
}

PVector kreisfoermigeQuelle(PVector tmpQuelle) {
  tmpQuelle.x = 300 * sin(2*PI * (frameCounter % 1000)/1000.0) + 100;
  tmpQuelle.y = 300 * cos(2*PI * (frameCounter % 1000)/1000.0) + 100;

  return(tmpQuelle);
}
