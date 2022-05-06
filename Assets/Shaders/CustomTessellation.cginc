struct vertexInput
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 tex:TEXCOORD0;
};

struct vertexOutput
{
	float4 vertex : SV_POSITION;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 tex:TEXCOORD0;
};

vertexOutput tessVert(vertexInput v)
{
	vertexOutput o;
	// Note that the vertex is NOT transformed to clip
	// space here; this is done in the grass geometry shader.
	//o.vertex = v.vertex;
	o.vertex = v.vertex;
	o.normal = v.normal;
	o.tangent = v.tangent;
	return o;
}

//Variables
sampler2D _TextureMap;
float _MaxDisplacement;
sampler2D _ColorMap;

vertexOutput vert(vertexInput v) {
	vertexOutput vout;
	//Calcular el valor de color de la textura segun la coordenada de textura del vertice
	float4 colorValue = (tex2Dlod(_TextureMap, float4(v.tex.xy, 0, 0)));
	//Aplicar el desplazamiento siguiendo la normal del vertice
	vout.vertex = UnityObjectToClipPos(v.vertex + float4(v.normal * _MaxDisplacement * colorValue.rgb, 0));
	//Pasamos el valor de la textura y de la normal
	vout.tex = v.tex;
	vout.normal = v.normal;

	return vout;
}

[UNITY_domain("tri")]
[UNITY_outputcontrolpoints(3)]
[UNITY_outputtopology("triangle_cw")]
[UNITY_partitioning("integer")]
[UNITY_patchconstantfunc("patchConstantFunction")]
vertexInput hull(InputPatch<vertexInput, 3> patch, uint id: SV_OutputControlPointID) 
{
	return patch[id];
}

struct TessellationFactors
{
	float edge[3] : SV_TessFactor;
	float inside : SV_InsideTessFactor;
};

float _TessellationUniform;

TessellationFactors patchConstantFunction(InputPatch<vertexInput, 3> patch)
{
	TessellationFactors f;
	f.edge[0] = _TessellationUniform;
	f.edge[1] = _TessellationUniform;
	f.edge[2] = _TessellationUniform;
	f.inside = _TessellationUniform;
	return f;
}

[UNITY_domain("tri")]
vertexOutput domain(TessellationFactors factors, OutputPatch<vertexInput, 3> patch, float3 barycentricCoordinates : SV_DomainLocation)
{
	vertexInput v;

	#define MY_DOMAIN_PROGRAM_INTERPOLATE(fieldName) v.fieldName = \
		patch[0].fieldName * barycentricCoordinates.x + \
		patch[1].fieldName * barycentricCoordinates.y + \
		patch[2].fieldName * barycentricCoordinates.z;

	MY_DOMAIN_PROGRAM_INTERPOLATE(vertex)
	MY_DOMAIN_PROGRAM_INTERPOLATE(normal)
	MY_DOMAIN_PROGRAM_INTERPOLATE(tangent)

	return tessVert(v);
}