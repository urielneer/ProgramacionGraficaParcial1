// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterSprite"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		_WaterHeight("WaterHeight", Range( 0 , 1)) = 0.5850044
		_WaveHeight("WaveHeight", Range( 0 , 0.3)) = 0.03176471
		_SplashPosX("SplashPosX", Range( 0 , 1)) = 0
		_WaterTint("WaterTint", Color) = (0.759,0.9601653,1,1)
		_SplashStrength("SplashStrength", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 1)) = 0
		_FoamColor("FoamColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		
		GrabPass{ }

		Pass
		{
		CGPROGRAM
			#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
			#else
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
			#endif

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


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
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
			uniform sampler2D _TextureSample0;
			uniform float4 _TextureSample0_ST;
			uniform float4 _WaterTint;
			uniform float _Opacity;
			uniform float _WaterHeight;
			uniform float _SplashStrength;
			uniform float _SplashPosX;
			uniform float _WaveHeight;
			uniform float4 _FoamColor;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				float4 ase_clipPos = UnityObjectToClipPos(IN.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				OUT.ase_texcoord1 = screenPos;
				
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float4 screenPos = IN.ase_texcoord1;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float4 screenColor30 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_screenPosNorm + ( sin( ( _Time.y + ase_screenPosNorm ) ) * float4( 0.01,0,0,0 ) ) ).xy);
				float2 uv_TextureSample0 = IN.texcoord.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float4 lerpResult73 = lerp( screenColor30 , ( tex2D( _TextureSample0, uv_TextureSample0 ) * _WaterTint ) , _Opacity);
				float2 texCoord42 = IN.texcoord.xy * float2( 6,2 ) + float2( 0,0 );
				float temp_output_8_0 = (texCoord42).y;
				float2 texCoord2 = IN.texcoord.xy * float2( 6,2 ) + float2( 0,0 );
				float2 texCoord59 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_27_0 = ( _WaterHeight + ( sin( ( ( (texCoord2).x + _Time.y ) * 6.2831 ) ) * ( ( ( _SplashStrength * saturate( ( 1.0 - ( abs( ( (texCoord59).x - _SplashPosX ) ) / 0.18 ) ) ) ) + 1.0 ) * _WaveHeight ) ) );
				float temp_output_12_0 = step( temp_output_8_0 , temp_output_27_0 );
				float4 lerpResult86 = lerp( ( lerpResult73 * temp_output_12_0 ) , _FoamColor , ( ( 1.0 - saturate( ( ( temp_output_27_0 - temp_output_8_0 ) / 0.2264706 ) ) ) * temp_output_12_0 ));
				
				fixed4 c = lerpResult86;
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
66;53;1920;1006;36.49896;-602.6843;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;57;-2182.282,535.4182;Inherit;False;1480.009;369;SPLASH - Distancia al epicentro del splash: 1 en el centro, 0 en bordes;9;47;59;60;49;50;52;51;53;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;-2148.453,590.9389;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;-1920.287,803.4178;Float;False;Property;_SplashPosX;SplashPosX;2;0;Create;True;0;0;0;False;0;False;0;0.46;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;60;-1937.458,584.939;Inherit;True;True;False;False;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-1587.11,607.3004;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1581.289,809.418;Inherit;False;Constant;_SplashRadius;SplashRadius;4;0;Create;True;0;0;0;False;0;False;0.18;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;50;-1384.288,616.4178;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;62;-1126.208,-131.8217;Inherit;False;1210.099;514.2772;Ondas en X;7;2;13;15;18;19;43;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;52;-1235.289,653.4181;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1076.208,-81.82173;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,2;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;63;-644.0864,546.142;Inherit;False;771.6708;372.7239;SPLASH - Tamaño de waves dependiendo de esa distancia;5;48;55;58;26;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;53;-1062.281,614.7794;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;18;-719.3473,209.1804;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;13;-768.9467,-42.99785;Inherit;True;True;False;False;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;54;-856.2815,662.7795;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-594.0864,596.142;Float;False;Property;_SplashStrength;SplashStrength;4;0;Create;True;0;0;0;False;0;False;0;1.96;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-487.2883,266.4554;Inherit;False;Constant;_Tau;Tau;2;0;Create;True;0;0;0;False;0;False;6.2831;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-438.566,61.34753;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-416.4012,607.0118;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;-281.4007,610.0097;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-286.8879,103.4118;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-421.6343,758.3504;Inherit;False;Property;_WaveHeight;WaveHeight;1;0;Create;True;0;0;0;False;0;False;0.03176471;0.052;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;337.0458,748.3738;Inherit;False;1838.913;757.4614;Transparencia + tinte azul;12;74;38;73;30;76;77;66;41;40;46;35;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;45;423.6257,1115.911;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;35;387.0459,877.0514;Float;True;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;15;-114.1095,18.35825;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-107.4157,664.8659;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;439.4307,15.2776;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,2;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;46;656.4709,1111.501;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;23;440.7465,312.0462;Inherit;False;Property;_WaterHeight;WaterHeight;0;0;Create;True;0;0;0;False;0;False;0.5850044;0.7412553;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;198.3839,363.3731;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;718.1859,337.9615;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;8;758.4821,14.20612;Inherit;True;False;True;False;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;84;1169.555,-213.4468;Inherit;False;1295.668;501.8608;Foam;7;87;81;78;83;79;75;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;38;825.678,1114.059;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;79;1219.555,64.35487;Inherit;False;Constant;_FoamThickness;FoamThickness;6;0;Create;True;0;0;0;False;0;False;0.2264706;0;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;75;1263.267,-160.2125;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;1014.974,1113.503;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0.01,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;66;1255.845,1065.651;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;0;False;0;False;-1;None;74bd13a8eff8d40b6a73db463bcc24be;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;78;1514.037,-163.4468;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;1128.853,877.0161;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;74;1397.687,1314.681;Inherit;False;Property;_WaterTint;WaterTint;3;0;Create;True;0;0;0;False;0;False;0.759,0.9601653,1,1;0.759,0.9601653,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;77;1614.674,933.168;Inherit;False;Property;_Opacity;Opacity;6;0;Create;True;0;0;0;False;0;False;0;0.5882353;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1686.298,1169.742;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;80;1751.362,-149.777;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;30;1306.261,803.6779;Inherit;False;Global;_GrabScreen0;Grab Screen 0;2;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;73;1900.954,821.233;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;12;1479.099,332.049;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;81;1911.362,-160.777;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;2213.434,859.8923;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;87;2126.09,117.1573;Inherit;False;Property;_FoamColor;FoamColor;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;2152.012,-160.8421;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;86;2447.109,368.4478;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;2773.539,360.6321;Float;False;True;-1;2;ASEMaterialInspector;0;8;WaterSprite;0f8ba0101102bb14ebf021ddadce9b49;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;False;True;3;1;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;60;0;59;0
WireConnection;49;0;60;0
WireConnection;49;1;47;0
WireConnection;50;0;49;0
WireConnection;52;0;50;0
WireConnection;52;1;51;0
WireConnection;53;0;52;0
WireConnection;13;0;2;0
WireConnection;54;0;53;0
WireConnection;19;0;13;0
WireConnection;19;1;18;0
WireConnection;55;0;48;0
WireConnection;55;1;54;0
WireConnection;58;0;55;0
WireConnection;16;0;19;0
WireConnection;16;1;43;0
WireConnection;15;0;16;0
WireConnection;61;0;58;0
WireConnection;61;1;26;0
WireConnection;46;0;45;0
WireConnection;46;1;35;0
WireConnection;28;0;15;0
WireConnection;28;1;61;0
WireConnection;27;0;23;0
WireConnection;27;1;28;0
WireConnection;8;0;42;0
WireConnection;38;0;46;0
WireConnection;75;0;27;0
WireConnection;75;1;8;0
WireConnection;40;0;38;0
WireConnection;78;0;75;0
WireConnection;78;1;79;0
WireConnection;41;0;35;0
WireConnection;41;1;40;0
WireConnection;76;0;66;0
WireConnection;76;1;74;0
WireConnection;80;0;78;0
WireConnection;30;0;41;0
WireConnection;73;0;30;0
WireConnection;73;1;76;0
WireConnection;73;2;77;0
WireConnection;12;0;8;0
WireConnection;12;1;27;0
WireConnection;81;0;80;0
WireConnection;88;0;73;0
WireConnection;88;1;12;0
WireConnection;83;0;81;0
WireConnection;83;1;12;0
WireConnection;86;0;88;0
WireConnection;86;1;87;0
WireConnection;86;2;83;0
WireConnection;0;0;86;0
ASEEND*/
//CHKSM=ABCD6095A32C26643BF848280DAE51E3282B7641