//collisions help http://www.jeffreythompson.org/collision-detection
//3 times encountered a bug when hitting spike and jumping, player flies upwards, press p key to fix

//level 0 = start screen, level 0.1 = character selection, level 0.2 = stats level 0.3 = level selection
float level=0;
int  totalDeaths, totalCoins, totalJumps;
int time, timeSeconds, timeMinutes;
String startWord="START";
float backButtonX, backButtonY;

color[] colours = {color(255, 0, 0), color(255, 56, 46), color(194, 16, 0), color(255, 115, 0), color(255, 153, 0), color(255, 81, 0),
  color(255, 215, 4), color(255, 233, 48), color(255, 173, 0), color(0, 255, 0), color(115, 224, 0), color(44, 189, 0),
  color(0, 158, 255), color(0, 205, 255), color(1, 105, 224), color(193, 0, 224), color(245, 79, 255), color(140, 0, 255)};

PlayerCharacter[] playerCharacters = new PlayerCharacter[6];
PlayerCharacter custom = new PlayerCharacter(color(255, 0, 0), color(255, 56, 46), color(194, 16, 0));
PlayerCharacter player = new PlayerCharacter();

import javax.swing.*;
String name = "player";

//check for button presses
boolean a, d, space;

int menuX, menuY;
int startX, startY, startSize;

int[] coinXCoords = {500, 250, 750, 150, 500, 700, 300, 900, 850, 750, 950, 410, 850, 100, 600};
int[] coinYCoords = {100, 220, 430, 220, 170, 340, 200, 430, 90, 100, 430, 300, 340, 150, 80};
Coin[] coins = new Coin[15];
int[] coinTotals = new int[5];
Coin coin = new Coin();

Coin largeCoin = new Coin(850, 100, 70);
Spike menuSpike = new Spike(0, 500, 30);
Platform menuPlatform = new Platform(775, 150, 150, 15);
Portal menuPortal = new Portal(850, 360, 10);

Spike[] spikes = new Spike[11];
Spike[] largeSpikes = new Spike[3];
float[] spikeX = {200, 200, 360, 520, 680, /**/ 350, 650, /**/ 200, 290, 540, 790};
float[] spikeY = {460, 460, 460, 460, 460, /**/ 460, 460, /**/ 460, 370, 370, 370};
int[] numSpikes = {30, 3, 3, 3, 3, /**/ 6, 12, /**/ 40, 1, 1, 1};
int[] largeSize = {80, 100, 70};
float[] largeX = {460, 250, 615};
float[] largeY = {460, 460, 200};
//small spikes per level - 0,1,4,2,4
//large spikes per level - 0,1,0,2,0

Platform[] platforms = new Platform[32];
float[] platformX = {450, 200, 450, 700, /**/ 250, 100, 250, 650, 800, 650, 450, /**/ 850, 680, 800, 400, 250, 150, /**/ 100, 100, 400, 600, 800, 800, 900, /**/ 250, 500, 750, 900, 750, 550, 350, 150};
float[] platformY = {370, 250, 130, 250, /**/ 370, 250, 130, 130, 250, 370, 200, /**/ 370, 260, 120, 160, 230, 130, /**/ 360, 240, 230, 200, 360, 250, 130, /**/ 370, 370, 370, 240, 150, 110, 150, 110};
//platforms per level - 4,7,6,7,8

Portal[] portals = new Portal[5];
float[] portalX = {900, 900, 200, 950, 200};
float[] portalY = {400, 400, 70, 70, 50};

