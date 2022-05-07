Shader "Practica/WavesMoving"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _ColorMap("Albedo (RGB)", 2D) = "white" {}
        _MaxDisplacement("Maximum Displacement Effect", Float) = 1
    }
    SubShader
    {
        Pass{
            Tags { "RenderType" = "Opaque" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _ColorMap;
            fixed4 _Color;
            float _MaxDisplacement;

            struct vertexInput {
                float4 position:POSITION;
                float4 tex:TEXCOORD0;
                float3 normal:NORMAL;
            };

            struct vertexOutput {
                float4 position:SV_POSITION;
                float4 tex:TEXCOORD0;
                float3 normal:NORMAL;
            };

            vertexOutput vert(vertexInput v) {
                vertexOutput vout;
                vout.position = UnityObjectToClipPos(v.position); 
                vout.tex = v.tex;
                vout.normal = v.normal;
                return vout;
            }

            float4 frag(vertexOutput i) : COLOR
            {
                //Calcular el movimiento
                return tex2D(_ColorMap, i.tex + float2(0, sin(i.position.x / 30 + _Time[2]) / 30));
            }

            ENDCG

        }
    }
}