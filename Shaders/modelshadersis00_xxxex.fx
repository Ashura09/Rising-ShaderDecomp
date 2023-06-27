sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
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
float4 specularParam;
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
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.xyz = i.texcoord3.xyz;
	r2.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r2.xyz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r0.xyz = r0.xyz * -r2.yyy;
	r0.w = r2.x * i.texcoord2.w;
	r0.xyz = r0.www * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r2.zzz * i.texcoord3.xyz + r0.xyz;
	r2.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, r2.xyz);
	r0.xyz = r0.xxx * point_light1.xyz;
	r0.xyz = r0.xyz * i.texcoord8.xxx;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r1.xyz);
	r0.w = dot(r3.xyz, r2.xyz);
	r1.xyz = r0.www * muzzle_light.xyz;
	r0.xyz = r1.xyz * i.texcoord8.zzz + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.xyz = ambient_rate.xyz;
	r1.xyz = r0.www * ambient_rate_rate.xyz + r1.xyz;
	r1.w = dot(lightpos.xyz, r2.xyz);
	r2.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.w = r1.w + -r2.w;
	r1.w = r1.w;
	r2.w = r2.w + 1;
	r2.w = r2.w * 0.5 + 0.5;
	r0.xyz = r2.www * r1.xyz + r0.xyz;
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r1.xyz = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r3.xyz = normalize(r1.xyz);
	r1.x = dot(r3.xyz, r2.xyz);
	r2.x = pow(r1.x, specularParam.z);
	r1.y = (-r1.w >= 0) ? 0 : 1;
	r1.z = r1.w * r1.y;
	r1.x = (-r1.x >= 0) ? 0 : r1.y;
	r1.x = r2.x * r1.x;
	r1.yzw = r1.zzz * light_Color.xyz;
	r1.xyz = r1.xxx * r1.yzw;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r2);
	r1.xyz = r1.xyz * r2.www;
	r1.xyz = r0.www * r1.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r0.w = 1 / ambient_rate.w;
	r3.xyz = r2.xyz * r0.www + specularParam.www;
	r2.xyz = r0.www * r2.xyz;
	r1.xyz = r1.xyz * r3.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
