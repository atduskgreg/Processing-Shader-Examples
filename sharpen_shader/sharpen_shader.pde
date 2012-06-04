import processing.opengl.*;
import codeanticode.glgraphics.*;

GLTexture face;
GLTexture output;
GLTextureFilter sharpen;

int w = 640;
int h = 480;

void setup() {
  size(w * 2, h, GLConstants.GLGRAPHICS);

  face = new GLTexture(this, "face.jpg");
  output = new GLTexture(this, w, h);
  sharpen = new GLTextureFilter(this, "sharpen.xml");    
}

void draw() {
  sharpen.setParameterValue("imgWidth", float(w));
  sharpen.setParameterValue("imgHeight", float(h));
  sharpen.setParameterValue("stepSize", map(mouseX, 0, width, 1, 5));
  sharpen.apply(face, output);
  image(face, 0, 0);
  image(output, w, 0);
  
  fill(255);
  text("mouse left-to-right to increase sharpness: " + map(mouseX, 0, width, 1, 5), 5, height - 15);
}

