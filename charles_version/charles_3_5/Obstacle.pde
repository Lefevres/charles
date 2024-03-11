class Obstacle {
  int x;
  float y;
  int largeur;
  int epaisseur;
  String type;




  Obstacle(int x, int y, int largeur) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.type = "plateforme";
  }


  Obstacle(int x, int y, int largeur, int epaisseur) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.epaisseur = epaisseur;
    this.type = "obstacle";
  }


  Obstacle() {
    this.x = personnage.x;
    this.y = personnage.y + personnage.hauteur;
    this.largeur = personnage.largeur;
    this.epaisseur = height/80;
    this.type = "plateformemagic";
  }

  void dessiner() {
    if (this.type == "plateforme") {
      fill(0, 0, 255);
      rect(this.x, this.y, this.largeur, height/80);
    } else if (this.type == "plateformemagic") {
      fill(240,12,236);
      rect(this.x, this.y, this.largeur, this.epaisseur);
    }
  }


  void detecterGD(Ennemi ennemi) {
    if (ennemi.colisionplateforme()) {
      if (ennemi.deplacement == "D") {

        if (ennemi.x + ennemi.largeur + ennemi.vitesse > this.x + this.largeur) {

          ennemi.deplacement = "G";
          ennemi.image = image_ennemiDvG;
        }
      } else {
        if (ennemi.x -ennemi.vitesse < this.x) {
          ennemi.deplacement = "D";
          ennemi.image = image_ennemiGvD;
        }
      }
    } else if (ennemi.estausol()) {
      if (ennemi.deplacement == "D") {
        if (ennemi.x + ennemi.largeur + ennemi.vitesse >= width) {
          ennemi.deplacement = "G";
          ennemi.image = image_ennemiDvG;
        }
      } else {
        if (0 >= this.x) {
          ennemi.deplacement = "D";
          ennemi.image = image_ennemiGvD;
        }
      }
    }
  }
}
  
  
