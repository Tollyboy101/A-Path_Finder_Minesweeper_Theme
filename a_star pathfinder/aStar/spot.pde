import java.util.*;

class Spot {
  int i;
  int j;
  float f = 0;
  float g = 0;
  float h = 0;
  float amountWalls = 0.4;
  boolean wall = false;
  PImage mine;
  
  
  Spot previous = null;
  
  int rectWidth;
  int rectHeight;
  
  List<Spot> neighbours = new ArrayList<Spot>();
  
  Spot(int i,int j, PImage mine_){
    this.i = i;
    this.j = j;
    rectWidth = width / cols;
    rectHeight = height/ rows;
    
    if (random(1) < amountWalls){
      wall = true;
    }
    mine = mine_;
  }
  
  void show(int col){ 
    if (wall){
      fill(0);
      noStroke();
      //ellipse(this.i*rectWidth + w/2, this.j*rectHeight + h/2, rectWidth-5, rectHeight-5);
      imageMode(CENTER);
      image(mine, this.i*rectWidth + w/2, this.j*rectHeight + h/2 + rectHeight/2, rectWidth, rectHeight);
    }
    stroke(col);
    strokeWeight(0.5);
    noFill();
    rect(this.i*rectWidth, this.j*rectHeight, rectWidth-1, rectHeight-1);
  }
  void addNeighbours(Spot[][] grid){
    int i = this.i;
    int j = this.j;
    if (i < cols - 1) {
      neighbours.add(grid[i + 1][j]);
    }
    if (i > 0) {
      neighbours.add(grid[i - 1][j]);
    }
    if (j < rows - 1) {
      neighbours.add(grid[i][j + 1]);
    }
    if (j > 0) {
      neighbours.add(grid[i][j - 1]);
    }
    if (i > 0 && j > 0){
      neighbours.add(grid[i-1][j-1]);
    }
    if (i < cols-1 && j > 0){
      neighbours.add(grid[i+1][j-1]);
    }
    if (i > 0 && j < rows-1){
      neighbours.add(grid[i-1][j+1]);
    }
    if (i < cols-1 && j < rows-1){
      neighbours.add(grid[i+1][j+1]);
    }


  }
}
