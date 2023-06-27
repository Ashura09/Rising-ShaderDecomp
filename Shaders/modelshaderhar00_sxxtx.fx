sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float aniso_diff_rate;
float aniso_shine;
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
sampler specularmap_sampler;

struct PS_IN
{
	float color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r0 = tex2D(specularmap_sampler, r0);
	r2.x = -0.01;
	r2 = r1.w * ambient_rate.w + r2.x;
	clip(r2);
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r2.xyz, r2.xyz);
	r0.w = 1 / sqrt(r0.w);
	r2.xyz = r0.www * r2.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r2.x = dot(r2.xyz, i.texcoord3.xyz);
	r2.y = r2.x * 0.5 + 0.5;
	r2.y = r2.y * r2.y;
	r3.x = lerp(r2.y, r2.x, hll_rate.x);
	r2.xyz = r3.xxx * point_light1.xyz;
	r2.xyz = r0.www * r2.xyz;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r3.xyz, r3.xyz);
	r0.w = 1 / sqrt(r0.w);
	r3.xyz = r0.www * r3.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r2.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.x = r2.w * 0.5 + 0.5;
	r3.x = r3.x * r3.x;
	r4.x = lerp(r3.x, r2.w, hll_rate.x);
	r3.xyz = r4.xxx * muzzle_light.xyz;
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r4.xyz = i.texcoord1.xyz;
	r3.y = dot(r4.xyz, -i.texcoord3.xyz);
	r3.xy = r0.ww * r3.xy;
	r3.xy = r3.xy * -0.5 + 1;
	r3.zw = r3.xy * r3.xy;
	r3.zw = r3.zw * r3.zw;
	r3.xy = r3.xy * -r3.zw + 1;
	r2.w = r3.y * r3.x;
	r3.x = r2.w * 0.193754 + 0.5;
	r2.w = r2.w * 0.387508;
	r3.x = r3.x * r3.x + -r2.w;
	r2.w = hll_rate.x * r3.x + r2.w;
	r3.xyz = light_Color.xyz;
	r3.xyz = r3.xyz * aniso_diff_rate.xxx;
	r2.xyz = r3.xyz * r2.www + r2.xyz;
	r3.xy = -r1.yy + r1.xz;
	r2.w = max(abs(r3.x), abs(r3.y));
	r2.w = r2.w + -0.015625;
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r1.xz = (r2.ww >= 0) ? r1.yy : r1.xz;
	r1.w = r1.w * ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r2.xyz = r2.xyz * r1.xyz;
	r3.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r2.xyz = r3.xyz * ambient_rate_rate.xyz + r2.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r3.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r4.xyz = normalize(r3.xyz);
	r1.w = dot(r4.xyz, i.texcoord3.xyz);
	r2.w = -r1.w + 1;
	r1.w = r2.w * -specularParam.z + r1.w;
	r3.xyz = i.texcoord3.xyz;
	r4.xyz = r3.yzx * i.texcoord2.zxy;
	r3.xyz = i.texcoord2.yzx * r3.zxy + -r4.xyz;
	r4.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r4.xyz);
	r2.w = dot(r5.xyz, r3.xyz);
	r3.y = 1;
	r2.w = abs(r2.w) * -aniso_shine.x + r3.y;
	r3.x = r1.w * r2.w;
	r3.y = specularParam.y;
	r3 = tex2D(Spec_Pow_sampler, r3);
	r3.xyz = r3.xyz * light_Color.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r0.www * r0.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * i.color.xxx + r2.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