void setup()
{
  size(1000, 500);
  background(0);
  for (int i=0; i<coins.length; i++)
  {
    coins[i] = new Coin(coinXCoords[i], coinYCoords[i], 40);
  }
  for (int i=0; i<playerCharacters.length; i++)
  {
    playerCharacters[i] = new PlayerCharacter(colours[i*3], colours[i*3 +1], colours[i*3 +2]);
  }
  player.setSize(7);
  for (int i=0; i<spikes.length; i++)
  {
    spikes[i] = new Spike(spikeX[i], spikeY[i], numSpikes[i]);
  }
  for (int i=0; i<largeSpikes.length; i++)
  {
    largeSpikes[i] = new Spike(largeX[i], largeY[i], largeSize[i], 1);
  }
  for (int i=0; i<platforms.length; i++)
  {
    platforms[i] = new Platform(platformX[i], platformY[i]);
  }
  for (int i=0; i<portals.length; i++)
  {
    portals[i] = new Portal(portalX[i], portalY[i]);
  }
}

void draw()
{
  time(60);
  startingScreens();  //all level<1
  if (level>=1)
  {
    background(0);
    backButton(0, 0);
    fill(0, 200, 0);
    rect(0, 460, width, 40);
    player.characterCustom();
  }
  coinManager();
  updatePlayer();
  spikesAndPlatforms();
}

void mouseClicked()
{
  //Starting screens buttons (character selection, statistics, start)
  if (level==0)
  {
    if (mouseX>=(menuX-textWidth("Character Selection")/2) && mouseX<=(menuX+textWidth("Character Selection")/2) && mouseY>=menuY-40 && mouseY<=menuY)
    {
      level=0.1;
    } else if (mouseX>=(menuX-textWidth("Statistics")/2) && mouseX<=(menuX+textWidth("Statistics")/2) && mouseY>=menuY+20 && mouseY<=menuY+60)
    {
      level=0.2;
    } else if (mouseX>=(startX-(startSize*7/6+(textWidth(startWord))/2)) && mouseX<=(startX+(textWidth(startWord)+startSize*14/6)/2) && mouseY>=(startY-startSize/6) && mouseY<=((startY-startSize/6)+startSize*2))
    {
      level=0.3;
    }
  }  //if level == 0 (start screen)
}

void mousePressed()
{
  //name editor
  if (level==0)
  {
    if (mouseX>=10 && mouseX<=60 && mouseY>=10 && mouseY<=60)
    {
      name = JOptionPane.showInputDialog(null, "Please enter your name \nmaximum of 8 characters", name);

      if (name.length() > 8)
      {
        name = name.substring(0, 8);
      }
    }
  }

  //back button
  if (mouseX>=backButtonX && mouseX<=backButtonX+70 && mouseY>=backButtonY && mouseY<=backButtonY+50)
  {
    if (level==0.1 || level==0.2 || level==0.3)
    {
      level=0;
    } else if (level==1 || level==2 || level==3 || level==4 || level==5)
    {
      level=0.3;
    }
  }
  if (level==0.3)  //level selection
  {
    for (int i=0; i<5; i++) {
      if (mouseY>150+i*70 && mouseY<220+i*70)
      {
        level=i+1;
        player.setXCoord(50);
        player.setYCoord(390);
      }
    }
  }
  //Character Selection
  if (level==0.1)
  {
    //colour selection
    for (int i=0; i<6; i++) {
      if (mouseX>=25+i*160 && mouseX<=25+(i+1)*150+i*10 && mouseY>=335 && mouseY<=485)
      {
        custom.setColours(playerCharacters[i].getColour1(), playerCharacters[i].getColour2(), playerCharacters[i].getColour3());
        custom.setCharacterChosen(i+1);
      }
    }
    //face Selection
    int k=1;
    for (int i=0; i<2; i++) {
      for (int j=0; j<3; j++) {
        if (mouseX>505+j*160 && mouseX<505+(j+1)*150+j*10 && mouseY>15+i*160 && mouseY<15+(i+1)*150+i*10)
        {
          custom.setFaceChosen(k);
        }
        k++;
      }  //for int j
    }  //for int i
  }  //if level == 0.1 (character selection)
}

