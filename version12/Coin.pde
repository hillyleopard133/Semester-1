public class Coin
{
  // fields

  private float xCoord, yCoord;
  private float size = 40;
  private boolean collected = false;
  private int value;

  // constructors

  public Coin()
  {
  }

  public Coin(float xCoord, float yCoord)
  {
    if (xCoord>0 && xCoord<1000)
      this.xCoord = xCoord;
    if (yCoord>0 && yCoord<500)
      this.yCoord = yCoord;
  }

  public Coin(float xCoord, float yCoord, float size)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
    if (size>=20 && size<=100)
      this.size = size;
  }

  // methods

  public void display()
  {
    if (collected==false)
    {
      strokeWeight(size*3/40);
      stroke(244, 196, 48);
      fill(255, 215, 0);
      ellipse(xCoord, yCoord, size, size);
      textSize(size);
      textAlign(CENTER);
      fill(225, 173, 33);
      text("C", xCoord-size/40, yCoord+size*(13.5/40));
    }
  }

  public void collect()
  {
    setCollected(true);
    updateValue();
  }

  public void updateValue()
  {
    if (collected==true)
    {
      value=1;
    } else if (collected==false)
    {
      value=0;
    }
  }

  // setters

  public void setXCoord(float xCoord)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
  }

  public void setYCoord(float yCoord)
  {
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
  }

  public void setSize(float size)
  {
    if (size>=20 && size<=100)
      this.size = size;
  }

  public void setCollected(boolean collected)
  {
    this.collected = collected;
  }

  public void setValue(int value)
  {
    if (value==0 || value==1)
      this.value = value;
  }

  // getters

  public float getXCoord()
  {
    return xCoord;
  }

  public float getYCoord()
  {
    return yCoord;
  }

  public float getSize()
  {
    return size;
  }

  public boolean getCollected()
  {
    return collected;
  }

  public int getValue()
  {
    return value;
  }
}
