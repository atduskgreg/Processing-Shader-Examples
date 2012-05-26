#version 120
#extension GL_EXT_geometry_shader4: enable

uniform float Shrink;
varying in vec3 Normal[3];
varying out float LightIntensity;

const vec3 LightPos = vec3(0., 10., 0.);

vec3 V[3];
vec3 CG;

void ProduceVertex( int v ){
  
  LightIntensity = dot(normalize(LightPos - V[v]), Normal[v]);
  LightIntensity = abs(LightIntensity);
  
  gl_Position = gl_ModelViewProjectionMatrix * vec4( CG + Shrink * (V[v] - CG), 1. );
  EmitVertex();
}

void main(){
  
  V[0] = gl_PositionIn[0].xyz;
  V[1] = gl_PositionIn[1].xyz;
  V[2] = gl_PositionIn[2].xyz;
  CG = ( V[0] + V[1] + V[2] ) / 3.;
  ProduceVertex(0);
  ProduceVertex(1);
  ProduceVertex(2);
}