Shader "CustomRenderTexture/Scrolling_2layers"
{
	Properties
	{
		_Tex("InputTex", 2D) = "white" {}
		_Tex2("InputTex2", 2D) = "white" {}
		_Speed("Speed", Vector) = (1,1,1,1)
	}

		SubShader
	{
		Lighting Off
		Blend One Zero

		Pass
		{
			CGPROGRAM
		#include "UnityCustomRenderTexture.cginc"
		#pragma vertex CustomRenderTextureVertexShader
		#pragma fragment frag
		#pragma target 3.0

		float4		_Speed;
		sampler2D   _Tex;
		float4   _Tex_ST;
		sampler2D   _Tex2;
		float4   _Tex2_ST;

		float4 frag(v2f_customrendertexture IN) : COLOR
		{
			float4 col = tex2D(_Tex, IN.localTexcoord.xy + frac(_Time * _Speed.xy));
			float4 col2 = tex2D(_Tex2, IN.localTexcoord.xy + frac(_Time * _Speed.zw));
			return max(0.1f,col * col2);
		}
		ENDCG
		}
	}
}