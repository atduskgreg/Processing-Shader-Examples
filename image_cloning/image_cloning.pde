import processing.opengl.*;
import codeanticode.glgraphics.*;

GLTexture face;
GLTexture background;
GLTexture maskTex;

GLTextureFilter maskedBlur;

GLTexture outputTex;

PGraphics mask;

int w = 640;
int h = 480;

void setup() {
  size(w * 2, h, GLConstants.GLGRAPHICS);

 // blurShader = new GLSLShader(this, "passthrough.vert", "masked_blur.frag"); 
 // cloneShader = new GLSLShader(this, "passthrough.vert", "clone.frag");  

 // face = loadImage("face.jpg");
  //background = loadImage("background.jpg");

  face = new GLTexture(this, "face.jpg");
  background = new GLTexture(this, "background.jpg");
  maskTex = new GLTexture(this, w, h);

  maskedBlur = new GLTextureFilter(this, "masked_blur.xml");    

  outputTex = new GLTexture(this, w,h);

  mask = createGraphics(w, h, P2D);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.rect(286, 277, 110, 100);
  mask.endDraw();

  maskTex.putImage(mask);

}

void maskedBlur(PImage src) {
  int k = 10;
  maskedBlur.setParameterValue("k", k);
  maskedBlur.setParameterValue("imgWidth", float(w));
  maskedBlur.setParameterValue("direction", new float[]{1.0, 0.0});
  maskedBlur.apply(new GLTexture[]{face, maskTex}, outputTex);
  image(outputTex, w, 0);
}



void draw() {
  pushMatrix();
  scale(0.5);
  image(background, 0, 0);
  image(face, w, 0);
  image(maskTex, 0, h);
  popMatrix();
    maskedBlur(face);

  //outputTex.render(w,0);
  //PGraphics blur = maskedBlur(face);

  //image(blur, w, 0);
}

