uniform sampler2D src_tex_unit0;
uniform sampler2D src_tex_unit1;
uniform vec2 direction;
uniform int k;
uniform float imgWidth;

void main(void) {
 	vec2 pos = gl_TexCoord[0].st;
 	vec4 img = texture2D(src_tex_unit0, pos);
 	vec4 msk = texture2D(src_tex_unit1, pos);

    int samples = 1;
    int i = 1;
	for(i = 1; i < k; i++) {

		vec2 currOffset = float(i) * vec2(1./imgWidth, 0);

 		if(msk.r > 0.5){
				img += 
					texture2D(src_tex_unit0, pos + currOffset) +
					texture2D(src_tex_unit0, pos - currOffset);
				samples += 2;
    	} else {
    	   break;
    	}    	

	}
	    	gl_FragColor = img / float(samples);


} 