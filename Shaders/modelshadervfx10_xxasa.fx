sampler Color_1_sampler;
float4 CubeParam;
sampler RefractMap_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
samplerCUBE cubemap_sampler;
float4 finalcolor_enhance;
float3 fog;
float4 g_CameraParam;
float4 g_TargetUvParam;
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
	r0.zw = float2(0.5, -0.5);
	r0.x = (SoftPt_Rate.x >= 0) ? r0.w : r0.z;
	r0.y = (-SoftPt_Rate.x >= 0) ? -r0.w : -r0.z;
	r0.x = r0.y + r0.x;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r0.y = 1 / i.texcoord8.w;
	r0.yw = r0.yy * i.texcoord8.xy;
	r0.yw = r0.yw * 0.5 + 0.5;
	r0.yw = r0.yw + g_TargetUvParam.xy;
	r1 = tex2D(g_Z_sampler, r0.ywzw);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.x = r1.x + -i.texcoord8.w;
	r1.yz = abs(SoftPt_Rate.xz);
	r1.y = 1 / r1.y;
	r1.x = r1.y * r1.x;
	r1.y = -r1.x + 1;
	r0.x = (r0.x >= 0) ? r1.x : r1.y;
	r2 = tex2D(Color_1_sampler, i.texcoord);
	r1.x = r2.w * ambient_rate.w;
	r3 = r1.x * r0.x + -0.01;
	r0.x = r0.x * r1.x;
	clip(r3);
	r1.x = -SoftPt_Rate.z;
	r3.xyz = normalize(-i.texcoord1.xyz);
	r1.y = dot(r3.xyz, i.texcoord3.xyz);
	r1.xy = -r1.xy + 1;
	r1.w = (-r1.z >= 0) ? 0 : 1;
	r1.z = 1 / r1.z;
	r3 = r1.y * -r1.w + r1.x;
	clip(r3);
	r1.x = SoftPt_Rate.z;
	r4 = r1.y * r1.w + -r1.x;
	r1.x = (-r1.x >= 0) ? r3.w : r4.w;
	clip(r4);
	r1.x = r1.z * r1.x;
	r1.w = r0.x * r1.x;
	r3.xy = -r2.yy + r2.xz;
	r0.x = max(abs(r3.x), abs(r3.y));
	r0.x = r0.x + -0.015625;
	r2.w = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r2.w;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r2.xz = (r0.xx >= 0) ? r2.yy : r2.xz;
	r3.xyz = i.texcoord3.xyz;
	r4.xyz = r3.yzx * i.texcoord2.zxy;
	r3.xyz = i.texcoord2.yzx * r3.zxy + -r4.xyz;
	r4.xy = i.texcoord.zw * tile.xy + tile.zw;
	r4 = tex2D(normalmap_sampler, r4);
	r4.xyz = r4.xyz + -0.5;
	r3.xyz = r3.xyz * -r4.yyy;
	r0.x = r4.x * i.texcoord2.w;
	r3.xyz = r0.xxx * i.texcoord2.xyz + r3.xyz;
	r3.xyz = r4.zzz * i.texcoord3.xyz + r3.xyz;
	r0.x = dot(r3.xyz, r3.xyz);
	r0.x = 1 / sqrt(r0.x);
	r3.xyz = r3.xyz * r0.xxx + -i.texcoord3.xyz;
	r4.xy = CubeParam.ww * r3.xy + i.texcoord3.xy;
	r3.xyz = r3.xyz * CubeParam.www;
	r3.xyz = Refract_Param.zzz * r3.xyz + i.texcoord3.xyz;
	r0.xy = r4.xy * -Refract_Param.yy + r0.yw;
	r4 = tex2D(RefractMap_sampler, r0);
	r0.xyw = lerp(r4.xyz, r2.xyz, Refract_Param.xxx);
	r2.x = dot(r3.xyz, transpose(viewInverseMatrix)[0].xyz);
	r2.y = dot(r3.xyz, transpose(viewInverseMatrix)[1].xyz);
	r2.z = dot(r3.xyz, transpose(viewInverseMatrix)[2].xyz);
	r2.w = dot(lightpos.xyz, r3.xyz);
	r3.x = dot(i.texcoord4.xyz, r2.xyz);
	r3.x = r3.x + r3.x;
	r3.xyz = r2.xyz * -r3.xxx + i.texcoord4.xyz;
	r3.w = -r3.z;
	r3 = tex2D(cubemap_sampler, r3.xyww);
	r2.x = r3.w * CubeParam.y + CubeParam.x;
	r2.xyz = r2.xxx * r3.xyz;
	r3.xyz = r0.xyw * r2.xyz;
	r0.xyw = r0.xyw * ambient_rate.xyz;
	r3.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.w = r2.w + -r3.w;
	r2.w = r2.w * 0.5 + 1;
	r0.xyw = r0.xyw * r2.www;
	r4.xyz = r3.xyz * CubeParam.zzz + r0.xyw;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r0.xyw = r0.xyw * -r3.xyz + r4.xyz;
	r2.w = r0.z + -CubeParam.z;
	r1.xyz = r2.xyz * r2.www + r0.xyw;
	r2 = -1 + i.color;
	r0 = SoftPt_Rate.y * r2 + r0.z;
	r0 = r0 * r1;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r1.w = r0.w * prefogcolor_enhance.w;
	r1.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o = r1 * finalcolor_enhance;

	return o;
}
