ArrayList<Bullet>p1BulletList;
ArrayList<Bullet>eneBulletList;
ArrayList<Bullet>bossBulletList;
ArrayList<Enemy>enemyList;

int switchVal=1;

int score=0;
int winningScore;

PImage bgi;
PImage bg;
PImage bgb;
PImage bgw;

PFont font;

Animation playerWalk;
PImage []cowboyWalk=new PImage[2];
Animation enemy1Walk;
PImage []ene1Walk=new PImage[2];
Animation bossWalk;
PImage []bWalk=new PImage[2];

Player p1;
Boss b1;
Player aPlayer;

import processing.sound.*;
SoundFile gunshot;
SoundFile theme;



void setup(){
  size(1500,999);
  
  p1=new Player();
  b1=new Boss();
  
  bgi=loadImage("background intro.png");
  bg=loadImage("background.png");
  bgb=loadImage("background boss.png");
  bgw=loadImage("background win.png");
  
  font = loadFont("storyfont-99.vlw");
  textFont(font);
  
  gunshot= new SoundFile(this, "gunshot.mp3");
  theme= new SoundFile(this, "reddeadtheme.mp3");
  
  
/////adds player and enemy bullets  
  p1BulletList=new ArrayList<Bullet>();
  eneBulletList=new ArrayList<Bullet>();
  bossBulletList=new ArrayList<Bullet>();
  
/////adds enemies  
  enemyList=new ArrayList<Enemy>(2);
   enemyList.add (new Enemy(500,0));
   enemyList.add (new Enemy(1000,100));
   enemyList.add (new Enemy(700,50));
   enemyList.add (new Enemy(900,200));
   enemyList.add (new Enemy(570,50));
   enemyList.add (new Enemy(800,150));
   enemyList.add (new Enemy(630,300));
   enemyList.add (new Enemy(970,250));
   enemyList.add (new Enemy(600,0));
   enemyList.add (new Enemy(870,25));

/////animations
   for(int i=0;i<cowboyWalk.length;i++){
    cowboyWalk[i]=loadImage("cowboyWalk"+i+".png");
   }
   playerWalk= new Animation(cowboyWalk, 0.2, 4);
   
   for(int i=0;i<ene1Walk.length;i++){
    ene1Walk[i]=loadImage("enemy1Walk"+i+".png");
   }
   enemy1Walk= new Animation(ene1Walk, 0.02, 4);
   
   for(int i=0;i<bWalk.length;i++){
    bWalk[i]=loadImage("bossWalk"+i+".png");
   }
   bossWalk= new Animation(bWalk, 0.15, 5);
}


