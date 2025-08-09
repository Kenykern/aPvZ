shader_type canvas_item;

uniform vec4   outline_color : source_color   = vec4(0.94, 0.34, 0.72, 1.0);
uniform float  edge_threshold : hint_range(0.0, 1.0) = 0.2;
uniform float  outline_size   : hint_range(0.0, 5.0) = 1.5;

void fragment() {
    // toma el alpha de la textura original
    float sa = texture(TEXTURE, UV).a;

    // si es completamente transparente, no pintes nada
    if (sa < 0.01) {
        discard;
    }

    // tamaño del paso en UV según el tamaño de outline
    vec2 px = outline_size * TEXTURE_PIXEL_SIZE;

    // muestras Sobel sobre el canal alpha
    float tl = texture(TEXTURE, UV + vec2(-px.x, -px.y)).a;
    float  t = texture(TEXTURE, UV + vec2(0.0, -px.y)).a;
    float tr = texture(TEXTURE, UV + vec2(px.x, -px.y)).a;
    float ml = texture(TEXTURE, UV + vec2(-px.x, 0.0)).a;
    float mr = texture(TEXTURE, UV + vec2(px.x, 0.0)).a;
    float bl = texture(TEXTURE, UV + vec2(-px.x, px.y)).a;
    float  b = texture(TEXTURE, UV + vec2(0.0, px.y)).a;
    float br = texture(TEXTURE, UV + vec2(px.x, px.y)).a;

    // cálculo de gradientes
    float gx = -tl - 2.0 * ml - bl + tr + 2.0 * mr + br;
    float gy = -tl - 2.0 * t  - tr + bl + 2.0 * b  + br;
    float mag = length(vec2(gx, gy));

    // si supera el umbral, pinta outline_color; si no, silueta blanca
    if (mag > edge_threshold) {
        COLOR = outline_color;
    } else {
        COLOR = vec4(1.0, 1.0, 1.0, sa);
    }
}