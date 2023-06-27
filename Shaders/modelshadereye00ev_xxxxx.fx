sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap2_sampler;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_CubeBlendParam;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_eyeLightDir;
float4 g_eyeLightDir2;
float4 g_specCalc1;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_light2;
float4 point_lightpos1;
float4 point_lightpos2;
float4 prefogcolor_enhance;
float4 specularParam;
float4 spot_angle;
float4 spot_param;
float4 tile;
sampler tripleMask_sampler;
float4x4 viewInverseMatrix;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
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
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.x = 1 / r0.w;
	r0.xyz = r0.www * r0.xyz;
	r0.w = -r1.x + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = tile.xy;
	r2.xy = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r1.w = r2.x * i.texcoord2.w;
	r1.xyz = r1.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.x = dot(r0.xyz, r2.xyz);
	r0.y = r0.x * 0.5 + 0.5;
	r0.y = r0.y * r0.y;
	r1.x = lerp(r0.y, r0.x, hll_rate.x);
	r0.xyz = r1.xxx * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r1.x = 2;
	r1.xy = r1.xx + -g_specCalc1.xy;
	r0.xyz = r0.xyz * r1.xxx;
	r1.xzw = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xzw, r1.xzw);
	r0.w = 1 / sqrt(r0.w);
	r2.w = 1 / r0.w;
	r1.xzw = r0.www * r1.xzw;
	r0.w = dot(r1.xzw, r2.xyz);
	r1.x = -r2.w + muzzle_lightpos.w;
	r1.x = r1.x * muzzle_light.w;
	r1.z = r0.w * 0.5 + 0.5;
	r1.z = r1.z * r1.z;
	r2.w = lerp(r1.z, r0.w, hll_rate.x);
	r3.xyz = r2.www * muzzle_light.xyz;
	r0.xyz = r3.xyz * r1.xxx + r0.xyz;
	r1.xzw = point_lightpos2.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xzw, r1.xzw);
	r0.w = 1 / sqrt(r0.w);
	r1.xzw = r0.www * r1.xzw;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos2.w;
	r0.w = r0.w * point_light2.w;
	r1.x = dot(r1.xzw, r2.xyz);
	r1.z = r1.x * 0.5 + 0.5;
	r1.z = r1.z * r1.z;
	r2.w = lerp(r1.z, r1.x, hll_rate.x);
	r1.xzw = r2.www * point_light2.xyz;
	r1.xzw = r0.www * r1.xzw;
	r0.xyz = r1.xzw * r1.yyy + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.y = 1;
	r1.x = r1.y + -spot_param.x;
	r1.x = 1 / r1.x;
	r3.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r1.z = dot(r3.xyz, r3.xyz);
	r1.z = 1 / sqrt(r1.z);
	r3.xyz = r1.zzz * r3.xyz;
	r1.z = 1 / r1.z;
	r1.w = dot(r3.xyz, lightpos.xyz);
	r1.w = r1.w + -spot_param.x;
	r1.x = r1.x * r1.w;
	r2.w = max(r1.w, 0);
	r1.w = 1 / spot_param.y;
	r1.x = r1.w * r1.x;
	r1.w = frac(-r2.w);
	r1.w = r1.w + r2.w;
	r2.w = dot(lightpos.xyz, r2.xyz);
	r3.x = r2.w;
	r1.w = r1.w * r3.x;
	r1.x = r1.x * r1.w;
	r1.w = 1 / spot_angle.w;
	r1.z = r1.w * r1.z;
	r1.z = -r1.z + 1;
	r1.z = r1.z * 10;
	r1.x = r1.z * r1.x;
	r4.x = lerp(r1.x, r3.x, spot_param.z);
	r1.x = r4.x * 0.5 + 0.5;
	r1.x = r1.x * r1.x;
	r3.x = lerp(r1.x, r4.x, hll_rate.x);
	r1.x = r4.x + -0.5;
	r3.xyz = r3.xxx * light_Color.xyz;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r1.zw = tile.xy * i.texcoord.xy;
	r3 = tex2D(tripleMask_sampler, r1.zwzw);
	r0.w = r1.x + r3.x;
	r1.xz = g_All_Offset.xy + i.texcoord.xy;
	r4 = tex2D(Color_1_sampler, r1.xzzw);
	r1.xz = -r4.yy + r4.xz;
	r4.w = max(abs(r1.x), abs(r1.z));
	r1.x = r4.w + -0.015625;
	r1.z = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.z;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r4.xz = (r1.xx >= 0) ? r4.yy : r4.xz;
	r1.xzw = r0.www * r4.xyz;
	r0.xyz = r0.xyz * r1.xzw;
	r0.xyz = r3.www * r0.xyz;
	r1.xzw = r3.xxx * r4.xyz;
	r1.xzw = r1.xzw * ambient_rate.xyz;
	r1.xzw = r1.xzw * ambient_rate_rate.xyz;
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.w = r2.w + -r3.x;
	r2.w = r2.w + 1;
	r0.xyz = r1.xzw * r2.www + r0.xyz;
	r5.x = dot(r2.xyz, transpose(viewInverseMatrix)[0].xyz);
	r5.y = dot(r2.xyz, transpose(viewInverseMatrix)[1].xyz);
	r5.z = dot(r2.xyz, transpose(viewInverseMatrix)[2].xyz);
	r1.x = dot(i.texcoord4.xyz, r5.xyz);
	r1.x = r1.x + r1.x;
	r5.xyz = r5.xyz * -r1.xxx + i.texcoord4.xyz;
	r5.w = -r5.z;
	r6 = tex2D(cubemap_sampler, r5.xyww);
	r5 = tex2D(cubemap2_sampler, r5.xyww);
	r7 = lerp(r5, r6, g_CubeBlendParam.x);
	r5 = r7 * ambient_rate_rate.w;
	r1.xzw = r3.yyy * r5.xyz;
	r2.w = r5.w * CubeParam.y + CubeParam.x;
	r1.xzw = r1.xzw * r2.www;
	r1.xzw = r0.www * r1.xzw;
	r3.xyw = r4.xyz * r1.xzw;
	r4.xyz = r4.xyz + specularParam.www;
	r5.xyz = r3.xyw * CubeParam.zzz + r0.xyz;
	r3.xyw = r3.xyw * CubeParam.zzz;
	r0.xyz = r0.xyz * -r3.xyw + r5.xyz;
	r5.xyz = normalize(-g_eyeLightDir2.xyz);
	r2.w = dot(r5.xyz, r2.xyz);
	r3.x = pow(r2.w, specularParam.z);
	r2.w = r3.x * g_eyeLightDir2.w;
	r5.xyz = normalize(-g_eyeLightDir.xyz);
	r2.x = dot(r5.xyz, r2.xyz);
	r3.x = pow(r2.x, specularParam.z);
	r2.x = r3.x * g_eyeLightDir.w + r2.w;
	r2.xyz = r2.xxx * light_Color.xyz;
	r2.xyz = r3.zzz * r2.xyz;
	r2.xyz = r0.www * r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r2.xyz * r4.xyz + r0.xyz;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r1.xzw * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
