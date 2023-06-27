sampler A_Occ_sampler;
sampler Color_1_sampler;
float4 CubeParam;
sampler ShadowCast_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float2 g_ShadowFarInvPs;
float g_ShadowUse;
float4 g_TargetUvParam;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
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
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r0 = tex2D(A_Occ_sampler, r0);
	r2 = r1.w + -0.01;
	clip(r2);
	r2.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r2.x), abs(r2.y));
	r0.w = r0.w + -0.015625;
	r2.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r2.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r0.w = 1 / ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(ShadowCast_Tex_sampler, r2);
	r0.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r0.w = -r0.w + 1;
	r0.w = -r2.x + r0.w;
	r0.w = r0.w + g_ShadowUse.x;
	r1.w = frac(-r0.w);
	r0.w = r0.w + r1.w;
	r2.xyz = ambient_rate_rate.xyz;
	r2.xyz = r0.www * r2.xyz + ambient_rate.xyz;
	r3.xy = -r0.yy + r0.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.xz = (r0.ww >= 0) ? r0.yy : r0.xz;
	r2.xyz = r0.xyz * r2.xyz + i.texcoord2.xyz;
	r2.xyz = r1.xyz * r2.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3.xyz = r0.xyz * r3.xyz;
	r0 = r3 * ambient_rate_rate.w;
	r3.xy = g_All_Offset.xy;
	r3.xy = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r3);
	r0.xyz = r0.xyz * r3.www;
	r0.w = r0.w * CubeParam.y + CubeParam.x;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = r1.xyz * r0.xyz;
	r3.xyz = r1.xyz * CubeParam.zzz + r2.xyz;
	r1.xyz = r1.xyz * CubeParam.zzz;
	r1.xyz = r2.xyz * -r1.xyz + r3.xyz;
	r2.z = CubeParam.z;
	r0.w = -r2.z + 1;
	r0.xyz = r0.xyz * r0.www + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;

	return o;
}
