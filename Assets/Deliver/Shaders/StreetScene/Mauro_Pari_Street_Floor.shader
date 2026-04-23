// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mauro_Pari_Street_Floor"
{
	Properties
	{
		_TexturaPisoPiedra("TexturaPisoPiedra", 2D) = "white" {}
		_TexturaPisoNormal("TexturaPisoNormal", 2D) = "bump" {}
		_AlbedoPiso("AlbedoPiso", 2D) = "white" {}
		_AlbedoTierra("AlbedoTierra", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_ParallaxStrength("ParallaxStrength", Float) = 0.02
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform sampler2D _AlbedoTierra;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _ParallaxStrength;
		uniform sampler2D _TexturaPisoPiedra;
		uniform float4 _TexturaPisoPiedra_ST;
		uniform sampler2D _TexturaPisoNormal;
		uniform sampler2D _AlbedoPiso;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_1 = (16.0).xxxx;
			return temp_cast_1;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 uv_TextureSample0 = v.texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 ase_worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
			half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
			float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * tangentSign;
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 ase_tanViewDir = mul( ase_worldToTangent, ase_worldViewDir );
			float4 appendResult52 = (float4(ase_tanViewDir.x , ase_tanViewDir.y , 0.0 , 0.0));
			float2 uv_TexCoord58 = v.texcoord.xy * float2( 8,8 ) + ( ( tex2Dlod( _TextureSample0, float4( uv_TextureSample0, 0, 0.0) ).r * _ParallaxStrength ) * appendResult52 ).xy;
			float4 tex2DNode47 = tex2Dlod( _AlbedoTierra, float4( uv_TexCoord58, 0, 0.0) );
			float2 uv_TexturaPisoPiedra = v.texcoord * _TexturaPisoPiedra_ST.xy + _TexturaPisoPiedra_ST.zw;
			float4 tex2DNode2 = tex2Dlod( _TexturaPisoPiedra, float4( uv_TexturaPisoPiedra, 0, 0.0) );
			float PisoNoiseRefR80 = tex2DNode2.r;
			float smoothstepResult83 = smoothstep( 0.07 , 0.07 , ( 1.0 - PisoNoiseRefR80 ));
			v.vertex.xyz += ( ( ( tex2DNode47.r * 0.06 ) * smoothstepResult83 ) * float3(0,1,0) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 appendResult52 = (float4(i.viewDir.x , i.viewDir.y , 0.0 , 0.0));
			float2 uv_TexCoord58 = i.uv_texcoord * float2( 8,8 ) + ( ( tex2D( _TextureSample0, uv_TextureSample0 ).r * _ParallaxStrength ) * appendResult52 ).xy;
			float4 tex2DNode47 = tex2D( _AlbedoTierra, uv_TexCoord58 );
			float3 tex2DNode3 = UnpackNormal( tex2D( _TexturaPisoNormal, uv_TexCoord58 ) );
			float2 uv_TexturaPisoPiedra = i.uv_texcoord * _TexturaPisoPiedra_ST.xy + _TexturaPisoPiedra_ST.zw;
			float4 tex2DNode2 = tex2D( _TexturaPisoPiedra, uv_TexturaPisoPiedra );
			float4 lerpResult60 = lerp( tex2DNode47 , CalculateContrast(0.5,float4( UnpackNormal( float4( tex2DNode3 , 0.0 ) ) , 0.0 )) , tex2DNode2);
			o.Normal = lerpResult60.rgb;
			float4 AlbedoTierra71 = CalculateContrast(1.9,tex2DNode47);
			float4 lerpResult9 = lerp( AlbedoTierra71 , tex2D( _AlbedoPiso, uv_TexCoord58 ) , tex2DNode2);
			o.Albedo = lerpResult9.rgb;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Smoothness = ( tex2D( _TextureSample1, uv_TextureSample1 ).r * 2.5 );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.worldPos = worldPos;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
763;73;1156;918;403.6229;-168.95;1;True;False
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;48;-1783.168,796.6674;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;55;-1738.281,696.8257;Inherit;False;Property;_ParallaxStrength;ParallaxStrength;5;0;Create;True;0;0;0;False;0;False;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;54;-1800.481,500.1897;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;None;a0ba43f29bb76c44abe1da969219a3ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;52;-1549.623,790.5435;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1409.281,507.8255;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;583.2914,735.0768;Inherit;True;Property;_TexturaPisoPiedra;TexturaPisoPiedra;0;0;Create;True;0;0;0;False;0;False;-1;eacfe5a54f2eaab4d83ae4d780b076cb;eacfe5a54f2eaab4d83ae4d780b076cb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-1225.834,535.0623;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;962.3602,866.71;Inherit;False;PisoNoiseRefR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;59;-1114.174,388.7365;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;8,8;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;73;-255.0665,529.6107;Inherit;False;80;PisoNoiseRefR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-814.3515,467.2856;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-205.1056,426.9923;Inherit;False;Constant;_HeightScale;HeightScale;7;0;Create;True;0;0;0;False;0;False;0.06;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-158.6795,956.9587;Inherit;True;Property;_TexturaPisoNormal;TexturaPisoNormal;1;0;Create;True;0;0;0;False;0;False;-1;eacfe5a54f2eaab4d83ae4d780b076cb;6f61d17e1a557be459e7e5c443ee4a29;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;81;-75.03991,531.3102;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;89;-456.7312,16.75761;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;47;-323.3759,135.9799;Inherit;True;Property;_AlbedoTierra;AlbedoTierra;3;0;Create;True;0;0;0;False;0;False;-1;None;cc390f9ea16fc4df092cb67b7fe6fd7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleContrastOpNode;64;156.1698,178.4874;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;1.9;False;1;COLOR;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;4;246.6288,988.6906;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SmoothstepOpNode;83;120.1539,500.7329;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.07;False;2;FLOAT;0.07;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-179.811,-171.6383;Inherit;True;Property;_AlbedoPiso;AlbedoPiso;2;0;Create;True;0;0;0;False;0;False;-1;None;26795b2541ef42b4d98f8c2cf2cfdf91;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;145.6055,356.7874;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;74;48.23884,721.517;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;318.5151,421.4736;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;82;182.7955,626.2737;Inherit;False;Constant;_Vector1;Vector 1;7;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;65;737.0042,1124.875;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleContrastOpNode;62;515.0272,1023.082;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;67;831.4232,1309.77;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;2.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;68;757.53,-19.8872;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;71;401.3983,222.6125;Inherit;False;AlbedoTierra;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;483.9167,524.5608;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;86;-764.1451,292.156;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;85;-998.6036,233.2979;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;1078.633,1167.149;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;1301.045,1094.452;Inherit;False;Constant;_Tesselation;Tesselation;7;0;Create;True;0;0;0;False;0;False;16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;60;1015.46,960.895;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;9;1085.93,550.4477;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;84;-1229.404,139.1978;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1452.094,631.9246;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Mauro_Pari_Street_Floor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;52;0;48;1
WireConnection;52;1;48;2
WireConnection;56;0;54;1
WireConnection;56;1;55;0
WireConnection;57;0;56;0
WireConnection;57;1;52;0
WireConnection;80;0;2;1
WireConnection;58;0;59;0
WireConnection;58;1;57;0
WireConnection;3;1;58;0
WireConnection;81;0;73;0
WireConnection;89;0;58;0
WireConnection;47;1;58;0
WireConnection;64;1;47;0
WireConnection;4;0;3;0
WireConnection;83;0;81;0
WireConnection;12;1;89;0
WireConnection;69;0;47;1
WireConnection;69;1;70;0
WireConnection;74;0;47;0
WireConnection;72;0;69;0
WireConnection;72;1;83;0
WireConnection;62;1;4;0
WireConnection;68;0;12;0
WireConnection;71;0;64;0
WireConnection;76;0;72;0
WireConnection;76;1;82;0
WireConnection;86;0;85;0
WireConnection;85;0;84;1
WireConnection;85;2;84;3
WireConnection;66;0;65;1
WireConnection;66;1;67;0
WireConnection;60;0;74;0
WireConnection;60;1;62;0
WireConnection;60;2;2;0
WireConnection;9;0;71;0
WireConnection;9;1;68;0
WireConnection;9;2;2;0
WireConnection;0;0;9;0
WireConnection;0;1;60;0
WireConnection;0;4;66;0
WireConnection;0;11;76;0
WireConnection;0;14;79;0
ASEEND*/
//CHKSM=CB277918E88617602C4C23BBE54B952B4B2E2CEC