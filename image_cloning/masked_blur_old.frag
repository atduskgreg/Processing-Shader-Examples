#extension GL_ARB_texture_rectangle : enable
uniform sampler2DRect tex, mask; 
uniform vec2 direction;
uniform int k;

//#define LOW_RES
//#define USE_HARDWARE_INTERPOLATION
#define STANDARD

void main() {
	vec2 pos = gl_TexCoord[0].st;

	vec4 sum = texture2DRect(tex, pos);
	int i;

	int samples = 1;
	for(i = 1; i < k; i++) {
		vec2 curOffset = float(i) * direction;
		vec4 leftMask = texture2DRect(mask, pos - curOffset);
		vec4 rightMask = texture2DRect(mask, pos + curOffset);
		bool valid = leftMask.r == 1. && rightMask.r == 1.; // ignore black pixels
		if(valid) { 
			sum += 
				texture2DRect(tex, pos + curOffset) +
				texture2DRect(tex, pos - curOffset);
			samples += 2;
		} else {
			break;
		}
	}
	
	gl_FragColor = sum / float(samples);
}