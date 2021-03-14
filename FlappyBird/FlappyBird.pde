PImage background, bird, title, startButton, gameOver, replay, scoreboard, pipe, pipeInverted;
int x=423, menu=0, score=0, x1=423, random=0, random1=532, x2=750, random2=0, random3=500, best=0, start=0;

float y, yv=1;
/*
x= used for the background, their are two pictures, they are synced so that when one picture is leaving space on the screen
 the other one is replacing that blanck space. Once the second picture is centralized on the screen the variable is reset.
 
 menu=there are three menu stages: 0-main menu, 1-game ,2- game over
 
 x1 & x2= this are the pipes, they will move two pixel per loop round. Once one of the pipes reaches the end of the screen,
 it will appear on the other end of the screen
 
 random and random2=this are responsible for the top pipes of x1 and x2
 
 random1 and random3=this are responsible for the bottom pipe of x1 and x2
 
 start= this variable works like a boolean, they are only to stages 0 and 1, its is use to give a time for the user to see 
 the instruction of the game
 
 We didn't use array because we didn't find it necessary.
 
 */

void setup()
{
  size(432, 642);
  fill(0);
  //load images
  background=loadImage("Background.png");
  bird=loadImage("Bird1.png");
  title=loadImage("Title.png");
  startButton=loadImage("Start-button.png");
  scoreboard=loadImage("Score1.png");
  gameOver=loadImage("GAmeOver.png");
  pipe=loadImage("Pipes2.png");
  pipeInverted=loadImage("Pipes2-bottom.png");
}

void setup1()
{
  y=height/2-41;//bird initial y-position
  x1=424;//fist pipe
  x2=750;//second pipe
  yv=1;//bird velocity
  score=0;
  start=0;


  random=int(random(-215, 0));//top pipe of x1
  random1=355+random+165;//bottom pipe of x1

  random2=int(random(-215, 0));//top pipe of x2
  random3=355+random2+165;//bottom pipe of x2
}

void draw()
{
  background(0);

  image(background, x-background.width, 0);
  image(background, x, 0);

  if (x<0)
  {
    x=432;
    // when one of the pictures reaches the end of the screen 
    // it appear at the other end of the screen
  } 

  x-=1;//background movement



  if (menu==0)//forced menu
  {
    menu();
  } 
  else if (menu==1)//game
{
  Game();
  
  } 
  else if(menu==2) 
  {
    gameOver();
  }
}





void menu()
{
  image(title, 75, 50);
  image(startButton, 150, 500);
}

void Game()
{
  image(bird, 50, y);

  if (start==0)
  {
    textSize(22);
    text("Press mouse or spacebar to start", 30, 500);
  }

  if (start==1)
  {
    y=y+yv;
    yv+=0.3;//bird movement




    image(pipe, x1, random);//top pipe
    image(pipeInverted, x1, random1);//bottom pipe
    image(pipe, x2, random2);// top pipe
    image(pipeInverted, x2, random3);// bottom pipe

    //pipe movement
    x1-=2;
    x2-=2;



    if (x1<-50)//when pipe x1 leaves the screen
    {
      random=int(random(-215, 0));
      random1=355+random+165;

      x1=600;// appear at the other end of the screen
    }

    if (x2<-50)//when pipe x2 leaves the screen
    {
      random2=int(random(-215, 0));
      random3=355+random2+165;


      x2=600;// appear at the other end of the screen
    }

    if (x1==30 ||x2==30)//score keeping
    {
      score+=1;
    }

    if (y <0 || y >height )//hit top of the window || bottom of the window
    {
      menu=2;
      y=height/2-41;
      x1=423;
      x2=750;
    }

    if (x1<108 && x1>30 && 335+random>=y)//hit top pipe of x1
    {

      menu=2;
    }
    if (x1<108 && x1>30 && y>=random1)//hit bottom pipe of x1
    {
      menu=2;
    }

    if (x2<108 && x2>30 && y>=random3)//hit bottom pipe of x2
    {
      menu=2;
    }

    if (x2<108 && x2>30 && 335+random2>=y)// hit top pipe of x2
    {
      menu=2;
    }
    textSize(32);
    text(score, width/2, 100);//Score printing
  }
}

void gameOver()
{
  if (score>best)
  {
    best=score;
  }

  image (gameOver, 100, 50);
  image(startButton, 150, 500);
  image(scoreboard, 35, 150);

  fill(0);//Score & best score printing 
  textSize(40);
  text(score, width/2-30, 220 );
  text(best, width/2-30, 290 );
}

void mousePressed()
{
  if (menu==0 || menu==2)//menu
  {
    if (mouseX >150 && mouseX <270 && mouseY >500 && mouseY<569)
    {
      menu=1;
      setup1();
    }
  } else if (menu==1)//game
  {
    yv-=9;
    start=1;
  }
}

void keyPressed()
{
  if (menu==1)//game
  {
    yv-=9;
    start=1;
  }
}
