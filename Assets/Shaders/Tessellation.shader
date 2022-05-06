Shader "PGATR/Tessellation"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_TessellationUniform ("Tessellation Uniform", Range(1,64)) = 1
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma hull hull
			#pragma domain domain

			#pragma target 4.6
			
			#include "UnityCG.cginc"
			#include "CustomTessellation.cginc"


			float4 _Color;
			
			float4 frag (vertexOutput i) : SV_Target
			{
				return _Color;
			}
			ENDCG
		}
	}
}
