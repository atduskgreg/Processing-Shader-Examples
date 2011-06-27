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


  vertexShader.start();
   // vertexShader.setFloatUniform("mouseX", map(mouseX, 0, width, 0, 200));
   // vertexShader.setFloatUniform("mouseY", map(mouseY, 0, height, 200, 0));

  beginShape(QUADS);
    vertex(width/2 - 200, height/2 + 100, 0);
    vertex(width/2 + 200, height/2 + 100, 0);
    vertex(width/2+200, height/2 - 100, -200);
    vertex(width/2-200, height/2 - 100, -200);
  endShape();


  vertexShader.stop();
}
