class Hero {
  PVector _position; //amelioration pour mouv fluide
  int _cellX, _cellY;// pos actuelle
  int _startX, _startY;// se rappeler du depart
  PVector _direction; // direction du mouv
  PVector _nextDirection;
  float _speed; //vitesse de deplacement
  float _size; //taille
  
  Hero(int x, int y, float size, Board board) {
    _cellX = x;
    _cellY = y;
    _startX = x;
    _startY = y;
    _size = size;
    _speed = HERO_SPEED;
    _direction = new PVector(0, 0);//imobile au debut
    _nextDirection = new PVector(0, 0);
    _position = board.getCellCenter(_cellY, _cellX);// position au centre de la case
  }
  
  void launchMove(PVector dir) { // stocke la direction fleches ou lettres
    _nextDirection = dir.copy();
  }
  //mise a jour du heros
  void update(Board board) {
    PVector center = board.getCellCenter(_cellY, _cellX); //centre de la case actuelle
    
    // Si on est proche du centre de la case
    if (PVector.dist(_position, center) < _speed) {
      // Essaie de changer de direction si demandé
      if (_nextDirection.mag() > 0) {//verifie si c pas un mur
        if (!board.isWall(_cellX + (int)_nextDirection.x, _cellY + (int)_nextDirection.y)) {
          _direction = _nextDirection.copy();
          _position = center.copy(); //tjrs au centre
        }
      }
      
      // Vérifie si on peut continuer dans la direction actuelle
      if (board.isWall(_cellX + (int)_direction.x, _cellY + (int)_direction.y)) {
        _direction.set(0, 0);// arrete si mur devant
        _position = center.copy();
      }
    }
    
    // Déplacement
    _position.add(PVector.mult(_direction, _speed));
    
    // Mise à jour de la position en grille
   _cellX = int((_position.x - board._position.x) / board._cellSize);
_cellY = int((_position.y - board._position.y) / board._cellSize);
  //la pour quand ca sort a gauche, il est a droite genre teleportation
  if (_cellX < 0) {
      _cellX = board._nbCellsX - 1;
      _position = board.getCellCenter(_cellY, _cellX);
    } else if (_cellX >= board._nbCellsX) {
      _cellX = 0;
      _position = board.getCellCenter(_cellY, _cellX);
    }
}
  //reinitialise pacman a pos de depart
  void reset(Board board) {
    _cellX = _startX;
    _cellY = _startY;
    _position = board.getCellCenter(_cellY, _cellX);
    _direction.set(0, 0);
    _nextDirection.set(0, 0);
  }
  
  void drawIt() {//amelioration bouche qui bouge a ajouter peut etre ici
   
  // Paramètres de ton sprite d'après tes coordonnées
  int sx = 851; // x de départ sur l'image
  int sy = 102;   // y de départ sur l'image
  int sw = 37;  // largeur du sprite
  int sh = 38;  // hauteur du sprite

  // On dessine le sprite centré sur la position du Hero
  imageMode(CENTER); 
  image(spriteSheet, _position.x, _position.y, _size, _size, sx, sy, sx + sw, sy + sh);
  imageMode(CORNER); // On remet en mode par défaut pour ne pas casser le reste
}
    
   
}
