varying vec3 Normal;

void main(void)
{
    Normal = gl_Normal;
    gl_Position = ftransform();
}