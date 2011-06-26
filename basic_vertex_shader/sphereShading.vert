varying vec4 color;
varying float LightIntensity;

void main(void){
  vec3 LightPos   = vec3(3., 5., 10.);
  vec3 transNorm  = normalize(gl_NormalMatrix * gl_Normal);
  vec3 ECposition = vec3(gl_ModelViewMatrix * gl_Vertex);
  LightIntensity  = dot(normalize( LightPos - ECposition ), transNorm); 
  LightIntensity  = abs(LightIntensity);
  
  color           = gl_Color;  
  gl_Position     = gl_ModelViewProjectionMatrix * gl_Vertex;
}