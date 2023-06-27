sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float aniso_diff_rate;
float aniso_shine;
float3 fog;
float4 g_All_Offset;
float4 g_BackLightRate;
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
sampler specularmap_sampler;
float4 spot_angle;
float4 spot_param;
float4 tile;

struct PS_IN
{
	float3 color : COLOR;
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
	float4 r10;
	float4 r11;
	float3 r12;
	float3 r13;
	float3 r14;
	float4 r15;
	float3 r16;
	float3 r17;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r0 = tex2D(specularmap_sampler, r0);
	r2 = r1.w + -0.8;
	clip(r2);
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r2.xyz, r2.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.w = 1 / r0.w;
	r2.xyz = r0.www * r2.xyz;
	r0.w = -r1.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r3.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.w = dot(r3.xyz, r3.xyz);
	r1.w = 1 / sqrt(r1.w);
	r4.xyz = r1.www * r3.xyz;
	r5.xy = g_All_Offset.xy;
	r5.xy = i.texcoord.xy * tile.xy + r5.xy;
	r5 = tex2D(normalmap_sampler, r5);
	r5.xyz = r5.xyz + -0.5;
	r2.w = r5.x * i.texcoord2.w;
	r6.xyz = i.texcoord3.xyz;
	r7.xyz = r6.yzx * i.texcoord2.zxy;
	r6.xyz = i.texcoord2.yzx * r6.zxy + -r7.xyz;
	r5.xyw = -r5.yyy * r6.xyz;
	r5.xyw = r2.www * i.texcoord2.xyz + r5.xyw;
	r5.xyz = r5.zzz * i.texcoord3.xyz + r5.xyw;
	r7.xyz = normalize(r5.xyz);
	r2.w = dot(r4.xyz, r7.xyz);
	r4.z = r2.w;
	r2.w = -r2.w;
	r4.w = dot(i.texcoord1.xyz, -r7.xyz);
	r5.xy = r4.zw;
	r5.xy = r5.xy * -0.5 + 1;
	r5.zw = r5.xy * r5.xy;
	r5.zw = r5.zw * r5.zw;
	r5.xy = r5.xy * -r5.zw + 1;
	r3.w = r5.y * r5.x;
	r4.z = r3.w * 0.193754 + 0.5;
	r3.w = r3.w * 0.387508;
	r4.z = r4.z * r4.z + -r3.w;
	r3.w = hll_rate.x * r4.z + r3.w;
	r4.z = 2;
	r5 = r4.z + -g_specCalc1;
	r8.xyz = r5.xxx * point_light1.xyz;
	r8.xyz = r8.xyz * aniso_diff_rate.xxx;
	r8.xyz = r3.www * r8.xyz;
	r3.w = 1 / r1.w;
	r3.w = -r3.w + point_lightpos1.w;
	r3.w = r3.w * point_light1.w;
	r8.xyz = r3.www * r8.xyz;
	r8.xyz = r5.xxx * r8.xyz;
	r5.x = r2.w * 0.5 + 0.5;
	r5.x = r5.x * r5.x + -r2.w;
	r2.w = hll_rate.x * r5.x + r2.w;
	r9.xyz = r2.www * point_light1.xyz;
	r9.xyz = r9.xyz * i.color.yyy;
	r9.xyz = r9.xyz * g_BackLightRate.xxx;
	r8.xyz = r8.xyz * i.color.zzz + r9.xyz;
	r5.x = aniso_diff_rate.x;
	r9.xyz = r5.xxx * muzzle_light.xyz;
	r2.z = dot(r2.xyz, r7.xyz);
	r2.y = r4.w;
	r10.xy = r2.zy;
	r10.xy = r10.xy * -0.5 + 1;
	r10.zw = r10.xy * r10.xy;
	r10.zw = r10.zw * r10.zw;
	r10.xy = r10.xy * -r10.zw + 1;
	r6.w = r10.y * r10.x;
	r7.w = r6.w * 0.193754 + 0.5;
	r6.w = r6.w * 0.387508;
	r7.w = r7.w * r7.w + -r6.w;
	r6.w = hll_rate.x * r7.w + r6.w;
	r9.xyz = r6.www * r9.xyz;
	r8.xyz = r9.xyz * r0.www + r8.xyz;
	r9.xyz = r5.yyy * point_light2.xyz;
	r9.xyz = r9.xyz * aniso_diff_rate.xxx;
	r10.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r0.w = dot(r10.xyz, r10.xyz);
	r0.w = 1 / sqrt(r0.w);
	r11.xyz = r0.www * r10.xyz;
	r6.w = dot(r11.xyz, r7.xyz);
	r4.y = r6.w;
	r6.w = -r6.w;
	r11.xy = r4.yw;
	r11.xy = r11.xy * -0.5 + 1;
	r11.zw = r11.xy * r11.xy;
	r11.zw = r11.zw * r11.zw;
	r11.xy = r11.xy * -r11.zw + 1;
	r4.y = r11.y * r11.x;
	r7.w = r4.y * 0.193754 + 0.5;
	r4.y = r4.y * 0.387508;
	r7.w = r7.w * r7.w + -r4.y;
	r4.y = hll_rate.x * r7.w + r4.y;
	r9.xyz = r4.yyy * r9.xyz;
	r4.y = 1 / r0.w;
	r4.y = -r4.y + point_lightpos2.w;
	r4.y = r4.y * point_light2.w;
	r9.xyz = r4.yyy * r9.xyz;
	r9.xyz = r5.yyy * r9.xyz;
	r5.y = r6.w * 0.5 + 0.5;
	r5.y = r5.y * r5.y + -r6.w;
	r5.y = hll_rate.x * r5.y + r6.w;
	r11.xyz = r5.yyy * point_light2.xyz;
	r11.xyz = r11.xyz * i.color.yyy;
	r11.xyz = r11.xyz * g_BackLightRate.xxx;
	r9.xyz = r9.xyz * i.color.zzz + r11.xyz;
	r8.xyz = r8.xyz + r9.xyz;
	r5.y = 1 / i.texcoord7.w;
	r9.xy = r5.yy * i.texcoord7.xy;
	r9.xy = r9.xy * float2(0.5, -0.5) + 0.5;
	r9.xy = r9.xy + g_TargetUvParam.xy;
	r9 = tex2D(Shadow_Tex_sampler, r9);
	r5.y = r9.z + g_ShadowUse.x;
	r6.w = 1 / spot_angle.w;
	r9.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r7.w = dot(r9.xyz, r9.xyz);
	r7.w = 1 / sqrt(r7.w);
	r8.w = 1 / r7.w;
	r9.xyz = r7.www * r9.xyz;
	r7.w = dot(r9.xyz, lightpos.xyz);
	r7.w = r7.w + -spot_param.x;
	r6.w = r6.w * r8.w;
	r6.w = -r6.w + 1;
	r6.w = r6.w * 10;
	r9.y = 1;
	r8.w = r9.y + -spot_param.x;
	r8.w = 1 / r8.w;
	r8.w = r7.w * r8.w;
	r9.x = max(r7.w, 0);
	r7.w = 1 / spot_param.y;
	r7.w = r7.w * r8.w;
	r8.w = frac(-r9.x);
	r8.w = r8.w + r9.x;
	r9.x = dot(lightpos.xyz, r7.xyz);
	r9.z = r9.x;
	r8.w = r8.w * r9.z;
	r7.w = r7.w * r8.w;
	r6.w = r6.w * r7.w;
	r4.x = lerp(r6.w, r9.z, spot_param.z);
	r4.xw = r4.xw * r5.yy;
	r4.xw = r4.xw * -0.5 + 1;
	r9.zw = r4.xw * r4.xw;
	r9.zw = r9.zw * r9.zw;
	r4.xw = r4.xw * -r9.zw + 1;
	r4.x = r4.w * r4.x;
	r4.w = r4.x * 0.193754 + 0.5;
	r4.x = r4.x * 0.387508;
	r4.w = r4.w * r4.w + -r4.x;
	r4.x = hll_rate.x * r4.w + r4.x;
	r11.xyz = r5.xxx * light_Color.xyz;
	r12.xyz = r4.xxx * r11.xyz;
	r4.x = -r9.x;
	r4.w = r4.x * 0.5 + 0.5;
	r4.w = r4.w * r4.w;
	r2.w = lerp(r4.w, r4.x, hll_rate.x);
	r4.xw = r2.wy;
	r4.xw = r4.xw * -0.5 + 1;
	r9.zw = r4.xw * r4.xw;
	r9.zw = r9.zw * r9.zw;
	r4.xw = r4.xw * -r9.zw + 1;
	r2.w = r4.w * r4.x;
	r2.w = r2.w * 0.387508;
	r11.xyz = r2.www * r11.xyz;
	r11.xyz = r12.xyz * i.color.zzz + r11.xyz;
	r8.xyz = r8.xyz + r11.xyz;
	r4.xw = -r1.yy + r1.xz;
	r2.w = max(abs(r4.x), abs(r4.w));
	r2.w = r2.w + -0.015625;
	r4.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r4.x;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r1.xz = (r2.ww >= 0) ? r1.yy : r1.xz;
	r11.xyz = r1.xyz * point_lightEv0.xyz;
	r12.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r2.w = dot(r12.xyz, r12.xyz);
	r2.w = 1 / sqrt(r2.w);
	r4.x = 1 / r2.w;
	r4.x = -r4.x + point_lightposEv0.w;
	r4.x = r4.x * point_lightEv0.w;
	r4.x = r4.x * i.color.x;
	r11.xyz = r4.xxx * r11.xyz;
	r11.xyz = r5.zzz * r11.xyz;
	r11.xyz = r11.xyz * aniso_diff_rate.xxx;
	r13.xyz = r2.www * r12.xyz;
	r2.x = dot(r13.xyz, r7.xyz);
	r5.xz = r2.xy;
	r5.xz = r5.xz * -0.5 + 1;
	r9.zw = r5.xz * r5.xz;
	r9.zw = r9.zw * r9.zw;
	r5.xz = r5.xz * -r9.zw + 1;
	r4.w = r5.z * r5.x;
	r5.x = r4.w * 0.193754 + 0.5;
	r4.w = r4.w * 0.387508;
	r5.x = r5.x * r5.x + -r4.w;
	r4.w = hll_rate.x * r5.x + r4.w;
	r11.xyz = r4.www * r11.xyz;
	r8.xyz = r1.xyz * r8.xyz + r11.xyz;
	r11.xyz = r1.xyz * point_lightEv1.xyz;
	r13.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r4.w = dot(r13.xyz, r13.xyz);
	r4.w = 1 / sqrt(r4.w);
	r5.x = 1 / r4.w;
	r5.x = -r5.x + point_lightposEv1.w;
	r5.x = r5.x * point_lightEv1.w;
	r5.x = r5.x * i.color.x;
	r11.xyz = r5.xxx * r11.xyz;
	r11.xyz = r5.www * r11.xyz;
	r11.xyz = r11.xyz * aniso_diff_rate.xxx;
	r14.xyz = r4.www * r13.xyz;
	r2.z = dot(r14.xyz, r7.xyz);
	r5.zw = r2.zy;
	r5.zw = r5.zw * -0.5 + 1;
	r9.zw = r5.zw * r5.zw;
	r9.zw = r9.zw * r9.zw;
	r5.zw = r5.zw * -r9.zw + 1;
	r2.z = r5.w * r5.z;
	r5.z = r2.z * 0.193754 + 0.5;
	r2.z = r2.z * 0.387508;
	r5.z = r5.z * r5.z + -r2.z;
	r2.z = hll_rate.x * r5.z + r2.z;
	r8.xyz = r11.xyz * r2.zzz + r8.xyz;
	r11.xyz = r1.xyz * point_lightEv2.xyz;
	r14.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r2.z = dot(r14.xyz, r14.xyz);
	r2.z = 1 / sqrt(r2.z);
	r5.z = 1 / r2.z;
	r5.z = -r5.z + point_lightposEv2.w;
	r5.z = r5.z * point_lightEv2.w;
	r5.z = r5.z * i.color.x;
	r11.xyz = r5.zzz * r11.xyz;
	r4.z = r4.z + -g_specCalc2.x;
	r11.xyz = r4.zzz * r11.xyz;
	r11.xyz = r11.xyz * aniso_diff_rate.xxx;
	r15.xyz = r2.zzz * r14.xyz;
	r2.x = dot(r15.xyz, r7.xyz);
	r2.xy = r2.xy;
	r2.xy = r2.xy * -0.5 + 1;
	r9.zw = r2.xy * r2.xy;
	r9.zw = r9.zw * r9.zw;
	r2.xy = r2.xy * -r9.zw + 1;
	r2.x = r2.y * r2.x;
	r2.y = r2.x * 0.193754 + 0.5;
	r2.x = r2.x * 0.387508;
	r2.y = r2.y * r2.y + -r2.x;
	r2.x = hll_rate.x * r2.y + r2.x;
	r8.xyz = r11.xyz * r2.xxx + r8.xyz;
	r11.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r11.xyz = r11.xyz * ambient_rate_rate.xyz;
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.x = -r2.x + r9.x;
	r2.x = r2.x + 1;
	r8.xyz = r11.xyz * r2.xxx + r8.xyz;
	r9.xzw = r3.xyz * r1.www + -i.texcoord1.xyz;
	r11.xyz = normalize(r9.xzw);
	r2.x = dot(r11.xyz, r6.xyz);
	r2.x = abs(r2.x) * -aniso_shine.x + r9.y;
	r2.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.y = 1 / sqrt(r2.y);
	r9.xzw = r2.yyy * -i.texcoord1.xyz;
	r11.xyz = -i.texcoord1.xyz * r2.yyy + lightpos.xyz;
	r15.xyz = normalize(r11.xyz);
	r2.y = dot(r15.xyz, r7.xyz);
	r3.xyz = r3.xyz * r1.www + r9.xzw;
	r11.xyz = normalize(r3.xyz);
	r1.w = dot(r11.xyz, r7.xyz);
	r3.x = -r1.w + 1;
	r1.w = r3.x * -specularParam.z + r1.w;
	r11.z = r2.x * r1.w;
	r11.yw = specularParam.yy;
	r15 = tex2D(Spec_Pow_sampler, r11.zwzw);
	r3.xyz = r15.xyz * point_light1.xyz;
	r3.xyz = r3.www * r3.xyz;
	r3.xyz = r0.xyz * r3.xyz;
	r15 = g_specCalc1;
	r3.xyz = r3.xyz * r15.xxx;
	r1.w = -r2.y + 1;
	r1.w = r1.w * -specularParam.z + r2.y;
	r16.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r17.xyz = normalize(r16.xyz);
	r2.x = dot(r17.xyz, r6.xyz);
	r2.x = abs(r2.x) * -aniso_shine.x + r9.y;
	r11.x = r1.w * r2.x;
	r11 = tex2D(Spec_Pow_sampler, r11);
	r11.xyz = r11.xyz * light_Color.xyz;
	r11.xyz = r0.xyz * r11.xyz;
	r3.xyz = r11.xyz * r5.yyy + r3.xyz;
	r11.xyz = r10.xyz * r0.www + -i.texcoord1.xyz;
	r10.xyz = r10.xyz * r0.www + r9.xzw;
	r16.xyz = normalize(r10.xyz);
	r0.w = dot(r16.xyz, r7.xyz);
	r10.xyz = normalize(r11.xyz);
	r1.w = dot(r10.xyz, r6.xyz);
	r1.w = abs(r1.w) * -aniso_shine.x + r9.y;
	r2.x = -r0.w + 1;
	r0.w = r2.x * -specularParam.z + r0.w;
	r10.x = r1.w * r0.w;
	r10.yw = specularParam.yy;
	r11 = tex2D(Spec_Pow_sampler, r10);
	r11.xyz = r11.xyz * point_light2.xyz;
	r11.xyz = r4.yyy * r11.xyz;
	r11.xyz = r0.xyz * r11.xyz;
	r3.xyz = r11.xyz * r15.yyy + r3.xyz;
	r11.xyz = r12.xyz * r2.www + -i.texcoord1.xyz;
	r2.xyw = r12.xyz * r2.www + r9.xzw;
	r12.xyz = normalize(r2.xyw);
	r0.w = dot(r12.xyz, r7.xyz);
	r12.xyz = normalize(r11.xyz);
	r1.w = dot(r12.xyz, r6.xyz);
	r1.w = abs(r1.w) * -aniso_shine.x + r9.y;
	r2.x = -r0.w + 1;
	r0.w = r2.x * -specularParam.z + r0.w;
	r10.z = r1.w * r0.w;
	r10 = tex2D(Spec_Pow_sampler, r10.zwzw);
	r2.xyw = r10.xyz * point_lightEv0.xyz;
	r2.xyw = r4.xxx * r2.xyw;
	r2.xyw = r0.xyz * r2.xyw;
	r2.xyw = r2.xyw * r15.zzz + r3.xyz;
	r3.xyz = r13.xyz * r4.www + -i.texcoord1.xyz;
	r4.xyz = r13.xyz * r4.www + r9.xzw;
	r9.xzw = r14.xyz * r2.zzz + r9.xzw;
	r10.xyz = r14.xyz * r2.zzz + -i.texcoord1.xyz;
	r11.xyz = normalize(r10.xyz);
	r0.w = dot(r11.xyz, r6.xyz);
	r0.w = abs(r0.w) * -aniso_shine.x + r9.y;
	r10.xyz = normalize(r9.xzw);
	r1.w = dot(r10.xyz, r7.xyz);
	r10.xyz = normalize(r4.xyz);
	r2.z = dot(r10.xyz, r7.xyz);
	r4.xyz = normalize(r3.xyz);
	r3.x = dot(r4.xyz, r6.xyz);
	r3.x = abs(r3.x) * -aniso_shine.x + r9.y;
	r3.y = -r2.z + 1;
	r2.z = r3.y * -specularParam.z + r2.z;
	r3.x = r3.x * r2.z;
	r3.yw = specularParam.yy;
	r4 = tex2D(Spec_Pow_sampler, r3);
	r4.xyz = r4.xyz * point_lightEv1.xyz;
	r4.xyz = r5.xxx * r4.xyz;
	r4.xyz = r0.xyz * r4.xyz;
	r2.xyz = r4.xyz * r15.www + r2.xyw;
	r2.w = -r1.w + 1;
	r1.w = r2.w * -specularParam.z + r1.w;
	r3.z = r0.w * r1.w;
	r3 = tex2D(Spec_Pow_sampler, r3.zwzw);
	r3.xyz = r3.xyz * point_lightEv2.xyz;
	r3.xyz = r5.zzz * r3.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.w = g_specCalc2.x;
	r0.xyz = r0.xyz * r0.www + r2.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * i.color.xxx + r8.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