void keyPressed()
{
  if (key == 'd' || key == 'D')
  {
    if (player.getXCoord()<=(1000-player.getSize()*10))
    {
      d = true;
    } else {
      d = false;
    }
  } else if (key == 'a' || key == 'A')
  {
    if (player.getXCoord()>=0)
    {
      a = true;
    } else {
      a = false;
    }
  } else if (key == ' ')
  {
    space = true;
  }

  if (key == 'p' || key == 'P')
  {
    player.setJump(false);
    player.setLanded(true);
    player.setXCoord(50);
    player.setYCoord(390);
    player.setSpeed(0);
  }
}

void keyReleased()
{
  if (key == 'd' || key == 'D')
  {
    d = false;
  } else if (key == 'a' || key == 'A')
  {
    a = false;
  } else if (key == ' ')
  {
    space = false;
  }
}

public boolean platformLand(Platform platform)
{
  if (playerPlatformCollision(player.getXCoord(), player.getYCoord()+player.getSize()*10, player.getXCoord()+player.getSize()*10, player.getYCoord()+player.getSize()*10, platform))
  {
    player.setLanded(true);
    player.setYCoord(platform.getYCoord()-player.getSize()*10);
    if (player.getSpeed()>=0)
    {
      player.setSpeed(0);
    }
  } else {
    player.setLanded(false);
  }
  return player.getLanded();
}

//check if either of the bottom corners of the player touch the top of the platform
public boolean playerPlatformCollision(float xCoord, float yCoord, float xCoord2, float yCoord2, Platform platform)
{
  if (((yCoord >= platform.getYCoord()-8 && yCoord<=platform.getYCoord()+8) && (xCoord>=platform.getXCoord() && xCoord<=platform.getXCoord()+platform.getPWidth())) ||
    ((yCoord2 >= platform.getYCoord()-8 && yCoord2<=platform.getYCoord()+8) && (xCoord2>=platform.getXCoord() && xCoord2<=platform.getXCoord()+platform.getPWidth())))
  {
    return true;
  }
  return false;
}

public void spikeHit(Spike spike)
{
  if (playerSpikeCollision(spike.getXCoord(), spike.getYCoord(), spike.getSize(), spike.getNumSpikes()))
  {
    totalDeaths++;
    player.setJump(false);
    player.setXCoord(50);
    player.setYCoord(390);
  }
}

public boolean playerSpikeCollision(float xCoord, float yCoord, int size, int numSpikes)
{
  // check each edge of the spikes if its collision with the player
  if (linePlayer(xCoord, yCoord, xCoord + size*numSpikes, yCoord)==true || linePlayer(xCoord, yCoord, xCoord+size/2, yCoord - size*3)==true ||
    linePlayer(xCoord+size/2, yCoord - size*3, xCoord+size*numSpikes-size/2, yCoord - size*3)==true ||
    linePlayer(xCoord+size*numSpikes, yCoord, xCoord+size*numSpikes-size/2, yCoord-size*3)==true)
  {
    return true;
  }
  return false;
}

public boolean linePlayer(float x1, float y1, float x2, float y2)
{
  // check if that edge of the spikes has touched any of the edges of the player
  if (lineLine(x1, y1, x2, y2, player.getXCoord(), player.getYCoord(), player.getXCoord(), player.getYCoord()+player.getSize()*10) ||   //left
    lineLine(x1, y1, x2, y2, player.getXCoord()+player.getSize()*10, player.getYCoord(), player.getXCoord()+player.getSize()*10, player.getYCoord()+player.getSize()*10) ||   //right
    lineLine(x1, y1, x2, y2, player.getXCoord(), player.getYCoord(), player.getXCoord()+player.getSize()*10, player.getYCoord()) ||   //top
    lineLine(x1, y1, x2, y2, player.getXCoord(), player.getYCoord()+player.getSize()*10, player.getXCoord()+player.getSize()*10, player.getYCoord()+player.getSize()*10))   //bottom
  {
    return true;
  }
  return false;
}

//lineLine collision method taken from http://www.jeffreythompson.org/collision-detection, I don't quite understand what uA and uB are calculating
public boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the direction of the lines
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    return true;
  }
  return false;
}

boolean collide(int start, int stop)
{
  for (int i=start; i<stop; i++)
  {
    if (platformLand(platforms[i]))

      return true;
  }
  return false;
}

