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
		_TitleFlowColor("TitleFlowColor", Color) = (1,0,0,1)
		_BaseImage("BaseImage", 2D) = "white" {}
		_DistortAmount("DistortAmount", Range( 0 , 1)) = 1
		_PulseSpeed("PulseSpeed", Range( 0 , 5)) = 0
		_DistortNormal("DistortNormal", 2D) = "white" {}
		_ProtaTexture("ProtaTexture", 2D) = "white" {}
		_ProtaTexture1("ProtaTexture", 2D) = "white" {}
		_ProtaOffset("ProtaOffset", Vector) = (0,0,0,0)
		_ProtaOffset1("ProtaOffset", Vector) = (0,0,0,0)
		_ProtaScale("ProtaScale", Range( 0 , 2)) = 0
		_ProtaFilter("ProtaFilter", Color) = (0,0,0,0)
		_ProtaOutlineScale("ProtaOutlineScale", Range( 0 , 2)) = 1.05
		_TitleFill("TitleFill", 2D) = "white" {}
		_ProtaOutlineColror("ProtaOutlineColror", Color) = (0,0,0,1)
		_PulseAmp("PulseAmp", Range( 0 , 0.5)) = 0
		_RampText("RampText", 2D) = "white" {}
		_FlowTexture("FlowTexture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

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
			uniform float4 _TitleFlowColor;
			uniform sampler2D _BaseImage;
			uniform sampler2D _DistortNormal;
			uniform float4 _BaseImage_ST;
			uniform float _DistortAmount;
			uniform float4 _ProtaOutlineColror;
			uniform sampler2D _ProtaTexture1;
			uniform float _PulseSpeed;
			uniform float _PulseAmp;
			uniform float _ProtaScale;
			uniform float _ProtaOutlineScale;
			uniform float2 _ProtaOffset1;
			uniform float4 _ProtaFilter;
			uniform sampler2D _ProtaTexture;
			uniform float2 _ProtaOffset;
			uniform sampler2D _TitleFill;
			uniform float4 _TitleFill_ST;

			
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
				float4 tex2DNode14_g9 = tex2D( _FlowTexture, uv_FlowTexture );
				float2 appendResult20_g9 = (float2(tex2DNode14_g9.r , tex2DNode14_g9.g));
				float TimeVar197_g9 = _Time.y;
				float2 temp_cast_0 = (TimeVar197_g9).xx;
				float2 temp_output_18_0_g9 = ( appendResult20_g9 - temp_cast_0 );
				float4 tex2DNode72_g9 = tex2D( _RampText, temp_output_18_0_g9 );
				float2 uv_BaseImage = IN.texcoord.xy * _BaseImage_ST.xy + _BaseImage_ST.zw;
				float2 MainUvs222_g8 = uv_BaseImage;
				float4 tex2DNode65_g8 = tex2D( _DistortNormal, MainUvs222_g8 );
				float4 appendResult82_g8 = (float4(0.0 , tex2DNode65_g8.g , 0.0 , tex2DNode65_g8.r));
				float2 temp_output_84_0_g8 = (UnpackScaleNormal( appendResult82_g8, _DistortAmount )).xy;
				float2 panner179_g8 = ( 1.0 * _Time.y * float2( 0,0.16 ) + MainUvs222_g8);
				float2 temp_output_71_0_g8 = ( temp_output_84_0_g8 + panner179_g8 );
				float4 tex2DNode96_g8 = tex2D( _BaseImage, temp_output_71_0_g8 );
				float2 texCoord28 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_29_0 = ( texCoord28 - float2( 0.5,0.5 ) );
				float temp_output_38_0 = ( ( ( sin( ( _Time.y * _PulseSpeed ) ) * _PulseAmp ) + 1.0 ) * _ProtaScale );
				float4 lerpResult53 = lerp( tex2DNode96_g8 , _ProtaOutlineColror , tex2D( _ProtaTexture1, ( ( ( temp_output_29_0 / ( temp_output_38_0 * _ProtaOutlineScale ) ) + float2( 0.5,0.5 ) ) - _ProtaOffset1 ) ).a);
				float4 tex2DNode33 = tex2D( _ProtaTexture, ( ( ( temp_output_29_0 / temp_output_38_0 ) + float2( 0.5,0.5 ) ) - _ProtaOffset ) );
				float4 lerpResult34 = lerp( lerpResult53 , saturate( ( _ProtaFilter * tex2DNode33 ) ) , tex2DNode33.a);
				float2 uv_TitleFill = IN.texcoord.xy * _TitleFill_ST.xy + _TitleFill_ST.zw;
				float4 tex2DNode59 = tex2D( _TitleFill, uv_TitleFill );
				float4 lerpResult60 = lerp( lerpResult34 , tex2DNode59 , tex2DNode59.a);
				float4 temp_output_192_0_g9 = lerpResult60;
				
				half4 color = ( ( ( tex2DNode72_g9 * tex2DNode14_g9.a ) * _TitleFlowColor ) + temp_output_192_0_g9 );
				
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
0;53;1920;1006;-1504.898;-1675.772;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;55;-965.962,201.652;Inherit;False;2136.13;808.4928;Prota + Pulse;17;21;20;23;25;24;26;28;27;39;38;29;30;31;37;40;32;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-915.962,657.2222;Inherit;False;Property;_PulseSpeed;PulseSpeed;10;0;Create;True;0;0;0;False;0;False;0;0.96;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;20;-822.2513,533.9067;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-593.962,604.2222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-542.962,756.2222;Inherit;False;Property;_PulseAmp;PulseAmp;21;0;Create;True;0;0;0;False;0;False;0;0.107;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;24;-397.962,597.2222;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-264.962,666.2222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-87.96198,659.2222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-177.9431,362.5511;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;54;608.5305,1061.188;Inherit;False;1400.945;592.5168;Prota Outline;9;46;47;48;51;49;44;45;50;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-181.4088,894.1448;Inherit;False;Property;_ProtaScale;ProtaScale;16;0;Create;True;0;0;0;False;0;False;0;0.43;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;49.74528,427.4926;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;45;658.5305,1180.401;Inherit;False;Property;_ProtaOutlineScale;ProtaOutlineScale;18;0;Create;True;0;0;0;False;0;False;1.05;1.08;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;65.59119,797.1448;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;30;291.8876,540.6434;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;864.8732,1111.188;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;46;1016.491,1114.746;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;507.5472,529.4598;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;37;447.6255,809.1351;Inherit;False;Property;_ProtaOffset;ProtaOffset;14;0;Create;True;0;0;0;False;0;False;0,0;0,-0.74;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;40;703.1424,775.0739;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;1138.656,1139.179;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;56;1213.636,176.3548;Inherit;False;435.6741;314.9903;Color Filter;2;41;42;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;57;231.7548,-408.7558;Inherit;False;1088.3;547.9003;Distort Background;4;13;15;17;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;49;1115.914,1257.114;Inherit;False;Property;_ProtaOffset1;ProtaOffset;15;0;Create;True;0;0;0;False;0;False;0,0;0,-0.69;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;32;492.8247,251.652;Inherit;True;Property;_ProtaTexture;ProtaTexture;12;0;Create;True;0;0;0;False;0;False;None;5160ff8a6255742bfbe77eeb548c7577;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleSubtractOpNode;48;1280.111,1148.181;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;50;1263.976,1353.651;Inherit;True;Property;_ProtaTexture1;ProtaTexture;13;0;Create;True;0;0;0;False;0;False;None;5160ff8a6255742bfbe77eeb548c7577;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;15;281.7548,-203.1558;Inherit;True;Property;_DistortNormal;DistortNormal;11;0;Create;True;0;0;0;False;0;False;76a10595be7e2c74aa376d4267f35bbf;76a10595be7e2c74aa376d4267f35bbf;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;41;1263.636,226.3548;Inherit;False;Property;_ProtaFilter;ProtaFilter;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.2898821,0.4375024,0.723,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;691.5665,-60.60545;Inherit;False;Property;_DistortAmount;DistortAmount;9;0;Create;True;0;0;0;False;0;False;1;0.996;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;526.6548,-358.7558;Inherit;True;Property;_BaseImage;BaseImage;8;0;Create;True;0;0;0;False;0;False;80ab37a9e4f49c842903bb43bdd7bcd2;9006211dc92524815a60c5a0faa52d2e;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;33;850.1684,447.2882;Inherit;True;Property;_TextureSample0;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;61;2102.442,1564.428;Inherit;False;790.8582;453.6909;Title;3;58;59;60;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;19;966.0547,-230.9561;Inherit;True;UI-Sprite Effect Layer;0;;8;789bf62641c5cfe4ab7126850acc22b8;18,74,0,204,0,191,0,225,0,242,0,237,0,249,0,186,0,177,1,182,0,229,0,92,1,98,0,234,0,126,0,129,1,130,0,31,0;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0.16;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.ColorNode;52;1555.869,1441.704;Inherit;False;Property;_ProtaOutlineColror;ProtaOutlineColror;20;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.735849,0.735849,0.735849,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;1487.31,356.3451;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;51;1516.995,1169.546;Inherit;True;Property;_TextureSample1;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;53;2186.627,251.6591;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;43;1779.668,340.8956;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;58;2152.442,1709.893;Inherit;True;Property;_TitleFill;TitleFill;19;0;Create;True;0;0;0;False;0;False;None;be323a7d39e3c4482924497c221d717b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;59;2442.225,1788.119;Inherit;True;Property;_TextureSample2;Texture Sample 2;18;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;62;2271.748,2152.325;Inherit;False;1044.819;667.231;Title Outline Flow;4;6;4;8;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;34;2359.543,562.2474;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;60;2711.3,1614.428;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;2356.748,2379.053;Inherit;True;Property;_RampText;RampText;22;0;Create;True;0;0;0;False;0;False;131633c45b26caa4f9673a16077a1970;131633c45b26caa4f9673a16077a1970;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;8;2321.748,2589.556;Inherit;True;Property;_FlowTexture;FlowTexture;23;0;Create;True;0;0;0;False;0;False;7b0842e3d0da6bf468f08b4a0ad9db9b;62f6a983efc26459199613504e90c25b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;4;2567.357,2202.325;Inherit;False;Property;_TitleFlowColor;TitleFlowColor;7;0;Create;True;0;0;0;False;0;False;1,0,0,1;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;18;2957.567,2230.116;Inherit;True;UI-Sprite Effect Layer;0;;9;789bf62641c5cfe4ab7126850acc22b8;18,74,1,204,1,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;3424.813,2205.251;Float;False;True;-1;2;ASEMaterialInspector;0;6;CaratulaUI;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;23;0;20;0
WireConnection;23;1;21;0
WireConnection;24;0;23;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;27;0;26;0
WireConnection;29;0;28;0
WireConnection;38;0;27;0
WireConnection;38;1;39;0
WireConnection;30;0;29;0
WireConnection;30;1;38;0
WireConnection;44;0;38;0
WireConnection;44;1;45;0
WireConnection;46;0;29;0
WireConnection;46;1;44;0
WireConnection;31;0;30;0
WireConnection;40;0;31;0
WireConnection;40;1;37;0
WireConnection;47;0;46;0
WireConnection;48;0;47;0
WireConnection;48;1;49;0
WireConnection;33;0;32;0
WireConnection;33;1;40;0
WireConnection;19;37;13;0
WireConnection;19;75;15;0
WireConnection;19;80;17;0
WireConnection;42;0;41;0
WireConnection;42;1;33;0
WireConnection;51;0;50;0
WireConnection;51;1;48;0
WireConnection;53;0;19;0
WireConnection;53;1;52;0
WireConnection;53;2;51;4
WireConnection;43;0;42;0
WireConnection;59;0;58;0
WireConnection;34;0;53;0
WireConnection;34;1;43;0
WireConnection;34;2;33;4
WireConnection;60;0;34;0
WireConnection;60;1;59;0
WireConnection;60;2;59;4
WireConnection;18;192;60;0
WireConnection;18;39;4;0
WireConnection;18;37;6;0
WireConnection;18;33;8;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=B3C3FE748A13333408E23888FA763250758030B5