class Player{
  
/////class variables
int x;
int y;
int size;

int runSpeed;

int topBound;
int bottomBound;
int leftBound;
int rightBound;

boolean movingLeft;
boolean movingRight;
boolean movingUp;
boolean movingDown;

boolean isPlayerDead;



/////constructor
Player(){
  x=750;
  y=900;
  size=70;
  
  runSpeed=8;
  
  topBound=y;
  bottomBound=y+size;
  leftBound=x;
  rightBound=x+size;
}



void movingLeft(){
  if (movingLeft==true){
      x=x-runSpeed;
  }
}
  
void movingRight(){
if (movingRight==true){
  x=x+runSpeed;
}
}

void movingUp(){
  if (movingUp==true){
      y=y-runSpeed;
  }
}

void movingDown(){
  if (movingDown==true){
      y=y+runSpeed;
  }
}

  
void resetBoundaries(){
  topBound=y;
  bottomBound=y+size;
  leftBound=x;
  rightBound=x+size;
}

void isHit(Bullet bullet1){
  if (bullet1.topBound<=bottomBound){
    if(bullet1.rightBound>=leftBound){
      if(bullet1.leftBound<=rightBound){
        if(bullet1.bottomBound>=topBound){
          isPlayerDead=true;
          }
        }
    }
  }
if(isPlayerDead){
  switchVal=9;
}
}
}
