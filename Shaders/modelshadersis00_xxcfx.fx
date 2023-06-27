sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
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
float4x4 viewInverseMatrix;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r1.xyz = ambient_rate_rate.xyz;
	r0.yzw = r0.xxx * r1.xyz + ambient_rate.xyz;
	r1.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.xyz = normalize(r1.xyz);
	r1.xyz = i.texcoord3.xyz;
	r3.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r3.xyz;
	r3.xy = g_All_Offset.xy;
	r3.xy = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r3);
	r3.xyz = r3.xyz + -0.5;
	r1.xyz = r1.xyz * -r3.yyy;
	r1.w = r3.x * i.texcoord2.w;
	r1.xyz = r1.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r3.zzz * i.texcoord3.xyz + r1.xyz;
	r3.xyz = normalize(r1.xyz);
	r1.x = dot(r2.xyz, r3.xyz);
	r1.xyz = r1.xxx * point_light1.xyz;
	r1.xyz = r1.xyz * i.texcoord8.xxx;
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r2.xyz);
	r1.w = dot(r4.xyz, r3.xyz);
	r2.xyz = r1.www * muzzle_light.xyz;
	r1.xyz = r2.xyz * i.texcoord8.zzz + r1.xyz;
	r1.w = dot(lightpos.xyz, r3.xyz);
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.x = r1.w + -r2.x;
	r1.w = r1.w;
	r2.x = r2.x + 1;
	r2.x = r2.x * 0.5 + 0.5;
	r0.yzw = r2.xxx * r0.yzw + r1.xyz;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r1);
	r1.xy = -r2.yy + r2.xz;
	r3.w = max(abs(r1.x), abs(r1.y));
	r1.x = r3.w + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r2.xz = (r1.xx >= 0) ? r2.yy : r2.xz;
	r1.x = 1 / ambient_rate.w;
	r1.xyz = r1.xxx * r2.xyz;
	r2.xyz = r1.xyz * i.color.xyz;
	r1.xyz = r1.xyz * i.color.xyz + specularParam.www;
	r0.yzw = r0.yzw * r2.xyz;
	r4.x = dot(r3.xyz, transpose(viewInverseMatrix)[0].xyz);
	r4.y = dot(r3.xyz, transpose(viewInverseMatrix)[1].xyz);
	r4.z = dot(r3.xyz, transpose(viewInverseMatrix)[2].xyz);
	r3.w = dot(i.texcoord4.xyz, r4.xyz);
	r3.w = r3.w + r3.w;
	r4.xyz = r4.xyz * -r3.www + i.texcoord4.xyz;
	r4.w = -r4.z;
	r4 = tex2D(cubemap_sampler, r4.xyww);
	r4 = r4 * ambient_rate_rate.w;
	r4.xyz = r2.www * r4.xyz;
	r3.w = r4.w * CubeParam.y + CubeParam.x;
	r4.xyz = r3.www * r4.xyz;
	r2.xyz = r2.xyz * r4.xyz;
	r5.xyz = r2.xyz * CubeParam.zzz + r0.yzw;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.yzw = r0.yzw * -r2.xyz + r5.xyz;
	r2.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.x = 1 / sqrt(r2.x);
	r2.xyz = -i.texcoord1.xyz * r2.xxx + lightpos.xyz;
	r5.xyz = normalize(r2.xyz);
	r2.x = dot(r5.xyz, r3.xyz);
	r3.x = pow(r2.x, specularParam.z);
	r2.y = (-r1.w >= 0) ? 0 : 1;
	r1.w = r1.w * r2.y;
	r2.x = (-r2.x >= 0) ? 0 : r2.y;
	r2.x = r3.x * r2.x;
	r3.xyz = r1.www * light_Color.xyz;
	r2.xyz = r2.xxx * r3.xyz;
	r2.xyz = r2.www * r2.xyz;
	r2.xyz = r0.xxx * r2.xyz;
	r0.x = abs(specularParam.x);
	r2.xyz = r0.xxx * r2.xyz;
	r0.xyz = r2.xyz * r1.xyz + r0.yzw;
	r1.z = CubeParam.z;
	r0.w = -r1.z + 1;
	r0.xyz = r4.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
