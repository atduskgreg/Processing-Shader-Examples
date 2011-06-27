import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader vertexShader;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);

  vertexShader = new GLSLShader(this, "sphereShading.vert", "sphereShading.frag");  
  noStroke();
}

void draw() {
  background(0);
  fill(255, 255*0.5, 0);
  
  pushMatrix();
    translate(width/2, height/2, 0);
    
    vertexShader.start();
        vertexShader.setFloatUniform("mouseX", map(mouseX, 0, width, 0, 200));
        vertexShader.setFloatUniform("mouseY", map(mouseY, 0, height, 200, 0));
        sphere(200);
    vertexShader.stop();
  popMatrix(); 
}

