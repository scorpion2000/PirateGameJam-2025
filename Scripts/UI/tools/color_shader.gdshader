shader_type canvas_item;

uniform vec4 modulate_color = vec4(1.0, 1.0, 1.0, 1.0); // Default color is white

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = tex_color * modulate_color;
}