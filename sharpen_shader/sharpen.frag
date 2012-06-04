uniform sampler2D src_tex_unit0;
uniform float imgWidth;
uniform float imgHeight;
uniform float stepSize;

// NOTE: we should initialize these arrays up here
// 		 but that syntax doesn't work on OSX for some reason
//		 so we set these array values in main(), which
//       is bad for performance, but works on OSX

float kernel[9];
vec2 offset[9];

float step_w = stepSize/imgWidth;
float step_h = stepSize/imgHeight;

void main() {
	offset[0] = vec2(-step_w, -step_h);
	offset[1] = vec2(0.0, -step_h);
	offset[2] = vec2(step_w, -step_h);
	offset[3] = vec2(-step_w, 0.0);
	offset[4] = vec2(0.0, 0.0);
	offset[5] = vec2(step_w, 0.0);
	offset[6] = vec2(-step_w, step_h);
	offset[7] = vec2(0.0, step_h);
	offset[8] = vec2(step_w, step_h);


	/* SHARPEN KERNEL 
	 0 -1  0
	-1  5 -1
	 0 -1  0
	*/

	kernel[0] = 0.;
	kernel[1] = -1.;
	kernel[2] = 0.;
	kernel[3] = -1.;
	kernel[4] = 5.;
	kernel[5] = -1.;
	kernel[6] = 0.;
	kernel[7] = -1.;
	kernel[8] = 0.;

	vec4 sum = vec4(0.0);
	int i;

	for (i = 0; i < 9; i++) {
		vec4 color = texture2D(src_tex_unit0, gl_TexCoord[0].st + offset[i]);
		sum += color * kernel[i];
	}

	gl_FragColor = sum;
}

