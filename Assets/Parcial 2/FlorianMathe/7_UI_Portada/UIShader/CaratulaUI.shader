// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CaratulaUI"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_BaseImage("BaseImage", 2D) = "white" {}
		_DistortAmount("DistortAmount", Range( 0 , 1)) = 1
		_DistortNormal("DistortNormal", 2D) = "white" {}
		_DistortMask("DistortMask", 2D) = "white" {}
		_RampText("RampText", 2D) = "white" {}
		_FlowTexture("FlowTexture", 2D) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			#include "UnityShaderVariables.cginc"
			#include "UnityStandardUtils.cginc"

			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform sampler2D _RampText;
			uniform sampler2D _FlowTexture;
			uniform float4 _FlowTexture_ST;
			uniform sampler2D _BaseImage;
			uniform sampler2D _DistortNormal;
			uniform float4 _BaseImage_ST;
			uniform float _DistortAmount;
			uniform sampler2D _DistortMask;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_FlowTexture = IN.texcoord.xy * _FlowTexture_ST.xy + _FlowTexture_ST.zw;
				float4 tex2DNode14_g7 = tex2D( _FlowTexture, uv_FlowTexture );
				float2 appendResult20_g7 = (float2(tex2DNode14_g7.r , tex2DNode14_g7.g));
				float TimeVar197_g7 = _Time.y;
				float2 temp_cast_0 = (TimeVar197_g7).xx;
				float2 temp_output_18_0_g7 = ( appendResult20_g7 - temp_cast_0 );
				float4 tex2DNode72_g7 = tex2D( _RampText, temp_output_18_0_g7 );
				float4 color4 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
				float2 uv_BaseImage = IN.texcoord.xy * _BaseImage_ST.xy + _BaseImage_ST.zw;
				float2 MainUvs222_g6 = uv_BaseImage;
				float4 tex2DNode65_g6 = tex2D( _DistortNormal, MainUvs222_g6 );
				float4 appendResult82_g6 = (float4(0.0 , tex2DNode65_g6.g , 0.0 , tex2DNode65_g6.r));
				float2 temp_output_84_0_g6 = (UnpackScaleNormal( appendResult82_g6, _DistortAmount )).xy;
				float2 temp_output_71_0_g6 = ( ( temp_output_84_0_g6 * tex2D( _DistortMask, MainUvs222_g6 ).g ) + MainUvs222_g6 );
				float4 tex2DNode96_g6 = tex2D( _BaseImage, temp_output_71_0_g6 );
				float4 temp_output_192_0_g7 = tex2DNode96_g6;
				float4 temp_output_18_0 = ( ( ( tex2DNode72_g7 * tex2DNode14_g7.a ) * color4 ) + temp_output_192_0_g7 );
				
				half4 color = temp_output_18_0;
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
248;73;1174;711;355.5603;363.8574;1.500039;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;13;-491.0466,-746.7757;Inherit;True;Property;_BaseImage;BaseImage;7;0;Create;True;0;0;0;False;0;False;80ab37a9e4f49c842903bb43bdd7bcd2;80ab37a9e4f49c842903bb43bdd7bcd2;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;17;-349.1349,-590.6254;Inherit;False;Property;_DistortAmount;DistortAmount;8;0;Create;True;0;0;0;False;0;False;1;0.961;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;16;-470.8467,-478.8755;Inherit;True;Property;_DistortMask;DistortMask;11;0;Create;True;0;0;0;False;0;False;596678c53fd54a640bf95ba7dfafd092;596678c53fd54a640bf95ba7dfafd092;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;15;-735.9467,-591.1757;Inherit;True;Property;_DistortNormal;DistortNormal;9;0;Create;True;0;0;0;False;0;False;76a10595be7e2c74aa376d4267f35bbf;76a10595be7e2c74aa376d4267f35bbf;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;19;-51.64667,-618.976;Inherit;True;UI-Sprite Effect Layer;0;;6;789bf62641c5cfe4ab7126850acc22b8;18,204,0,74,0,191,0,225,0,242,0,237,0,249,0,186,1,177,0,182,0,229,0,92,1,98,0,234,0,126,0,129,1,130,0,31,0;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.ColorNode;4;-181.8729,-186.8378;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;8;-427.4818,200.3911;Inherit;True;Property;_FlowTexture;FlowTexture;14;0;Create;True;0;0;0;False;0;False;7b0842e3d0da6bf468f08b4a0ad9db9b;7b0842e3d0da6bf468f08b4a0ad9db9b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;6;-432.4818,-0.1089516;Inherit;True;Property;_RampText;RampText;12;0;Create;True;0;0;0;False;0;False;131633c45b26caa4f9673a16077a1970;131633c45b26caa4f9673a16077a1970;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;18;248.7933,-127.5027;Inherit;True;UI-Sprite Effect Layer;0;;7;789bf62641c5cfe4ab7126850acc22b8;18,204,1,74,1,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.ColorNode;20;251.1286,198.9905;Inherit;False;Constant;_Color1;Color 0;2;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;23;401.9603,650.1693;Inherit;True;Property;_Texture0;Texture 0;10;0;Create;True;0;0;0;False;0;False;7b0842e3d0da6bf468f08b4a0ad9db9b;7b0842e3d0da6bf468f08b4a0ad9db9b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;24;239.9556,464.1643;Inherit;True;Property;_RampText1;RampText;13;0;Create;True;0;0;0;False;0;False;131633c45b26caa4f9673a16077a1970;131633c45b26caa4f9673a16077a1970;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;21;665.2944,382.829;Inherit;True;UI-Sprite Effect Layer;0;;8;789bf62641c5cfe4ab7126850acc22b8;18,204,1,74,1,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;903.1799,-48.62272;Float;False;True;-1;2;ASEMaterialInspector;0;4;CaratulaUI;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;19;37;13;0
WireConnection;19;75;15;0
WireConnection;19;80;17;0
WireConnection;19;188;16;0
WireConnection;18;192;19;0
WireConnection;18;39;4;0
WireConnection;18;37;6;0
WireConnection;18;33;8;0
WireConnection;21;192;18;0
WireConnection;21;39;20;0
WireConnection;21;37;24;0
WireConnection;21;33;23;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=DF266A3562A801D9A9C80A45162618B1D541A02A