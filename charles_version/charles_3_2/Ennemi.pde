class Ennemi {
  PImage image;
  int vie;
  float x;
  int y;
  int largeur;
  int hauteur;
  int vitesse;
  String deplacement = "G";
  float grav=0;

  Ennemi(PImage image, int x, int y) {
    this.x = x;
    this.y = y;
    this.largeur = 50;
    this.hauteur = 70;
    this.vitesse = width/500;
    this.image = image;
  }


  void dessiner() {
    if (this.image == image_ennemiGvD) {
      image(this.image, this.x, this.y, this.largeur*2, this.hauteur);
    } else {
      image(this.image, this.x, this.y, this.largeur, this.hauteur);
    }
  }


  void gravite() {
    if (!this.estsurunappui()) {
      this.y += grav;
      grav+=0.075/999*height*1.025;
      this.y = constrain(this.y, 0, height-this.hauteur);    //on s'assure que le perso ne dessande pas sous le sol, this.y + height /150 n'est pas forcement exactement  == height
    } else {
      grav=0;
    }
  }


  boolean estsurunappui() {
    if (this.y + this.hauteur == height || this.colisionplateforme()) {
      return true;
    } else {
      return false;
    }
  }


  boolean estausol() {
    if (this.y + this.hauteur == height) {
      return true;
    } else {
      return false;
    }
  }


  boolean colisionplateforme() {
    boolean colision = false;
    for (Obstacle plateforme : obstacle) {
      if (plateforme.type == "plateforme" &&
        this.x + this.largeur >= plateforme.x &&
        this.x <= plateforme.x + plateforme.largeur &&
        (this.y + this.hauteur)-this.hauteur/8 <= plateforme.y &&
        this.y+this.hauteur >= plateforme.y) {
        colision = true ;
      }
    }
    return colision;
  }


  void toucher(Personnage personnage) {
    if (this.x + this.largeur >= personnage.x &&
      this.x <= personnage.x + personnage.largeur &&
      this.y + this.hauteur >= personnage.y &&
      this.y <= personnage.y + personnage.hauteur) {
      personnage.toucher();
    }
  }


  void deplacement() {
    if (this.deplacement == "D") {
      this.sedeplaceradroite();
    } else {
      this.sedeplaceragauche();
    }
  }


  void sedeplaceragauche() {
    this.x -= this.vitesse;
  }


  void sedeplaceradroite() {
    this.x += this.vitesse;
  }
}
