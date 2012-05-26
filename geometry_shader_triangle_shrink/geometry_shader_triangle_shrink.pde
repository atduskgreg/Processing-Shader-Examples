import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader vertexShader;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);

  vertexShader = new GLSLShader(this, "triangleShrinker.vert", "triangleShrinker.geo", "triangleShrinker.frag");  
  int n = vertexShader.getMaxOutVertCount();
  noStroke();
    vertexShader.setupGeometryShader(TRIANGLES, TRIANGLE_STRIP, n);

}

void draw() {
  background(0);
  fill(255, 255*0.5, 0);

  vertexShader.start();
  vertexShader.setFloatUniform("mouseX", map(mouseX, 0, width, 0, 1));

  beginShape(TRIANGLE_STRIP);

  for (int i =0; i <11; i ++) {
    float startX = width/2 - 200;
    float startY =  height/4;
    int triangleHeight = 20;
    vertex(startX, startY + (i * triangleHeight), (i * triangleHeight));
    vertex(startX + 400, startY + (i* triangleHeight ), (i * triangleHeight));
  }
  endShape(CLOSE);
  
  vertexShader.stop();
}

