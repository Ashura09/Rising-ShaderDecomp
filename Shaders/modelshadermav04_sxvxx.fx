sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float3 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 fogParam;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 prefogcolor_enhance;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r1.xyz = normalize(i.texcoord3.xyz);
	r0.y = dot(lightpos.xyz, r1.xyz);
	r0.yzw = r0.yyy * light_Color.xyz;
	r0.xyz = r0.yzw * r0.xxx + i.texcoord2.xyz;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r1);
	r1.xyz = r1.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xyz = r1.xyz * ambient_rate.xyz;
	r0.xyz = r1.xyz * ambient_rate_rate.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = -fogParam.x + fogParam.y;
	r0.w = 1 / r0.w;
	r1.x = fogParam.y + i.texcoord1.z;
	r0.w = r0.w * r1.x;
	o.xyz = r0.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
