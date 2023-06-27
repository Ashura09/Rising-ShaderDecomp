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
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r0 = r0 * i.color;
	r1.xyz = r0.xyz * ambient_rate.xyz;
	r1.w = 1 / i.texcoord7.w;
	r2.xy = r1.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(ShadowCast_Tex_sampler, r2);
	r1.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r1.w = -r1.w + 1;
	r1.w = -r2.x + r1.w;
	r1.w = r1.w + g_ShadowUse.x;
	r2.x = frac(-r1.w);
	r1.w = r1.w + r2.x;
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.xyz = r2.xxx * light_Color.xyz;
	r2.xyz = r2.xyz * r1.www + i.texcoord2.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r0.xyz = r1.xyz * ambient_rate_rate.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;

	return o;
}
