class Personnage {
  PImage image;
  int x;
  float y;
  int largeur;
  int hauteur;
  int vitesse;
  int saut;
  int tpsrepos = 1200;
  int nombreplateforme;
  int pointdevie=30000000;
  int debuttempsinvincibilite = 0;
  boolean[] direction = new boolean[4];   //g,d,h,b
  float grav = 0;
  int piece = 0;




  Personnage(PImage image, int x, int y, int largeur, int hauteur, int vitesse, int saut) {
    nombreplateforme = 4;
    this.image = image;
    this.x = x;
    this.y = y;
    this.saut = saut;
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.vitesse = vitesse;
  }


  Personnage(PImage image) {
    nombreplateforme = 4;
    this.image = image;
    this.x = width/5;
    this.y = height;
    this.saut = height/225;
    this.largeur = width/8;
    this.hauteur = height/8;
    this.vitesse = width/185;
  }


  void dessiner() {
    image(this.image, this.x, this.y, this.largeur, this.hauteur);
  }


  void Qappuyee() {
    this.direction[0] = true;
  }


  void Dappuyee() {
    this.direction[1] = true;
  }


  void Zappuyee() {
    this.direction[2] = true;
  }


  void Sappuyee() {
    this.direction[3] = true;
  }


  void Qrelachee() {
    this.direction[0] = false;
  }


  void Drelachee() {
    this.direction[1] = false;
  }


  void Zrelachee() {
    this.direction[2] = false;
  }


  void Srelachee() {
    this.direction[3] = false;
  }


  void ajouterpointdevie() {
    this.pointdevie++;
  }


  void enleverpointdevie() {
    this.pointdevie--;
  }


  void ajouterplateforme() {
    this.nombreplateforme++;
  }


  void enleverplateforme() {
    this.nombreplateforme--;
  }


  void ajouterpiece() {
    this.piece ++;
    if (this.piece == piecetotal) {
      victoire = true;
    }
  }


  void enleverpiece() {
    this.piece --;
  }


  void deplacer() {
    if (this.direction[0] == true) { //q
      if (this.x - this.vitesse > 0 + width/6) {
        this.x -= this.vitesse;
      } else {
        niveau.defilement -= this.vitesse;
        plateformemagic.clear();
      }
    }
    if (this.direction[1] == true) { //d
      if (this.x + this.largeur + this.vitesse < width - width/6) {
        this.x += this.vitesse;
      } else {
        niveau.defilement += this.vitesse;
        plateformemagic.clear();
      }
    }
    if (this.direction[2] == true && this.peutsauter() ) { //z
      this.y -= this.saut;
    }
    if (this.direction[3] == true) { //s
      if (!estsurunappui()) {
        this.y += this.vitesse;
      }
    }
  }


  void gravite() {
    if (!estsurunappui()) {
      this.y += grav;
      grav+=height/12000.0;
      this.y = constrain(this.y, 0, height-this.hauteur);    //on s'assure que le perso ne dessande pas sous le sol, this.y + height /150 n'est pas forcement exactement  == height
    } else {
      grav=0;
    }
  }


  boolean estsurunappui() {
    if (this.y + this.hauteur == height || this.colision()) {
      return true;
    } else {
      return false;
    }
  }


  boolean peutsauter() {
    if (estsurunappui() || this.direction[2]) {
      return true;
    } else {
      return false;
    }
  }


  boolean colision() {
    boolean colision = false;
    for (Obstacle plateforme : plateforme) {
      if (plateforme.type == "plateforme" &&
        this.x + this.largeur >= plateforme.x &&
        this.x <= plateforme.x + plateforme.largeur &&
        (this.y + this.hauteur)-this.hauteur/8 <= plateforme.y &&
        this.y+this.hauteur >= plateforme.y) {
        colision = true ;
      }
    }
    if (plateformemagic.size() > 0) {
      Obstacle plat = plateformemagic.get(0);
      if (this.x + this.largeur >= plat.x &&
        this.x <= plat.x + plat.largeur &&
        (this.y + this.hauteur)-this.hauteur/8 <= plat.y &&
        this.y+this.hauteur >= plat.y) {
        colision = true;
        plateformemagic.get(0).dessiner();
      }
    }
    return colision;
  }


  void toucher() {
    if (debuttempsinvincibilite +tpsrepos < millis()) {
      this.pointdevie--;
      debuttempsinvincibilite = millis();
      if (this.pointdevie == 0) {
        perdu = true;
      }
    }
  }
}
