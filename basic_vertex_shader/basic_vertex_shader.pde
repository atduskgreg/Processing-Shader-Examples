import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader vertexShader;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);

  vertexShader = new GLSLShader(this, "sphereShading.vert", "sphereShading.frag");  
  noStroke();
}

float y = 0;

void draw() {
  background(0);
  fill(255, 255*0.5, 0);
  
  pushMatrix();
    translate(width/2, height/2, 0);
    rotateY(y+=0.01);

    vertexShader.start();
    box(300);
    vertexShader.stop();
  popMatrix(); 
}

