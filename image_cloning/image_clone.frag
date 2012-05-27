uniform sampler2D src_tex_unit0, src_tex_unit1, src_tex_unit2;//src, srcBlur, dstBlur;

void main() {
	vec2 pos = gl_TexCoord[0].st;	
	vec4 srcColorBlur = texture2D(src_tex_unit1, pos);
	if(srcColorBlur.a > 0.) {
		vec3 srcColor = texture2D(src_tex_unit0, pos).rgb;
		vec4 dstColorBlur = texture2D(src_tex_unit2, pos);
		vec3 offset = (dstColorBlur.rgb - srcColorBlur.rgb);
		gl_FragColor = vec4(srcColor + offset, 1.);
	} else {
		gl_FragColor = vec4(0.);
	}
}