public class Spike
{
  // fields

  private float xCoord, yCoord;
  private int size = 20;
  private color colour = color(120);
  private int numSpikes;

  // constructors

  public Spike()
  {
  }

  public Spike(float xCoord, float yCoord)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
  }

  public Spike(float xCoord, float yCoord, int numSpikes)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
    this.numSpikes = numSpikes;
  }

  public Spike(float xCoord, float yCoord, int size, int numSpikes)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
    this.numSpikes = numSpikes;
    this.size = size;
  }

  public Spike(float xCoord, float yCoord, int size, color colour, int numSpikes)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
    this.size = size;
    this.colour = colour;
    this.numSpikes = numSpikes;
  }

  // methods

  public void display()
  {
    for (int i=0; i<numSpikes; i++)
    {
      noStroke();
      fill(colour);
      triangle(xCoord +i*size, yCoord, xCoord+size+i*size, yCoord, xCoord+(size/2)+i*size, yCoord - size*3);
    }
  }

  // setters

  public void setXCoord(float xCoord)
  {
    this.xCoord = xCoord;
  }

  public void setYCoord(float yCoord)
  {
    this.yCoord = yCoord;
  }

  public void setSize(int size)
  {
    this.size = size;
  }

  public void setColour(color colour)
  {
    this.colour = colour;
  }

  public void setNumSpikes(int numSpikes)
  {
    this.numSpikes = numSpikes;
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

  public int getSize()
  {
    return size;
  }

  public color getColour()
  {
    return colour;
  }

  public int getNumSpikes()
  {
    return numSpikes;
  }
}
