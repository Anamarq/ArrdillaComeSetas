Shader "Practica/DisplacementMap"
{
    Properties
    {
        _TextureMap("Texture Map", 2D) = "white" {}
        _ColorMap("Color Map", 2D) = "white" {}
        _MaxDisplacement("Maximum Displacement Effect", Float) = 1
    }

    SubShader{
        Pass{

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //Variables
            sampler2D _TextureMap;
            float _MaxDisplacement;
            sampler2D _ColorMap;

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
                //Calcular el valor de color de la textura segun la coordenada de textura del vertice
                float4 colorValue = (tex2Dlod(_TextureMap, float4(v.tex.xy, 0, 0)));
                //Aplicar el desplazamiento siguiendo la normal del vertice
                vout.position = UnityObjectToClipPos(v.position + float4(v.normal * _MaxDisplacement * colorValue.rgb, 0));
                //Pasamos el valor de la textura y de la normal
                vout.tex = v.tex;
                vout.normal = v.normal;

                return vout;
            }

            float4 frag(vertexOutput i) : COLOR
            {
                return tex2D(_ColorMap, i.tex.xy);
            }

            ENDCG
        }
    }
} 