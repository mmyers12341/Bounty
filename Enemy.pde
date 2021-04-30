class Enemy{
int x;
int y;
int w;
int h;
int c;
int topBound;
int bottomBound;
int leftBound;
int rightBound;
boolean isDead;
boolean movingDown;
int runSpeed;

/////constructor
Enemy(int tempX, int tempY){
x=tempX;
y=tempY;
w=50;
h=70;
c=color(128);

topBound=y;
bottomBound=y+h;
leftBound=x;
rightBound=x+w;

runSpeed=int(random(2,6));

movingDown=true;
}

void renderEnemy(){
  fill(c);
  rect(x,y,w,h);
}

void movingDown(){
  if (movingDown==true){
      y=y+runSpeed;
  }
}

void resetBoundaries(){
  topBound=y;
  bottomBound=y+h;
  leftBound=x;
  rightBound=x+w;
}

void resetPosition(){
  if (y-50>1000){
    y=-75;
  }
}

void isHit(Bullet bullet1){
  if (bullet1.topBound<=bottomBound){
    if(bullet1.rightBound>=leftBound){
      if(bullet1.leftBound<=rightBound){
        if(bullet1.bottomBound>=topBound){
          isDead=true;
          bullet1.isDead=true;
        }
      }
    }
  }
}
}
