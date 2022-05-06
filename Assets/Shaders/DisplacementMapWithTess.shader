Shader "Practica/DisplacementMapWithTess"
{
    Properties
    {
        _TextureMap("Texture Map", 2D) = "white" {}
        _ColorMap("Color Map", 2D) = "white" {}
        _MaxDisplacement("Maximum Displacement Effect", Float) = 1
        _TessellationUniform("Tessellation Uniform", Range(1,64)) = 1
    }

    CGINCLUDE
    #include "CustomTessellation.cginc"

    ENDCG

    SubShader{
        Pass{

            CGPROGRAM
            #pragma vertex vert
            #pragma hull hull
            #pragma domain domain  
            #pragma fragment frag

            //Variables
            //sampler2D _TextureMap;
            //float _MaxDisplacement;
            //sampler2D _ColorMap;

            //vertexOutput vert(vertexInput v) {
            //    vertexOutput vout;
            //    //Calcular el valor de color de la textura segun la coordenada de textura del vertice
            //    float4 colorValue = (tex2Dlod(_TextureMap, float4(v.tex.xy, 0, 0)));
            //    //Aplicar el desplazamiento siguiendo la normal del vertice
            //    vout.vertex = UnityObjectToClipPos(v.vertex + float4(v.normal * _MaxDisplacement * colorValue.rgb, 0));
            //    //Pasamos el valor de la textura y de la normal
            //    vout.tex = v.tex;
            //    vout.normal = v.normal;

            //    return vout;
            //}

            float4 frag(vertexOutput v) : COLOR
            {
                vertexOutput vout;
                //Calcular el valor de color de la textura segun la coordenada de textura del vertice
                float4 colorValue = (tex2Dlod(_TextureMap, float4(v.tex.xy, 0, 0)));
                //Aplicar el desplazamiento siguiendo la normal del vertice
                vout.vertex = UnityObjectToClipPos(v.vertex + float4(v.normal * _MaxDisplacement * colorValue.rgb, 0));
                //Pasamos el valor de la textura y de la normal
                vout.tex = v.tex;
                vout.normal = v.normal;

                return tex2D(_ColorMap, v.tex.xy);
            }

            ENDCG
        }
    }
} 