varying vec4 color;
varying float LightIntensity;

uniform float Density;
uniform float Frequency;

void main(void)
{
  float s = gl_TexCoord[0].s;
  float t = gl_TexCoord[0].t;
  
  float sf = s * Frequency;
  float tf = t * Frequency;
  
  if(fract(sf) >= Density && fract(tf) >= Density){
    discard;
  }
  
    gl_FragColor = vec4(LightIntensity * color.rgb, 1.);
}