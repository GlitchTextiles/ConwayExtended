World world;
PImage output;
float[][] rules = {
    {0, 0, .0625, 1, .125, .0625, 0, 0, 0}, // if the cells are dead, chances of 
    {0, 0, .25, 1.0, .85, .125, .0625, .025, 0} // if the cells are alive
  };

void setup () {
  size(500, 500);
  world = new World(width, height, rules);
  output = createImage(width, height, GRAY);
  for (Cell c : world.getCells()) {
    c.setState(world.probability(.25));
  }
  frameRate(30);
}

void draw() {
  output = world.render();
  image(output, 0, 0);
  world.update();
}