void spikesAndPlatforms()
{
  for (int i=1; i<=5; i++)
  {
    if (level==i)
    {
      portals[i-1].display();
      if (circleCollision(portals[i-1].getXCoord(), portals[i-1].getYCoord(), portals[i-1].getRadius()))
      {
        player.setXCoord(50);
        player.setYCoord(390);
        player.setSpeed(0);
        if (level<5)
          level = i+1;
        else if (level==5)
          level = 0.3;
      }
    }
  }
  if (level==1)
  {
    for (int i=0; i<4; i++)
    {
      platforms[i].display();
    }
    if (collide(0, 4))
    {
      player.setLanded(true);
    }
  } else if (level==2)
  {
    for (int i=4; i<11; i++)
    {
      platforms[i].display();
    }
    if (collide(4, 11))
    {
      player.setLanded(true);
    }
    spikes[0].display();
    largeSpikes[0].display();
    spikeHit(spikes[0]);
    spikeHit(largeSpikes[0]);
  } else if (level==3)
  {
    for (int i=11; i<17; i++)
    {
      platforms[i].display();
    }
    if (collide(11, 17))
    {
      player.setLanded(true);
    }
    for (int i=1; i<5; i++)
    {
      spikes[i].display();
      spikeHit(spikes[i]);
    }
  } else if (level==4)
  {
    for (int i=17; i<24; i++)
    {
      platforms[i].display();
    }
    if (collide(17, 24))
    {
      player.setLanded(true);
    }
    for (int i=1; i<3; i++)
    {
      largeSpikes[i].display();
      spikeHit(largeSpikes[i]);
    }
    for (int i=5; i<7; i++)
    {
      spikes[i].display();
      spikeHit(spikes[i]);
    }
  } else if (level==5)
  {
    for (int i=24; i<32; i++)
    {
      platforms[i].display();
    }
    if (collide(24, 32))
    {
      player.setLanded(true);
    }
    for (int i=7; i<11; i++)
    {
      spikes[i].display();
      spikeHit(spikes[i]);
    }
  }
}

void updatePlayer()
{
  player.setColours(custom.getColour1(), custom.getColour2(), custom.getColour3());
  player.setFaceChosen(custom.getFaceChosen());

  if (d == true)
  {
    player.setXCoord(player.getXCoord()+5);
  }
  if (a == true)
  {
    player.setXCoord(player.getXCoord()-5);
  }
  if (space == true)
  {
    if (player.getYCoord()==player.getGroundY() || player.getLanded()==true)
    {
      player.setJump(true);
      if (level>=1)
      {
        totalJumps++;
      }
    }
  }
  player.moveY();
}

boolean circleCollision(float circleX, float circleY, float circleRadius)
{
  // variables for holding the x and y coords from the player that are closest to the coin
  float testX = circleX;
  float testY = circleY;

  if (circleX < player.getXCoord())
  {
    testX = player.getXCoord();
  } else if (circleX > (player.getXCoord() + player.getSize()*10))
  {
    testX = (player.getXCoord() + player.getSize()*10);
  }

  if (circleY < player.getYCoord())
  {
    testY = player.getYCoord();
  } else if (circleY > (player.getYCoord() + player.getSize()*10))
  {
    testY = (player.getYCoord() + player.getSize()*10);
  }

  //check if distance from the player to the center of the coin is less than the radius
  if ((sqrt(((circleX - testX)*(circleX - testX)) + ((circleY - testY)*(circleY - testY)))) <= circleRadius)
    return true;

  return false;
}

