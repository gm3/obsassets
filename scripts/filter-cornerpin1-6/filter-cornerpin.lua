--Corner Pin effect filter v1.4 by khaver

obs = obslua
bit = require("bit")

SETTING_TLX = 'pos_tlx'
SETTING_TLY = 'pos_tly'
SETTING_TRX = 'pos_trx'
SETTING_TRY = 'pos_try'
SETTING_BLX = 'pos_blx'
SETTING_BLY = 'pos_bly'
SETTING_BRX = 'pos_brx'
SETTING_BRY = 'pos_bry'

TEXT_TLX = 'Top Left X'
TEXT_TLY = 'Top Left Y'
TEXT_TRX = 'Top Right X'
TEXT_TRY = 'Top Right Y'
TEXT_BLX = 'Bottom Left X'
TEXT_BLY = 'Bottom Left Y'
TEXT_BRX = 'Bottom Right X'
TEXT_BRY = 'Bottom Right Y'

source_def = {}
source_def.id = 'filter-cornerpin'
source_def.type = obs.OBS_SOURCE_TYPE_FILTER
source_def.output_flags = bit.bor(obs.OBS_SOURCE_VIDEO)

image = "data:image/png;base64,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"

-- Returns the description displayed in the Scripts window
function script_description()
  return [[<center><img width=160 height=90 src=']] .. image .. [['/><br>New Filter by khaver - v1.6</br><br/><hr/></center>]]
end

function script_properties(settings)
    local p = obs.obs_properties_create()
	local pe = obs.obs_properties_add_text(p, "text", "", obs.OBS_TEXT_DEFAULT)
	obs.obs_property_set_visible(pe, false)
	return p

end

function script_load(settings)
  obs.obs_register_source(source_def)
end

function set_render_size(filter)
    target = obs.obs_filter_get_target(filter.context)

    local width, height
    if target == nil then
        width = 0
        height = 0
    else
        width = obs.obs_source_get_base_width(target)
        height = obs.obs_source_get_base_height(target)
    end

    filter.width = width
    filter.height = height
end

source_def.get_name = function()
    return "Corner Pin"
end

source_def.create = function(settings, source)
    --local effect_path = script_path() .. 'filter-cornerpin.cpp'

    filter = {}
    filter.params = {}
    filter.context = source

    set_render_size(filter)

    obs.obs_enter_graphics()
    --filter.effect = obs.gs_effect_create_from_file(effect_path, nil)
    filter.effect = obs.gs_effect_create(shader, nil, nil)
    if filter.effect ~= nil then
        filter.params.pos_tlx = obs.gs_effect_get_param_by_name(filter.effect, 'pos_tlx')
        filter.params.pos_tly = obs.gs_effect_get_param_by_name(filter.effect, 'pos_tly')
        filter.params.pos_trx = obs.gs_effect_get_param_by_name(filter.effect, 'pos_trx')
        filter.params.pos_try = obs.gs_effect_get_param_by_name(filter.effect, 'pos_try')
        filter.params.pos_blx = obs.gs_effect_get_param_by_name(filter.effect, 'pos_blx')
        filter.params.pos_bly = obs.gs_effect_get_param_by_name(filter.effect, 'pos_bly')
        filter.params.pos_brx = obs.gs_effect_get_param_by_name(filter.effect, 'pos_brx')
        filter.params.pos_bry = obs.gs_effect_get_param_by_name(filter.effect, 'pos_bry')
    end
    obs.obs_leave_graphics()

    if filter.effect == nil then
        source_def.destroy(filter)
        return nil
    end

    source_def.update(filter, settings)
    return filter
end

source_def.destroy = function(filter)
    if filter.effect ~= nil then
        obs.obs_enter_graphics()
        obs.gs_effect_destroy(filter.effect)
        obs.obs_leave_graphics()
    end
	filter = nil
end

source_def.get_width = function(filter)
    return filter.width
end

source_def.get_height = function(filter)
    return filter.height
end

source_def.update = function(filter, settings)
    filter.pos_tlx = obs.obs_data_get_double(settings, SETTING_TLX)
    filter.pos_tly = obs.obs_data_get_double(settings, SETTING_TLY)
    filter.pos_trx = obs.obs_data_get_double(settings, SETTING_TRX)
    filter.pos_try = obs.obs_data_get_double(settings, SETTING_TRY)
    filter.pos_blx = obs.obs_data_get_double(settings, SETTING_BLX)
    filter.pos_bly = obs.obs_data_get_double(settings, SETTING_BLY)
    filter.pos_brx = obs.obs_data_get_double(settings, SETTING_BRX)
    filter.pos_bry = obs.obs_data_get_double(settings, SETTING_BRY)

    set_render_size(filter)
end

source_def.video_render = function(filter, effect)
  if not obs.obs_source_process_filter_begin(filter.context, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING) then
	obs.obs_source_skip_video_filter(filter.context)
	return
  end

    obs.gs_effect_set_float(filter.params.pos_tlx, filter.pos_tlx)
    obs.gs_effect_set_float(filter.params.pos_tly, filter.pos_tly)
    obs.gs_effect_set_float(filter.params.pos_trx, filter.pos_trx)
    obs.gs_effect_set_float(filter.params.pos_try, filter.pos_try)
    obs.gs_effect_set_float(filter.params.pos_blx, filter.pos_blx)
    obs.gs_effect_set_float(filter.params.pos_bly, filter.pos_bly)
    obs.gs_effect_set_float(filter.params.pos_brx, filter.pos_brx)
    obs.gs_effect_set_float(filter.params.pos_bry, filter.pos_bry)

	obs.gs_blend_state_push()
	obs.gs_blend_function(obs.GS_BLEND_ONE, obs.GS_BLEND_INVSRCALPHA)
    obs.obs_source_process_filter_end(filter.context, filter.effect, filter.width, filter.height)
	obs.gs_blend_state_pop()
