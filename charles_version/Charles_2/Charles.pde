import ddf.minim.*;
Niveau niveau;
AudioPlayer mario;
Perso charles;
Obstacle[] obstacle;
Ennemi[] ennemi;
Obstacle rampe ;
float gravite;
//copier le systeme de graviter par 1 au perso et l'adapter a la taille de l'écran
boolean plat;
boolean[] direction = new boolean[4];
int defilement=0;
PImage plateforme;
PImage perso;
PImage imgennemid;
PImage imgennemig;


void setup() {
  size(950, 950);
  Minim minim = new Minim(this);
  mario = minim.loadFile("mario.mp3");
  niveau = new Niveau("niveaux1.txt");
  gravite = 1;//(height * 0.002421053) * width / 2800.0;
  perso = loadImage("bosnome.png");
  imgennemid = loadImage("ennemiGvD.png");
  imgennemig = loadImage("ennemiDvG.png");
  plateforme = loadImage("plateforme.png");
  charles = new Perso(perso, 25, height, width/8, height/8, 7, height/105);
  niveau.chargementniveau();
  rampe = new Obstacle(-250*width, -250*height, charles.largeur);
  println("dans ce niveau il y a ", obstacle.length, "bloc d'obstacles et ", ennemi.length, "ennemies");
}

void draw() {
  float last_time = millis();
  background(0);
  println("vous avez ", charles.pv, "point de vie");
  //println(ennemi[4].y,obstacle[109].y);
  plat = false;
  niveau.dessiner();
  charles.affichage();
  if (!rampe.detecterCollisionAvecPlateforme(charles)) {
    rampe.changerx(-250*width);
    rampe.changery(-250*height);
  } else {
    rampe.dessiner(204, 70, 232);
  }
  defilement=0;
  charles.graviter();
  charles.apparaitre_ligne();
  charles.dessiner();
  charles.deplacement();
  print(millis()-last_time, "\n");
  
}


void keyPressed() {
  if (key == 'z' || key == 'Z') {
    for (int i = 0; i < obstacle.length; i++) {
      if (plat==true) {
        direction[0] = true;
        direction[2]=false;
      }
    }
    if (charles.est_au_sol() ) {
      direction[0] = true;
      direction[2]=false;
    }
    if (rampe.detecterCollisionAvecPlateforme(charles) ) {
      direction[0] = true;
      direction[2]=false;
    }
  } else if (key == 'q' || key == 'Q') {
    direction[1] = true;
  } else if (key == 's' || key == 'S') {
    direction[2] = true;
    direction[0]=false;
  } else if (key == 'd' || (key == 'D') ) {
    direction[3] = true;
  } else if (key == 'p' || (key == 'P') ) {
    mario.play();
    charles.nbplateforme++;
    mario.rewind();
    charles.toucher = false; 
  } else if (key == 32 && charles.nbplateforme >= 1) {
    rampe.changerx(charles.x);
    rampe.changery(charles.y+charles.hauteur);
    charles.nbplateforme--;
  }
}


void keyReleased() {
  if (key == 'z' || key == 'Z') {
    direction[0] = false;
    charles.grav=0;
  } else if (key == 'q' || key == 'Q') {
    direction[1] = false;
  } else if (key == 's' || key == 'S') {
    direction[2] = false;
  } else if (key == 'd' || key == 'D') {
    direction[3] = false;
  }
}


void defiler(String direction) {
  if (direction == "d") {
    defilement+=charles.vitesse;
  } else if (direction == "q") {
    defilement-=charles.vitesse;
  }
}
