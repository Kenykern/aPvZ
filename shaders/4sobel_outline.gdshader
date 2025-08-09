shader_type canvas_item;

uniform vec4  outline_color    : source_color   = vec4(0.94, 0.34, 0.72, 1.0);
uniform float edge_threshold   : hint_range(0.0, 1.0) = 0.2;
uniform float outline_size     : hint_range(0.0, 5.0) = 1.5;
uniform float smooth_width     : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    // Paso de muestreo en UV
    vec2 px = outline_size * TEXTURE_PIXEL_SIZE;

    // Muestreo original y descarte de transparentes
    vec4 tex = texture(TEXTURE, UV);
    float sa = tex.a;
    if (sa < 0.01) {
        discard;
    }

    //
    // 1) Sobel sobre el canal alpha → contorno externo
    //
    float tl_a  = texture(TEXTURE, UV + vec2(-px.x, -px.y)).a;
    float  t_a  = texture(TEXTURE, UV + vec2(0.0,   -px.y)).a;
    float tr_a  = texture(TEXTURE, UV + vec2(px.x,  -px.y)).a;
    float ml_a  = texture(TEXTURE, UV + vec2(-px.x,  0.0  )).a;
    float mr_a  = texture(TEXTURE, UV + vec2(px.x,   0.0  )).a;
    float bl_a  = texture(TEXTURE, UV + vec2(-px.x,  px.y)).a;
    float  b_a  = texture(TEXTURE, UV + vec2(0.0,    px.y)).a;
    float br_a  = texture(TEXTURE, UV + vec2(px.x,   px.y)).a;

    float gx_a  = -tl_a - 2.0 * ml_a - bl_a + tr_a + 2.0 * mr_a + br_a;
    float gy_a  = -tl_a - 2.0 *  t_a - tr_a + bl_a + 2.0 *  b_a + br_a;
    float mag_a = length(vec2(gx_a, gy_a));

    //
    // 2) Sobel sobre luminancia → contornos internos (ojos, boca…)
    //
    float l      = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    float tl_l   = dot(texture(TEXTURE, UV + vec2(-px.x, -px.y)).rgb, vec3(0.299, 0.587, 0.114));
    float  t_l   = dot(texture(TEXTURE, UV + vec2(0.0,   -px.y)).rgb, vec3(0.299, 0.587, 0.114));
    float tr_l   = dot(texture(TEXTURE, UV + vec2(px.x,  -px.y)).rgb, vec3(0.299, 0.587, 0.114));
    float ml_l   = dot(texture(TEXTURE, UV + vec2(-px.x,  0.0  )).rgb, vec3(0.299, 0.587, 0.114));
    float mr_l   = dot(texture(TEXTURE, UV + vec2(px.x,   0.0  )).rgb, vec3(0.299, 0.587, 0.114));
    float bl_l   = dot(texture(TEXTURE, UV + vec2(-px.x,  px.y)).rgb, vec3(0.299, 0.587, 0.114));
    float  b_l   = dot(texture(TEXTURE, UV + vec2(0.0,    px.y)).rgb, vec3(0.299, 0.587, 0.114));
    float br_l   = dot(texture(TEXTURE, UV + vec2(px.x,   px.y)).rgb, vec3(0.299, 0.587, 0.114));

    float gx_l   = -tl_l - 2.0 * ml_l - bl_l + tr_l + 2.0 * mr_l + br_l;
    float gy_l   = -tl_l - 2.0 *  t_l - tr_l + bl_l + 2.0 *  b_l + br_l;
    float mag_l  = length(vec2(gx_l, gy_l));

    // Magnitud combinada (prioridad al contorno externo)
    float mag = max(mag_a, mag_l);

    //
    // 3) Suavizado de umbral
    //
    // De mag < (threshold - smooth) → 0
    // A mag > (threshold + smooth) → 1
    float edge_alpha = smoothstep(
        edge_threshold - smooth_width,
        edge_threshold + smooth_width,
        mag
    );

    //
    // 4) Mezcla silueta blanca ⇆ color de outline con alpha suave
    //
    vec4 sil = vec4(1.0, 1.0, 1.0, sa);
    COLOR = mix(sil, outline_color, edge_alpha);
}