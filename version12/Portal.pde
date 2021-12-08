public class Portal
{
  // fields

  private float xCoord, yCoord;
  private int size = 7;
  private float radius = (size*size)/2;

  // constructors

  public Portal()
  {
  }

  public Portal(float xCoord, float yCoord)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
  }

  public Portal(float xCoord, float yCoord, int size)
  {
    if (xCoord>=0 && xCoord<=1000)
      this.xCoord = xCoord;
    if (yCoord>=0 && yCoord<=500)
      this.yCoord = yCoord;
    if (size>=1 && size<=20)
    {
      this.size = size;
      radius = (size*size)/2;
    }
  }


  // methods

  public void display()
  {
    noStroke();
    for (int i=size; i>0; i--)
    {
      fill(25*i, 0, 18*i);
      ellipse(xCoord, yCoord, i*size, i*size*2);
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

  public void setSize(int size)
  {
    if (size>=1 && size<=20)
    {
      this.size = size;
      radius = (size*size)/2;
    }
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

  public float getRadius()
  {
    return radius;
  }
}
