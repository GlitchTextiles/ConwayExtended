public class World {

  private int w = 0;
  private int h = 0;
  private ArrayList<Cell> cells;
  private float[][] rules;

  public World(int _w, int _h, float[][] _rules) {
    this.w=_w;
    this.h=_h;
    this.initCells();
    this.rules=_rules;
  }

  public void initCells() {
    this.cells = new ArrayList<Cell>();
    for (int i = 0; i < this.w*this.h; i++) {
      int x = i % this.w;
      int y = int(i / this.w);
      this.cells.add(new Cell(x, y));
    }
  }

  public Cell getCell(int _i) {
    if (_i < this.cells.size() && _i >= 0) {
      return this.cells.get(_i);
    } else {
      println();
      return null;
    }
  }

  public ArrayList<Cell> getCells() {
    return this.cells;
  }

  public void update() {
    //create a copy of the current state of cells in the world
    ArrayList<Cell> snapshot = this.copyCells();

    // set the state of the cells based on the snapshot
    for (int y = 0; y < this.w; y++) {
      for (int x = 0; x < this.h; x++) {
        Cell present = snapshot.get(y*this.w+x);
        Cell future = this.cells.get(y*this.w+x);
        future.setState(this.probability(this.rules[int(present.getState())][this.countLiveNeighbors(snapshot, x, y)]));
      }
    }
  }

  public ArrayList<Cell> copyCells() {
    ArrayList<Cell> copy = new ArrayList<Cell>();
    for (Cell c : this.cells) {
      copy.add(c.copy());
    }
    return copy;
  }

  public boolean probability(float _percentChance) {
    return random(1) < _percentChance;
  }

  public int countLiveNeighbors(ArrayList<Cell> _cells, int _x, int _y) {

    int count = 0;

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j<= 1; j++) {
        if (!(i == 0 && j == 0)) {
          int neighbor_x = _x+j;
          int neighbor_y = _y+i;
          neighbor_x = (neighbor_x + width) % width;
          neighbor_y = (neighbor_y + height) % height;
          if (_cells.get(neighbor_y*width+neighbor_x).getState()) {
            count++;
          }
        }
      }
    }
    return count;
  }

  public PImage render() {
    PImage image = createImage(width, height, GRAY);
    image.loadPixels();
    for ( int x = 0; x < width; x++ ) {
      for ( int y = 0; y < height; y++ ) {
        if (this.getCell(y*width+x).getState()) {
          image.pixels[x+(height*y)]=color(0);
        } else {
          image.pixels[x+(height*y)]=color(255);
        }
      }
    }
    image.updatePixels();
    return image;
  }

  public float[][] getRules() {
    return this.rules;
  }
}
