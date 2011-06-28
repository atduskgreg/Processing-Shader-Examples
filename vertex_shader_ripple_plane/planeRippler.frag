varying vec3 myColor;
varying float LightIntensity;

void main(void)
{
    gl_FragColor = vec4(LightIntensity * myColor.rgb, 1.);
}