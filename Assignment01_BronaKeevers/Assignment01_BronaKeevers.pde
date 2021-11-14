//colour array
color[] colours = {
  color(255, 42, 0), color(255, 106, 0), color(255, 145, 0), color(255, 195, 0), color(255, 229, 0), //row 1
  color(0, 153, 10), color(63, 189, 0), color(88, 255, 0), color(153, 255, 1), color(194, 252, 0), //row 2
  color(33, 1, 158), color(0, 51, 189), color(0, 149, 255), color(0, 234, 255), color(168, 255, 242), //row 3
  color(123, 0, 163), color(178, 0, 189), color(254, 0, 194), color(255, 106, 223), color(253, 181, 248), //row4
  color(0), color(60), color(120), color(180), color(255)};  //row 5

//colour selection grid
int gap=3;
int rectSize=20;
color colour;

//shape choice, 1=line, 2=square, 3=triangle, 4=star
int shape=1;
int shapeXCoord, shapeGap, shapeYCoord;
float shapeSquareSize;

//variables for stroke weight
float diameter=5;
float stroke=5;
int strokeX, strokeY, strokeBoxWidth, strokeBoxHeight;

void setup()
{
  size(800, 600);
  background(255);
}

void draw()
{
  title(50, "DRAWING");
  backgroundSetButton("Clear", color(255, 0, 0), 255, width-(textWidth("Clear")+10));
  backgroundSetButton("Fill", 220, 0, width-(textWidth("ClearFill")+20));
  shapeChoice(53, 3, 338, 50);
  strokeWeightSlider(118, 50, 220, 59);
  colourGrid();
 
  strokeWeight(stroke);
  stroke(colour);
  if (mousePressed && shape==1)
  {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }  //close if mousePressed (drawing line)
} //close void draw

void mousePressed()
{
  //colour selection
  int k=0;
  for (int i=0; i<=4; i++) {
    for (int j=0; j<=4; j++) {
      if (mouseX>((gap*(j+1))+(rectSize*j)) && mouseX<((gap+rectSize)*(j+1)) && mouseY>(50+(gap*(i+1))+(rectSize*i)) && mouseY<(50+(gap+rectSize)*(i+1)))
      {
        colour=colours[k];
      }
      k++;
    }//for j
  }//for i

  //clear and fill button
  if (mouseX>=width-(textWidth("Clear")+10) && mouseX<=width && mouseY>=50 &&mouseY<=80)
    background(255);
  else if (mouseX>=width-(textWidth("ClearFill")+20) && mouseX<=width-(textWidth("Clear")+10) && mouseY>=50 && mouseY<=80)
    background(colour);

  //draw chosen shape to screen scaled with stroke size
  fill(colour);
  if (mouseY>103)
  {
    if (shape==2)
    {
      rect(mouseX - stroke*2, mouseY-stroke*2, stroke*4, stroke*4);
    } else if (shape==3)
    {
      triangle(mouseX, mouseY-stroke*2, mouseX-stroke*2, mouseY+stroke*2, mouseX+stroke*2, mouseY+stroke*2);
    } else if (shape==4)
    {
      triangle(mouseX, mouseY-stroke*2.5, mouseX-stroke*2, mouseY+stroke*1.2, mouseX+stroke*2, mouseY+stroke*1.2);
      triangle(mouseX, mouseY+stroke*2.5, mouseX+stroke*2, mouseY-stroke*1.2, mouseX-stroke*2, mouseY-stroke*1.2);
    }
  }

  //shape selection
  for (int i=1; i<=4; i++)
  {
    if (mouseY>=(shapeYCoord+shapeGap) && mouseY <=(shapeYCoord+shapeGap+shapeSquareSize))
    {
      if (mouseX>=(shapeXCoord+shapeGap*i+shapeSquareSize*(i-1)) && mouseX<=(shapeXCoord+shapeGap*i+shapeSquareSize*i))
        shape=i;
    }
  }

  //set stroke to diameter of stroke weight slider ellipse
  if (mouseX>=strokeX && mouseX<=(strokeX+strokeBoxWidth) && mouseY >=strokeY && mouseY<=(strokeY+strokeBoxHeight))
    stroke=diameter;
}  //close void mousePressed


void title(int size, String word)
{
  textAlign(CENTER);
  noStroke();
  fill(180);
  rect(0, 0, width, size);
  textSize(size);
  fill(255);
  text(word, width/2, size - size/7);
  textSize(30);
}

