float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
float4 g_CubeBlendParam;
samplerCUBE g_CubeSampler;
samplerCUBE g_CubeSampler2;
sampler g_Normalmap_sampler;
sampler g_OcclusionSampler;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float4 g_normalmapRate;
float4 g_otherParam;

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color2 : COLOR2;
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
	float4 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r0.w = g_cubeParam.z * r0.w + g_cubeParam.x;
	r1.y = -1;
	r1.x = r1.y + g_cubeParam.w;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r1.yz = -r2.xy + 1;
	r1.yz = g_ambientRate.ww * r1.yz + r2.xy;
	r1.w = r1.z * g_cubeParam.w;
	r2 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r1.z = g_cubeParam.w * -r1.z + r2.w;
	r2.xyz = r2.xyz * 2 + -1;
	r1.y = r1.y * 0.5 + 0.5;
	r1.y = r1.y * r1.y;
	r1.x = r1.x * r1.z + r1.w;
	r0.w = r0.w + r1.x;
	r3.xyz = i.texcoord4.xyz;
	r1.xzw = r3.zxy * i.texcoord5.yzx;
	r1.xzw = r3.yzx * i.texcoord5.zxy + -r1.xzw;
	r3.x = r2.x * i.texcoord2.w;
	r3.y = -r2.y;
	r2.xy = r3.xy * g_normalmapRate.xx;
	r3.xyz = normalize(r2.xyz);
	r1.xzw = r1.xzw * r3.yyy;
	r1.xzw = r3.xxx * i.texcoord4.xyz + r1.xzw;
	r1.xzw = r3.zzz * i.texcoord5.xyz + r1.xzw;
	r2.x = dot(i.texcoord6.xyz, r1.xzw);
	r2.x = r2.x + r2.x;
	r2.xyz = r1.xzw * -r2.xxx + i.texcoord6.xyz;
	r2.w = -r2.z;
	r4 = tex2D(g_CubeSampler, r2.xyww);
	r2 = tex2D(g_CubeSampler2, r2.xyww);
	r5 = lerp(r2, r4, g_CubeBlendParam.x);
	r1.xzw = r0.www * r5.xyz;
	r1.xzw = r1.xzw * g_cubeParam.yyy;
	r2.xyz = r5.www * r1.xzw;
	r2.xyz = r2.xyz * g_cubeParam2.yyy;
	r1.xzw = r1.xzw * g_cubeParam2.xxx + r2.xyz;
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r2.xyz + g_cubeParam2.zzz;
	r0.xyz = r0.xyz * r1.xzw;
	o.color2.xyz = r1.yyy * r0.xyz;
	o.color = 0;
	r0.xyz = normalize(i.texcoord2.xyz);
	r1.xyz = normalize(i.texcoord3.xyz);
	r2.xyz = r0.zxy * r1.yzx;
	r2.xyz = r0.yzx * r1.zxy + -r2.xyz;
	r2.xyz = r2.xyz * r3.yyy;
	r0.xyz = r3.xxx * r0.xyz + r2.xyz;
	r0.xyz = r3.zzz * r1.xyz + r0.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.xyz * r0.www + -r1.xyz;
	r0.xyz = g_normalmapRate.xxx * r0.xyz + r1.xyz;
	r0.xyz = r0.xyz * 0.5 + 0.5;
	o.color1.xw = r0.xx * float2(1, 0) + 0;
	r1 = r0.xxyy * float4(65025, 16581375, 65025, 16581375);
	o.color3.xw = r0.yz;
	r0 = frac(-r1);
	r0 = r0 + r1;
	r0 = r0 * 0.003921569;
	r0 = frac(r0);
	o.color1.yz = r0.xy;
	o.color3.yz = r0.zw;
	o.color2.w = 0;

	return o;
}
