varying float LightIntensity;

void main(void)
{
    gl_FragColor = vec4(LightIntensity * gl_Color.rgb, 1.);
}