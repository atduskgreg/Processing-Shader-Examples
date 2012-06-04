uniform sampler2D src_tex_unit0;
uniform sampler2D src_tex_unit1;
uniform vec2 direction;
uniform int k;
uniform float imgWidth;

void main(void) {
 	vec2 pos = gl_TexCoord[0].st;
 	vec4 sum = texture2D(src_tex_unit0, pos);

    int samples = 1;
    int i;
	for(i = 1; i < k; i++) {

	vec2 normDirection;

		if(direction.x == 1.){
			 normDirection = vec2(1./imgWidth, 0);
		} else {
			 normDirection = vec2(0, 1./imgWidth);
		}

		vec2 currOffset = float(i) * normDirection;

		vec4 leftMask = texture2D(src_tex_unit1, pos - currOffset);
		vec4 rightMask = texture2D(src_tex_unit1, pos + currOffset);

		bool valid = leftMask.r == 1. && rightMask.r == 1.;

 		if(valid){
				sum += 
					texture2D(src_tex_unit0, pos + currOffset) +
					texture2D(src_tex_unit0, pos - currOffset);
				samples += 2;
    	} else {
    	   break;
    	}    	

	}
	gl_FragColor = sum / float(samples);


} 