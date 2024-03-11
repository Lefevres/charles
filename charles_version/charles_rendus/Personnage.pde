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
  int pointdevie;
  int debuttempsinvincibilite = 0;
  boolean[] direction = new boolean[4];   //g,d,h,b
  float grav = 0;
  int piece = 0;


  //Les différents constructeurs de la classe Personnage. Ils initialisent les attributs du personnage, tels que sa position, sa taille, sa vitesse, etc.


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
    
    this.saut = height/225;
    this.largeur = width/8;
    this.hauteur = height/8;
    this.vitesse = width/185;
  }


  void dessiner() {  //Méthode de la classe Personnage. Elle dessine le personnage à sa position actuelle sur l'écran.
    image(this.image, this.x, this.y, this.largeur, this.hauteur);
  }


  //Méthodes de la classe Personnage. Elles gèrent les déplacements du personnage dans différentes directions en fonction des touches appuyées et ou relacher.


  void appuyeeQ() {
    this.direction[0] = true;
  }


  void appuyeeD() {
    this.direction[1] = true;
  }


  void appuyeeZ() {
    this.direction[2] = true;
  }


  void appuyeeS() {
    this.direction[3] = true;
  }


  void relacheeQ() {
    this.direction[0] = false;
  }


  void relacheeD() {
    this.direction[1] = false;
  }


  void relacheeZ() {
    this.direction[2] = false;
  }


  void relacheeS() {
    this.direction[3] = false;
  }


  void ajouterPointDeVie() {    //ajoute un point de vie au personnage
    this.pointdevie++;
  }


  void enleverPointDeVie() {    //enleve un point de vie au personnage
    this.pointdevie--;
  }


  void ajouterPlateforme() {    //ajoute une plateforme a son compteur de plateforme magique qu'il peut faire apparaitre
    this.nombreplateforme++;
  }


  void enleverPlateforme() {    //enleve  une plateforme a son compteur de plateforme magique qu'il peut faire apparaitre
    this.nombreplateforme--;
  }


  void ajouterPiece() {    //ajoute une piece a personnage
    this.piece ++;
    if (this.piece == piecetotal) {
      niveau.victoire = true;
    }
  }


  void enleverPiece() {   //enleve une piece a personnage
    this.piece --;
  }


  void deplacer() {   //gere le deplacement du personnage celon ce qu'il peut phisiquement faire
    if (this.direction[0] == true) { //q
      if (this.x - this.vitesse > 0 + width/5) {
        this.x -= this.vitesse;
      } else {
        niveau.defilement -= this.vitesse;
        plateformeMagic.clear();
      }
    }
    if (this.direction[1] == true) { //d
      if (this.x + this.largeur + this.vitesse < width - width/5) {
        this.x += this.vitesse;
      } else {
        niveau.defilement += this.vitesse;
        plateformeMagic.clear();
      }
    }
    if (this.direction[2] == true && this.peutsauter() ) { //z
      this.y -= this.saut;
    }
    if (this.direction[3] == true) { //s
      if (!estSurUnAppui()) {
        this.y += this.vitesse;
      }
    }
  }


  void gravite() {    //applique la graviter a personnage si celui ci n'as pas de point d'appuie
    if (!estSurUnAppui()) {
      this.y += grav;
      grav+=height/12000.0;
      this.y = constrain(this.y, 0, height-this.hauteur);    //on s'assure que le perso ne dessande pas sous le sol, this.y + height /150 n'est pas forcement exactement  == height
    } else {
      grav=0;
    }
  }


  boolean estSurUnAppui() {     //renvoie si oui ou non le personnage est sur un appui
    if (this.y + this.hauteur == height || this.colision()) {
      return true;
    } else {
      return false;
    }
  }


  boolean peutsauter() {        //verifie si le personnage peut sauter
    if (estSurUnAppui() || this.direction[2]) {
      return true;
    } else {
      return false;
    }
  }


  boolean colision() {       // verifie si le personnage st sur une plateforme
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
    if (plateformeMagic.size() > 0) {
      Obstacle plat = plateformeMagic.get(0);
      if (this.x + this.largeur >= plat.x &&
        this.x <= plat.x + plat.largeur &&
        (this.y + this.hauteur)-this.hauteur/8 <= plat.y &&
        this.y+this.hauteur >= plat.y) {
        colision = true;
        plateformeMagic.get(0).dessiner();
      }
    }
    return colision;
  }


  void toucher() {      //offre un temps d'invincibilité au personnge après qu'il se soit fait toucher
    if (debuttempsinvincibilite +tpsrepos < millis()) {
      this.pointdevie--;
      debuttempsinvincibilite = millis();
      if (this.pointdevie == 0) {
        niveau.perdu = true;
      }
    }
  }


  void jeu() {   //Méthode de la classe Personnage. Elle représente le comportement global du personnage pendant le jeu.
    this.gravite();
    this.dessiner();
    this.deplacer();
  }
}
