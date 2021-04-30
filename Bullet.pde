class Bullet{
int x;
int y;
int d;
int c;
int speed;
int bossSpeed;
int topBound;
int bottomBound;
int leftBound;
int rightBound;
boolean isPlayers;
boolean isDead;
boolean isPlayerDead;

/////constructor (player bullets)
Bullet(int tempX, int tempY, boolean tempisPlayers){
x=tempX;
y=tempY;
d=20;
c=color(0);
speed=15;
bossSpeed=5;
topBound=y;
bottomBound=y+d;
leftBound=x;
rightBound=x+d;
isPlayers=tempisPlayers;
}



void renderBullet(){
  fill(c);
  circle(x,y,d);
}

void moveBulletUp(){
  if(isPlayers==true){
    y=y-speed;
  }
}

void moveBulletDown(){
  if(isPlayers==false){
    y=y+speed;
  }
}

void moveBossBullet(Player aPlayer){
    y=y+bossSpeed;
}


void resetBoundaries(){
  topBound=y;
  bottomBound=y+d;
  leftBound=x;
  rightBound=x+d;
}

void isHit(Player aPlayer){
  if (aPlayer.topBound<=bottomBound){
    if(aPlayer.rightBound>=leftBound){
      if(aPlayer.leftBound<=rightBound){
        if(aPlayer.bottomBound>=topBound){
          isPlayerDead=true;
          }
        }
      }
    }
  }
}
