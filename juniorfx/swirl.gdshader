shader_type canvas_item;

float swirl(vec2 uv, float size, int arms)
{
	float angle = atan(-uv.y + 0.5, uv.x - 0.5) ;
	float len = length(uv - vec2(0.5, 0.5));

	return sin(len * size + angle * float(arms) - TIME);
}

void fragment()
{
	float swirl = swirl(UV, 50.0, 6);
	COLOR += vec4(vec3(swirl), 1.0);
}
