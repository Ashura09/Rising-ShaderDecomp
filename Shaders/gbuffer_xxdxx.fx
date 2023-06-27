float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
sampler g_MaskSampler;
sampler g_Normalmap_sampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float4 g_lightColor;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_olcParam;
float4 g_otherParam;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color : COLOR;
	float4 color2 : COLOR2;
	float4 color3 : COLOR3;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord2.xyz);
	r2.xyz = normalize(i.texcoord3.xyz);
	r3.xyz = r1.zxy * r2.yzx;
	r3.xyz = r1.yzx * r2.zxy + -r3.xyz;
	r4 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r4.xyz = r4.xyz * 2 + -1;
	r5.x = r4.x * i.texcoord2.w;
	r5.yz = r4.yz * float2(2, -1);
	r4.xyz = r5.xyz * g_normalmapRate.xxx;
	r5.xyz = normalize(r4.xyz);
	r3.xyz = r3.xyz * r5.yyy;
	r1.xyz = r5.xxx * r1.xyz + r3.xyz;
	r1.xyz = r5.zzz * r2.xyz + r1.xyz;
	r0.w = dot(g_lightDir.xyz, r2.xyz);
	r2.xyz = normalize(r1.xyz);
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r1.xyz = i.texcoord4.xyz;
	r3.xyz = r1.zxy * i.texcoord5.yzx;
	r1.xyz = r1.yzx * i.texcoord5.zxy + -r3.xyz;
	r1.xyz = r1.xyz * r5.yyy;
	r1.xyz = r5.xxx * i.texcoord4.xyz + r1.xyz;
	r1.xyz = r5.zzz * i.texcoord5.xyz + r1.xyz;
	r1.w = dot(i.texcoord6.xyz, r1.xyz);
	r1.w = r1.w + r1.w;
	r1.xyz = r1.xyz * -r1.www + i.texcoord6.xyz;
	r1.w = -r1.z;
	r1 = tex2D(g_CubeSampler, r1.xyww);
	r3 = tex2D(g_MaskSampler, i.texcoord8.zwzw);
	r3.xyz = g_cubeParam.zzz * r3.xyz + g_cubeParam.xxx;
	r3.xyz = r3.xyz + g_cubeParam.www;
	r1.xyz = r1.xyz * r3.xyz;
	r1.xyz = r1.xyz * g_cubeParam.yyy;
	r3.xyz = r1.www * r1.xyz;
	r3.xyz = r3.xyz * g_cubeParam2.yyy;
	r1.xyz = r1.xyz * g_cubeParam2.xxx + r3.xyz;
	r3.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r4.xyz = r0.xyz * r3.xyz + g_cubeParam2.zzz;
	r0.xyz = r0.xyz * r3.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r1.w = dot(g_lightDir.xyz, r2.xyz);
	r0.w = -r0.w + r1.w;
	r1.w = r1.w;
	r1.w = r1.w + 0.5;
	r0.w = r0.w + 1;
	r2.w = 0.1 + -i.texcoord3.w;
	r3.xyz = r2.www * g_GroundHemisphereColor.xyz;
	r2.w = 0.1 + i.texcoord3.w;
	r3.xyz = g_SkyHemisphereColor.xyz * r2.www + r3.xyz;
	r3.xyz = r3.xyz + g_ambientRate.xyz;
	r3.xyz = r0.xyz * r3.xyz;
	r3.xyz = r0.www * r3.xyz;
	r0.w = frac(r1.w);
	r0.w = -r0.w + r1.w;
	r1.w = r0.w + g_olcParam.x;
	r0.w = -r0.w + 1;
	r1.xyz = r3.xyz * r1.www + r1.xyz;
	r3.xyz = normalize(-i.texcoord1.xyz);
	r1.w = dot(r3.xyz, r2.xyz);
	r2.w = 0.5;
	r1.w = r1.w * g_olcParam.w + r2.w;
	r2.x = frac(r1.w);
	r1.w = r1.w + -r2.x;
	r2.x = r2.w + g_olcParam.y;
	r2.y = frac(r2.x);
	r2.x = -r2.y + r2.x;
	r2.x = 1 / r2.x;
	r1.w = r1.w * -r2.x + 1;
	r1.w = r1.w * g_olcParam.z;
	r0.w = r0.w * r1.w;
	r2.xyz = r0.xyz * g_lightColor.xyz;
	o.color.xyz = r0.xyz;
	o.color2.xyz = r2.xyz * r0.www + r1.xyz;
	o.color.w = 1;
	o.color1.w = g_otherParam.x;
	o.color2.w = g_otherParam.z;
	r0.yzw = float3(0.1, -1, 0);
	o.color3.xzw = g_ambientRate.www * r0.yzz + r0.wzz;
	o.color3.y = g_cubeParam2.w;

	return o;
}
