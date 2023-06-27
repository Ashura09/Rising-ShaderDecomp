sampler Color_1_sampler;
sampler ShadowCast_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float2 g_ShadowFarInvPs;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.x = 1 / i.texcoord7.w;
	r1.xy = r1.xx * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(ShadowCast_Tex_sampler, r1);
	r1.y = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r1.y = -r1.y + 1;
	r1.x = -r1.x + r1.y;
	r1.x = r1.x + g_ShadowUse.x;
	r1.y = frac(-r1.x);
	r1.x = r1.y + r1.x;
	r2.xyz = i.texcoord3.xyz;
	r1.yzw = r2.yzx * i.texcoord2.zxy;
	r1.yzw = i.texcoord2.yzx * r2.zxy + -r1.yzw;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.yzw = r1.yzw * -r2.yyy;
	r2.x = r2.x * i.texcoord2.w;
	r1.yzw = r2.xxx * i.texcoord2.xyz + r1.yzw;
	r1.yzw = r2.zzz * i.texcoord3.xyz + r1.yzw;
	r2.xyz = normalize(r1.yzw);
	r1.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r1.yzw);
	r1.y = dot(r3.xyz, r2.xyz);
	r1.yzw = r1.yyy * point_light1.xyz;
	r1.yzw = r1.yzw * i.texcoord8.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r3.xyz);
	r2.w = dot(r4.xyz, r2.xyz);
	r2.x = dot(lightpos.xyz, r2.xyz);
	r2.yzw = r2.www * muzzle_light.xyz;
	r1.yzw = r2.yzw * i.texcoord8.zzz + r1.yzw;
	r2.y = r2.x;
	r2.yzw = r2.yyy * light_Color.xyz;
	r1.xyz = r2.yzw * r1.xxx + r1.yzw;
	r2.yz = -r0.yy + r0.xz;
	r1.w = max(abs(r2.y), abs(r2.z));
	r1.w = r1.w + -0.015625;
	r2.y = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.y;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r0.xz = (r1.ww >= 0) ? r0.yy : r0.xz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r1.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz;
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = -r0.w + r2.x;
	r0.w = r0.w + 1;
	r0.xyz = r0.xyz * r0.www + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
