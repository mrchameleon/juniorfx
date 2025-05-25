shader_type canvas_item;
// https://docs.godotengine.org/en/stable/tutorials/shaders/your_first_shader/your_first_2d_shader.html

// ref: https://www.youtube.com/watch?v=eU-F-xuEo7s&t=47s


uniform sampler2D noise : repeat_enable;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec2 scroll = vec2(0.05, 0.05);
uniform float distortion_strength : hint_range(-1,1) = 0.2;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 noise_col = texture(noise, UV + scroll * TIME);
	vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortion_strength * noise_col.rr);

	COLOR = screen_col;  // comment this + uncomment below to see the noise
	//COLOR = noise_col;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
