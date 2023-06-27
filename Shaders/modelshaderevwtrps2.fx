sampler Caustics_sampler;
sampler Caustics_sampler2;
sampler Color_1_sampler;
sampler Color_2_sampler;
float4 CubeParam;
sampler RefractMap_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 blendTile;
samplerCUBE cubemap_sampler;
float4 finalcolor_enhance;
float3 fog;
float4 g_All_Offset;
float4 g_CameraParam;
float4 g_CausticsParam;
float4 g_HamabeParam;
float4 g_OtherParam;
float4 g_TargetUvParam;
float4 g_WtrFogColor;
float4 g_WtrFogParam;
sampler g_Z_sampler;
float4 lightpos;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;
float4x4 viewInverseMatrix;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
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
	r0.xy = i.texcoord.zw * blendTile.xy + blendTile.zw;
	r0 = tex2D(Color_2_sampler, r0);
	r0.zw = i.texcoord.zw * tile.xy + tile.zw;
	r1 = tex2D(normalmap_sampler, r0.zwzw);
	r1.xyz = r1.xyz + -0.5;
	r0.xy = r0.xy + r1.xy;
	r0.xy = r0.xy + -0.5;
	r1.xy = g_CausticsParam.xy;
	r0.zw = i.texcoord.zw * r1.xy + g_All_Offset.xy;
	r2 = tex2D(Caustics_sampler, r0.zwzw);
	r0.z = r2.w;
	r0.xy = r0.zz * r0.xy;
	r2.xyz = i.texcoord3.xyz;
	r1.xyw = r2.yzx * i.texcoord2.zxy;
	r1.xyw = i.texcoord2.yzx * r2.zxy + -r1.xyw;
	r0.yzw = -r0.yyy * r1.xyw;
	r0.x = r0.x * i.texcoord2.w;
	r0.xyz = r0.xxx * i.texcoord2.xyz + r0.yzw;
	r0.xyz = r1.zzz * i.texcoord3.xyz + r0.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.xyz * r0.www + -i.texcoord3.xyz;
	r1.xy = CubeParam.ww * r0.xy + i.texcoord3.xy;
	r0.xyz = r0.xyz * CubeParam.www;
	r0.xyz = Refract_Param.zzz * r0.xyz + i.texcoord3.xyz;
	r0.w = 1 / i.texcoord8.w;
	r1.zw = r0.ww * i.texcoord8.xy;
	r1.zw = r1.zw * float2(0.5, -0.5) + 0.5;
	r1.zw = r1.zw + g_TargetUvParam.xy;
	r1.xy = r1.xy * -Refract_Param.yy + r1.zw;
	r3 = tex2D(g_Z_sampler, r1);
	r0.w = r3.x * g_CameraParam.y + g_CameraParam.x;
	r2.x = -r0.w + abs(i.texcoord1.z);
	r1.xy = (-r2.xx >= 0) ? r1.xy : r1.zw;
	r3 = tex2D(RefractMap_sampler, r1);
	r1.xy = g_HamabeParam.zz * i.texcoord3.xy;
	r4 = g_HamabeParam.xxyy * i.texcoord;
	r1.xy = r1.xy * 0.1 + r4.zw;
	r4 = tex2D(Color_1_sampler, r4);
	r5 = tex2D(Caustics_sampler2, r1);
	r5.xyz = r5.www * r5.xyz;
	r2.yzw = r2.www * r5.xyz;
	r5.xyz = finalcolor_enhance.xyz;
	r5.w = -1 + i.color.w;
	r6.zw = float2(0.5, -0.5);
	r5 = SoftPt_Rate.y * r5 + r6.wwwz;
	r2.yzw = r2.yzw * g_HamabeParam.www + r5.xyz;
	r5.w = r5.w * ambient_rate.w;
	r5.xyz = lerp(r3.xyz, r2.yzw, Refract_Param.xxx);
	r3 = tex2D(g_Z_sampler, r1.zwzw);
	r1.xy = i.texcoord3.xy * g_OtherParam.yy + r1.zw;
	r1 = tex2D(RefractMap_sampler, r1);
	r1.w = r3.x * g_CameraParam.y + g_CameraParam.x;
	r0.w = (-r2.x >= 0) ? r0.w : r1.w;
	r1.w = r1.w + -i.texcoord8.w;
	r0.w = r0.w + -i.texcoord8.w;
	r0.w = -r0.w + g_WtrFogParam.w;
	r2.xy = -g_WtrFogParam.zx + g_WtrFogParam.wy;
	r2.x = 1 / r2.x;
	r2.y = 1 / r2.y;
	r0.w = r0.w * r2.x;
	r3 = lerp(r5, g_WtrFogColor, r0.w);
	r0.w = 1 / SoftPt_Rate.w;
	r0.w = r0.w * r1.w;
	r0.w = -r0.w + 1;
	r3 = r4 * r0.w + r3;
	r0.w = g_WtrFogParam.y + i.texcoord1.z;
	r0.w = r2.y * r0.w;
	r2 = lerp(r3, g_WtrFogColor, r0.w);
	r0.w = abs(SoftPt_Rate.x);
	r0.w = 1 / r0.w;
	r0.w = r0.w * r1.w;
	r1.w = -r0.w + 1;
	r3.x = (SoftPt_Rate.x >= 0) ? r6.w : r6.z;
	r3.y = (-SoftPt_Rate.x >= 0) ? -r6.w : -r6.z;
	r3.x = r3.y + r3.x;
	r3.x = (r3.x >= 0) ? -r3.x : -0;
	r0.w = (r3.x >= 0) ? r0.w : r1.w;
	r3 = r2.w * r0.w + -0.01;
	r0.w = r0.w * r2.w;
	o.w = r0.w * prefogcolor_enhance.w;
	clip(r3);
	r3.x = dot(r0.xyz, transpose(viewInverseMatrix)[0].xyz);
	r3.y = dot(r0.xyz, transpose(viewInverseMatrix)[1].xyz);
	r3.z = dot(r0.xyz, transpose(viewInverseMatrix)[2].xyz);
	r0.w = dot(i.texcoord4.xyz, r3.xyz);
	r0.w = r0.w + r0.w;
	r3.xyz = r3.xyz * -r0.www + i.texcoord4.xyz;
	r3.w = -r3.z;
	r3 = tex2D(cubemap_sampler, r3.xyww);
	r4.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r4.xyz, r0.xyz);
	r0.x = dot(lightpos.xyz, r0.xyz);
	r0.y = -r0.w + 1;
	r1.w = pow(r0.y, SoftPt_Rate.z);
	r0.y = max(0.001, r1.w);
	r3.xyz = r0.yyy * r3.xyz;
	r0.z = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r0.zzz * r3.xyz;
	r0.z = g_OtherParam.w + i.texcoord4.w;
	r0.w = 1 / g_OtherParam.z;
	r0.z = r0.w * r0.z;
	r4 = tex2D(Color_1_sampler, i.texcoord);
	r0.z = r0.z * r4.w;
	r5.xyz = lerp(r4.xyz, r2.xyz, r0.zzz);
	r2.xyz = r3.xyz * r5.xyz;
	r4.xyz = r5.xyz * ambient_rate.xyz;
	r0.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.z + r0.x;
	r0.x = r0.x * 0.5 + 1;
	r0.xzw = r0.xxx * r4.xyz;
	r0.xyz = r0.yyy * r0.xzw;
	r4.xyz = r2.xyz * CubeParam.zzz + r0.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r2.xyz + r4.xyz;
	r0.w = r6.z + -CubeParam.z;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r2.xyz = lerp(r1.xyz, r0.xyz, g_OtherParam.xxx);
	r0.xyz = fog.xyz;
	r0.xyz = r2.xyz * prefogcolor_enhance.xyz + -r0.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
