/*
	遠景山シェーダー by あるる（きのもと 結衣） @arlez80
	Background Mountain Shader by Yui Kinomoto

	MIT License
*/

shader_type spatial;
//render_mode unshaded, shadows_disabled;

uniform float mountain_distance = 2000.0;
uniform sampler2D mountain_texture : hint_albedo;
uniform sampler2D sand_texture : hint_albedo;
uniform sampler2D height_map : hint_black;
uniform float height = 11.0;
uniform vec4 aerial_perspective_color : hint_color = vec4( 0.1411764705882353, 0.41568627450980394, 0.6705882352941176, 1.0 );
uniform vec2 uv_scale = vec2( 10.0, 10.0 );

void vertex( )
{
	float r = atan( VERTEX.z, VERTEX.x );
	VERTEX.y = texture( height_map, UV ).r * height * length( UV - vec2( 0.5, 0.5 ) );
	NORMAL = vec3( 0.0, 1.0, 0.0 );
}

void fragment( )
{
	ALBEDO = mix(
		texture( mountain_texture, UV * uv_scale )
	,	texture( sand_texture, UV * uv_scale )
	,	clamp( pow( texture( height_map, UV * 1.1 ).r, 6.0 ), 0.0, 1.0 )
	).rgb;
	DEPTH = 0.999999;
}
