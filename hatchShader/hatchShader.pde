import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader vertexShader;

void setup() {
  size(800, 800, GLConstants.GLGRAPHICS);

  vertexShader = new GLSLShader(this, 
  "Hatch.vert", "Hatch.frag");  
  noStroke();
}

float y = 0;

void draw() {
  background(0);
  fill(255, 255*0.5, 0);

    pointLight(100, 200, 100, 0, 1, 1);
    pointLight(100, 200, 100, 0, 0, -1);
  
  sphereDetail(60);
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(HALF_PI+(y+=0.02));
  rotateY(y);

  vertexShader.start();

  vertexShader.setFloatUniform("frequency", map(mouseX, 0, width, 0.5, 3));
  vertexShader.setFloatUniform("edgew", map(mouseY, 0, height, 0, 1));
  vertexShader.setVecUniform("HatchDirection", 0, 0.5f, 0.5f);
  vertexShader.setFloatUniform("Lightness", 0.2f);    

  scale(1.2);
  translate(-100, 100, -50);
  sphere(150);
  translate(200, 0, 0);
  sphere(150);
  translate(-100, -200, 0);
  sphere(150);
  vertexShader.stop();

  popMatrix();
}