void colourGrid()
{
  //colour grid background
  fill(50);
  rect(0, 50, rectSize*5+ gap*6, rectSize*5+ gap*6);
  //colour grid squares
  int k=0;
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      fill(colours[k]);
      noStroke();
      rect(gap + (j * (gap+rectSize)), 50 +gap + (i *(rectSize+gap)), rectSize, rectSize);
      k++;
    }  //close for j
  }  //close for i
}

void backgroundSetButton(String word, color colour1, color textColour, float boxXCoord)
{
  textSize(30);
  noStroke();
  textAlign(LEFT);
  fill(colour1);
  rect(boxXCoord, 50, ((textWidth(word))+10), 30);
  fill(textColour);
  text(word, boxXCoord+5, 76);
}

void strokeWeightSlider(int x, int y, int boxWidth, int boxHeight)
{
  fill(220);
  rect (x, y, boxWidth, boxHeight);  //background rect
  stroke(0);
  strokeWeight(1);
  line(x+(boxHeight/2), y+(boxHeight/2), (x+boxWidth)-(boxHeight/2), y+(boxHeight/2));  //slider line
  fill(colour);
  noStroke();
  //ellipse drawn to mouseX coord along line while mouse is inside the rect
  if (mouseX>=x+(boxWidth/7) && mouseX<=((x+boxWidth)-(boxWidth/7)) && mouseY >=y && mouseY<=(y+boxHeight))
  {
    diameter=((mouseX-(x+(boxWidth/7)))/((boxWidth-boxHeight)/(160/3)));
    ellipse(mouseX, y+(boxHeight/2), diameter, diameter);
  }
  //when mouse inside area of rect but outside of where the line is, ellipse is draw to the edge of the line
  else if (mouseX>=x && mouseX<=(x+(boxWidth/7)) && mouseY>=y && mouseY<=(y+boxHeight))
  {
    diameter=0.2;
    ellipse((x+(boxWidth/7)), y+(boxHeight/2), diameter, diameter);
  } else if (mouseX>=((x+boxWidth)-(boxWidth/7)) && mouseX<=(x+boxWidth) && mouseY>=y && mouseY<=(y+boxHeight))
  {
    diameter=160/3;
    ellipse(((x+boxWidth)-(boxWidth/7)), y+(boxHeight/2), diameter, diameter);
  }
  //when mouse not in slider area ellipse is drawn to the selected stroke size
  else
  {
    ellipse((stroke*((boxWidth-boxHeight)/(160/3)))+(x+(boxWidth/7)), y+(boxHeight/2), stroke, stroke);
  }
  //variables to use for mousePressed
  strokeBoxWidth=boxWidth;
  strokeBoxHeight=boxHeight;
  strokeX=x;
  strokeY=y;
}

void shapeChoice(float squareSize, int gap, int xCoord, int yCoord)
{
  noStroke();
  fill(220);
  rect(xCoord, yCoord, ((squareSize*4)+(gap*5)), (squareSize+(gap*2)));  //background rect
  fill(180);
  //square buttons for each shape
  for (int i=0; i<4; i++)
  {
    rect((xCoord+gap)+((squareSize+gap)*i), yCoord+gap, squareSize, squareSize);
  }
  //shapes on the buttons
  fill(0);
  strokeWeight((squareSize+gap)/10);
  stroke(0);
  line(xCoord+gap+squareSize*39/47, yCoord+gap+squareSize*8/47, xCoord+gap+squareSize*8/47, yCoord+gap+squareSize*39/47);
  noStroke();
  rect(xCoord+gap*2+squareSize*55/47, yCoord+gap+squareSize*8/47, squareSize*31/47, squareSize*31/47);
  triangle(xCoord+gap*3+squareSize*102/47, yCoord+gap+squareSize*39/47, xCoord+gap*3+squareSize*133/47, yCoord+gap+squareSize*39/47, xCoord+gap*3+squareSize*2.5, yCoord+gap+squareSize*8/47);
  //star
  triangle(xCoord+gap*4+squareSize*149/47, yCoord+gap+squareSize*32/47, xCoord+gap*4+squareSize*3.5, yCoord+gap+squareSize*7/47, xCoord+gap*4+squareSize*180/47, yCoord+gap+squareSize*32/47);
  triangle(xCoord+gap*4+squareSize*149/47, yCoord+gap+squareSize*15/47, xCoord+gap*4+squareSize*3.5, yCoord+gap+squareSize*40/47, xCoord+gap*4+squareSize*180/47, yCoord+gap+squareSize*15/47);
  //variables to use for mousePressed
  shapeXCoord=xCoord;
  shapeGap=gap;
  shapeSquareSize=squareSize;
  shapeYCoord=yCoord;
}
