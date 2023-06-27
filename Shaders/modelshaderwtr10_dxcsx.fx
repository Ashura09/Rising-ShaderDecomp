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
float4 g_CameraParam;
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
	float3 texcoord4 : TEXCOORD4;
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
	r0.xyz = i.texcoord3.xyz;
	r1.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r1.xyz;
	r1.xy = i.texcoord.zw * blendTile.xy + blendTile.zw;
	r1 = tex2D(Color_2_sampler, r1);
	r1.zw = i.texcoord.zw * tile.xy + tile.zw;
	r2 = tex2D(normalmap_sampler, r1.zwzw);
	r2.xyz = r2.xyz + -0.5;
	r1.xy = r1.xy + r2.xy;
	r1.xy = r1.xy + -0.5;
	r0.xyz = r0.xyz * -r1.yyy;
	r0.w = r1.x * i.texcoord2.w;
	r0.xyz = r0.www * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r2.zzz * i.texcoord3.xyz + r0.xyz;
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
	r2 = tex2D(g_Z_sampler, r1.zwzw);
	r0.w = r2.x * g_CameraParam.y + g_CameraParam.x;
	r0.w = r0.w + -i.texcoord8.w;
	r1 = tex2D(RefractMap_sampler, r1);
	r2.xyz = finalcolor_enhance.xyz;
	r2.w = -1 + i.color.w;
	r3.zw = float2(0.5, -0.5);
	r2 = SoftPt_Rate.y * r2 + r3.wwwz;
	r4.xyz = lerp(r1.xyz, r2.xyz, Refract_Param.xxx);
	r4.w = r2.w * ambient_rate.w;
	r1 = r4 + -g_WtrFogColor;
	r2.x = -r0.w + g_WtrFogParam.w;
	r2.yz = -g_WtrFogParam.zx + g_WtrFogParam.wy;
	r2.y = 1 / r2.y;
	r2.z = 1 / r2.z;
	r2.x = r2.y * r2.x;
	r1 = r1 * r2.x;
	r2.x = g_WtrFogParam.y + i.texcoord1.z;
	r2.x = r2.z * r2.x;
	r1 = r2.x * r1 + g_WtrFogColor;
	r2.x = abs(SoftPt_Rate.x);
	r2.x = 1 / r2.x;
	r0.w = r0.w * r2.x;
	r2.x = -r0.w + 1;
	r2.y = (SoftPt_Rate.x >= 0) ? r3.w : r3.z;
	r2.z = (-SoftPt_Rate.x >= 0) ? -r3.w : -r3.z;
	r2.y = r2.z + r2.y;
	r2.y = (r2.y >= 0) ? -r2.y : -0;
	r0.w = (r2.y >= 0) ? r0.w : r2.x;
	r2 = r1.w * r0.w + -0.01;
	r0.w = r0.w * r1.w;
	o.w = r0.w * prefogcolor_enhance.w;
	clip(r2);
	r2.x = dot(r0.xyz, transpose(viewInverseMatrix)[0].xyz);
	r2.y = dot(r0.xyz, transpose(viewInverseMatrix)[1].xyz);
	r2.z = dot(r0.xyz, transpose(viewInverseMatrix)[2].xyz);
	r0.x = dot(lightpos.xyz, r0.xyz);
	r0.y = dot(i.texcoord4.xyz, r2.xyz);
	r0.y = r0.y + r0.y;
	r2.xyz = r2.xyz * -r0.yyy + i.texcoord4.xyz;
	r2.w = -r2.z;
	r2 = tex2D(cubemap_sampler, r2.xyww);
	r0.y = r2.w * CubeParam.y + CubeParam.x;
	r0.yzw = r0.yyy * r2.xyz;
	r2.xyz = r1.xyz * r0.yzw;
	r1.xyz = r1.xyz * ambient_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = r0.x + -r1.w;
	r0.x = r0.x * 0.5 + 1;
	r1.xyz = r0.xxx * r1.xyz;
	r3.xyw = r2.xyz * CubeParam.zzz + r1.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r2.xyz + r3.xyw;
	r0.x = r3.z + -CubeParam.z;
	r0.xyz = r0.yzw * r0.xxx + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
