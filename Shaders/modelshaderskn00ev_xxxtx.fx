sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_specCalc1;
float4 g_specCalc2;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap_sampler;
float4 point_light1;
float4 point_light2;
float4 point_lightEv0;
float4 point_lightEv1;
float4 point_lightEv2;
float4 point_lightpos1;
float4 point_lightpos2;
float4 point_lightposEv0;
float4 point_lightposEv1;
float4 point_lightposEv2;
float4 prefogcolor_enhance;
float4 specularParam;
float4 spot_angle;
float4 spot_param;
float ss_scat_pow;
float ss_scat_rate;
float4 tile;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
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
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float3 r10;
	float4 r11;
	float4 r12;
	float4 r13;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = 1 / spot_angle.w;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r0.w = 1 / r0.z;
	r1.xyz = r0.zzz * r1.xyz;
	r0.z = dot(r1.xyz, lightpos.xyz);
	r0.z = r0.z + -spot_param.x;
	r0.y = r0.y * r0.w;
	r0.y = -r0.y + 1;
	r0.y = r0.y * 10;
	r1.y = 1;
	r0.w = r1.y + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.x = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.x);
	r0.w = r0.w + r1.x;
	r2.xyz = i.texcoord3.xyz;
	r1.xzw = r2.yzx * i.texcoord2.zxy;
	r1.xzw = i.texcoord2.yzx * r2.zxy + -r1.xzw;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xzw = r1.xzw * -r2.yyy;
	r2.x = r2.x * i.texcoord2.w;
	r1.xzw = r2.xxx * i.texcoord2.xyz + r1.xzw;
	r1.xzw = r2.zzz * i.texcoord3.xyz + r1.xzw;
	r2.x = dot(r1.xzw, r1.xzw);
	r2.x = 1 / sqrt(r2.x);
	r2.yzw = r1.xzw * r2.xxx;
	r1.x = r1.w * -r2.x + 1;
	r1.z = dot(lightpos.xyz, r2.yzw);
	r1.w = r1.z;
	r0.w = r0.w * r1.w;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r2.x = lerp(r0.y, r1.w, spot_param.z);
	r0.y = r2.x * 0.5 + 0.5;
	r0.y = r0.y * r0.y;
	r1.w = lerp(r0.y, r2.x, hll_rate.x);
	r0.yzw = r1.www * light_Color.xyz;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r1.w = dot(r3.xyz, r3.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.x = 1 / r1.w;
	r3.xyz = r1.www * r3.xyz;
	r1.w = dot(r3.xyz, r2.yzw);
	r2.x = -r2.x + muzzle_lightpos.w;
	r2.x = r2.x * muzzle_light.w;
	r3.x = r1.w * 0.5 + 0.5;
	r3.x = r3.x * r3.x;
	r4.x = lerp(r3.x, r1.w, hll_rate.x);
	r3.xyz = r4.xxx * muzzle_light.xyz;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.w = dot(r4.xyz, r4.xyz);
	r1.w = 1 / sqrt(r1.w);
	r5.xyz = r1.www * r4.xyz;
	r3.w = dot(r5.xyz, r2.yzw);
	r4.w = r3.w * 0.5 + 0.5;
	r4.w = r4.w * r4.w;
	r5.x = lerp(r4.w, r3.w, hll_rate.x);
	r5.xyz = r5.xxx * point_light1.xyz;
	r3.w = 1 / r1.w;
	r3.w = -r3.w + point_lightpos1.w;
	r3.w = r3.w * point_light1.w;
	r5.xyz = r3.www * r5.xyz;
	r6 = g_specCalc1;
	r6 = -r6 + 2;
	r5.xyz = r5.xyz * r6.xxx;
	r3.xyz = r3.xyz * r2.xxx + r5.xyz;
	r5.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r2.x = dot(r5.xyz, r5.xyz);
	r2.x = 1 / sqrt(r2.x);
	r7.xyz = r2.xxx * r5.xyz;
	r4.w = dot(r7.xyz, r2.yzw);
	r5.w = r4.w * 0.5 + 0.5;
	r5.w = r5.w * r5.w;
	r6.x = lerp(r5.w, r4.w, hll_rate.x);
	r7.xyz = r6.xxx * point_light2.xyz;
	r4.w = 1 / r2.x;
	r4.w = -r4.w + point_lightpos2.w;
	r4.w = r4.w * point_light2.w;
	r7.xyz = r4.www * r7.xyz;
	r3.xyz = r7.xyz * r6.yyy + r3.xyz;
	r0.yzw = r0.yzw * r0.xxx + r3.xyz;
	r3.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r5.w = dot(r3.xyz, r3.xyz);
	r5.w = 1 / sqrt(r5.w);
	r7.xyz = r3.xyz * r5.www;
	r6.x = dot(r7.xyz, r2.yzw);
	r6.y = r6.x * 0.5 + 0.5;
	r6.y = r6.y * r6.y;
	r7.x = lerp(r6.y, r6.x, hll_rate.x);
	r6.xy = g_All_Offset.xy + i.texcoord.xy;
	r8 = tex2D(Color_1_sampler, r6);
	r6.xy = -r8.yy + r8.xz;
	r7.y = max(abs(r6.x), abs(r6.y));
	r6.x = r7.y + -0.015625;
	r6.y = (-r6.x >= 0) ? 0 : 1;
	r6.x = (r6.x >= 0) ? -0 : -1;
	r6.x = r6.x + r6.y;
	r6.x = (r6.x >= 0) ? -r6.x : -0;
	r8.xz = (r6.xx >= 0) ? r8.yy : r8.xz;
	r7.yzw = r8.xyz * point_lightEv0.xyz;
	r7.xyz = r7.xxx * r7.yzw;
	r6.x = 1 / r5.w;
	r6.x = -r6.x + point_lightposEv0.w;
	r6.x = r6.x * point_lightEv0.w;
	r7.xyz = r6.xxx * r7.xyz;
	r7.xyz = r6.zzz * r7.xyz;
	r0.yzw = r8.xyz * r0.yzw + r7.xyz;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r6.y = dot(r7.xyz, r7.xyz);
	r6.y = 1 / sqrt(r6.y);
	r9.xyz = r6.yyy * r7.xyz;
	r6.z = dot(r9.xyz, r2.yzw);
	r7.w = r6.z * 0.5 + 0.5;
	r7.w = r7.w * r7.w;
	r9.x = lerp(r7.w, r6.z, hll_rate.x);
	r9.yzw = r8.xyz * point_lightEv1.xyz;
	r9.xyz = r9.xxx * r9.yzw;
	r6.z = 1 / r6.y;
	r6.z = -r6.z + point_lightposEv1.w;
	r6.z = r6.z * point_lightEv1.w;
	r9.xyz = r6.zzz * r9.xyz;
	r0.yzw = r9.xyz * r6.www + r0.yzw;
	r9.x = 2;
	r6.w = r9.x + -g_specCalc2.x;
	r9.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r7.w = dot(r9.xyz, r9.xyz);
	r7.w = 1 / sqrt(r7.w);
	r10.xyz = r7.www * r9.xyz;
	r9.w = dot(r10.xyz, r2.yzw);
	r10.x = r9.w * 0.5 + 0.5;
	r10.x = r10.x * r10.x;
	r11.x = lerp(r10.x, r9.w, hll_rate.x);
	r10.xyz = r8.xyz * point_lightEv2.xyz;
	r10.xyz = r11.xxx * r10.xyz;
	r9.w = 1 / r7.w;
	r9.w = -r9.w + point_lightposEv2.w;
	r9.w = r9.w * point_lightEv2.w;
	r10.xyz = r9.www * r10.xyz;
	r0.yzw = r10.xyz * r6.www + r0.yzw;
	r6.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.z = r1.z + -r6.w;
	r1.z = r1.z + 1;
	r10.xyz = r8.xyz * ambient_rate.xyz;
	r10.xyz = r10.xyz * ambient_rate_rate.xyz;
	r0.yzw = r10.xyz * r1.zzz + r0.yzw;
	r1.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.z = 1 / sqrt(r1.z);
	r10.xyz = r1.zzz * -i.texcoord1.xyz;
	r11.xyz = -i.texcoord1.xyz * r1.zzz + lightpos.xyz;
	r12.xyz = normalize(r11.xyz);
	r1.z = dot(r12.xyz, r2.yzw);
	r4.xyz = r4.xyz * r1.www + r10.xyz;
	r11.xyz = normalize(r4.xyz);
	r1.w = dot(r11.xyz, r2.yzw);
	r4.x = -r1.w + 1;
	r11.z = r4.x * -specularParam.z + r1.w;
	r11.yw = specularParam.yy;
	r12 = tex2D(Spec_Pow_sampler, r11.zwzw);
	r4.xyz = r12.xyz * point_light1.xyz;
	r4.xyz = r3.www * r4.xyz;
	r4.xyz = r8.www * r4.xyz;
	r12 = g_specCalc1;
	r4.xyz = r4.xyz * r12.xxx;
	r1.w = -r1.z + 1;
	r11.x = r1.w * -specularParam.z + r1.z;
	r11 = tex2D(Spec_Pow_sampler, r11);
	r11.xyz = r11.xyz * light_Color.xyz;
	r11.xyz = r8.www * r11.xyz;
	r4.xyz = r11.xyz * r0.xxx + r4.xyz;
	r5.xyz = r5.xyz * r2.xxx + r10.xyz;
	r11.xyz = normalize(r5.xyz);
	r0.x = dot(r11.xyz, r2.yzw);
	r1.z = -r0.x + 1;
	r11.x = r1.z * -specularParam.z + r0.x;
	r11.yw = specularParam.yy;
	r13 = tex2D(Spec_Pow_sampler, r11);
	r5.xyz = r13.xyz * point_light2.xyz;
	r5.xyz = r4.www * r5.xyz;
	r5.xyz = r8.www * r5.xyz;
	r4.xyz = r5.xyz * r12.yyy + r4.xyz;
	r3.xyz = r3.xyz * r5.www + r10.xyz;
	r5.xyz = normalize(r3.xyz);
	r0.x = dot(r5.xyz, r2.yzw);
	r1.z = -r0.x + 1;
	r11.z = r1.z * -specularParam.z + r0.x;
	r3 = tex2D(Spec_Pow_sampler, r11.zwzw);
	r3.xyz = r3.xyz * point_lightEv0.xyz;
	r3.xyz = r6.xxx * r3.xyz;
	r3.xyz = r8.www * r3.xyz;
	r3.xyz = r3.xyz * r12.zzz + r4.xyz;
	r4.xyz = r7.xyz * r6.yyy + r10.xyz;
	r5.xyz = r9.xyz * r7.www + r10.xyz;
	r7.xyz = normalize(r5.xyz);
	r0.x = dot(r7.xyz, r2.yzw);
	r5.xyz = normalize(r4.xyz);
	r1.z = dot(r5.xyz, r2.yzw);
	r1.w = -r1.z + 1;
	r2.x = r1.w * -specularParam.z + r1.z;
	r2.yw = specularParam.yy;
	r4 = tex2D(Spec_Pow_sampler, r2);
	r4.xyz = r4.xyz * point_lightEv1.xyz;
	r4.xyz = r6.zzz * r4.xyz;
	r4.xyz = r8.www * r4.xyz;
	r3.xyz = r4.xyz * r12.www + r3.xyz;
	r1.z = -r0.x + 1;
	r2.z = r1.z * -specularParam.z + r0.x;
	r2 = tex2D(Spec_Pow_sampler, r2.zwzw);
	r2.xyz = r2.xyz * point_lightEv2.xyz;
	r2.xyz = r9.www * r2.xyz;
	r2.xyz = r8.www * r2.xyz;
	r0.x = g_specCalc2.x;
	r2.xyz = r2.xyz * r0.xxx + r3.xyz;
	r0.x = abs(specularParam.x);
	r2.xyz = r0.xxx * r2.xyz;
	r3.xyz = r8.xyz + specularParam.www;
	r4.xyz = r1.xxx * r8.xyz;
	r0.x = r1.x + -ss_scat_rate.x;
	r1.xzw = r4.xyz * ss_scat_pow.xxx;
	r0.yzw = r2.xyz * r3.xyz + r0.yzw;
	r1.y = r1.y + -ss_scat_rate.x;
	r1.y = 1 / r1.y;
	r1.y = r0.x * r1.y;
	r0.x = r0.x;
	r2.x = frac(-r0.x);
	r0.x = r0.x + r2.x;
	r0.x = r0.x * r1.y;
	r0.xyz = r1.xzw * r0.xxx + r0.yzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
