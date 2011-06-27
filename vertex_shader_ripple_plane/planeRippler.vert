varying vec3 myColor;
varying float LightIntensity;

void main(void){
  vec3 thisNorml;
  
  vec4 thisPos = gl_Vertex;
  myColor = gl_Color.rgb;
  
  float thisX = thisPos.x;
  float thisY = thisPos.y;
  
  thisPos.z = 0.3 * sin(thisX*thisX + thisY*thisY);
  
  vec3 LightPos = vec3(0., 10., 0.);
  
  thisNorml.x = 2. * 0.3 * thisX * cos(thisX*thisX + thisY*thisY);
  thisNorml.y = 2. * 0.3 * thisY * cos(thisX*thisX + thisY*thisY);
  thisNorml.z = 1.;
  
  vec3 myNorml = normalize(thisNorml);
  
  vec3 ECpos = vec3(gl_ModelViewMatrix * thisPos);
  
  LightIntensity = dot(normalize(LightPos - ECpos), myNorml);
  LightIntensity = 0.3 + abs(LightIntensity);
  LightIntensity = clamp(LightIntensity, 0., 1.);
  
  gl_Position     = gl_ModelViewProjectionMatrix * thisPos;
}