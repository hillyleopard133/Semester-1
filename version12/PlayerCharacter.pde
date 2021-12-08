public class PlayerCharacter
{
  // fields

  private color colour1, colour2, colour3;
  private int size;
  private float xCoord, yCoord;
  private int characterChosen=1;
  private int faceChosen=1;
  private boolean jump;
  private float groundY = 390;
  private boolean landed;
  private float gravity = 0.6;
  private float speed;

  // constructors

  public PlayerCharacter()
  {
  }

  public PlayerCharacter(color colour1, color colour2, color colour3)
  {
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.colour3 = colour3;
  }

  public PlayerCharacter(float xCoord, float yCoord, int size)
  {
    if (xCoord>=0 && xCoord<=1000-size*10)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500-size*10)
      this.yCoord = yCoord;
    if (size>=1 && size<=50)
      this.size = size;
  }

  public PlayerCharacter(color colour1, color colour2, color colour3, int size)
  {
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.colour3 = colour3;
    if (size>=1 && size<=50)
      this.size = size;
  }

  public PlayerCharacter(color colour1, color colour2, color colour3, float xCoord, float yCoord)
  {
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.colour3 = colour3;
    if (xCoord>=0 && xCoord<=1000-size*10)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500-size*10)
      this.yCoord = yCoord;
  }

  public PlayerCharacter(color colour1, color colour2, color colour3, float xCoord, float yCoord, int size)
  {
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.colour3 = colour3;
    if (xCoord>=0 && xCoord<=1000-size*10)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500-size*10)
      this.yCoord = yCoord;
    if (size>=1 && size<=50)
      this.size = size;
  }

  // methods

  public void characterCustom(float xCoord, float yCoord, int size)
  {
    displayBody(xCoord, yCoord, size);
    displayFace(xCoord, yCoord, size, faceChosen);
  }

  public void characterCustom()
  {
    displayBody(xCoord, yCoord, size);
    displayFace(xCoord, yCoord, size, faceChosen);
  }

  public void moveY()
  {
    if (yCoord >= groundY)
    {
      landed = true;
      yCoord = groundY;
    }
    if (speed>=0 && landed==true)
    {
      speed = 0;
    }
    if (landed == true && speed<0)
    {
      jump = false;
      landed = false;
    }
    if (jump == true)
    {
      speed = -15;
      jump = false;
      landed = false;
    }
    if (landed==false)
    {
      speed += gravity;
    }
    yCoord += speed;
  }

  public void displayBody(float xCoord, float yCoord, int size)
  {
    noStroke();
    fill(colour2);
    rect(xCoord, yCoord, size*10, size*10);
    fill(colour1);
    rect(xCoord+size, yCoord+size, size*8, size*8);
    for (int i=0; i<8; i++) {
      for (int j=0; j<2; j++) {
        if ((i+j+1)%2==0)
        {
          fill(colour3);
        } else {
          fill(colour1);
        }
        rect(xCoord+size+i*size, yCoord+size*7+j*size, size, size);
        rect(xCoord+size+i*size, yCoord+size+j*size, size, size);
      }
    }
  }

  public void displayFace(float xCoord, float yCoord, int size, int faceNum)
  {
    noStroke();
    //square size= size*10
    if (faceNum==1)  //happy
    {
      eye(xCoord+size*3, yCoord+size*4, size*2.5, size*3.5);
      eye(xCoord+size*7, yCoord+size*4, size*2.5, size*3.5);
      arc(xCoord+size*5, yCoord+size*6.5, size*4, size*3, 0, PI, CHORD);
    } else if (faceNum==2)  //angry
    {
      eye(xCoord+size*3, yCoord+size*4, size*3);
      eye(xCoord+size*7, yCoord+size*4, size*3);
      quad(xCoord+size*2, yCoord+size*1.8, xCoord+size, yCoord+size*2.8, xCoord+size*4.8, yCoord+size*3.8, xCoord+size*4.8, yCoord+size*2.8);
      quad(xCoord+size*8, yCoord+size*1.8, xCoord+size*9, yCoord+size*2.8, xCoord+size*5.2, yCoord+size*3.8, xCoord+size*5.2, yCoord+size*2.8);
      rect(xCoord+size*3, yCoord+size*6.5, size*4, size*1.8);
    } else if (faceNum==3)  //shock
    {
      eye(xCoord+size*3, yCoord+size*4, size*3);
      eye(xCoord+size*7, yCoord+size*4, size*3);
      ellipse(xCoord+size*5, yCoord+size*6.5, size*2, size*2.5);
    } else if (faceNum==4)  //sad
    {
      eye(xCoord+size*3, yCoord+size*4, size*2.5, size*3.5);
      eye(xCoord+size*7, yCoord+size*4, size*2.5, size*3.5);
      quad(xCoord+size*1.1, yCoord+size*2.8, xCoord+size, yCoord+size*3.8, xCoord+size*4.8, yCoord+size*2.8, xCoord+size*3.8, yCoord+size*1.8);
      quad(xCoord+size*8.9, yCoord+size*2.8, xCoord+size*9, yCoord+size*3.8, xCoord+size*5.2, yCoord+size*2.8, xCoord+size*6.2, yCoord+size*1.8);
      arc(xCoord+size*5, yCoord+size*7.5, size*4, size*3, -PI, 0, CHORD);
    } else if (faceNum==5)  //cyclops
    {
      fill(255);
      ellipse(xCoord+size*5, yCoord+size*4.5, size*3, size*4.5);
      fill(0);
      ellipse(xCoord+size*5, yCoord+size*4.5, size, size*1.2);
      rect(xCoord+size*2.5, yCoord+size*2, size*5, size*1.2);
      stroke(0);
      strokeWeight(size/3);
      line(xCoord+size*2, yCoord+size*7.5, xCoord+size*8, yCoord+size*7.5);
      line(xCoord+size*2, yCoord+size*7, xCoord+size*2, yCoord+size*8);
      line(xCoord+size*8, yCoord+size*7, xCoord+size*8, yCoord+size*8);
      noStroke();
    } else if (faceNum==6)  //two face
    {
      fill(255);
      ellipse(xCoord+size*3, yCoord+size*4, size*2.5, size*3.5);
      fill(0);
      ellipse(xCoord+size*3, yCoord+size*4, size, size);
      ellipse(xCoord+size*7, yCoord+size*4, size*2.5, size*3.5);
      arc(xCoord+size*5, yCoord+size*6.5, size*4, size*3, PI/2, PI, PIE);
      fill(255);
      ellipse(xCoord+size*7, yCoord+size*4, size, size);
      arc(xCoord+size*5, yCoord+size*6.5, size*4, size*3, 0, PI/2, PIE);
    }
  }

  private void eye(float xCoord, float yCoord, float size)  //circle eye
  {
    fill(255);
    ellipse(xCoord, yCoord, size, size);
    fill(0);
    ellipse(xCoord, yCoord, size/3, size/3);
  }

  private void eye(float xCoord, float yCoord, float sizeWidth, float sizeHeight)  //ellipse eye
  {
    fill(255);
    ellipse(xCoord, yCoord, sizeWidth, sizeHeight);
    fill(0);
    ellipse(xCoord, yCoord, sizeWidth/2.5, sizeWidth/2.5);
  }

  // setters

  public void setColours(color colour1, color colour2, color colour3)
  {
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.colour3 = colour3;
  }

  public void setColour1(color colour1)
  {
    this.colour1 = colour1;
  }

  public void setColour2(color colour2)
  {
    this.colour2 = colour2;
  }

  public void setColour3(color colour3)
  {
    this.colour3 = colour3;
  }

  public void setSize(int size)
  {
    if (size>=1 && size<=50)
      this.size = size;
  }

  public void setCharacterChosen(int characterChosen)
  {
    if (characterChosen>=1 && characterChosen<=6)
      this.characterChosen = characterChosen;
  }

  public void setFaceChosen(int faceChosen)
  {
    if (faceChosen>=1 && faceChosen<=6)
      this.faceChosen = faceChosen;
  }

  public void setXCoord(float xCoord)
  {
    if (xCoord>=0 && xCoord<=1000-size*10)
      this.xCoord = xCoord;
  }

  public void setYCoord(float yCoord)
  {
    if (yCoord>=0 && yCoord<=500-size*10)
      this.yCoord = yCoord;
  }

  public void setJump(boolean jump)
  {
    this.jump = jump;
  }

  public void setGroundY(float groundY)
  {
    if (groundY>=0 && groundY<=500-size*10)
      this.groundY = groundY;
  }

  public void setLanded(boolean landed)
  {
    this.landed = landed;
  }

  public void setGravity(float gravity)
  {
    if (gravity>0 && gravity<=2)
      this.gravity = gravity;
  }

  public void setSpeed(float speed)
  {
    if (speed>= -30 && speed<= 30)
      this.speed = speed;
  }

  // getters

  public color getColour1()
  {
    return colour1;
  }

  public color getColour2()
  {
    return colour2;
  }

  public color getColour3()
  {
    return colour3;
  }

  public int getSize()
  {
    return size;
  }

  public int getCharacterChosen()
  {
    return characterChosen;
  }

  public int getFaceChosen()
  {
    return faceChosen;
  }

  public float getXCoord()
  {
    return xCoord;
  }

  public float getYCoord()
  {
    return yCoord;
  }

  public boolean getJump()
  {
    return jump;
  }

  public float getGroundY()
  {
    return groundY;
  }

  public boolean getLanded()
  {
    return landed;
  }

  public float getGravity()
  {
    return gravity;
  }

  public float getSpeed()
  {
    return speed;
  }
}
