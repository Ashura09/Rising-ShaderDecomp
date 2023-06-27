sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float4 eyeLightDir;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
float4 tile;
sampler tripleMask_sampler;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	float3 r5;
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r0.x = dot(r0.xyz, i.texcoord3.xyz);
	r0.y = r0.x * 0.5 + 0.5;
	r0.y = r0.y * r0.y;
	r1.x = lerp(r0.y, r0.x, hll_rate.x);
	r0.xyz = r1.xxx * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.x = dot(r1.xyz, i.texcoord3.xyz);
	r1.y = r1.x * 0.5 + 0.5;
	r1.y = r1.y * r1.y;
	r2.x = lerp(r1.y, r1.x, hll_rate.x);
	r1.xyz = r2.xxx * muzzle_light.xyz;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.y = r1.x * 0.5 + 0.5;
	r1.y = r1.y * r1.y;
	r2.x = lerp(r1.y, r1.x, hll_rate.x);
	r1.x = r1.x + -0.5;
	r2.y = max(r1.x, 0);
	r1.xyz = r2.xxx * light_Color.xyz;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r1);
	r2.xz = -r1.yy + r1.xz;
	r0.w = max(abs(r2.x), abs(r2.z));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r2.xz = tile.xy * i.texcoord.xy;
	r3 = tex2D(tripleMask_sampler, r2.xzzw);
	r0.w = r2.y + r3.x;
	r2.xyz = r0.www * r1.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r0.xyz = r3.www * r0.xyz;
	r2.xyz = r1.xyz * r3.xxx;
	r2.xyz = r2.xyz * ambient_rate.xyz;
	r0.xyz = r2.xyz * ambient_rate_rate.xyz + r0.xyz;
	r2 = tex2D(cubemap_sampler, i.texcoord4);
	r2 = r2 * ambient_rate_rate.w;
	r2.xyz = r3.yyy * r2.xyz;
	r1.w = r2.w * CubeParam.y + CubeParam.x;
	r2.xyz = r1.www * r2.xyz;
	r2.xyz = r0.www * r2.xyz;
	r3.xyw = r1.xyz * r2.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r4.xyz = r3.xyw * CubeParam.zzz + r0.xyz;
	r3.xyw = r3.xyw * CubeParam.zzz;
	r0.xyz = r0.xyz * -r3.xyw + r4.xyz;
	r4.xyz = normalize(eyeLightDir.xyz);
	r5.xyz = normalize(i.texcoord3.xyz);
	r1.w = dot(r4.xyz, r5.xyz);
	r2.w = pow(r1.w, specularParam.z);
	r3.xyw = r2.www * light_Color.xyz;
	r3.xyz = r3.zzz * r3.xyw;
	r3.xyz = r0.www * r3.xyz;
	r0.w = abs(specularParam.x);
	r3.xyz = r0.www * r3.xyz;
	r0.xyz = r3.xyz * r1.xyz + r0.xyz;
	r1.z = CubeParam.z;
	r0.w = -r1.z + 1;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