void coinManager()
{
  int k=0;
  for (int i=1; i<=5; i++)
  {
    for (int j=0; j<3; j++)
    {
      if (level == i)
      {
        // display coins only if they havent been collected yet
        if (coins[k].getCollected() == false)
        {
          coins[k].display();
        }
        // collect coin if player touches it
        if (circleCollision(coins[k].getXCoord(), coins[k].getYCoord(), coins[k].getSize()/2) == true)
        {
          coins[k].collect();
        }
      }
      k++;
    }
  }
  //add up the amount of coins collected for each level and the total amount altogether
  for (int i=0; i<5; i++)
  {
    coinTotals[i] = coins[i*3].getValue() + coins[i*3 +1].getValue() + coins[i*3 +2].getValue();
  }
  totalCoins = coinTotals[0] + coinTotals[1] + coinTotals[2] + coinTotals[3] +coinTotals[4];
}

void nameEditor()
{
  noStroke();
  fill(200);
  rect(10, 10, 50, 50);
  fill(50);
  quad(20, 40, 30, 50, 45, 35, 35, 25);
  triangle(18, 42, 28, 52, 12, 58);
  quad(47, 33, 37, 23, 42, 18, 52, 28);
  ellipse(47.5, 22.5, 15, 15);
  textSize(40);
  textAlign(LEFT);
  fill(255);
  text(name, 70, 50);
}

void characterSelection()
{
  //large custom character
  custom.characterCustom(102.5, 17.5, 30);
  //colour selection
  for (int i=0; i<6; i++) {
    noFill();
    strokeWeight(3);
    if (custom.getCharacterChosen()-1==i)
    {
      stroke(0, 0, 255);
      fill(180);
    } else {
      stroke(255);
      fill(220);
    }
    rect(25+i*160, 335, 150, 150);
    playerCharacters[i].displayBody(40+i*160, 350, 12);
    custom.displayFace(40+i*160, 350, 12, custom.getFaceChosen());
  }
  //face selection
  int k=1;
  for (int i=0; i<2; i++) {
    for (int j=0; j<3; j++) {
      if (custom.getFaceChosen()==k)
      {
        stroke(0, 0, 255);
        fill(180);
      } else {
        stroke(255);
        fill(220);
      }
      strokeWeight(3);
      rect(505+j*160, 15+i*160, 150, 150);
      custom.displayBody(520+j*160, 30+i*160, 12);
      custom.displayFace(520+j*160, 30+i*160, 12, k);
      k++;
    }  //for int j
  }  //for int i
}  //void characterSelection()

void padlock( int xCoord, int yCoord, int transparency)
{
  noFill();
  stroke(150, transparency);
  strokeWeight(10);
  bezier(xCoord+15, yCoord+60, xCoord+15, yCoord, xCoord+65, yCoord, xCoord+65, yCoord+60);
  noStroke();
  fill(150, transparency);
  rect(xCoord, yCoord+60, 80, 75);
  fill(100, transparency);
  for (int i=70; i<=130; i+=15) {
    for (int j=10; j<=70; j+=60) {
      ellipse(xCoord+j, yCoord+i, 8, 8);
    }
  }
  ellipse(xCoord+40, yCoord+90, 25, 25);
  quad(xCoord+35, yCoord+100, xCoord+45, yCoord+100, xCoord+50, yCoord+120, xCoord+30, yCoord+120);
}

void backButton(float xCoord, float yCoord)
{
  noStroke();
  fill(255, 0, 0);
  rect(xCoord, yCoord, 70, 50);
  fill(0);
  triangle(xCoord+10, yCoord+25, xCoord+30, yCoord+10, xCoord+30, yCoord+40);
  rect(xCoord+30, yCoord+17.5, 25, 15);
  backButtonX = xCoord;
  backButtonY = yCoord;
}

void time(int fps)
{
  frameRate(fps);
  if (time<60)
  {
    time++;
  } else if (time==60 && timeSeconds<60)
  {
    timeSeconds++;
    time=0;
  } else if (timeSeconds==60)
  {
    timeSeconds=0;
    timeMinutes++;
  }
}

