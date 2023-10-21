shader_type canvas_item;

uniform float speed;

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x - TIME * float(speed / -4.0), UV.y - TIME * speed));
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}