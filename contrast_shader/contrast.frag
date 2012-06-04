uniform sampler2D src_tex_unit0;
uniform float imgWidth;
uniform float imgHeight;
uniform float contrast;

float step_w = 1.0/imgWidth;
float step_h = 1.0/imgHeight;

void main() {
	vec3 color = vec3(texture2D(src_tex_unit0, gl_TexCoord[0].st));
	const vec3 LumCoeff = vec3(0.2125, 0.7154, 0.0721);
	
	vec3 AvgLumin = vec3(0.5, 0.5, 0.5);

	vec3 intensity = vec3(dot(color, LumCoeff));

	// could substitute a uniform for this 1. and have variable saturation
	vec3 satColor = mix(intensity, color, 1.); 
	vec3 conColor = mix(AvgLumin, satColor, contrast);

	gl_FragColor = vec4(conColor, 1);
}

