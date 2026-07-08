// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VHS_Error"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_StaticAmount("StaticAmount", Range( 0 , 1)) = 0.4
		_WaveSpeed("WaveSpeed", Range( 1 , 15)) = 8
		_WaveFreq("WaveFreq", Range( 1 , 30)) = 15
		_WaveAmp("WaveAmp", Range( 0 , 0.3)) = 0.05
		_ColorSplit("ColorSplit", Range( 0 , 0.08)) = 0.08

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
			uniform float _WaveFreq;
			uniform float _WaveSpeed;
			uniform float _WaveAmp;
			uniform float _ColorSplit;
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
				float2 texCoord17 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 break18 = texCoord17;
				float2 texCoord9 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult20 = (float2(( break18.x + ( sin( ( ( texCoord9.y * _WaveFreq ) + ( _Time.y * _WaveSpeed ) ) ) * _WaveAmp ) ) , break18.y));
				float2 appendResult26 = (float2(( appendResult20.x + _ColorSplit ) , break18.y));
				float3 temp_cast_0 = (tex2D( _MainTex, appendResult26 ).r).xxx;
				float3 desaturateInitialColor33 = temp_cast_0;
				float desaturateDot33 = dot( desaturateInitialColor33, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar33 = lerp( desaturateInitialColor33, desaturateDot33.xxx, 0.0 );
				float3 temp_cast_2 = (tex2D( _MainTex, appendResult20 ).g).xxx;
				float3 desaturateInitialColor35 = temp_cast_2;
				float desaturateDot35 = dot( desaturateInitialColor35, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar35 = lerp( desaturateInitialColor35, desaturateDot35.xxx, 0.0 );
				float2 appendResult28 = (float2(( appendResult20.x - _ColorSplit ) , break18.y));
				float3 temp_cast_4 = (tex2D( _MainTex, appendResult28 ).b).xxx;
				float3 desaturateInitialColor34 = temp_cast_4;
				float desaturateDot34 = dot( desaturateInitialColor34, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar34 = lerp( desaturateInitialColor34, desaturateDot34.xxx, 0.0 );
				float4 appendResult29 = (float4(desaturateVar33.x , desaturateVar35.x , desaturateVar34.xy));
				float2 texCoord31 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner32 = ( 1.0 * _Time.y * float2( 18,-22 ) + texCoord31);
				float4 lerpResult30 = lerp( appendResult29 , tex2D( _NoiseTex, panner32 ) , _StaticAmount);
				
				
				finalColor = lerpResult30;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
171;73;550;535;-929.4324;355.9878;1.289857;False;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-253.1373,147.9483;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-8.737218,181.7483;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleTimeNode;12;296.7632,354.6492;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;172.5117,452.3309;Inherit;False;Property;_WaveSpeed;WaveSpeed;3;0;Create;True;0;0;0;False;0;False;8;15;1;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-157.0886,357.631;Inherit;False;Property;_WaveFreq;WaveFreq;4;0;Create;True;0;0;0;False;0;False;15;10;1;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;356.5633,259.7495;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;174.5628,241.5483;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;391.6624,133.6485;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;15;519.0629,82.9483;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;518.7118,193.6306;Inherit;False;Property;_WaveAmp;WaveAmp;5;0;Create;True;0;0;0;False;0;False;0.05;0.003;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-45.1372,-88.86729;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;18;246.0623,-93.85173;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;656.8625,-21.05127;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;422.8625,-95.15178;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;584.0632,-290.8516;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;24;2.436523,-489.0743;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;7;-30.0477,-342.9832;Inherit;False;Property;_ColorSplit;ColorSplit;6;0;Create;True;0;0;0;False;0;False;0.08;0.035;0;0.08;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;212.4365,-474.0743;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;81.99145,-625.4877;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;252.291,-615.0878;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;343.7059,-441.2875;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;963.7581,-76.82117;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;532.7116,-622.2165;Inherit;True;Property;_MainTexR;MainTexR;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;345.5619,-825.3025;Inherit;True;Property;_MainTexB;MainTexB;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-363.5,-445.5926;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;fa848c05469974841be1fb631f2d63f5;fa848c05469974841be1fb631f2d63f5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;34;725.4656,-759.933;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DesaturateOpNode;35;-153.5344,-615.933;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DesaturateOpNode;33;910.3683,-575.4614;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;32;1183.519,-43.47815;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;18,-22;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;1011.661,-460.0897;Inherit;False;COLOR;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;1398.27,-155.9805;Inherit;True;Property;_NoiseTex;NoiseTex;1;0;Create;True;0;0;0;False;0;False;-1;7acb8f9a1f385b547857dcbff14d5598;7acb8f9a1f385b547857dcbff14d5598;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;803.3928,-205.8363;Inherit;False;Property;_StaticAmount;StaticAmount;2;0;Create;True;0;0;0;False;0;False;0.4;0.282;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;30;1203.866,-356.9083;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1418.095,-432.3228;Float;False;True;-1;2;ASEMaterialInspector;100;1;VHS_Error;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;10;0;9;0
WireConnection;13;0;12;0
WireConnection;13;1;4;0
WireConnection;11;0;10;1
WireConnection;11;1;5;0
WireConnection;14;0;11;0
WireConnection;14;1;13;0
WireConnection;15;0;14;0
WireConnection;18;0;17;0
WireConnection;16;0;15;0
WireConnection;16;1;6;0
WireConnection;19;0;18;0
WireConnection;19;1;16;0
WireConnection;20;0;19;0
WireConnection;20;1;18;1
WireConnection;24;0;20;0
WireConnection;25;0;24;0
WireConnection;25;1;7;0
WireConnection;27;0;24;0
WireConnection;27;1;7;0
WireConnection;28;0;27;0
WireConnection;28;1;18;1
WireConnection;26;0;25;0
WireConnection;26;1;18;1
WireConnection;22;1;26;0
WireConnection;23;1;28;0
WireConnection;1;1;20;0
WireConnection;34;0;23;3
WireConnection;35;0;1;2
WireConnection;33;0;22;1
WireConnection;32;0;31;0
WireConnection;29;0;33;0
WireConnection;29;1;35;0
WireConnection;29;2;34;0
WireConnection;2;1;32;0
WireConnection;30;0;29;0
WireConnection;30;1;2;0
WireConnection;30;2;3;0
WireConnection;0;0;30;0
ASEEND*/
//CHKSM=082A2F5C942F7731301B5749CB83DB87743EEC1C