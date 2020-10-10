boolean[][] cells;
int[][] tallies;
float[] rulesAlive = {0, 0, 100, 100, 100, 100, 0, 0};
float[] rulesDead = {.0005, 50, 50, 50, 50, 50, 50, 50};

void setup (){
  size(500,500);
  cells = new boolean[width][height];
  tallies = new int[width][height];

}

void draw(){
  evaluateCells();
  updateCells();
  renderGeneration();
  //saveFrame("output/CA_001-###.PNG");
}

void evaluateCells(){
  tallies = new int[width][height];
  for(int x = 0 ; x < width ; x++){
    for(int y = 0 ; y < height ; y++){
      tallies[x][y] = tallyNeighbors(x, y);      
    }
  }
}

int tallyNeighbors(int _x, int _y){ 
  int tally = 0;
  int x = 0;
  int y = 0;
  for(int i = 0 ; i < 3 ; i++){
    for(int j = 0 ; j < 3 ; j++){     
      int neighbor_x = _x+(i-1);
      int neighbor_y = _y+(j-1);
      if(i != 1 && j != 1){      
        if( neighbor_x < 0){
          x = width - 1;
        } else if(neighbor_x == width){
          x = 0;
        } else {
          x =  neighbor_x;
        }
        if( neighbor_y < 0){
          y = height - 1;
        } else if(neighbor_y == height){
          y = 0;
        } else {
          y = neighbor_y;
        }    
        if(cells[x][y] == true){
            tally++;
        }      
      }
    }
  }
  return tally;
}

void updateCells(){
  boolean[][] newCells = new boolean[width][height];
  for(int x = 0 ; x < width ; x++){
    for(int y = 0 ; y < height ; y++){
      if(cells[x][y] == true){
          newCells[x][y] = probability(rulesAlive[tallies[x][y]]);
        } else {
          newCells[x][y] = probability(rulesDead[tallies[x][y]]);
        }
    }
  }
  cells = newCells;
}

boolean probability(float _percentChance){
  if( random(100) < _percentChance ){
    return true;
  } else {
    return false;
  }
}

void renderGeneration(){ 
  loadPixels();
  for( int x = 0 ; x < width ; x++ ){
    for( int y = 0 ; y < height ; y++ ){
      if(cells[x][y] == false){
        pixels[x+(height*y)]=color(255);
      } else {
        pixels[x+(height*y)]=color(0);
      }      
    }
  }
  updatePixels(); 
}
