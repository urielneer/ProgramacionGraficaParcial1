// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Binoculars"
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
		_Center1("_Center1", Vector) = (0.3,0.5,0,0)
		_Center2("_Center2", Vector) = (0.7,0.5,0,0)
		_Min("_Min", Float) = 0.25
		_Max("_Max", Float) = 0.22
		_Texture0("_MainTex", 2D) = "white" {}

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
			uniform sampler2D _Texture0;
			uniform float _Min;
			uniform float _Max;
			uniform float2 _Center1;
			uniform float2 _Center2;

			
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

				float2 texCoord32 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float4 tex2DNode2 = tex2D( _Texture0, texCoord32 );
				float Minimum21 = _Min;
				float Maximum22 = _Max;
				float2 texCoord9 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float smoothstepResult13 = smoothstep( Minimum21 , Maximum22 , distance( texCoord9 , _Center1 ));
				float2 texCoord12 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float smoothstepResult14 = smoothstep( Minimum21 , Maximum22 , distance( texCoord12 , _Center2 ));
				float BinocularEffect17 = ( 1.0 - ( smoothstepResult13 + smoothstepResult14 ) );
				float clampResult3 = clamp( BinocularEffect17 , 0.0 , 1.0 );
				float4 appendResult40 = (float4(tex2DNode2.r , tex2DNode2.g , tex2DNode2.b , clampResult3));
				
				half4 color = appendResult40;
				
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
207;73;905;402;924.0416;353.5425;1.617759;True;False
Node;AmplifyShaderEditor.CommentaryNode;23;-2736.261,-762.4977;Inherit;False;437.5623;236.2532;Comment;4;19;20;21;22;Min and Max;1,0,0.8580036,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2682.654,-643.2098;Inherit;False;Property;_Max;_Max;3;0;Create;True;0;0;0;False;0;False;0.22;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2686.261,-712.4977;Inherit;False;Property;_Min;_Min;2;0;Create;True;0;0;0;False;0;False;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;18;-2211.338,-721.5411;Inherit;False;1097.038;701.3955;Comment;13;12;5;11;4;10;9;14;13;17;24;25;34;39;Binocular Effect;0.5941916,1,0,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2146.001,-299.802;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;5;-2124.397,-184.1461;Inherit;False;Property;_Center2;_Center2;1;0;Create;True;0;0;0;False;0;False;0.7,0.5;0.3,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-2522.699,-642.2446;Inherit;False;Maximum;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-2522.727,-711.775;Inherit;False;Minimum;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;4;-2125.731,-557.9359;Inherit;False;Property;_Center1;_Center1;0;0;Create;True;0;0;0;False;0;False;0.3,0.5;0.3,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-2161.338,-671.5411;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;24;-1909.722,-475.1115;Inherit;False;21;Minimum;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;10;-1920.49,-593.1263;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1914.57,-399.1453;Inherit;False;22;Maximum;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;11;-1905.151,-221.387;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;13;-1673.777,-535.7504;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;14;-1671.176,-401.021;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1490.52,-429.6946;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;39;-1348.191,-427.1033;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1313.616,-301.4122;Inherit;True;BinocularEffect;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-551.9758,170.436;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;31;-794.5753,-289.2674;Inherit;True;Property;_Texture0;_MainTex;4;0;Create;False;0;0;0;False;0;False;c376a2d96fb3e4241a9e94e21bbd377e;c376a2d96fb3e4241a9e94e21bbd377e;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-781.3251,-88.20361;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-553.5522,244.5198;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-561.4338,96.35216;Inherit;False;17;BinocularEffect;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-509.4531,-117.95;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;3;-357.3078,101.8725;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;-82.80694,-10.57768;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;203.569,18.30039;Float;False;True;-1;2;ASEMaterialInspector;0;6;Binoculars;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;22;0;20;0
WireConnection;21;0;19;0
WireConnection;10;0;9;0
WireConnection;10;1;4;0
WireConnection;11;0;12;0
WireConnection;11;1;5;0
WireConnection;13;0;10;0
WireConnection;13;1;24;0
WireConnection;13;2;25;0
WireConnection;14;0;11;0
WireConnection;14;1;24;0
WireConnection;14;2;25;0
WireConnection;34;0;13;0
WireConnection;34;1;14;0
WireConnection;39;0;34;0
WireConnection;17;0;39;0
WireConnection;2;0;31;0
WireConnection;2;1;32;0
WireConnection;3;0;26;0
WireConnection;3;1;27;0
WireConnection;3;2;28;0
WireConnection;40;0;2;1
WireConnection;40;1;2;2
WireConnection;40;2;2;3
WireConnection;40;3;3;0
WireConnection;0;0;40;0
ASEEND*/
//CHKSM=940C9251B664A5D496BF3DC4B6DC89AC61C5E71D