int cols = 50;
int rows = 50;

Spot[][] grid = new Spot[cols][rows];
List<Spot> openSet = new ArrayList<Spot>();
List<Spot> closedSet = new ArrayList<Spot>();

Spot start;
Spot end;
Spot current;

PImage mine;

float w,h;

float heuristic(Spot a, Spot b){
  //euclidean distance
  float d = dist(a.i, a.j, b.i,b.j);
  
  //manhatten
  //float d = abs(a.i-b.i) +  abs(a.j-b.j);
  return d;
}

void setup(){
  size(800,800);
  //fullScreen();
  
  mine = loadImage("mine.png", "png");
  
  
  for (int i=0; i < cols; i++){
    for (int j=0; j < rows; j++){
      grid[i][j] = new Spot(i,j, mine);
      
    }
  }
  for (int i=0; i < cols; i++){
    for (int j=0; j < rows; j++){
      grid[i][j].addNeighbours(grid);
      
    }
  }
  
  w = float(width)/ cols;
  h = float(height)/rows;
  
  
  start = grid[0][0];
  end = grid[cols-1][rows-1];
  start.wall = false;
  end.wall = false;
  
  openSet.add(start);
 
}

void draw(){
  
  if (openSet.size() > 0){
    
    int winner = 0;
    for (int i = 0; i < openSet.size(); i++){
      if (openSet.get(i).f < openSet.get(winner).f){
        winner = i;
      }
    }
    
    current = openSet.get(winner);
    
    if (current == end){
      noLoop();
      println("DONE");
    }  
    
    openSet.remove(current);
    closedSet.add(current);
    
    List<Spot> neighbours = current.neighbours;
    for (int i = 0; i < neighbours.size(); i++){
      
      Spot neighbour = neighbours.get(i);
      
      if (!closedSet.contains(neighbour) && !neighbour.wall){
        float tempG = current.g + 1;
        
        boolean newPath = false;
        if (openSet.contains(neighbour)){
          if (tempG < neighbour.g){
            neighbour.g = tempG; 
            newPath = true;
          }
        }else{
            neighbour.g = tempG;
            newPath = true;
            openSet.add(neighbour);
          }
        if (newPath){
          neighbour.h = heuristic(neighbour,end);
          neighbour.f = neighbour.g + neighbour.h;
          neighbour.previous = current;
        }
        
      }
      
    }
      
  }else{
    println("NO SOLUTION");
    noLoop();
    return;
  }
  
  background(189,189,189);
  
  for (int i = 0; i < cols; i++){
    for (int j = 0; j < rows; j++){
      grid[i][j].show(color(0));
    }
  }
  
  //for ( int i = 0; i < closedSet.size(); i++){
  //  closedSet.get(i).show(color(255,0,0));
  //}
  //for (int i = 0; i < openSet.size(); i++){
  //  openSet.get(i).show(color(0,255,0));
  //}
  
  List<Spot> path = new ArrayList<Spot>();
  Spot temp = current;
  path.add(temp);
  while (temp.previous != null){
    path.add(temp.previous);
    temp = temp.previous;
  }
  //for (int i = 0; i< path.size(); i++){
  //  path.get(i).show(color(0,0,255));
  //}
  
  beginShape();
  noFill();
  stroke(255,0,255);
  strokeWeight(w/4);
  for (int i = 0; i < path.size(); i++){
    vertex(path.get(i).i*w + w/2, path.get(i).j*h + h/2);
  }
  endShape();
}
