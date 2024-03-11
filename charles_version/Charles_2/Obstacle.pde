class Obstacle {
  int x;
  int y;
  int sx;
  int sy;
  int largeur = 25;//(width/50);
  int largeurb = (width/50)*(width/50);
  int hauteur=height/80;
  int coefx = 18;
  int coefy = 20;

  Obstacle(int x, int y) {
    this.x=x;
    this.y=y;
  }

  Obstacle(int x, int y, int largeur) {
    this.x=x;
    this.y=y;
    this.largeur=largeur;
  }


  void fixer() {
    this.x-=defilement;
  }




  void dessiner() {
    this.fixer();
    fill(0, 0, 255);
    stroke(0, 0, 255);
    //image(plateforme, this.x, this.y, this.largeurb, this.hauteur);
    rect(this.x, this.y, this.largeur, this.hauteur);
  }

  void dessiner(color couleur1, color couleur2, color couleur3) {
    this.fixer();
    fill(couleur1, couleur2, couleur3);
    stroke(0, 0, 255);
    rect(this.x, this.y, this.largeur, this.hauteur);
  }


  void dessiner(color couleur1, color couleur2, color couleur3, int x, int y) {
    this.fixer();
    fill(couleur1, couleur2, couleur3);
    stroke(0, 0, 255);
    rect(x, y, this.largeur, this.hauteur);
  }


  void sauvegarder() {
    sx = charles.x;
    sy = charles.y;
  }
  boolean detecterCollisionAvecPlateforme(Perso personnage) {//seulement les pieds
    return personnage.x + personnage.largeur >= this.x && personnage.x <= this.x + this.largeur && (personnage.y + personnage.hauteur)-personnage.hauteur/8 <= this.y && personnage.y+personnage.hauteur >= this.y;
  }
  /*
  boolean detecterCollisionAvecPlateforme(Perso personnage) {//seulement les pieds
    return personnage.x + personnage.largeur >= this.x && personnage.x <= this.x + this.largeur && (personnage.y + personnage.hauteur)== this.y ;
  }*/

  boolean detecterCollisionAvecPlateforme(Ennemi ennemi) {//seulement les pieds
    return ennemi.x + ennemi.largeur >= this.x && ennemi.x <= this.x + this.largeur && (ennemi.y + ennemi.hauteur) == this.y;
  }

  
  void detecterCollisionAvecPlateformeGD(Ennemi ennemi) {
    if (this.y == ennemi.y +ennemi.hauteur) {
      if (ennemi.x - ennemi.vitesse > this.x && ennemi.deplacement == "G") {
        ennemi.se_deplacer_a_gauche();
      } else if (ennemi.x + ennemi.vitesse + ennemi.largeur < this.x + this.largeur) {
        ennemi.se_deplacer_a_droite();
        ennemi.deplacement = "D";
      } else {
        ennemi.deplacement = "G";
      }
    }
  }

  void changerx(int nouveaux) {
    this.x=nouveaux;
  }
  void changery(int nouveauy) {
    this.y=nouveauy;
  }

  void collisionAvecPersonnage(Perso personnage) {
    if (this.detecterCollisionAvecPlateforme(personnage)) {
      personnage.contrainte[3] = this.y-personnage.hauteur;
      plat=true;
    }
  }
}
