shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Default red color
uniform float flash_amount : hint_range(0.0, 1) = 0.0; // Control intensity

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (tex_color.a < 0.1) {
        discard; // Preserve transparency
    }
    COLOR = mix(tex_color, flash_color, flash_amount);
}
