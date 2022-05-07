Shader "Practica/GenerateGeometryWithShadows"
{
	Properties
	{
		[Header(Shading)]
		//_TranslucentGain("Translucent Gain", Range(0,1)) = 0.5
		
		_BaseWidth("Base Width", Float) = 0.1
		_TopWidth("Top Width", Float) =  0.1
		_Height("Height", Float) = 0.1
		
		//_Texture("Texture", 2D)= "white"{}

		_MushromSize("Mushrom size", Float) = 0.1
		_MushromDepth("Mushrom depth", Float) = 0.1

		//_Factor("Factor", Range(0., 2.)) = 0.2

		_Albedo("Albedo", Color) = (1,1,1,1)
	}

		CGINCLUDE
		#include "UnityCG.cginc"
		#include "Autolight.cginc"

		float _Height;
		float _BaseWidth;
		float _TopWidth;

		//sampler2D _Texture;
		//float4 _Texture_ST;

		//Mushrom
		float _MushromSize;
		float _MushromDepth;

		//float _Factor;
		float4 _Albedo;

		struct vertexInput  
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 tangent : TANGENT;
			float2 uv : TEXCOORD0;
		};

		struct vertexOutput  
		{
			float4 vertex : SV_POSITION;
			float3 normal : NORMAL;
			float4 tangent : TANGENT;
			float2 uv : TEXCOORD0;
		};

		struct geometryOutput  
		{
			float4 pos : SV_POSITION;
			float3 worldNormal : TEXCOORD2;
		};

		geometryOutput VertexOutput(float3 pos, float2 uv)
		{
			geometryOutput o;
			o.pos = UnityObjectToClipPos(pos);
			return o;
		}
		vertexOutput vert(vertexInput v)
		{
			vertexOutput o;
			o.vertex = v.vertex;
			//o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv;
			o.normal = v.normal;
			o.tangent = v.tangent;
			return o;
		}

		// Construct a rotation matrix that rotates around the provided axis, sourced from:
		// https://gist.github.com/keijiro/ee439d5e7388f3aafc5296005c8c3f33
		//float3x3 AngleAxis3x3(float angle, float3 axis)
		//{
		//	float c, s;
		//	sincos(angle, s, c);

		//	float t = 1 - c;
		//	float x = axis.x;
		//	float y = axis.y;
		//	float z = axis.z;

		//	return float3x3(
		//		t * x * x + c, t * x * y - s * z, t * x * z + s * y,
		//		t * x * y + s * z, t * y * y + c, t * y * z - s * x,
		//		t * x * z - s * y, t * y * z + s * x, t * z * z + c
		//		);
		//}


		geometryOutput GetVertex(float3 pos, float3 normal) {
			geometryOutput o;
			//float3x3 facingRotationMatrix = AngleAxis3x3(rand(pos) * UNITY_TWO_PI, float3(0, 0, 1));
			//pos = mul(AngleAxis3x3(0.25 * UNITY_TWO_PI, float3(0, 1, 0)), pos);
			o.pos = UnityObjectToClipPos(pos);
			o.worldNormal = UnityObjectToWorldNormal(normal);
			return o;
		}

		// Simple noise function, sourced from http://answers.unity.com/answers/624136/view.html
		// Extended discussion on this function can be found at the following link:
		// https://forum.unity.com/threads/am-i-over-complicating-this-random-function.454887/#post-2949326
		// Returns a number in the 0...1 range.
		float rand(float3 co)
		{
			return frac(sin(dot(co.xyz, float3(12.9898, 78.233, 53.539))) * 43758.5453);
		}

		void setTriangle(float3 pointA, float3 pointB, float3 pointC, float3 normal, inout TriangleStream<geometryOutput> triStream)
		{

			triStream.Append(GetVertex(pointA,  normal));
			triStream.Append(GetVertex(pointB,  normal));
			triStream.Append(GetVertex(pointC,  normal));
			triStream.RestartStrip();
		}


		[maxvertexcount(18)]
		void geo(triangle vertexOutput IN[3], inout TriangleStream<geometryOutput> triStream)
		{
			geometryOutput o;
			float4 center = (IN[0].vertex + IN[1].vertex + IN[2].vertex) / 3;
			float3 normal = normalize((IN[0].normal + IN[1].normal + IN[2].normal) / 3);
			float4 right = normalize(mul(unity_WorldToObject, float3(1, 0, 0)));
			float4 left = normalize(mul(unity_WorldToObject, float3(-1, 0, 0)));
			float4 fwRight = normalize(mul(unity_WorldToObject, float3(1, 0, 1)));
			float4 fwLeft = normalize(mul(unity_WorldToObject, float3(-1, 0, 1)));
			float4 backRight = normalize(mul(unity_WorldToObject, float3(1, 0, -1)));
			float4 backLeft = normalize(mul(unity_WorldToObject, float3(-1, 0, -1)));
		
		/*	float3 vNormal = IN[0].normal;
			float4 vTangent = IN[0].tangent;
			float3 vBinormal = cross(vNormal, vTangent) * vTangent.w;

			float3x3 tangentToLocal = float3x3(
				vTangent.x, vBinormal.x, vNormal.x,
				vTangent.y, vBinormal.y, vNormal.y,
				vTangent.z, vBinormal.z, vNormal.z);*/


			//float3x3 facingRotationMatrix = AngleAxis3x3(rand(0.1) * UNITY_TWO_PI, float3(0, 0, 1));
		

			float3 pointA = center + _BaseWidth * 0.5 * right;
			float3 pointB = center +_TopWidth * 0.5 * right + float4(normal,0.0) * _Height;
			float3 pointC = center + _BaseWidth * 0.5 * left;
			
			setTriangle(pointA, pointB, pointC,  normal, triStream);


			pointA = center + _TopWidth * 0.5 * right + float4(normal, 0.0) * _Height;
		    pointB = center + _TopWidth * 0.5 * left + float4(normal, 0.0) * _Height;
			pointC = center + _BaseWidth * 0.5 * left;
			setTriangle(pointA, pointB, pointC, normal, triStream);



			pointA = center +float4(normal, 0.0) * _Height;
			pointB = pointA + _MushromSize * fwRight + float4(normal, 0.0) * _MushromDepth;
			pointC = pointA + _MushromSize * fwLeft + float4(normal, 0.0) * _MushromDepth;
			setTriangle(pointA, pointB, pointC, normal, triStream);

			pointA = center + float4(normal, 0.0) * _Height;
			pointB = pointA + _MushromSize * fwLeft + float4(normal, 0.0) * _MushromDepth;
			pointC = pointA + _MushromSize * backLeft + float4(normal, 0.0) * _MushromDepth;
			setTriangle(pointA, pointB, pointC, normal, triStream);


			pointA = center + float4(normal, 0.0) * _Height;
			pointB = pointA + _MushromSize * backLeft + float4(normal, 0.0) * _MushromDepth;
			pointC = pointA + _MushromSize * backRight + float4(normal, 0.0) * _MushromDepth;
			setTriangle(pointA, pointB, pointC, normal, triStream);



			pointA = center + float4(normal, 0.0) * _Height;
			pointB = pointA + _MushromSize * backRight + float4(normal, 0.0) * _MushromDepth;
			pointC = pointA + _MushromSize * fwRight +float4(normal, 0.0) * _MushromDepth;
			setTriangle(pointA, pointB, pointC, normal, triStream);

		}

		

		ENDCG

			SubShader
		{
			Cull Off

			Pass
			{
				Tags
				{
					"RenderType" = "Opaque"
					"LightMode" = "ForwardBase"
				}
				Cull off
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 4.6
				#pragma geometry geo
				#pragma multi_compile_fwdbase


				#include "Lighting.cginc"


				//float _TranslucentGain;

		
				float4 frag(geometryOutput i, fixed facing : VFACE) : SV_Target
				{
					return _Albedo;
				}
				ENDCG
			}
		}
}