end

source_def.get_properties = function(settings)
    props = obs.obs_properties_create()

    obs.obs_properties_add_float_slider(props, SETTING_TLX, TEXT_TLX, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_TLY, TEXT_TLY, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_TRX, TEXT_TRX, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_TRY, TEXT_TRY, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_BLX, TEXT_BLX, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_BLY, TEXT_BLY, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_BRX, TEXT_BRX, -0.25, 1.0, 0.0001)
    obs.obs_properties_add_float_slider(props, SETTING_BRY, TEXT_BRY, -0.25, 1.0, 0.0001)

    return props
end

source_def.get_defaults = function(settings)
    obs.obs_data_set_default_double(settings, SETTING_TLX, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_TLY, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_TRX, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_TRY, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_BLX, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_BLY, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_BRX, 0.0)
    obs.obs_data_set_default_double(settings, SETTING_BRY, 0.0)
end

source_def.video_tick = function(filter, seconds)
    set_render_size(filter)
end


shader = [[
//Corner Pin effect filter adapted by khaver for cornerpin.lua
//Based on a shader at https://github.com/Oncorporation/obs-shaderfilter/blob/master/data/examples/corner_pin.shader
//By Charles Fettinger

uniform float4x4 ViewProj;
uniform texture2d image;

uniform float pos_tlx;
uniform float pos_tly;
uniform float pos_trx;
uniform float pos_try;
uniform float pos_blx;
uniform float pos_bly;
uniform float pos_brx;
uniform float pos_bry;

sampler_state textureSampler {
    Filter    = Linear;
    AddressU  = Border;
    AddressV  = Border;
	BorderColor = 0x00000000;
};

struct VertDataIn {
    float4 pos : POSITION;
    float2 uv  : TEXCOORD0;
};

struct VertDataOut {
    float4 pos : POSITION;
    float2 uv  : TEXCOORD0;
};

VertDataOut VSDefault(VertDataIn v_in)
{
    VertDataOut vert_out;

    vert_out.pos = mul(float4(v_in.pos.xyz, 1.0), ViewProj);
    vert_out.uv  = v_in.uv;
    return vert_out;
}

float cross2d(float2 a, float2 b)
{
	return (a.x * b.y) - (a.y * b.x);
}

float2 invBilinear(float2 p)
{
    float2 a = float2(pos_tlx / 1.0, pos_tly / 1.0);
    float2 b = float2(1.0 - (pos_trx / 1.0), pos_try / 1.0);
    float2 c = float2(1.0 - (pos_brx / 1.0), 1.0 - (pos_bry / 1.0));
    float2 d = float2(pos_blx / 1.0, 1.0 - (pos_bly / 1.0));

    float2 e = b-a;
    float2 f = d-a;
    float2 g = a-b+c-d;
    float2 h = p-a;

    float k2 = cross2d( g, f );
    float k1 = cross2d( e, f ) + cross2d( h, g );
    float k0 = cross2d( h, e );

    float k2u = cross2d( e, g );
    float k1u = cross2d( e, f ) + cross2d( g, h );
    float k0u = cross2d( h, f);

    float v1, u1, v2, u2;

    if (abs(k2) < 0.0001)
    {
        v1 = -k0 / k1;
        u1 = (h.x - f.x*v1)/(e.x + g.x*v1);
    }
    else if (abs(k2u) < 0.0001)
    {
        u1 = k0u / k1u;
        v1 = (h.y - e.y*u1)/(f.y + g.y*u1);
    }
    else
    {
        float w = k1*k1 - 4.0*k0*k2;

        if( w<0.0 ) return float2(-1.0, -1.0);

        w = sqrt( w );

        v1 = (-k1 - w)/(2.0*k2);
        v2 = (-k1 + w)/(2.0*k2);
        u1 = (-k1u - w)/(2.0*k2u);
        u2 = (-k1u + w)/(2.0*k2u);
    }
    bool  b1 = v1>0.0 && v1<1.0 && u1>0.0 && u1<1.0;
    bool  b2 = v2>0.0 && v2<1.0 && u2>0.0 && u2<1.0;

    float2 res = float2(-1.0, -1.0);

    if( b2 ) return float2( u2, v2 );
    if( b1 ) return float2( u1, v1 );

    return float2(-1.0, -1.0);
}


float4 PassThrough(VertDataOut v_in) : TARGET
{
	float2 xy = v_in.uv;
    xy = invBilinear(xy);
   float4 color = image.Sample(textureSampler, xy); //invBilinear(v_in.uv));
   if (( xy.x == -1.0) || (xy.y == -1.0)) color.a = 0.0;
   return color;

}

technique Draw
{
    pass
    {
        vertex_shader = VSDefault(v_in);
        pixel_shader  = PassThrough(v_in);
    }
}
]]
