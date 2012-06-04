import processing.opengl.*;
import codeanticode.glgraphics.*;

GLTexture face;
GLTexture output;
GLTextureFilter contrast;

int w = 640;
int h = 480;

void setup() {
  size(w * 2, h, GLConstants.GLGRAPHICS);

  face = new GLTexture(this, "face.jpg");
  output = new GLTexture(this, w, h);
  contrast = new GLTextureFilter(this, "contrast.xml");    
}

void draw() {
  contrast.setParameterValue("imgWidth", float(w));
  contrast.setParameterValue("imgHeight", float(h));
  contrast.setParameterValue("contrast", map(mouseX, 0, w/2, 0, 1));
  contrast.apply(face, output);
  image(face, 0, 0);
  image(output, w, 0);
  fill(255);
  text("mouse left-right to set contrast: " + map(mouseX, 0, w/2, 0, 1), 5, height-15);
}



