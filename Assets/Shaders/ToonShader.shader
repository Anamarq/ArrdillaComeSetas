Shader "Practica/ToonShader"
{
    //Basado en el tutorial: https://www.youtube.com/watch?v=kV4IG811DUU&ab_channel=Guidev

    Properties
    {
        _Albedo("Albedo", Color) = (1,1,1,1) 
        _Shades("Shades", Range(1,20)) = 3

        _InkColor("InkColor", Color) = (0,0,0,0)
        _InkSize("InkSize", float)=1.0 

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            float4 _InkColor;
            float _InkSize;

            v2f vert(appdata v)
            {
                v2f o;
                //Trasladar vertice a lo largo del vector normal
                o.vertex = UnityObjectToClipPos(v.vertex + _InkSize * v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                 return _InkColor;
            }
            ENDCG
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };

            float4 _Albedo;
            float _Shades;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //Calcular coseno del angulo entre el vector normal y el de la dirección de la luz
                float cosineAngle = dot(normalize(i.worldNormal), normalize(_WorldSpaceLightPos0.xyz));
                
                //min a 0
                cosineAngle = max(cosineAngle, 0.0);

                cosineAngle = floor(cosineAngle * _Shades) / _Shades;

                return _Albedo * cosineAngle;
            }
            ENDCG
        }
    }

    Fallback "VertexLit"
}