void draw(){
  background(#E08632);
  
  if (!theme.isPlaying()){
    theme.play();
  }
  
  
  /////switch statements
  
  /////title screen
switch(switchVal){
    case 1:
    imageMode(CORNER);
    image(bgi, 0, 0);
    fill(255);
    textSize(50);
    text("W  A  S  D", 200, 890);
    text("space", 600, 890);
    text("to move", 200, 950);
    text("to shoot", 600, 950);
    textAlign(CENTER);
    textSize(200);
    text("Bounty", 750, 400);
    textSize(50);
    text("Press r to start", 750, 570);
    score=0;
    break;
      
      
   /////intro screen
     case 2:
   background(0);
   textSize(50);
   fill(255);
   text("Arizona Territory, 1870.", 750, 100);
   text("You are wanted for a stagecoach robbery.", 750, 230);
   text("But you've left that life behind.", 750, 360);
   text("The sheriff has offered you a deal:", 750, 490);
   text("Round up all the bounties in the territory ($100,000),", 750, 560);
   text("and you won't hang.", 750, 630);
   text("Not willing to give up your life, you take him up", 750, 760);
   text("on his offer and begin your journey as you walk", 750, 830);
   text("into the outlaw-ridden town of New Summit...", 750, 900);
   textSize(25);
   text("(Press r to begin.)", 750, 980);
   break;
      
      
  /////main game screen    
    case 3:
  image(bg, 750, 500);
  p1.movingLeft();
  p1.movingRight();
  p1.movingUp();
  p1.movingDown();
  p1.resetBoundaries();
  playerWalk.display(p1.x+35, p1.y+35);
  playerWalk.isAnimating=true;


  
  for(Bullet bullet1:p1BulletList){
    bullet1.renderBullet();
    bullet1.moveBulletUp();
    bullet1.resetBoundaries();
  }
  
   for(Bullet bullet1:eneBulletList){
    bullet1.renderBullet();
    bullet1.moveBulletDown();
    bullet1.resetBoundaries();
    p1.isHit(bullet1);
    bullet1.isHit(p1);
  }
  
  for(Enemy enemy1:enemyList){
    /////adds enemy bullets
      int randomInt=int(random(0,400));
      if (randomInt<5){
        eneBulletList.add (new Bullet(enemy1.leftBound+35, enemy1.bottomBound, false));
      }
   
    enemy1.movingDown();
    enemy1.resetBoundaries();
    enemy1.resetPosition();
    enemy1Walk.display(enemy1.x+35, enemy1.y+35);
    enemy1Walk.isAnimating=true;
  }
  
  
  for(Bullet bullet1:p1BulletList){
    for(Enemy enemy1:enemyList){
      enemy1.isHit(bullet1);
    }
  }
  
  for (int i=enemyList.size()-1; i>=0; i--){
    if (enemyList.get(i).isDead == true){
    enemyList.remove(i);
    score = score+10000;
    }
  }
  
  for (int i=p1BulletList.size()-1; i>=0; i--){
    if (p1BulletList.get(i).isDead == true){
    p1BulletList.remove(i);
    }
  }
  
  /////score text
  textSize(70);
  textAlign(CENTER);
  fill(255);
  text("$",620,80);
  text(score,width/2,80);
  if (switchVal==1){
    score=0;
  }
  if (score==100000){
    switchVal=4;
  }
    break;
    
    
  /////before boss screen  
  case 4:
    background(0);
    textSize(50);
    text("You've made it.", 750, 100);
    text("You've collected all of the bounties ", 750, 230);
    text("the Wild West can throw at you.", 750, 300);
    text("But suddenly, a gunslinger calling himself Blond Billy", 750, 430);
    text("strolls out of the saloon and stares you down.", 750, 500);
    text("He knows you're the best bounty hunter out there,", 750, 570);
    text("and he wants all those bounties for himself.", 750, 640);
    text("'Give 'em up!' yells Blond Billy.", 750, 770);
    text("You say, 'Over my dead body.'", 750, 870);
    textSize(25);
    text("(Press r to begin the duel.)", 750, 950);
    break;
    
    
  /////boss screen  
  case 5:
  image(bgb,750,500);
  p1.movingLeft();
  p1.movingRight();
  p1.movingUp();
  p1.movingDown();
  p1.resetBoundaries();
  
  playerWalk.display(p1.x+35, p1.y+35);
  playerWalk.isAnimating=true;
  
  b1.move(p1);
  b1.resetBoundaries();
  
  bossWalk.display(b1.x+35, b1.y+35);
  bossWalk.isAnimating=true;
  
  
  /////moves player and boss bullets
for(Bullet bullet1:p1BulletList){
    bullet1.renderBullet();
    bullet1.moveBulletUp();
    bullet1.resetBoundaries();
    b1.isHit(bullet1);
  }
  
   for(Bullet bullet1:bossBulletList){
    bullet1.renderBullet();
    bullet1.moveBossBullet(p1);
    bullet1.resetBoundaries();
    p1.isHit(bullet1);
  }
  
  
  /////adds boss bullets
    int randomInt=int(random(0,30));
    if (randomInt<5){
      bossBulletList.add (new Bullet(b1.leftBound+35, b1.bottomBound, false));
    }
    
    for (int i=p1BulletList.size()-1; i>=0; i--){
    if (p1BulletList.get(i).isDead == true){
    p1BulletList.remove(i);
    }
  }
  break;
  
  
  
  /////player win screen
  case 6:
  background(0);
  textSize(50);
  fill(255);
  text("As the gunfire ceases, Blond Billy falls to the ground.", 750, 100);
  text("The townspeople come out from their", 750, 230);
  text("homes and shops and begin to cheer.", 750, 300);
  text("They call for you to be the town's new sheriff.", 750, 370);
  text("But you refuse.", 750, 500);
  text("You whistle for your horse, and before you", 750, 630);
  text("ride off into the sunset, you tell them...", 750, 700);
  text("'I've got bounties to catch.'", 750, 830);
  textSize(25);
  text("(Press r to continue)", 750, 930);
  break;
  
  
  /////player win screen pixel art
  case 7:
  image(bgw, 750, 500);
  textSize(40);
  fill(255);
  text("Nice shooting, cowpoke.", 750, 810);
  text("Press r to play again", 750, 920);
  break;
  
  
  /////player death screen
  case 9:
  background(0);
  textSize(140);
  fill(180,0,0);
  text("You died.", 750, 400);
  textSize(40);
  fill(255);
  text("No one said being a bounty hunter was easy...", 750, 600);
  textSize(40);
  text("(Press r to restart)", 750, 800);
  break;
}
}  






void keyPressed(){
  if (key=='w'){
    p1.movingUp=true;
    playerWalk.isAnimating=true;
  }
  if (key=='a'){
    p1.movingLeft=true;
    playerWalk.isAnimating=true;
  }
  if (key=='s'){
    p1.movingDown=true;
    playerWalk.isAnimating=true;
  }
  if (key=='d'){
    p1.movingRight=true;
    playerWalk.isAnimating=true;
  }

  if (key==' '){
    p1BulletList.add (new Bullet(p1.x+35, p1.y, true));
    playerWalk.isAnimating=true;
    if (gunshot.isPlaying()){
      gunshot.stop();
    }
    gunshot.play();
  }
  
  ////////////////switch statement keys
  if (key=='r'){
  switchVal +=1;
  if (switchVal==8 || switchVal==10){
    switchVal=1;
    setup();
  }
  }
}

void keyReleased(){
  if (key=='w'){
    p1.movingUp=false;
    playerWalk.isAnimating=true;
  }
  if (key=='a'){
    p1.movingLeft=false;
    playerWalk.isAnimating=true;
  }
  if (key=='s'){
    p1.movingDown=false;
    playerWalk.isAnimating=true;
  }
  if (key=='d'){
    p1.movingRight=false;
    playerWalk.isAnimating=true;
  }
}
