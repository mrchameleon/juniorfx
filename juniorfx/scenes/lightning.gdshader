shader_type canvas_item;

// reference video:
// https://www.youtube.com/watch?v=WthCMZ1nm2Q

uniform vec3 effect_color: source_color = vec3(0.2, 0.3, 0.8);
uniform int octave_count: hint_range(1, 20) = 10;
uniform float amp_start = 0.5;
uniform float amp_coeff = 0.5;
uniform float freq_coeff = 2.0;
uniform float speed = 0.5;


float hash12(vec2 x){
	//what in tarnation?
	return fract(cos(mod(dot(x, vec2(13.9898, 8.141)), 3.14)) * 43758.5453);
}

vec2 hash22(vec2 value){
	value = vec2( dot(value, vec2(127.1,311.7) ),
				  dot(value, vec2(269.5,183.3) ) );
	return -1.0 + 2.0 * fract(sin(value) * 43758.5453123);
}

//float noise(vec2 uv) {
	//return sin(uv.x + uv.y);  // try out different operators! (+, -, *, /)
//}

// https://godotshaders.com/snippet/seamless-perlin-noise/
float noise(vec2 uv) {
	vec2 iuv = floor(uv);
	vec2 fuv = fract(uv);
	vec2 blur = smoothstep(0.0, 1.0, fuv);
	return mix( mix( dot(hash22(iuv + vec2(0.0, 0.0)), fuv - vec2(0.0,0.0)),
                     dot(hash22(iuv + vec2(1.0, 0.0)), fuv - vec2(1.0,0.0)), blur.x),
                mix( dot(hash22(iuv + vec2(0.0, 1.0)), fuv - vec2(0.0,1.0)),
                     dot(hash22(iuv + vec2(1.0, 1.0)), fuv - vec2(1.0,1.0)), blur.x), blur.y) + 0.5;
}

// implementation of fractal brownian motion
// https://godotshaders.com/snippet/fractal-brownian-motion-fbm/
float fbm(vec2 uv, int octaves) {
	float value = 0.0;
	float amplitude = amp_start;
	for (int i = 0; i < octaves; i++) {
		value += amplitude * noise(uv);
		uv *= freq_coeff;
		amplitude *= amp_coeff;
	}
	return value;
} 

void fragment() {
	float thickness = 0.05;  // try different values (1, 0.1, 0.05)
	vec2 uv = 2.0 * UV - 1.0;
	uv += 2.0 * fbm(uv + TIME * speed, octave_count) - 1.0;
	//uv += fbm(uv, octave_count);
	float dist = abs(uv.x);
	vec3 color = effect_color * mix(0.0, thickness, hash12(vec2(TIME))) / dist;
	COLOR = vec4(color, 1.0);
}
