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
GLTexture buffer;
GLTexture positionedFace;

PGraphics faceCanvas;

PGraphics mask;

int w = 640;
int h = 480;

int k = 10;

void setup() {
  size(w * 2, h, GLConstants.GLGRAPHICS);

  face = new GLTexture(this, "face.jpg");
  background = new GLTexture(this, "background.jpg");
  maskTex = new GLTexture(this, w, h);

  maskedBlur = new GLTextureFilter(this, "masked_blur.xml");    
  imageClone = new GLTextureFilter(this, "image_clone.xml");    

  faceBlur = new GLTexture(this, w, h);
  backgroundBlur = new GLTexture(this, w, h);
  finalOutput = new GLTexture(this, w, h);
  buffer = new GLTexture(this, w, h);

  positionedFace = new GLTexture(this, w, h);
  faceCanvas = createGraphics(w, h, P2D);

  mask = createGraphics(w, h, P2D);
}

void maskedBlur(GLTexture src, GLTexture msk, GLTexture outputTex) {
  maskedBlur.setParameterValue("k", k);
  maskedBlur.setParameterValue("imgWidth", float(w));
  maskedBlur.setParameterValue("direction", new float[] {1.0, 0.0});
  maskedBlur.apply(new GLTexture[] {src, msk}, buffer);

  maskedBlur.setParameterValue("k", k);
  maskedBlur.setParameterValue("imgWidth", float(w));
  maskedBlur.setParameterValue("direction", new float[] {0.0, 1.0});
  maskedBlur.apply(new GLTexture[] {buffer, msk}, outputTex);
}

void draw() {
  background(125);
  
  faceCanvas.beginDraw();
  faceCanvas.background(0);
  faceCanvas.translate(-286, -287);
  faceCanvas.translate(mouseX, mouseY);
  faceCanvas.image(face, 0, 0);
  faceCanvas.endDraw();
  positionedFace.putImage(faceCanvas);

  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.translate(mouseX, mouseY);
  mask.rect(0, 0, 100, 100);
  mask.endDraw();

  maskTex.putImage(mask);

  pushMatrix();
  scale(0.5);
  image(background, 0, 0);
  image(faceCanvas, w, 0);
  image(maskTex, 0, h);
  popMatrix();
  
  text("Top Left - Background Source\nTop Right - Foreground Source\nLeft - Mask\n\nUp/down arrows control strength ("+ k +")\nMouse controls position", 330, 260 );

  maskedBlur(positionedFace, maskTex, faceBlur);
  maskedBlur(background, maskTex, backgroundBlur);

  imageClone.apply(new GLTexture[] {positionedFace, faceBlur, backgroundBlur}, finalOutput);

  image(finalOutput, w, 0);
}

void keyPressed() {
    if (keyCode == UP) {
      k++;
    }

    if (keyCode == DOWN) {
      k--;
    }
}

