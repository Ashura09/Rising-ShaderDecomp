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
float4 g_specCalc1;
float4 g_specCalc2;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
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
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;
	float3 r12;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r0 = tex2D(specularmap_sampler, r0);
	r2.x = -0.01;
	r2 = r1.w * ambient_rate.w + r2.x;
	clip(r2);
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r0.w = r2.z + g_ShadowUse.x;
	r2.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.x = 1 / sqrt(r2.x);
	r2.yzw = -i.texcoord1.xyz * r2.xxx + lightpos.xyz;
	r3.xyz = r2.xxx * -i.texcoord1.xyz;
	r4.xyz = normalize(r2.yzw);
	r2.x = dot(r4.xyz, i.texcoord3.xyz);
	r2.y = -r2.x + 1;
	r2.x = r2.y * -specularParam.z + r2.x;
	r2.yzw = lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r2.yzw);
	r5.xyz = i.texcoord3.xyz;
	r2.yzw = r5.yzx * i.texcoord2.zxy;
	r2.yzw = i.texcoord2.yzx * r5.zxy + -r2.yzw;
	r3.w = dot(r4.xyz, r2.yzw);
	r4.y = 1;
	r3.w = abs(r3.w) * -aniso_shine.x + r4.y;
	r6.x = r2.x * r3.w;
	r6.yw = specularParam.yy;
	r7 = tex2D(Spec_Pow_sampler, r6);
	r4.xzw = r7.xyz * light_Color.xyz;
	r4.xzw = r0.xyz * r4.xzw;
	r7.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.x = dot(r7.xyz, r7.xyz);
	r2.x = 1 / sqrt(r2.x);
	r8.xyz = r7.xyz * r2.xxx + r3.xyz;
	r9.xyz = normalize(r8.xyz);
	r3.w = dot(r9.xyz, i.texcoord3.xyz);
	r5.w = -r3.w + 1;
	r3.w = r5.w * -specularParam.z + r3.w;
	r8.xyz = r7.xyz * r2.xxx + -i.texcoord1.xyz;
	r7.xyz = r2.xxx * r7.xyz;
	r2.x = 1 / r2.x;
	r2.x = -r2.x + point_lightpos1.w;
	r2.x = r2.x * point_light1.w;
	r7.z = dot(r7.xyz, i.texcoord3.xyz);
	r9.xyz = normalize(r8.xyz);
	r5.w = dot(r9.xyz, r2.yzw);
	r5.w = abs(r5.w) * -aniso_shine.x + r4.y;
	r6.z = r3.w * r5.w;
	r6 = tex2D(Spec_Pow_sampler, r6.zwzw);
	r6.xyz = r6.xyz * point_light1.xyz;
	r6.xyz = r2.xxx * r6.xyz;
	r6.xyz = r0.xyz * r6.xyz;
	r8 = g_specCalc1;
	r6.xyz = r6.xyz * r8.xxx;
	r4.xzw = r4.xzw * r0.www + r6.xyz;
	r6.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r3.w = dot(r6.xyz, r6.xyz);
	r3.w = 1 / sqrt(r3.w);
	r9.xyz = r6.xyz * r3.www + r3.xyz;
	r10.xyz = normalize(r9.xyz);
	r5.w = dot(r10.xyz, i.texcoord3.xyz);
	r6.w = -r5.w + 1;
	r5.w = r6.w * -specularParam.z + r5.w;
	r9.xyz = r6.xyz * r3.www + -i.texcoord1.xyz;
	r6.xyz = r3.www * r6.xyz;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightpos2.w;
	r3.w = r3.w * point_light2.w;
	r7.y = dot(r6.xyz, i.texcoord3.xyz);
	r6.xyz = normalize(r9.xyz);
	r6.x = dot(r6.xyz, r2.yzw);
	r6.x = abs(r6.x) * -aniso_shine.x + r4.y;
	r6.x = r5.w * r6.x;
	r6.yw = specularParam.yy;
	r9 = tex2D(Spec_Pow_sampler, r6);
	r9.xyz = r9.xyz * point_light2.xyz;
	r9.xyz = r3.www * r9.xyz;
	r9.xyz = r0.xyz * r9.xyz;
	r4.xzw = r9.xyz * r8.yyy + r4.xzw;
	r9.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r5.w = dot(r9.xyz, r9.xyz);
	r5.w = 1 / sqrt(r5.w);
	r10.xyz = r9.xyz * r5.www + r3.xyz;
	r11.xyz = normalize(r10.xyz);
	r6.x = dot(r11.xyz, i.texcoord3.xyz);
	r6.y = -r6.x + 1;
	r6.x = r6.y * -specularParam.z + r6.x;
	r10.xyz = r9.xyz * r5.www + -i.texcoord1.xyz;
	r9.xyz = r5.www * r9.xyz;
	r5.w = 1 / r5.w;
	r5.w = -r5.w + point_lightposEv0.w;
	r5.w = r5.w * point_lightEv0.w;
	r5.w = r5.w * i.color.x;
	r9.y = dot(r9.xyz, i.texcoord3.xyz);
	r11.xyz = normalize(r10.xyz);
	r6.y = dot(r11.xyz, r2.yzw);
	r6.y = abs(r6.y) * -aniso_shine.x + r4.y;
	r6.z = r6.y * r6.x;
	r6 = tex2D(Spec_Pow_sampler, r6.zwzw);
	r6.xyz = r6.xyz * point_lightEv0.xyz;
	r6.xyz = r5.www * r6.xyz;
	r6.xyz = r0.xyz * r6.xyz;
	r4.xzw = r6.xyz * r8.zzz + r4.xzw;
	r6.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r6.w = dot(r6.xyz, r6.xyz);
	r6.w = 1 / sqrt(r6.w);
	r8.xyz = r6.xyz * r6.www + r3.xyz;
	r10.xyz = normalize(r8.xyz);
	r8.x = dot(r10.xyz, i.texcoord3.xyz);
	r8.y = -r8.x + 1;
	r8.x = r8.y * -specularParam.z + r8.x;
	r10.xyz = r6.xyz * r6.www + -i.texcoord1.xyz;
	r6.xyz = r6.www * r6.xyz;
	r6.w = 1 / r6.w;
	r6.w = -r6.w + point_lightposEv1.w;
	r6.w = r6.w * point_lightEv1.w;
	r6.w = r6.w * i.color.x;
	r9.x = dot(r6.xyz, i.texcoord3.xyz);
	r6.xyz = normalize(r10.xyz);
	r6.x = dot(r6.xyz, r2.yzw);
	r6.x = abs(r6.x) * -aniso_shine.x + r4.y;
	r10.x = r6.x * r8.x;
	r10.yw = specularParam.yy;
	r11 = tex2D(Spec_Pow_sampler, r10);
	r6.xyz = r11.xyz * point_lightEv1.xyz;
	r6.xyz = r6.www * r6.xyz;
	r6.xyz = r0.xyz * r6.xyz;
	r4.xzw = r6.xyz * r8.www + r4.xzw;
	r6.x = g_specCalc2.x;
	r8.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r6.y = dot(r8.xyz, r8.xyz);
	r6.y = 1 / sqrt(r6.y);
	r3.xyz = r8.xyz * r6.yyy + r3.xyz;
	r11.xyz = normalize(r3.xyz);
	r3.x = dot(r11.xyz, i.texcoord3.xyz);
	r3.y = -r3.x + 1;
	r3.x = r3.y * -specularParam.z + r3.x;
	r11.xyz = r8.xyz * r6.yyy + -i.texcoord1.xyz;
	r8.xyz = r6.yyy * r8.xyz;
	r3.y = 1 / r6.y;
	r3.y = -r3.y + point_lightposEv2.w;
	r3.y = r3.y * point_lightEv2.w;
	r3.y = r3.y * i.color.x;
	r8.x = dot(r8.xyz, i.texcoord3.xyz);
	r12.xyz = normalize(r11.xyz);
	r2.y = dot(r12.xyz, r2.yzw);
	r2.y = abs(r2.y) * -aniso_shine.x + r4.y;
	r10.z = r2.y * r3.x;
	r10 = tex2D(Spec_Pow_sampler, r10.zwzw);
	r2.yzw = r10.xyz * point_lightEv2.xyz;
	r2.yzw = r3.yyy * r2.yzw;
	r0.xyz = r0.xyz * r2.yzw;
	r0.xyz = r0.xyz * r6.xxx + r4.xzw;
	r2.y = abs(specularParam.x);
	r0.xyz = r0.xyz * r2.yyy;
	r2.yz = -r1.yy + r1.xz;
	r3.x = max(abs(r2.y), abs(r2.z));
	r2.y = r3.x + -0.015625;
	r2.z = (-r2.y >= 0) ? 0 : 1;
	r2.y = (r2.y >= 0) ? -0 : -1;
	r2.y = r2.y + r2.z;
	r2.y = (r2.y >= 0) ? -r2.y : -0;
	r1.xz = (r2.yy >= 0) ? r1.yy : r1.xz;
	r1.w = r1.w * ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r2.yzw = r1.xyz + specularParam.www;
	r0.xyz = r0.xyz * r2.yzw;
	r7.w = dot(i.texcoord1.xyz, -r5.xyz);
	r2.yz = r7.zw;
	r2.yz = r2.yz * -0.5 + 1;
	r3.xz = r2.yz * r2.yz;
	r3.xz = r3.xz * r3.xz;
	r2.yz = r2.yz * -r3.xz + 1;
	r1.w = r2.z * r2.y;
	r2.y = r1.w * 0.193754 + 0.5;
	r1.w = r1.w * 0.387508;
	r2.y = r2.y * r2.y + -r1.w;
	r1.w = hll_rate.x * r2.y + r1.w;
	r2.z = 2;
	r10 = r2.z + -g_specCalc1;
	r4.xzw = r10.xxx * point_light1.xyz;
	r4.xzw = r4.xzw * aniso_diff_rate.xxx;
	r4.xzw = r1.www * r4.xzw;
	r2.xyw = r2.xxx * r4.xzw;
	r2.xyw = r10.xxx * r2.xyw;
	r4.xzw = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r1.w = dot(r4.xzw, r4.xzw);
	r1.w = 1 / sqrt(r1.w);
	r4.xzw = r1.www * r4.xzw;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + muzzle_lightpos.w;
	r1.w = r1.w * muzzle_light.w;
	r9.z = dot(r4.xzw, i.texcoord3.xyz);
	r9.w = r7.w;
	r3.xz = r9.zw;
	r3.xz = r3.xz * -0.5 + 1;
	r4.xz = r3.xz * r3.xz;
	r4.xz = r4.xz * r4.xz;
	r3.xz = r3.xz * -r4.xz + 1;
	r3.x = r3.z * r3.x;
	r3.z = r3.x * 0.193754 + 0.5;
	r3.x = r3.x * 0.387508;
	r3.z = r3.z * r3.z + -r3.x;
	r3.x = hll_rate.x * r3.z + r3.x;
	r4.x = aniso_diff_rate.x;
	r5.xyz = r4.xxx * muzzle_light.xyz;
	r5.xyz = r3.xxx * r5.xyz;
	r2.xyw = r5.xyz * r1.www + r2.xyw;
	r3.xz = r7.yw;
	r3.xz = r3.xz * -0.5 + 1;
	r4.zw = r3.xz * r3.xz;
	r4.zw = r4.zw * r4.zw;
	r3.xz = r3.xz * -r4.zw + 1;
	r1.w = r3.z * r3.x;
	r3.x = r1.w * 0.193754 + 0.5;
	r1.w = r1.w * 0.387508;
	r3.x = r3.x * r3.x + -r1.w;
	r1.w = hll_rate.x * r3.x + r1.w;
	r5.xyz = r10.yyy * point_light2.xyz;
	r5.xyz = r5.xyz * aniso_diff_rate.xxx;
	r5.xyz = r1.www * r5.xyz;
	r3.xzw = r3.www * r5.xyz;
	r2.xyw = r3.xzw * r10.yyy + r2.xyw;
	r1.w = r4.y + -spot_param.x;
	r1.w = 1 / r1.w;
	r3.xzw = spot_angle.xyz + -i.texcoord1.xyz;
	r4.y = dot(r3.xzw, r3.xzw);
	r4.y = 1 / sqrt(r4.y);
	r3.xzw = r3.xzw * r4.yyy;
	r4.y = 1 / r4.y;
	r3.x = dot(r3.xzw, lightpos.xyz);
	r3.x = r3.x + -spot_param.x;
	r1.w = r1.w * r3.x;
	r4.z = max(r3.x, 0);
	r3.x = 1 / spot_param.y;
	r1.w = r1.w * r3.x;
	r3.x = frac(-r4.z);
	r3.x = r3.x + r4.z;
	r3.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r3.x = r3.x * r3.z;
	r1.w = r1.w * r3.x;
	r3.x = 1 / spot_angle.w;
	r3.x = r3.x * r4.y;
	r3.x = -r3.x + 1;
	r3.x = r3.x * 10;
	r1.w = r1.w * r3.x;
	r7.x = lerp(r1.w, r3.z, spot_param.z);
	r3.xz = r0.ww * r7.xw;
	r3.xz = r3.xz * -0.5 + 1;
	r4.yz = r3.xz * r3.xz;
	r4.yz = r4.yz * r4.yz;
	r3.xz = r3.xz * -r4.yz + 1;
	r0.w = r3.z * r3.x;
	r1.w = r0.w * 0.193754 + 0.5;
	r0.w = r0.w * 0.387508;
	r1.w = r1.w * r1.w + -r0.w;
	r0.w = hll_rate.x * r1.w + r0.w;
	r3.xzw = r4.xxx * light_Color.xyz;
	r2.xyw = r3.xzw * r0.www + r2.xyw;
	r3.xz = r9.yw;
	r3.xz = r3.xz * -0.5 + 1;
	r4.xy = r3.xz * r3.xz;
	r4.xy = r4.xy * r4.xy;
	r3.xz = r3.xz * -r4.xy + 1;
	r0.w = r3.z * r3.x;
	r1.w = r0.w * 0.193754 + 0.5;
	r0.w = r0.w * 0.387508;
	r1.w = r1.w * r1.w + -r0.w;
	r0.w = hll_rate.x * r1.w + r0.w;
	r3.xzw = r1.xyz * point_lightEv0.xyz;
	r3.xzw = r5.www * r3.xzw;
	r3.xzw = r10.zzz * r3.xzw;
	r3.xzw = r3.xzw * aniso_diff_rate.xxx;
	r3.xzw = r0.www * r3.xzw;
	r2.xyw = r1.xyz * r2.xyw + r3.xzw;
	r3.xz = r9.xw;
	r8.y = r9.w;
	r4.xy = r8.xy * -0.5 + 1;
	r3.xz = r3.xz * -0.5 + 1;
	r4.zw = r3.xz * r3.xz;
	r4.zw = r4.zw * r4.zw;
	r3.xz = r3.xz * -r4.zw + 1;
	r0.w = r3.z * r3.x;
	r1.w = r0.w * 0.193754 + 0.5;
	r0.w = r0.w * 0.387508;
	r1.w = r1.w * r1.w + -r0.w;
	r0.w = hll_rate.x * r1.w + r0.w;
	r3.xzw = r1.xyz * point_lightEv1.xyz;
	r3.xzw = r6.www * r3.xzw;
	r3.xzw = r10.www * r3.xzw;
	r3.xzw = r3.xzw * aniso_diff_rate.xxx;
	r2.xyw = r3.xzw * r0.www + r2.xyw;
	r3.xzw = r1.xyz * point_lightEv2.xyz;
	r1.xyz = r1.xyz * ambient_rate.xyz;
	r3.xyz = r3.yyy * r3.xzw;
	r0.w = r2.z + -g_specCalc2.x;
	r3.xyz = r0.www * r3.xyz;
	r3.xyz = r3.xyz * aniso_diff_rate.xxx;
	r4.zw = r4.xy * r4.xy;
	r4.zw = r4.zw * r4.zw;
	r4.xy = r4.xy * -r4.zw + 1;
	r0.w = r4.y * r4.x;
	r1.w = r0.w * 0.193754 + 0.5;
	r0.w = r0.w * 0.387508;
	r1.w = r1.w * r1.w + -r0.w;
	r0.w = hll_rate.x * r1.w + r0.w;
	r2.xyz = r3.xyz * r0.www + r2.xyw;
	r1.xyz = r1.xyz * ambient_rate_rate.xyz + r2.xyz;
	r0.xyz = r0.xyz * i.color.xxx + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
