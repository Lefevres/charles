class Perso {
  PImage image;
  int x;
  int y;
  int largeur;
  int hauteur;
  int vitesse;
  int saut;
  int[] contrainte = new int[4];
  int nbplateforme;
  float grav;
  boolean toucher;
  int pv=3;

  Perso(PImage image, int x, int y, int largeur, int hauteur, int vitesse, int saut) {
    this.contrainte[0] = width/6;
    this.contrainte[1] = width-largeur-width/6;
    this.contrainte[2] = 0;
    this.contrainte[3] = height-hauteur;
    nbplateforme = 4;
    this.grav=0;
    this.image = image;
    this.x = x;
    this.y = y;
    this.saut=saut;
    this.largeur=largeur;
    this.hauteur= hauteur;
    this.vitesse=vitesse;
  }
  
  void affichage(){
    fill(204, 70, 232);
    rampe.dessiner(204, 70, 232,width/50,height/50);
    fill(255);
    line(9*width/51,height/48,8*width/51,2*height/55);
    line(9*width/51,2*height/55,8*width/51,height/48);
    textSize(width/38);
    text(nbplateforme,10*width/51,height/27);
    //line();
    //rect(width/60,height/50,20,10);
  }

  void contraindre(int nombre, int indice) {
    indice=constrain(indice, 0, 3);
    contrainte[indice]=nombre;
  }


  void dessiner() {
    this.x=constrain(this.x, contrainte[0], contrainte[1]);
    this.y=constrain(this.y, contrainte[2], contrainte[3]);
    image(this.image, this.x, this.y, this.largeur, this.hauteur);
  }


  boolean est_au_sol() {
    float marge = 1.0;
    if (this.y >= height - this.hauteur - marge) {
      return true;
    }
    return false;
  }


  void graviter() {
    if (!plat && !this.est_au_sol() && !rampe.detecterCollisionAvecPlateforme(this)) {
     this.grav+=gravite/2;
    this.y += this.grav; 
    this.contrainte[3] = height - hauteur;
  } else {
    this.grav = 0;
  }
   
  }
  
  void toucher(){
    this.toucher = true;
    this.pv -=1;
  }


  void deplacement() {
    if (direction[0]) {
      this.deplacerHaut();
    }
    if (direction[1] && charles.contrainte[0] == charles.x) {
      defiler("q");
    } else if (direction[1]) {
      this.deplacerGauche();
    }

    if (direction[2]) {
      this.deplacerBas();
    }
    if (direction[3] && charles.contrainte[1] == charles.x) {
      defiler("d");
    } else if (direction[3]) {
      this.deplacerDroite();
    }
    if (this.est_au_sol()) {
      grav = 0;
    }
  }



  void deplacerHaut() {
    this.y-=saut;
  }
  void deplacerGauche() {
    this.x=constrain(this.x-vitesse, contrainte[0], contrainte[1]);
  }
  void deplacerBas() {
    this.y = constrain(this.y + vitesse, contrainte[2], contrainte[3]);
  }

  void deplacerDroite() {
    this.x=constrain(this.x+vitesse, contrainte[0], contrainte[1]);
  }


  void apparaitre_ligne() {
    if (mousePressed) {
      frameRate(1);
      rect(this.x, this.y, this.largeur, this.hauteur);
      stroke(215, 219, 24);
      line(0, this.y+this.hauteur, width, this.y+this.hauteur);
      stroke(173, 67, 206);
      line(0, (this.y+this.hauteur)-this.hauteur/8, width, (this.y+this.hauteur)-this.hauteur/8);
      stroke(67, 193, 206);
      fill(0, 255, 0);
      ellipse(this.x, this.y, 7, 7);
      for (int i = 0; i < obstacle.length; i++) {
        line(0, obstacle[i].y, width, obstacle[i].y);
        line(obstacle[i].x, height, obstacle[i].x, 0);
        line(obstacle[i].x+obstacle[i].largeur, height, obstacle[i].x+obstacle[i].largeur, 0);
        fill(255);
        text(i, obstacle[i].x + obstacle[i].largeur/2, obstacle[i].y + obstacle[i].hauteur/2);
      }
      for (Ennemi ennemie:ennemi){
        line(ennemie.x,0,ennemie.x,height); 
        line(ennemie.x + ennemie.largeur, 0 ,ennemie.x + ennemie.largeur , height);}
      /*fill(255,0,0);
      for (int x=0; x<width; x+=width/25){
        line(0,height/2,width,height/2);
        line(x,height/2-height/20,x,height/2-height/20);
      }*/
    } else {
      frameRate(60);
    }
  }
}
