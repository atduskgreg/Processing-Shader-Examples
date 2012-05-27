import processing.opengl.*;
import codeanticode.glgraphics.*;

GLTexture face;
GLTexture background;
GLTexture maskTex;

GLTextureFilter maskedBlur;
GLTextureFilter imageClone;

GLTexture faceBlur;
GLTexture backgroundBlur;
GLTexture finalOutput;

PGraphics mask;

int w = 640;
int h = 480;

void setup() {
  size(w * 2, h, GLConstants.GLGRAPHICS);

  face = new GLTexture(this, "face.jpg");
  background = new GLTexture(this, "background.jpg");
  maskTex = new GLTexture(this, w, h);

  maskedBlur = new GLTextureFilter(this, "masked_blur.xml");    
  imageClone = new GLTextureFilter(this, "image_clone.xml");    

  faceBlur = new GLTexture(this, w,h);
  backgroundBlur = new GLTexture(this, w,h);
  finalOutput = new GLTexture(this, w,h);
  

  mask = createGraphics(w, h, P2D);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.rect(286, 277, 110, 100);
  mask.endDraw();

  maskTex.putImage(mask);

}

void maskedBlur(GLTexture src, GLTexture msk, GLTexture outputTex) {
  int k = 10;
  maskedBlur.setParameterValue("k", k);
  maskedBlur.setParameterValue("imgWidth", float(w));
  maskedBlur.setParameterValue("direction", new float[]{1.0, 0.0});
  maskedBlur.apply(new GLTexture[]{src, msk}, outputTex);
}



void draw() {
  pushMatrix();
  scale(0.5);
  image(background, 0, 0);
  image(face, w, 0);
  image(maskTex, 0, h);
  popMatrix();
  
  maskedBlur(face, maskTex, faceBlur);
  maskedBlur(background, maskTex, backgroundBlur);
    
  imageClone.apply(new GLTexture[]{face, faceBlur, backgroundBlur}, finalOutput);

  image(finalOutput,w,0);
}

