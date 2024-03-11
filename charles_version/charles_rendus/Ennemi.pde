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


  Ennemi(int x, int y) {  //Le constructeur de la classe Ennemi. Il initialise les attributs de l'ennemi, tels que sa position, sa taille, sa vitesse, etc.
    this.x = x;
    this.y = y;
    this.largeur = height/(900/50);
    this.hauteur = height/(900/70);
    this.vitesse = width/500;
    this.image = image_ennemiDvG;
  }


  void dessiner() {    //Méthode de la classe Ennemi. Elle dessine l'ennemi à sa position actuelle sur l'écran.
    this.x -= niveau.defilement;
    if (this.image == image_ennemiGvD) {
      image(this.image, this.x, this.y, this.largeur*2, this.hauteur);
    } else {
      image(this.image, this.x, this.y, this.largeur, this.hauteur);
    }
  }


  void gravite() {  //Méthode de la classe Ennemi. Elle gère la gravité qui affecte l'ennemi, le faisant tomber vers le bas s'il n'est pas sur une plateforme.
    if (!this.estSurUnAppui()) {
      this.y += grav;
      grav+=0.075/999*height*1.025;
      this.y = constrain(this.y, 0, height-this.hauteur);    //on s'assure que le perso ne dessande pas sous le sol, this.y + height /150 n'est pas forcement exactement  == height
    } else {
      grav=0;
    }
  }


  boolean estSurUnAppui() {   //Méthode de la classe Ennemi. Elle vérifie si l'ennemi est sur une plateforme ou au sol.
    if (this.y + this.hauteur == height || this.colisionPlateforme()) {
      return true;
    } else {
      return false;
    }
  }


  boolean estAuSol() {   //Méthode de la classe Ennemi. Elle vérifie si l'ennemi est au sol.
    if (this.y + this.hauteur == height) {
      return true;
    } else {
      return false;
    }
  }


  boolean colisionPlateforme() {  //Méthode de la classe Ennemi. Elle vérifie s'il y a collision entre l'ennemi et une plateforme.
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
    return colision;
  }


  void toucher(Personnage personnage) {   //Méthode de la classe Ennemi. Elle détecte si l'ennemi entre en collision avec le personnage.
    if (this.x + this.largeur >= personnage.x &&
      this.x <= personnage.x + personnage.largeur &&
      this.y + this.hauteur >= personnage.y &&
      this.y <= personnage.y + personnage.hauteur) {
      personnage.toucher();
    }
  }


  void deplacement() {   //Méthode de la classe Ennemi. Elle gère le déplacement horizontal de l'ennemi.
    if (this.deplacement == "D") {
      this.seDeplacerADroite();
    } else {
      this.seDeplacerAGauche();
    }
  }


  void seDeplacerAGauche() {   //Méthode de la classe Ennemi. Elle fait déplacer l'ennemi vers la gauche.
    this.x -= this.vitesse;
  }


  void seDeplacerADroite() {  //Méthode de la classe Ennemi. Elle fait déplacer l'ennemi vers la droite.
    this.x += this.vitesse;
  }


  void jeu() {    //Méthode de la classe Ennemi. Elle représente le comportement global de l'ennemi pendant le jeu.
    this.gravite();
    if (this.estSurUnAppui()) {
      this.deplacement();
    }
    this.dessiner();
    this.toucher(personnage);
  }
}
