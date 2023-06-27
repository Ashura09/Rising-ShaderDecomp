float4 fogParam;
float4x4 g_Proj;
float4x4 g_ShadowView;
float4x4 g_ShadowViewProj;
float4x4 g_ViewInverseMatrix;
float4x4 g_WorldMatrix;
float4x4 g_WorldView;

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	o.texcoord7.x = dot(r0, transpose(g_ShadowViewProj)[0]);
	o.texcoord7.y = dot(r0, transpose(g_ShadowViewProj)[1]);
	o.texcoord7.w = dot(r0, transpose(g_ShadowViewProj)[3]);
	r0.w = dot(r0, transpose(g_ShadowView)[2]);
	o.texcoord7.z = abs(r0.w);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r2.w = dot(r1, transpose(g_WorldView)[3]);
	r2.x = dot(r1, transpose(g_WorldView)[0]);
	r2.y = dot(r1, transpose(g_WorldView)[1]);
	r2.z = dot(r1, transpose(g_WorldView)[2]);
	o.position.x = dot(r2, transpose(g_Proj)[0]);
	o.position.y = dot(r2, transpose(g_Proj)[1]);
	o.position.z = dot(r2, transpose(g_Proj)[2]);
	o.position.w = dot(r2, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r2.xyz;
	r0.w = r2.z + fogParam.y;
	o.texcoord1.w = r0.w * fogParam.x;
	r1.x = dot(i.normal.xyz, transpose(g_WorldView)[0].xyz);
	r1.y = dot(i.normal.xyz, transpose(g_WorldView)[1].xyz);
	r1.z = dot(i.normal.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3 = r0.www * r1.xyz;
	o.texcoord = i.texcoord.xyxy;
	r1.x = -transpose(g_ViewInverseMatrix)[0].w;
	r1.y = -transpose(g_ViewInverseMatrix)[1].w;
	r1.z = -transpose(g_ViewInverseMatrix)[2].w;
	r0.xyz = r0.xyz + r1.xyz;
	r1.w = dot(i.normal.xyz, transpose(g_WorldMatrix)[3].xyz);
	r1.x = dot(i.normal.xyz, transpose(g_WorldMatrix)[0].xyz);
	r1.y = dot(i.normal.xyz, transpose(g_WorldMatrix)[1].xyz);
	r1.z = dot(i.normal.xyz, transpose(g_WorldMatrix)[2].xyz);
	r0.w = dot(r1, r1);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = dot(r0.xyz, r1.xyz);
	r0.w = r0.w + r0.w;
	r0.xyz = r1.xyz * -r0.www + r0.xyz;
	r0.w = -r0.z;
	o.texcoord4 = r0.xyw;

	return o;
}
