// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Marcos_Serial_Ghost"
{
	Properties
	{
		_LineSpeed("LineSpeed", Range( 0 , 1)) = 0.400474
		_Frequency("Frequency", Float) = 10
		_GhostColor("GhostColor", Color) = (0,0,0,0)
		_Power("Power", Float) = 1
		_CambiaNoise("CambiaNoise", Float) = 0.2
		_Atmosphere("Atmosphere", 2D) = "white" {}
		_Ghost("Ghost", 2D) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float4 _GhostColor;
		uniform float _LineSpeed;
		uniform float _Frequency;
		uniform sampler2D _Atmosphere;
		uniform float _CambiaNoise;
		uniform float _Power;
		uniform sampler2D _Ghost;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime5 = _Time.y * _LineSpeed;
			float temp_output_10_0 = sin( ( ( ( 1.0 - ase_vertex3Pos.y ) + mulTime5 ) * ( _Frequency * 6.28318548202515 ) ) );
			float4 appendResult27 = (float4(0.0 , ( _CambiaNoise * _Time.y ) , 0.0 , 0.0));
			o.Albedo = saturate( ( ( _GhostColor * temp_output_10_0 ) * tex2D( _Atmosphere, appendResult27.xy ) ) ).rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV19 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode19 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV19, _Power ) );
			o.Alpha = saturate( ( ( temp_output_10_0 * ( 1.0 - pow( fresnelNode19 , _Power ) ) ) * tex2D( _Ghost, appendResult27.xy ) ) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
<<<<<<< HEAD:Assets/Parcial 1/Deliver/Marcos_Serial/Marcos_Serial_Ghost.shader
2162;73;816;540;1684.776;-50.85415;1.3;False;False
Node;AmplifyShaderEditor.CommentaryNode;39;-1776.192,175.265;Inherit;False;1078.64;477.4541;Scanlines;10;8;7;5;4;1;2;3;6;10;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;43;-1249.875,619.7164;Inherit;False;1055.389;302.335;Fresnel;4;41;32;19;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1700.192,225.2648;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1726.192,370.321;Inherit;False;Property;_LineSpeed;LineSpeed;0;0;Create;True;0;0;0;False;0;False;0.400474;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;41;-1234.875,921.0513;Inherit;False;955.3892;646.4213;Scrolling;6;30;24;25;27;20;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-743.5809,1207.464;Inherit;False;Property;_Power;Power;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;48;-1336.377,530.5544;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2;-1485.739,274.7229;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1470.882,377.4554;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1342.039,452.9173;Inherit;False;Property;_Frequency;Frequency;1;0;Create;True;0;0;0;False;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;19;-1029.009,669.7164;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1208.879,455.8481;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1249.293,258.7916;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-1104.119,1456.473;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1184.875,1202.456;Inherit;False;Property;_CambiaNoise;CambiaNoise;4;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1130.709,336.6306;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-602.4092,-172.1434;Inherit;False;793.6841;910.1691;Master(Mix Final );8;11;21;37;12;31;36;13;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;32;-780.9169,732.0601;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1008.679,1215.67;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-854.5042,1362.503;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SinOpNode;10;-895.5501,353.7311;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-552.4092,-42.4171;Inherit;False;Property;_GhostColor;GhostColor;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;46;-599.3788,739.4297;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-397.0972,467.0464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-276.7542,52.4769;Inherit;True;Property;_Atmosphere;Atmosphere;5;0;Create;True;0;0;0;False;0;False;-1;c7ae4a6c8bbb694419d4dac2e11c4b86;c7ae4a6c8bbb694419d4dac2e11c4b86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-437.3519,149.5155;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;35;-647.9351,1288.816;Inherit;True;Property;_Ghost;Ghost;6;0;Create;True;0;0;0;False;0;False;-1;163b47d1a73f00a4a8a590a1926e0834;163b47d1a73f00a4a8a590a1926e0834;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
=======
1920;73;1920;928;1808.292;102.4908;1.6;False;False
Node;AmplifyShaderEditor.CommentaryNode;39;-1776.192,175.265;Inherit;False;1078.64;477.4541;Scanlines;10;8;18;7;5;4;1;2;3;6;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1726.192,370.321;Inherit;False;Property;_LineSpeed;LineSpeed;0;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1700.192,225.2648;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;43;-1249.875,619.7164;Inherit;False;1055.389;302.335;Fresnel;3;41;32;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;2;-1485.739,274.7229;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;41;-1199.875,840.0513;Inherit;False;955.3892;646.4213;Scrolling;6;30;24;25;27;20;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1374.337,535.7192;Inherit;False;Constant;_TauManual;TauManual;3;0;Create;True;0;0;0;False;0;False;6.28318;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1342.039,452.9173;Inherit;False;Property;_Frequency;Frequency;1;0;Create;True;0;0;0;False;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1470.882,377.4554;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1208.879,455.8481;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1297.394,319.8914;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-708.5809,1126.464;Inherit;False;Property;_Power;Power;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-1069.119,1375.473;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1149.875,1121.456;Inherit;False;Property;_CambiaNoise;CambiaNoise;4;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;19;-1029.009,669.7164;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-602.4092,-172.1434;Inherit;False;793.6841;910.1691;Master(Mix Final );9;11;21;37;12;31;36;13;14;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-973.6787,1134.67;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1130.709,336.6306;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-819.5042,1281.503;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;11;-552.4092,-42.4171;Inherit;False;Property;_GhostColor;GhostColor;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;10;-895.5501,353.7311;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;-735.873,760.2125;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-437.3519,149.5155;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;35;-612.9351,1207.816;Inherit;True;Property;_Ghost;Ghost;6;0;Create;True;0;0;0;False;0;False;-1;163b47d1a73f00a4a8a590a1926e0834;163b47d1a73f00a4a8a590a1926e0834;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-268.9543,104.477;Inherit;True;Property;_Atmosphere;Atmosphere;5;0;Create;True;0;0;0;False;0;False;-1;c7ae4a6c8bbb694419d4dac2e11c4b86;c7ae4a6c8bbb694419d4dac2e11c4b86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-397.0972,467.0464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
>>>>>>> MarcosSerial:Assets/Deliver/Shaders/GhostScene/Marcos_Serial_Ghost.shader
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-64.34402,603.0256;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-210.08,-122.1434;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;13;26.27496,-28.3068;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
<<<<<<< HEAD:Assets/Parcial 1/Deliver/Marcos_Serial/Marcos_Serial_Ghost.shader
Node;AmplifyShaderEditor.SaturateNode;14;-221.7938,419.5857;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;239.8212,102.7929;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Custom/Marcos_Serial_Ghost;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;0;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;2
WireConnection;5;0;4;0
WireConnection;19;3;20;0
=======
Node;AmplifyShaderEditor.SimpleAddOpNode;38;36.80823,290.2608;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;226.0032,118.3382;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Custom/Marcos_Serial_Ghost;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;2
WireConnection;5;0;4;0
>>>>>>> MarcosSerial:Assets/Deliver/Shaders/GhostScene/Marcos_Serial_Ghost.shader
WireConnection;8;0;7;0
WireConnection;8;1;48;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
<<<<<<< HEAD:Assets/Parcial 1/Deliver/Marcos_Serial/Marcos_Serial_Ghost.shader
WireConnection;6;0;3;0
WireConnection;6;1;8;0
WireConnection;32;0;19;0
WireConnection;32;1;20;0
WireConnection;25;0;30;0
WireConnection;25;1;24;0
WireConnection;27;1;25;0
WireConnection;10;0;6;0
WireConnection;46;0;32;0
WireConnection;21;0;10;0
WireConnection;21;1;46;0
WireConnection;37;1;27;0
=======
WireConnection;19;3;20;0
WireConnection;25;0;30;0
WireConnection;25;1;24;0
WireConnection;6;0;3;0
WireConnection;6;1;8;0
WireConnection;27;1;25;0
WireConnection;10;0;6;0
WireConnection;32;0;19;0
WireConnection;32;1;20;0
>>>>>>> MarcosSerial:Assets/Deliver/Shaders/GhostScene/Marcos_Serial_Ghost.shader
WireConnection;12;0;11;0
WireConnection;12;1;10;0
WireConnection;35;1;27;0
WireConnection;37;1;27;0
WireConnection;21;0;10;0
WireConnection;21;1;32;0
WireConnection;31;0;21;0
WireConnection;31;1;35;0
WireConnection;36;0;12;0
WireConnection;36;1;37;0
WireConnection;13;0;36;0
WireConnection;14;0;31;0
WireConnection;0;0;13;0
WireConnection;0;9;14;0
ASEEND*/
<<<<<<< HEAD:Assets/Parcial 1/Deliver/Marcos_Serial/Marcos_Serial_Ghost.shader
//CHKSM=F8FD9F9A5D35E86656B5EDF380B7F526D0B5AB1B
=======
//CHKSM=1E13FC61E10B65F06C68EC4C277D96027AAD244D
>>>>>>> MarcosSerial:Assets/Deliver/Shaders/GhostScene/Marcos_Serial_Ghost.shader
