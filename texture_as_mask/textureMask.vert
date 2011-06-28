varying vec4 color;
varying float LightIntensity;

void main(void){
  vec3 transNorm = normalize( vec3(gl_NormalMatrix * gl_Normal) );
  vec3 LightPos = vec3(0., 0., 10.);
  vec3 ECpos = vec3(gl_ModelViewMatrix * gl_Vertex);

  LightIntensity = dot(normalize(LightPos - ECpos), transNorm);
  LightIntensity = 0.3 + abs(LightIntensity);
  LightIntensity = clamp(LightIntensity, 0., 1.);
  
  gl_TexCoord[0] = gl_MultiTexCoord0;
  color = gl_Color;
  gl_Position     = gl_ModelViewProjectionMatrix * gl_Vertex;
}