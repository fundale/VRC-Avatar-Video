Shader "Avatar Video/Avatar Video"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MaskTex ("Texture", 2D) = "white" {}
        [Toggle(_CLAMP_TO_1)]_Clamp ("Anti Bloom", int) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _CLAMP_TO_1

            sampler2D _VideoTex;

            #include "UnityCG.cginc"
            //#include "/Assets/AudioLink/Shaders/AudioLink.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            void visible(float4 col) {

                if (col.r == 0.0 && col.g == 0.0 && col.b == 0.0) discard;

            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {                

                // sample the texture
                /*#ifdef AUDIOLINK_STANDARD_INDEXING
                    
                #else
                    fixed4 col = _VideoTex[uint2(i.uv * float2(1280, 720))];
                #endif*/
                half4 col = tex2D(_VideoTex, i.uv);
                //visible(col);
                #ifdef _CLAMP_TO_1
                    col = min(col, fixed4(1.0, 1.0, 1.0, 1.0));
                #endif
                return col;
            }
            ENDCG
        }
    }
}
