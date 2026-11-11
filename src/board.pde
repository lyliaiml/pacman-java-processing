
// types pour case
enum TypeCell {
  WALL,        // x : Mur 
  EMPTY,       // V : vide
  DOT,         // o : Pac-Gomme
  SUPER_DOT,   // O : Super-Pac-Gomme
  HERO,        // P : PAC-Man
  GHOST        // G : Fantôm es
}

class Board {
  TypeCell[][] _cells; // tab 2D pour stocker le type de chaque case
  PVector _position; //position de depart
  int _nbCellsX, _nbCellsY; //nbr de colonnes et lignes
  int _cellSize;// taille dune cellule CARRE
  
  Board(PVector position, int cellSize) {
    this._position = position;
    this._cellSize = cellSize;
    
    String[] lines = loadStrings("levels/level1.txt");
    
    if (lines == null) {//pour verifier si c bien chargé
      println("Erreur : Impossible de trouver le fichier level1.txt");
      exit(); //fermer le prog
      return;
    }

    //ne pas oublier que ca commence pas de la 1ere ligne
    //commencer à l'indice 1
    _nbCellsY = lines.length - 1; 
    _nbCellsX = lines[1].length();
    _cells = new TypeCell[_nbCellsY][_nbCellsX]; // creation tab vide
    
    // la pour parcourir chaque caractere par ligne du fichier
    for (int i = 0; i < _nbCellsY; i++) {
     
      String currentLine = lines[i + 1]; 
      for (int j = 0; j < _nbCellsX; j++) {
        char c = currentLine.charAt(j);
        _cells[i][j] = charToTypeCell(c); // conversion du char en enum
      }
    }
  }
  
 

  // la je convertis un caractère en type de cellule
  TypeCell charToTypeCell(char c) {
    switch (c) {
      case 'x': return TypeCell.WALL;       // Mur
      case 'V': return TypeCell.EMPTY;      // Vide
      case 'o': return TypeCell.DOT;        // Pac-Gomme
      case 'O': return TypeCell.SUPER_DOT;  // Super Pac-Gomme
      case 'P': return TypeCell.HERO;       // Position Pacman
      default: return TypeCell.EMPTY;       // ici autre c vide
    }
  }
  
 
  // Calcule la position du centre d'une cellule en pixels
  PVector getCellCenter(int i, int j) {
    float x = _position.x + j * _cellSize + _cellSize / 2;
    float y = _position.y + i * _cellSize + _cellSize / 2;
    return new PVector(x, y);
  }
  
  
  // Vérifie si une position (x,y) c un mur
  boolean isWall(int x, int y) {
    // Si hors limites, on considère qu'il n'y a pas de mur (permet la téléportation)
    if (x < 0 || x >= _nbCellsX || y < 0 || y >= _nbCellsY) return false;
    return _cells[y][x] == TypeCell.WALL;//la ca retourne vrai si case c un mur
  }
  
  
  TypeCell getCell(int x, int y) {
    if (x < 0 || x >= _nbCellsX || y < 0 || y >= _nbCellsY) return TypeCell.EMPTY;
    return _cells[y][x];
  }
  

  // modcifier le contenu(quand on mange une gomme)
  void setCell(int x, int y, TypeCell type) {
    if (x >= 0 && x < _nbCellsX && y >= 0 && y < _nbCellsY) {
      _cells[y][x] = type;
    }
  }
  
 
  // ici parcourir le tab pour trouver P
  PVector findHeroStartPosition() {
    for (int i = 0; i < _nbCellsY; i++) {
      for (int j = 0; j < _nbCellsX; j++) {
        if (_cells[i][j] == TypeCell.HERO) {
          return new PVector(j, i);
        }
      }
    }
    return new PVector(1, 1);  
  }
  
  // Vérifie si reste des gommes à manger
  boolean hasDotsRemaining() {
    for (int i = 0; i < _nbCellsY; i++) {
      for (int j = 0; j < _nbCellsX; j++) {
        if (_cells[i][j] == TypeCell.DOT || _cells[i][j] == TypeCell.SUPER_DOT) {
          return true;  // Il reste au moins une
        }
      }
    }
    return false;  //tt a ete mange
  }
  
  
  // Dessine le plateau 
  void drawIt() {   
    
    for (int i = 0; i < _nbCellsY; i++) {
      for (int j = 0; j < _nbCellsX; j++) {
        TypeCell cell = _cells[i][j];
        
        
        float x = _position.x + j * _cellSize;
        float y = _position.y + i * _cellSize;
        
        // Dessin selon le type de cellule
        if (cell == TypeCell.WALL) {
         
          fill(COLOR_WALL);//si c mur
          rect(x + 2, y + 3, _cellSize - 2, _cellSize - 3); //pour le rect

        } else if (cell == TypeCell.DOT) {
          fill(COLOR_DOT);
          ellipse(x + _cellSize/2, y + _cellSize/2, 6, 6);// pour gomme
        } else if (cell == TypeCell.SUPER_DOT) {
          fill(COLOR_DOT);
          ellipse(x + _cellSize/2, y + _cellSize/2, 12, 12); // pour super gomme (je mets le double en taille)
          
        }}}}}
