sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap2_sampler;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_CubeBlendParam;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_specCalc1;
float4 g_specCalc2;
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
float4 tile;
float4x4 viewInverseMatrix;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord5 : TEXCOORD5;
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
	float4 r12;
	float4 r13;
	float4 r14;
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
	r2.xyz = normalize(r1.xzw);
	r1.x = dot(lightpos.xyz, r2.xyz);
	r1.z = r1.x;
	r0.w = r0.w * r1.z;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r3.x = lerp(r0.y, r1.z, spot_param.z);
	r0.yzw = r3.xxx * light_Color.xyz;
	r1.z = r3.x * 0.5 + 0.5;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r1.w = dot(r3.xyz, r3.xyz);
	r1.w = 1 / sqrt(r1.w);
	r3.w = 1 / r1.w;
	r3.xyz = r1.www * r3.xyz;
	r1.w = dot(r3.xyz, r2.xyz);
	r3.xyz = r1.www * muzzle_light.xyz;
	r1.w = -r3.w + muzzle_lightpos.w;
	r1.w = r1.w * muzzle_light.w;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.w = dot(r4.xyz, r4.xyz);
	r3.w = 1 / sqrt(r3.w);
	r4.w = 1 / r3.w;
	r4.w = -r4.w + point_lightpos1.w;
	r4.w = r4.w * point_light1.w;
	r5.xyz = r3.www * r4.xyz;
	r5.x = dot(r5.xyz, r2.xyz);
	r5.xyz = r5.xxx * point_light1.xyz;
	r5.xyz = r4.www * r5.xyz;
	r6 = g_specCalc1;
	r6 = -r6 + 2;
	r5.xyz = r5.xyz * r6.xxx;
	r3.xyz = r3.xyz * r1.www + r5.xyz;
	r5.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.w = dot(r5.xyz, r5.xyz);
	r1.w = 1 / sqrt(r1.w);
	r5.w = 1 / r1.w;
	r5.w = -r5.w + point_lightpos2.w;
	r5.w = r5.w * point_light2.w;
	r7.xyz = r1.www * r5.xyz;
	r6.x = dot(r7.xyz, r2.xyz);
	r7.xyz = r6.xxx * point_light2.xyz;
	r7.xyz = r5.www * r7.xyz;
	r3.xyz = r7.xyz * r6.yyy + r3.xyz;
	r0.yzw = r0.yzw * r0.xxx + r3.xyz;
	r3.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r6.x = dot(r3.xyz, r3.xyz);
	r6.x = 1 / sqrt(r6.x);
	r6.y = 1 / r6.x;
	r6.y = -r6.y + point_lightposEv0.w;
	r6.y = r6.y * point_lightEv0.w;
	r7.xyz = r3.xyz * r6.xxx;
	r7.x = dot(r7.xyz, r2.xyz);
	r7.yz = g_All_Offset.xy + i.texcoord.xy;
	r8 = tex2D(Color_1_sampler, r7.yzzw);
	r7.yz = -r8.yy + r8.xz;
	r9.x = max(abs(r7.y), abs(r7.z));
	r7.y = r9.x + -0.015625;
	r7.z = (-r7.y >= 0) ? 0 : 1;
	r7.y = (r7.y >= 0) ? -0 : -1;
	r7.y = r7.y + r7.z;
	r7.y = (r7.y >= 0) ? -r7.y : -0;
	r8.xz = (r7.yy >= 0) ? r8.yy : r8.xz;
	r7.yzw = r8.xyz * point_lightEv0.xyz;
	r7.xyz = r7.xxx * r7.yzw;
	r7.xyz = r6.yyy * r7.xyz;
	r7.xyz = r6.zzz * r7.xyz;
	r0.yzw = r8.xyz * r0.yzw + r7.xyz;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r6.z = dot(r7.xyz, r7.xyz);
	r6.z = 1 / sqrt(r6.z);
	r7.w = 1 / r6.z;
	r7.w = -r7.w + point_lightposEv1.w;
	r7.w = r7.w * point_lightEv1.w;
	r9.xyz = r6.zzz * r7.xyz;
	r9.x = dot(r9.xyz, r2.xyz);
	r9.yzw = r8.xyz * point_lightEv1.xyz;
	r9.xyz = r9.xxx * r9.yzw;
	r9.xyz = r7.www * r9.xyz;
	r0.yzw = r9.xyz * r6.www + r0.yzw;
	r9.x = 2;
	r6.w = r9.x + -g_specCalc2.x;
	r9.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r9.w = dot(r9.xyz, r9.xyz);
	r9.w = 1 / sqrt(r9.w);
	r10.x = 1 / r9.w;
	r10.x = -r10.x + point_lightposEv2.w;
	r10.x = r10.x * point_lightEv2.w;
	r10.yzw = r9.www * r9.xyz;
	r10.y = dot(r10.yzw, r2.xyz);
	r11.xyz = r8.xyz * point_lightEv2.xyz;
	r10.yzw = r10.yyy * r11.xyz;
	r10.yzw = r10.xxx * r10.yzw;
	r0.yzw = r10.yzw * r6.www + r0.yzw;
	r6.w = -r0.x + 1;
	r10.yzw = r8.xyz * i.texcoord5.xyz;
	r10.yzw = r6.www * r10.yzw;
	r11.xyz = r8.xyz * ambient_rate.xyz;
	r10.yzw = r11.xyz * ambient_rate_rate.xyz + r10.yzw;
	r6.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = r1.x + -r6.w;
	r1.x = r1.x + 1;
	r0.yzw = r10.yzw * r1.xxx + r0.yzw;
	r11.x = dot(r2.xyz, transpose(viewInverseMatrix)[0].xyz);
	r11.y = dot(r2.xyz, transpose(viewInverseMatrix)[1].xyz);
	r11.z = dot(r2.xyz, transpose(viewInverseMatrix)[2].xyz);
	r1.x = dot(i.texcoord4.xyz, r11.xyz);
	r1.x = r1.x + r1.x;
	r11.xyz = r11.xyz * -r1.xxx + i.texcoord4.xyz;
	r11.w = -r11.z;
	r12 = tex2D(cubemap_sampler, r11.xyww);
	r11 = tex2D(cubemap2_sampler, r11.xyww);
	r13 = lerp(r11, r12, g_CubeBlendParam.x);
	r11 = r13 * ambient_rate_rate.w;
	r11.xyz = r2.www * r11.xyz;
	r11 = r1.z * r11;
	r1.x = r11.w * CubeParam.y + CubeParam.x;
	r10.yzw = r1.xxx * r11.xyz;
	r11.xyz = r8.xyz * r10.yzw;
	r8.xyz = r8.xyz + specularParam.www;
	r12.xyz = r11.xyz * CubeParam.zzz + r0.yzw;
	r11.xyz = r11.xyz * CubeParam.zzz;
	r0.yzw = r0.yzw * -r11.xyz + r12.xyz;
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r11.xyz = r1.xxx * -i.texcoord1.xyz;
	r12.xyz = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r13.xyz = normalize(r12.xyz);
	r1.x = dot(r13.xyz, r2.xyz);
	r4.xyz = r4.xyz * r3.www + r11.xyz;
	r12.xyz = normalize(r4.xyz);
	r1.z = dot(r12.xyz, r2.xyz);
	r2.w = -r1.z + 1;
	r12.z = r2.w * -specularParam.z + r1.z;
	r12.yw = specularParam.yy;
	r13 = tex2D(Spec_Pow_sampler, r12.zwzw);
	r4.xyz = r13.xyz * point_light1.xyz;
	r4.xyz = r4.www * r4.xyz;
	r4.xyz = r8.www * r4.xyz;
	r13 = g_specCalc1;
	r4.xyz = r4.xyz * r13.xxx;
	r1.z = -r1.x + 1;
	r12.x = r1.z * -specularParam.z + r1.x;
	r12 = tex2D(Spec_Pow_sampler, r12);
	r12.xyz = r12.xyz * light_Color.xyz;
	r12.xyz = r8.www * r12.xyz;
	r4.xyz = r12.xyz * r0.xxx + r4.xyz;
	r1.xzw = r5.xyz * r1.www + r11.xyz;
	r5.xyz = normalize(r1.xzw);
	r0.x = dot(r5.xyz, r2.xyz);
	r1.x = -r0.x + 1;
	r12.x = r1.x * -specularParam.z + r0.x;
	r12.yw = specularParam.yy;
	r14 = tex2D(Spec_Pow_sampler, r12);
	r1.xzw = r14.xyz * point_light2.xyz;
	r1.xzw = r5.www * r1.xzw;
	r1.xzw = r8.www * r1.xzw;
	r1.xzw = r1.xzw * r13.yyy + r4.xyz;
	r3.xyz = r3.xyz * r6.xxx + r11.xyz;
	r4.xyz = normalize(r3.xyz);
	r0.x = dot(r4.xyz, r2.xyz);
	r2.w = -r0.x + 1;
	r12.z = r2.w * -specularParam.z + r0.x;
	r3 = tex2D(Spec_Pow_sampler, r12.zwzw);
	r3.xyz = r3.xyz * point_lightEv0.xyz;
	r3.xyz = r6.yyy * r3.xyz;
	r3.xyz = r8.www * r3.xyz;
	r1.xzw = r3.xyz * r13.zzz + r1.xzw;
	r3.xyz = r7.xyz * r6.zzz + r11.xyz;
	r4.xyz = r9.xyz * r9.www + r11.xyz;
	r5.xyz = normalize(r4.xyz);
	r0.x = dot(r5.xyz, r2.xyz);
	r4.xyz = normalize(r3.xyz);
	r2.x = dot(r4.xyz, r2.xyz);
	r2.y = -r2.x + 1;
	r2.x = r2.y * -specularParam.z + r2.x;
	r2.yw = specularParam.yy;
	r3 = tex2D(Spec_Pow_sampler, r2);
	r3.xyz = r3.xyz * point_lightEv1.xyz;
	r3.xyz = r7.www * r3.xyz;
	r3.xyz = r8.www * r3.xyz;
	r1.xzw = r3.xyz * r13.www + r1.xzw;
	r2.x = -r0.x + 1;
	r2.z = r2.x * -specularParam.z + r0.x;
	r2 = tex2D(Spec_Pow_sampler, r2.zwzw);
	r2.xyz = r2.xyz * point_lightEv2.xyz;
	r2.xyz = r10.xxx * r2.xyz;
	r2.xyz = r8.www * r2.xyz;
	r0.x = g_specCalc2.x;
	r1.xzw = r2.xyz * r0.xxx + r1.xzw;
	r0.x = abs(specularParam.x);
	r1.xzw = r0.xxx * r1.xzw;
	r0.xyz = r1.xzw * r8.xyz + r0.yzw;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r10.yzw * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
