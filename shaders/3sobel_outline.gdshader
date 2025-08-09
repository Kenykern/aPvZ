shader_type canvas_item;

uniform vec4  outline_color   : source_color   = vec4(0.94, 0.34, 0.72, 1.0);
uniform float edge_threshold  : hint_range(0.0, 1.0) = 0.2;
uniform float outline_size    : hint_range(0.0, 5.0) = 1.5;

void fragment() {
    // compute pixel‐step based on your outline_size
    vec2 px = outline_size * TEXTURE_PIXEL_SIZE;

    // sample original once
    vec4 tex       = texture(TEXTURE, UV);
    float alpha    = tex.a;

    // discard fully transparent
    if (alpha < 0.01) {
        discard;
    }

    //
    // 1) Sobel on alpha channel for the external silhouette
    //
    float tl_a = texture(TEXTURE, UV + vec2(-px.x, -px.y)).a;
    float  t_a = texture(TEXTURE, UV + vec2(0.0,  -px.y)).a;
    float tr_a = texture(TEXTURE, UV + vec2(px.x, -px.y)).a;
    float ml_a = texture(TEXTURE, UV + vec2(-px.x, 0.0 )).a;
    float mr_a = texture(TEXTURE, UV + vec2(px.x,  0.0 )).a;
    float bl_a = texture(TEXTURE, UV + vec2(-px.x,  px.y)).a;
    float  b_a = texture(TEXTURE, UV + vec2(0.0,   px.y)).a;
    float br_a = texture(TEXTURE, UV + vec2(px.x,  px.y)).a;

    float gx_a = -tl_a - 2.0 * ml_a - bl_a + tr_a + 2.0 * mr_a + br_a;
    float gy_a = -tl_a - 2.0 *  t_a - tr_a + bl_a + 2.0 *  b_a + br_a;
    float mag_a = length(vec2(gx_a, gy_a));

    //
    // 2) Sobel on luminance (grayscale) for internal color edges
    //
    // compute base luminance
    float l    = dot(tex.rgb, vec3(0.299, 0.587, 0.114));

    float tl_l = dot(texture(TEXTURE, UV + vec2(-px.x, -px.y)).rgb,
                     vec3(0.299, 0.587, 0.114));
    float  t_l = dot(texture(TEXTURE, UV + vec2(0.0,  -px.y)).rgb,
                     vec3(0.299, 0.587, 0.114));
    float tr_l = dot(texture(TEXTURE, UV + vec2(px.x, -px.y)).rgb,
                     vec3(0.299, 0.587, 0.114));
    float ml_l = dot(texture(TEXTURE, UV + vec2(-px.x, 0.0 )).rgb,
                     vec3(0.299, 0.587, 0.114));
    float mr_l = dot(texture(TEXTURE, UV + vec2(px.x,  0.0 )).rgb,
                     vec3(0.299, 0.587, 0.114));
    float bl_l = dot(texture(TEXTURE, UV + vec2(-px.x,  px.y)).rgb,
                     vec3(0.299, 0.587, 0.114));
    float  b_l = dot(texture(TEXTURE, UV + vec2(0.0,   px.y)).rgb,
                     vec3(0.299, 0.587, 0.114));
    float br_l = dot(texture(TEXTURE, UV + vec2(px.x,  px.y)).rgb,
                     vec3(0.299, 0.587, 0.114));

    float gx_l = -tl_l - 2.0 * ml_l - bl_l + tr_l + 2.0 * mr_l + br_l;
    float gy_l = -tl_l - 2.0 *  t_l - tr_l + bl_l + 2.0 *  b_l + br_l;
    float mag_l = length(vec2(gx_l, gy_l));

    //
    // 3) Decide output
    //
    // external outline has priority
    if (mag_a > edge_threshold) {
        COLOR = outline_color;
    }
    // then internal color edges
    else if (mag_l > edge_threshold) {
        COLOR = outline_color;
    }
    // otherwise solid white silhouette
    else {
        COLOR = vec4(1.0, 1.0, 1.0, alpha);
    }
}