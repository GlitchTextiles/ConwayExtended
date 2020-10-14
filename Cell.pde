class Cell {

  private int x;
  private int y;

  boolean state;

  public Cell(int _x, int _y) {
    this.x = _x;
    this.y = _y;
    this.state = false;
  }
  
  public Cell(int _x, int _y, boolean _state) {
    this.x = _x;
    this.y = _y;
    this.state = _state;
  }

  public boolean getState() {
    return this.state;
  }

  public void setState(boolean _state) {
    this.state = _state;
  }

  public int getX() {
    return this.x;
  }

  public int getY() {
    return this.y;
  }
  
  public Cell get(){
    return this;
  }
  
  public Cell copy(){
    return new Cell(this.x,this.y,this.state);
  }
}
