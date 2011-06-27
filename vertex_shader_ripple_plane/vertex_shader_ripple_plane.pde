import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader vertexShader;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);

  vertexShader = new GLSLShader(this, "planeRippler.vert", "planeRippler.frag");  
  noStroke();
}

void draw() {
  background(0);
  fill(255, 255*0.5, 0);
  //translate(width/2, height/2,0);

  vertexShader.start();
  vertexShader.setFloatUniform("mouseX", map(mouseX, 0, width, 0, 100));
  // vertexShader.setFloatUniform("mouseY", map(mouseY, 0, height, 200, 0));


  beginShape(TRIANGLE_STRIP);

  for (int i =0; i <11; i ++) {
    float startX = width/2 - 200;
    float startY =  height/4;
    int triangleHeight = 20;
    vertex(startX, startY + (i * triangleHeight), (i * triangleHeight));
    vertex(startX + 400, startY + (i* triangleHeight ), (i * triangleHeight));
  }
  endShape();


  vertexShader.stop();
}

