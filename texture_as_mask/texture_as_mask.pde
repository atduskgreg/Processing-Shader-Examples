import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader vertexShader;
GLTexture maskTexture;

void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);

  vertexShader = new GLSLShader(this, "textureMask.vert", "textureMask.frag");  
   noStroke();
  
  maskTexture = new GLTexture(this, "grid_texture.jpg");
  
}

void draw() {
  background(0);
  fill(255, 255*0.5, 0);
  translate(width/2, height/2,0);
  
     maskTexture.loadPixels();

  vertexShader.start();
  vertexShader.setFloatUniform("Density", map(mouseX, 0, width, 0, 1));
  vertexShader.setFloatUniform("Frequency", map(mouseY, 0, height, 1, 0));

   sphere(100);
  

  vertexShader.stop();
}