void startingScreens()
{
  if (level==0)  //start screen
  {
    startButton(width/2, 100, 70, startWord, color(0, 255, 0), 255);
    menu(width/2, 320);
    custom.characterCustom(50, 150, 20);
    largeCoin.display();
    //padlock(850, 300, 200);
    nameEditor();
    menuSpike.display();
    menuPlatform.display();
    menuPortal.display();
  } else if (level==0.1)  //character selection screen
  {
    background(0);
    backButton(0, 0);
    characterSelection();
  } else if (level==0.2)  //statistics screen
  {
    stats();
    backButton(0, 0);
  } else if (level==0.3)  //levels screen
  {
    background(0);
    backButton(0, 0);
    levelSelection();
  }
}

void menu(int xCoord, int yCoord)
{
  textAlign(CENTER);
  textSize(40);
  // if mouse over character selection make it red
  if (mouseX>=(xCoord-textWidth("Character Selection")/2) && mouseX<=(xCoord+textWidth("Character Selection")/2) && mouseY>=yCoord-40 && mouseY<=yCoord)
  {
    fill(255, 0, 0);
    text("Character Selection", xCoord, yCoord);
    fill(255);
    text("Statistics", xCoord, yCoord+60);
  }
  // if mouse over statistics make it red
  else if (mouseX>=(xCoord-textWidth("Statistics")/2) && mouseX<=(xCoord+textWidth("Statistics")/2) && mouseY>=yCoord+20 && mouseY<=yCoord+60)
  {
    fill(255);
    text("Character Selection", xCoord, yCoord);
    fill(255, 0, 0);
    text("Statistics", xCoord, yCoord+60);
  } else {  // else make them both white
    fill(255);
    text("Character Selection", xCoord, yCoord);
    text("Statistics", xCoord, yCoord+60);
  }
  menuX=xCoord;
  menuY=yCoord;
}

void startButton(int xCoord, int yCoord, int size, String word, color textColour, color boxColour)
{
  //xCoord is the middle point of the box, yCoord is the top point of the box
  noStroke();
  textAlign(CENTER);
  fill(boxColour);
  background(0);
  //make start button bigger while mouse is in the area of the button
  if (mouseX>=(xCoord-(size*7/6+(textWidth(word))/2)) && mouseX<=(xCoord+(textWidth(word)+size*14/6)/2) && mouseY>=(yCoord-size/6) && mouseY<=((yCoord-size/6)+size*2))
  {
    textSize(size*8/6);
    rect((xCoord-(size*7/6+(textWidth(word))/2)), (yCoord-size/6), (textWidth(word)+size*14/6), size*2);
    fill(textColour);
    text(word, xCoord, yCoord+size*4/3);
  } else {
    textSize(size);
    rect((xCoord-(size+(textWidth(word))/2)), yCoord, (textWidth(word)+size*2), size*5/3);
    fill(textColour);
    text(word, xCoord, yCoord+size*7/6);
  }
  startX=xCoord;
  startY=yCoord;
  startSize=size;
}

void stats()
{
  textAlign(CENTER);
  background(0);
  fill(255);
  textSize(70);
  text(name.toUpperCase() + "'S  STATISTICS", width/2, 70);
  textSize(35);
  textAlign(LEFT);
  text("Total time played: " +timeMinutes +" mins " +timeSeconds +" secs", 300, 250);
  text("Total coins collected: " +totalCoins, 300, 300);
  text("Total number of deaths: " +totalDeaths, 300, 350);
  text("Total jumps: " +totalJumps, 300, 400);
}

void levelSelection()
{
  background(0);
  fill(255);
  textSize(100);
  textAlign(CENTER);
  text("LEVELS", width/2, 110);
  stroke(255);
  line(0, 150, width, 150);
  backButton(0, 0);
  for (int i=0; i<5; i++)
  {
    noStroke();
    if (mouseY>150+i*70 && mouseY<220+i*70)
    {
      fill(0, 0, 255);
      rect(0, 150+i*70, width, 70);
    }
    fill(255);
    textSize(40);
    text("Level " +(i+1), 70, 200+(i*70));
    text(coinTotals[i] + "/3", 890, 197+i*70);

    coin.setXCoord(950);
    coin.setYCoord(185+i*70);
    coin.display();
  }
}
