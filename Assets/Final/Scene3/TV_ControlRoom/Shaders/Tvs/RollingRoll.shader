// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RollingRoll"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_BarThickness("BarThickness", Range( 0 , 0.5)) = 0.1
		_StaticAmount("StaticAmount", Range( 0 , 1)) = 0
		_RollSpeed("RollSpeed", Range( 0 , 2)) = 1
		_NoiseTex("NoiseTex", 2D) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _MainTex;
			uniform float _RollSpeed;
			uniform float _BarThickness;
			uniform sampler2D _NoiseTex;
			uniform float _StaticAmount;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 texCoord6 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 break7 = texCoord6;
				float temp_output_11_0 = frac( ( break7.y + ( _Time.y * _RollSpeed ) ) );
				float2 appendResult12 = (float2(break7.x , temp_output_11_0));
				float3 desaturateInitialColor20 = tex2D( _MainTex, ( 1.0 - appendResult12 ) ).rgb;
				float desaturateDot20 = dot( desaturateInitialColor20, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar20 = lerp( desaturateInitialColor20, desaturateDot20.xxx, 0.0 );
				float2 texCoord17 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner18 = ( 1.0 * _Time.y * float2( 18,-22 ) + texCoord17);
				float4 lerpResult15 = lerp( float4( ( desaturateVar20 * ( 1.0 - step( temp_output_11_0 , _BarThickness ) ) ) , 0.0 ) , tex2D( _NoiseTex, panner18 ) , _StaticAmount);
				
				
				finalColor = lerpResult15;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
171;73;550;535;1172.887;397.8445;1.6;False;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-827.2914,140.252;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;8;-658.5229,340.2602;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-664.2903,418.9288;Inherit;False;Property;_RollSpeed;RollSpeed;3;0;Create;True;0;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-462.5229,315.2602;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;7;-624.7943,185.2515;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-448.5229,227.2602;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;11;-300.5229,282.2602;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-433.7227,129.8601;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;22;-474.4874,38.95572;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-328.445,531.3099;Inherit;False;Property;_BarThickness;BarThickness;1;0;Create;True;0;0;0;False;0;False;0.1;0.216;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1062.699,-239.9258;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;None;6d85a1ed8e211e845bdb922731ae547d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;13;-112.6674,247.6257;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-507.0485,-262.7456;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;20;-588.5491,-104.3617;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;18;-287.2876,-229.4026;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;18,-22;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;19;7.450928,268.6383;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-219.0673,6.125656;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-103.7449,135.6572;Inherit;False;Property;_StaticAmount;StaticAmount;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-100.9487,-276.453;Inherit;True;Property;_NoiseTex;NoiseTex;4;0;Create;True;0;0;0;False;0;False;-1;7acb8f9a1f385b547857dcbff14d5598;7acb8f9a1f385b547857dcbff14d5598;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;15;-29.26733,21.72567;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;232.7,-22.1;Float;False;True;-1;2;ASEMaterialInspector;100;1;RollingRoll;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;9;0;8;0
WireConnection;9;1;2;0
WireConnection;7;0;6;0
WireConnection;10;0;7;1
WireConnection;10;1;9;0
WireConnection;11;0;10;0
WireConnection;12;0;7;0
WireConnection;12;1;11;0
WireConnection;22;0;12;0
WireConnection;4;1;22;0
WireConnection;13;0;11;0
WireConnection;13;1;3;0
WireConnection;20;0;4;0
WireConnection;18;0;17;0
WireConnection;19;0;13;0
WireConnection;14;0;20;0
WireConnection;14;1;19;0
WireConnection;5;1;18;0
WireConnection;15;0;14;0
WireConnection;15;1;5;0
WireConnection;15;2;1;0
WireConnection;0;0;15;0
ASEEND*/
//CHKSM=1BAD5A6ED3FFE453F48EC51D1E9D173EA18F0FF9