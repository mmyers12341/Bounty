class Boss{
  
/////class variables
int x;
int y;
int size;

int runSpeed;

int topBound;
int bottomBound;
int leftBound;
int rightBound;

boolean move;

boolean isBossDead;


/////constructor
Boss(){
  x=2500;
  y=280;
  size=70;
  
  runSpeed=10;
  
  topBound=y;
  bottomBound=y+size;
  leftBound=x;
  rightBound=x+size;
  
  move=true;
}



void move(Player aPlayer){
  if (aPlayer.x<x){
    x=x-runSpeed;
  }
  if (aPlayer.x>x){
    x=x+runSpeed;
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
          isBossDead=true;
        }
      }
    }
  }
if(isBossDead){
  switchVal=6;
}
}
}
