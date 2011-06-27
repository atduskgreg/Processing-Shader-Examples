varying vec4 color;
varying float LightIntensity;

void main(void)
{
    gl_FragColor = vec4(LightIntensity * color.rgb, 1.);
}