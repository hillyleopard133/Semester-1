public class Platform
{
  // fields

  private float xCoord, yCoord;
  private int pHeight = 10;
  private int pWidth = 100;
  private color colour = color(255, 0, 0);

  // constructors

  public Platform()
  {
  }

  public Platform(float xCoord, float yCoord)
  {
    this.xCoord = xCoord;
    this.yCoord = yCoord;
  }

  public Platform(float xCoord, float yCoord, color colour)
  {
    this.xCoord = xCoord;
    this.yCoord = yCoord;
    this.colour = colour;
  }

  public Platform(float xCoord, float yCoord, int pWidth, int pHeight)
  {
    this.xCoord = xCoord;
    this.yCoord = yCoord;
    this.pWidth = pWidth;
    this.pHeight = pHeight;
  }

  public Platform(float xCoord, float yCoord, int pWidth, int pHeight, color colour)
  {
    this.xCoord = xCoord;
    this.yCoord = yCoord;
    this.pWidth = pWidth;
    this.pHeight = pHeight;
    this.colour = colour;
  }

  // methods

  public void display()
  {
    fill(colour);
    noStroke();
    rect(xCoord, yCoord, pWidth, pHeight);
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

  public void setPHeight(int pHeight)
  {
    this.pHeight = pHeight;
  }

  public void setPWidth(int pWidth)
  {
    this.pWidth = pWidth;
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

  public int getPHeight()
  {
    return pHeight;
  }

  public int getPWidth()
  {
    return pWidth;
  }
}
