Shader "Practica/GenerateGeometry"
{
	Properties
	{
		_BaseWidth("Base Width", Float) = 0.1
		_TopWidth("Top Width", Float) =  0.1
		_Height("Height", Float) = 0.1
		
		_MushromSize("Mushrom size", Float) = 0.1
		_MushromDepth("Mushrom depth", Float) = 0.1

		_Albedo("Albedo", Color) = (1,1,1,1)
	}

		CGINCLUDE
		#include "UnityCG.cginc"
		#include "Autolight.cginc"

		float _Height;
		float _BaseWidth;
		float _TopWidth;

		//Mushrom
		float _MushromSize;
		float _MushromDepth;

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

		geometryOutput GetVertex(float3 pos, float3 normal) {
			geometryOutput o;
			o.pos = UnityObjectToClipPos(pos);
			o.worldNormal = UnityObjectToWorldNormal(normal);
			return o;
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

				#include "Lighting.cginc"
		
				float4 frag(geometryOutput i, fixed facing : VFACE) : SV_Target
				{
					return _Albedo;
				}
				ENDCG
			}
		}
}