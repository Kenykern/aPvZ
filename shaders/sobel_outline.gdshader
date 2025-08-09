shader_type canvas_item;

uniform vec4  outline_color    : source_color   = vec4(0.94, 0.34, 0.72, 1.0);
uniform float outline_size     : hint_range(0.0, 5.0) = 1.5;
uniform float edge_threshold   : hint_range(0.0, 1.0) = 0.15;
uniform float smooth_width     : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    vec2 px = outline_size * TEXTURE_PIXEL_SIZE;
    vec4 center = texture(TEXTURE, UV);
    float sa = center.a;
    if (sa < 0.01) {
        discard;
    }

    // 1) Pre-difuminado de alfa y luminancia (3×3 promedio)
    const vec3 LUM = vec3(0.299, 0.587, 0.114);
    float sum_a = 0.0;
    float sum_l = 0.0;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 off = vec2(float(x), float(y)) * px;
            vec4 t = texture(TEXTURE, UV + off);
            sum_a += t.a;
            sum_l += dot(t.rgb, LUM);
        }
    }
    float blur_a = sum_a / 9.0;
    float blur_l = sum_l / 9.0;

    // 2) Dilatación y erosión en alfa y luminancia
    float dil_a = 0.0, ero_a = 1.0;
    float dil_l = 0.0, ero_l = 1.0;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 off = vec2(float(x), float(y)) * px;
            vec4 t = texture(TEXTURE, UV + off);
            float a = t.a;
            float l = dot(t.rgb, LUM);

            dil_a = max(dil_a, a);
            ero_a = min(ero_a, a);
            dil_l = max(dil_l, l);
            ero_l = min(ero_l, l);
        }
    }
    float grad_a = dil_a - ero_a;
    float grad_l = dil_l - ero_l;

    // 3) Generamos máscaras de contorno y las atenuamos
    float raw_a = smoothstep(
        edge_threshold - smooth_width,
        edge_threshold + smooth_width,
        grad_a
    ) * blur_a;

    float raw_l = smoothstep(
        edge_threshold - smooth_width,
        edge_threshold + smooth_width,
        grad_l
    ) * blur_l;

    float edge_mask = max(raw_a, raw_l);

    // 4) Mezcla final (silueta blanca vs outline)
    vec4 base = vec4(1.0, 1.0, 1.0, sa);
    vec4 col  = vec4(outline_color.rgb, sa);
    COLOR = mix(base, col, edge_mask);
}