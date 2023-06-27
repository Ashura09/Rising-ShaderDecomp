sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
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
float ss_scat_pow;
float ss_scat_rate;
float4 tile;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;
	float3 r12;
	float3 r13;
	r0.x = 1 / i.texcoord8.w;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.zw = r0.xy * float2(1280, 720);
	r1.xy = frac(r0.zw);
	r0.zw = r0.zw + -r1.xy;
	r1.xy = (-r1.xy >= 0) ? 0 : 1;
	r0.xy = (r0.xy >= 0) ? 0 : r1.xy;
	r0.xy = r0.xy + r0.zw;
	r1 = (r0.xxyy >= 0) ? float4(8, 0.125, 8, 0.125) : float4(-8, -0.125, -8, -0.125);
	r0.xy = r0.xy * r1.yw;
	r0.xy = frac(r0.xy);
	r0.xy = r0.xy * r1.xz;
	r0.zw = frac(r0.xy);
	r1.xy = (-r0.zw >= 0) ? 0 : 1;
	r0.zw = r0.xy + -r0.zw;
	r0.xy = (r0.xy >= 0) ? 0 : r1.xy;
	r0.xy = r0.xy + r0.zw;
	r0.x = r0.y * 8 + r0.x;
	r1 = r0.x + float4(-1, -2, -3, -4);
	r0.y = (-abs(r1.x) >= 0) ? -0.25 : -0;
	r0.y = (-abs(r1.y) >= 0) ? -0.0625 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.015625 : r0.y;
	r1 = r0.x + float4(-5, -6, -7, -8);
	r0.y = (-abs(r1.x) >= 0) ? -0.265625 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.078125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.328125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.375 : r0.y;
	r1 = r0.x + float4(-9, -10, -11, -12);
	r0.y = (-abs(r1.x) >= 0) ? -0.125 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4375 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.1875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.390625 : r0.y;
	r1 = r0.x + float4(-13, -14, -15, -16);
	r0.y = (-abs(r1.x) >= 0) ? -0.140625 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.453125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.203125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.09375 : r0.y;
	r1 = r0.x + float4(-17, -18, -19, -20);
	r0.y = (-abs(r1.x) >= 0) ? -0.34375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.03125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.28125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.109375 : r0.y;
	r1 = r0.x + float4(-21, -22, -23, -24);
	r0.y = (-abs(r1.x) >= 0) ? -0.359375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.046875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.296875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.46875 : r0.y;
	r1 = r0.x + float4(-25, -26, -27, -28);
	r0.y = (-abs(r1.x) >= 0) ? -0.21875 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.40625 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.15625 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.484375 : r0.y;
	r1 = r0.x + float4(-29, -30, -31, -32);
	r0.y = (-abs(r1.x) >= 0) ? -0.234375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.421875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.171875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.0234375 : r0.y;
	r1 = r0.x + float4(-33, -34, -35, -36);
	r0.y = (-abs(r1.x) >= 0) ? -0.2734375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0859375 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3359375 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.0078125 : r0.y;
	r1 = r0.x + float4(-37, -38, -39, -40);
	r0.y = (-abs(r1.x) >= 0) ? -0.2578125 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0703125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3203125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.3984375 : r0.y;
	r1 = r0.x + float4(-41, -42, -43, -44);
	r0.y = (-abs(r1.x) >= 0) ? -0.1484375 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4609375 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.2109375 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.3828125 : r0.y;
	r1 = r0.x + float4(-45, -46, -47, -48);
	r0.y = (-abs(r1.x) >= 0) ? -0.1328125 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4453125 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.1953125 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.1171875 : r0.y;
	r1 = r0.x + float4(-49, -50, -51, -52);
	r0.y = (-abs(r1.x) >= 0) ? -0.3671875 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0546875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.3046875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.1015625 : r0.y;
	r1 = r0.x + float4(-53, -54, -55, -56);
	r0.y = (-abs(r1.x) >= 0) ? -0.3515625 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.0390625 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.2890625 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.4921875 : r0.y;
	r1 = r0.x + float4(-57, -58, -59, -60);
	r0.xzw = r0.xxx + float3(-61, -62, -62);
	r0.y = (-abs(r1.x) >= 0) ? -0.2421875 : r0.y;
	r0.y = (-abs(r1.y) >= 0) ? -0.4296875 : r0.y;
	r0.y = (-abs(r1.z) >= 0) ? -0.1796875 : r0.y;
	r0.y = (-abs(r1.w) >= 0) ? -0.4765625 : r0.y;
	r0.x = (-abs(r0.x) >= 0) ? -0.2265625 : r0.y;
	r0.x = (-abs(r0.z) >= 0) ? -0.4140625 : r0.x;
	r0.x = (-abs(r0.w) >= 0) ? -0.1640625 : r0.x;
	r0.yz = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0.yzzw);
	r2 = tex2D(specularmap_sampler, r0.yzzw);
	r0 = r0.x + r1.w;
	clip(r0);
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = 1 / spot_angle.w;
	r3.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.z = dot(r3.xyz, r3.xyz);
	r0.z = 1 / sqrt(r0.z);
	r0.w = 1 / r0.z;
	r3.xyz = r0.zzz * r3.xyz;
	r0.z = dot(r3.xyz, lightpos.xyz);
	r0.z = r0.z + -spot_param.x;
	r0.y = r0.y * r0.w;
	r0.y = -r0.y + 1;
	r0.y = r0.y * 10;
	r3.y = 1;
	r0.w = r3.y + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.w = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.w);
	r0.w = r0.w + r1.w;
	r4.xy = g_All_Offset.xy;
	r3.xz = i.texcoord.xy * tile.xy + r4.xy;
	r4 = tex2D(normalmap_sampler, r3.xzzw);
	r3.xzw = r4.xyz + -0.5;
	r1.w = r3.x * i.texcoord2.w;
	r4.xyz = i.texcoord3.xyz;
	r5.xyz = r4.yzx * i.texcoord2.zxy;
	r4.xyz = i.texcoord2.yzx * r4.zxy + -r5.xyz;
	r5.xyz = -r3.zzz * r4.xyz;
	r5.xyz = r1.www * i.texcoord2.xyz + r5.xyz;
	r3.xzw = r3.www * i.texcoord3.xyz + r5.xyz;
	r1.w = dot(r3.xzw, r3.xzw);
	r1.w = 1 / sqrt(r1.w);
	r5.xyz = r1.www * r3.xzw;
	r1.w = r3.w * -r1.w + 1;
	r2.w = dot(lightpos.xyz, r5.xyz);
	r3.x = r2.w;
	r0.w = r0.w * r3.x;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r6.x = lerp(r0.y, r3.x, spot_param.z);
	r0.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.x = dot(r0.yzw, r0.yzw);
	r3.x = 1 / sqrt(r3.x);
	r7.xyz = r0.yzw * r3.xxx;
	r6.z = dot(r7.xyz, r5.xyz);
	r7.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r3.z = dot(r7.xyz, r7.xyz);
	r3.z = 1 / sqrt(r3.z);
	r8.xyz = r3.zzz * r7.xyz;
	r6.y = dot(r8.xyz, r5.xyz);
	r8.xyz = (-r6.xzy >= 0) ? 0 : 1;
	r9.xyz = r0.yzw * r3.xxx + -i.texcoord1.xyz;
	r10.xyz = normalize(r9.xyz);
	r3.w = dot(r10.xyz, r4.xyz);
	r3.w = abs(r3.w) * -aniso_shine.x + r3.y;
	r4.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r4.w = 1 / sqrt(r4.w);
	r9.xyz = r4.www * -i.texcoord1.xyz;
	r10.xyz = -i.texcoord1.xyz * r4.www + lightpos.xyz;
	r11.xyz = normalize(r10.xyz);
	r4.w = dot(r11.xyz, r5.xyz);
	r0.yzw = r0.yzw * r3.xxx + r9.xyz;
	r3.x = 1 / r3.x;
	r3.x = -r3.x + point_lightpos1.w;
	r3.x = r3.x * point_light1.w;
	r10.xyz = normalize(r0.yzw);
	r0.y = dot(r10.xyz, r5.xyz);
	r0.y = r3.w * r0.y;
	r0.z = (-r0.y >= 0) ? 0 : r8.y;
	r3.w = pow(r0.y, specularParam.z);
	r0.y = r0.z * r3.w;
	r10.xyz = r6.xzy * r8.xyz;
	r11.xyz = r10.yyy * point_light1.xyz;
	r0.yzw = r0.yyy * r11.xyz;
	r0.yzw = r3.xxx * r0.yzw;
	r0.yzw = r2.xyz * r0.yzw;
	r11 = g_specCalc1;
	r0.yzw = r0.yzw * r11.xxx;
	r12.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r13.xyz = normalize(r12.xyz);
	r3.w = dot(r13.xyz, r4.xyz);
	r3.w = abs(r3.w) * -aniso_shine.x + r3.y;
	r3.w = r3.w * r4.w;
	r4.w = (-r3.w >= 0) ? 0 : r8.x;
	r5.w = pow(r3.w, specularParam.z);
	r3.w = r4.w * r5.w;
	r8.xyw = r10.xxx * light_Color.xyz;
	r10.xyz = r10.zzz * point_light2.xyz;
	r8.xyw = r3.www * r8.xyw;
	r8.xyw = r2.xyz * r8.xyw;
	r0.yzw = r8.xyw * r0.xxx + r0.yzw;
	r8.xyw = r7.xyz * r3.zzz + -i.texcoord1.xyz;
	r7.xyz = r7.xyz * r3.zzz + r9.xyz;
	r3.z = 1 / r3.z;
	r3.z = -r3.z + point_lightpos2.w;
	r3.z = r3.z * point_light2.w;
	r12.xyz = normalize(r7.xyz);
	r3.w = dot(r12.xyz, r5.xyz);
	r7.xyz = normalize(r8.xyw);
	r4.w = dot(r7.xyz, r4.xyz);
	r4.w = abs(r4.w) * -aniso_shine.x + r3.y;
	r3.w = r3.w * r4.w;
	r4.w = (-r3.w >= 0) ? 0 : r8.z;
	r5.w = pow(r3.w, specularParam.z);
	r3.w = r4.w * r5.w;
	r7.xyz = r3.www * r10.xyz;
	r7.xyz = r3.zzz * r7.xyz;
	r7.xyz = r2.xyz * r7.xyz;
	r0.yzw = r7.xyz * r11.yyy + r0.yzw;
	r7.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r3.w = dot(r7.xyz, r7.xyz);
	r3.w = 1 / sqrt(r3.w);
	r8.xyz = r7.xyz * r3.www + -i.texcoord1.xyz;
	r10.xyz = normalize(r8.xyz);
	r4.w = dot(r10.xyz, r4.xyz);
	r4.w = abs(r4.w) * -aniso_shine.x + r3.y;
	r8.xyz = r7.xyz * r3.www + r9.xyz;
	r7.xyz = r3.www * r7.xyz;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightposEv0.w;
	r3.w = r3.w * point_lightEv0.w;
	r3.w = r3.w * i.color.x;
	r7.y = dot(r7.xyz, r5.xyz);
	r10.xyz = normalize(r8.xyz);
	r5.w = dot(r10.xyz, r5.xyz);
	r4.w = r4.w * r5.w;
	r5.w = pow(r4.w, specularParam.z);
	r8.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r8.w = dot(r8.xyz, r8.xyz);
	r8.w = 1 / sqrt(r8.w);
	r10.xyz = r8.www * r8.xyz;
	r7.x = dot(r10.xyz, r5.xyz);
	r10.xy = (-r7.yx >= 0) ? 0 : 1;
	r4.w = (-r4.w >= 0) ? 0 : r10.x;
	r4.w = r5.w * r4.w;
	r10.xz = r7.yx * r10.xy;
	r12.xyz = r10.xxx * point_lightEv0.xyz;
	r10.xzw = r10.zzz * point_lightEv1.xyz;
	r12.xyz = r4.www * r12.xyz;
	r12.xyz = r3.www * r12.xyz;
	r12.xyz = r2.xyz * r12.xyz;
	r0.yzw = r12.xyz * r11.zzz + r0.yzw;
	r11.xyz = r8.xyz * r8.www + -i.texcoord1.xyz;
	r8.xyz = r8.xyz * r8.www + r9.xyz;
	r4.w = 1 / r8.w;
	r4.w = -r4.w + point_lightposEv1.w;
	r4.w = r4.w * point_lightEv1.w;
	r4.w = r4.w * i.color.x;
	r12.xyz = normalize(r8.xyz);
	r5.w = dot(r12.xyz, r5.xyz);
	r8.xyz = normalize(r11.xyz);
	r8.x = dot(r8.xyz, r4.xyz);
	r8.x = abs(r8.x) * -aniso_shine.x + r3.y;
	r5.w = r5.w * r8.x;
	r8.x = pow(r5.w, specularParam.z);
	r5.w = (-r5.w >= 0) ? 0 : r10.y;
	r5.w = r8.x * r5.w;
	r8.xyz = r5.www * r10.xzw;
	r8.xyz = r4.www * r8.xyz;
	r8.xyz = r2.xyz * r8.xyz;
	r0.yzw = r8.xyz * r11.www + r0.yzw;
	r5.w = g_specCalc2.x;
	r8.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r8.w = dot(r8.xyz, r8.xyz);
	r8.w = 1 / sqrt(r8.w);
	r9.xyz = r8.xyz * r8.www + r9.xyz;
	r10.xyz = normalize(r9.xyz);
	r9.x = dot(r10.xyz, r5.xyz);
	r9.yzw = r8.xyz * r8.www + -i.texcoord1.xyz;
	r8.xyz = r8.www * r8.xyz;
	r8.w = 1 / r8.w;
	r8.w = -r8.w + point_lightposEv2.w;
	r8.w = r8.w * point_lightEv2.w;
	r8.w = r8.w * i.color.x;
	r8.x = dot(r8.xyz, r5.xyz);
	r10.xyz = normalize(r9.yzw);
	r4.x = dot(r10.xyz, r4.xyz);
	r4.x = abs(r4.x) * -aniso_shine.x + r3.y;
	r4.x = r4.x * r9.x;
	r4.y = (-r8.x >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r8.z = pow(r4.x, specularParam.z);
	r4.x = r4.z * r8.z;
	r4.y = r8.x * r4.y;
	r9.xyz = r4.yyy * point_lightEv2.xyz;
	r4.xyz = r4.xxx * r9.xyz;
	r4.xyz = r8.www * r4.xyz;
	r2.xyz = r2.xyz * r4.xyz;
	r0.yzw = r2.xyz * r5.www + r0.yzw;
	r2.x = abs(specularParam.x);
	r0.yzw = r0.yzw * r2.xxx;
	r2.xy = -r1.yy + r1.xz;
	r4.x = max(abs(r2.x), abs(r2.y));
	r2.x = r4.x + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r1.xz = (r2.xx >= 0) ? r1.yy : r1.xz;
	r2.xyz = r1.xyz + specularParam.www;
	r0.yzw = r0.yzw * r2.xyz;
	r6.w = dot(i.texcoord1.xyz, -r5.xyz);
	r2.xy = r6.zw;
	r2.xy = r2.xy * -0.5 + 1;
	r4.xy = r2.xy * r2.xy;
	r4.xy = r4.xy * r4.xy;
	r2.xy = r2.xy * -r4.xy + 1;
	r2.x = r2.y * r2.x;
	r2.y = r2.x * 0.193754 + 0.5;
	r2.x = r2.x * 0.387508;
	r2.y = r2.y * r2.y + -r2.x;
	r2.x = hll_rate.x * r2.y + r2.x;
	r2.y = -2;
	r9 = -r2.y + -g_specCalc1;
	r4.xyz = r9.xxx * point_light1.xyz;
	r4.xyz = r4.xyz * aniso_diff_rate.xxx;
	r4.xyz = r2.xxx * r4.xyz;
	r4.xyz = r3.xxx * r4.xyz;
	r4.xyz = r9.xxx * r4.xyz;
	r10.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r2.x = dot(r10.xyz, r10.xyz);
	r2.x = 1 / sqrt(r2.x);
	r10.xyz = r2.xxx * r10.xyz;
	r2.x = 1 / r2.x;
	r2.x = -r2.x + muzzle_lightpos.w;
	r2.x = r2.x * muzzle_light.w;
	r7.z = dot(r10.xyz, r5.xyz);
	r7.w = r6.w;
	r5.xy = r7.zw;
	r5.xy = r5.xy * -0.5 + 1;
	r5.zw = r5.xy * r5.xy;
	r5.zw = r5.zw * r5.zw;
	r5.xy = r5.xy * -r5.zw + 1;
	r2.z = r5.y * r5.x;
	r3.x = r2.z * 0.193754 + 0.5;
	r2.z = r2.z * 0.387508;
	r3.x = r3.x * r3.x + -r2.z;
	r2.z = hll_rate.x * r3.x + r2.z;
	r3.x = aniso_diff_rate.x;
	r5.xyz = r3.xxx * muzzle_light.xyz;
	r5.xyz = r2.zzz * r5.xyz;
	r4.xyz = r5.xyz * r2.xxx + r4.xyz;
	r2.xz = r6.yw;
	r5.xy = r0.xx * r6.xw;
	r5.xy = r5.xy * -0.5 + 1;
	r2.xz = r2.xz * -0.5 + 1;
	r5.zw = r2.xz * r2.xz;
	r5.zw = r5.zw * r5.zw;
	r2.xz = r2.xz * -r5.zw + 1;
	r0.x = r2.z * r2.x;
	r2.x = r0.x * 0.193754 + 0.5;
	r0.x = r0.x * 0.387508;
	r2.x = r2.x * r2.x + -r0.x;
	r0.x = hll_rate.x * r2.x + r0.x;
	r6.xyz = r9.yyy * point_light2.xyz;
	r6.xyz = r6.xyz * aniso_diff_rate.xxx;
	r6.xyz = r0.xxx * r6.xyz;
	r6.xyz = r3.zzz * r6.xyz;
	r4.xyz = r6.xyz * r9.yyy + r4.xyz;
	r2.xz = r5.xy * r5.xy;
	r2.xz = r2.xz * r2.xz;
	r2.xz = r5.xy * -r2.xz + 1;
	r0.x = r2.z * r2.x;
	r2.x = r0.x * 0.193754 + 0.5;
	r0.x = r0.x * 0.387508;
	r2.x = r2.x * r2.x + -r0.x;
	r0.x = hll_rate.x * r2.x + r0.x;
	r5.xyz = r3.xxx * light_Color.xyz;
	r4.xyz = r5.xyz * r0.xxx + r4.xyz;
	r2.xz = r7.yw;
	r2.xz = r2.xz * -0.5 + 1;
	r3.xz = r2.xz * r2.xz;
	r3.xz = r3.xz * r3.xz;
	r2.xz = r2.xz * -r3.xz + 1;
	r0.x = r2.z * r2.x;
	r2.x = r0.x * 0.193754 + 0.5;
	r0.x = r0.x * 0.387508;
	r2.x = r2.x * r2.x + -r0.x;
	r0.x = hll_rate.x * r2.x + r0.x;
	r5.xyz = r1.xyz * point_lightEv0.xyz;
	r3.xzw = r3.www * r5.xyz;
	r3.xzw = r9.zzz * r3.xzw;
	r3.xzw = r3.xzw * aniso_diff_rate.xxx;
	r3.xzw = r0.xxx * r3.xzw;
	r3.xzw = r1.xyz * r4.xyz + r3.xzw;
	r2.xz = r7.xw;
	r8.y = r7.w;
	r8.xy = r8.xy;
	r4.xy = r8.xy * -0.5 + 1;
	r2.xz = r2.xz * -0.5 + 1;
	r5.xy = r2.xz * r2.xz;
	r5.xy = r5.xy * r5.xy;
	r2.xz = r2.xz * -r5.xy + 1;
	r0.x = r2.z * r2.x;
	r2.x = r0.x * 0.193754 + 0.5;
	r0.x = r0.x * 0.387508;
	r2.x = r2.x * r2.x + -r0.x;
	r0.x = hll_rate.x * r2.x + r0.x;
	r5.xyz = r1.xyz * point_lightEv1.xyz;
	r5.xyz = r4.www * r5.xyz;
	r5.xyz = r9.www * r5.xyz;
	r5.xyz = r5.xyz * aniso_diff_rate.xxx;
	r3.xzw = r5.xyz * r0.xxx + r3.xzw;
	r2.xz = r4.xy * r4.xy;
	r2.xz = r2.xz * r2.xz;
	r2.xz = r4.xy * -r2.xz + 1;
	r0.x = r2.z * r2.x;
	r2.x = r0.x * 0.193754 + 0.5;
	r0.x = r0.x * 0.387508;
	r2.x = r2.x * r2.x + -r0.x;
	r0.x = hll_rate.x * r2.x + r0.x;
	r4.xyz = r1.xyz * point_lightEv2.xyz;
	r4.xyz = r8.www * r4.xyz;
	r2.x = -r2.y + -g_specCalc2.x;
	r2.xyz = r2.xxx * r4.xyz;
	r2.xyz = r2.xyz * aniso_diff_rate.xxx;
	r2.xyz = r2.xyz * r0.xxx + r3.xzw;
	r0.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.x + r2.w;
	r0.x = r0.x + 1;
	r3.xzw = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.www * r1.xyz;
	r1.w = r1.w + -ss_scat_rate.x;
	r1.xyz = r1.xyz * ss_scat_pow.xxx;
	r3.xzw = r3.xzw * ambient_rate_rate.xyz;
	r2.xyz = r3.xzw * r0.xxx + r2.xyz;
	r0.xyz = r0.yzw * i.color.xxx + r2.xyz;
	r0.w = r3.y + -ss_scat_rate.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r1.w;
	r1.w = r1.w;
	r2.x = frac(-r1.w);
	r1.w = r1.w + r2.x;
	r0.w = r0.w * r1.w;
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r0.xyz * i.color.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
