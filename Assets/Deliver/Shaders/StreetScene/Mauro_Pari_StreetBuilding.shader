// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mauro_Pari_StreetBuilding"
{
	Properties
	{
		_EdificioNoise("EdificioNoise", 2D) = "white" {}
		_Color0("Color 0", Color) = (0,0,0,1)
		_WallNormal("WallNormal", 2D) = "bump" {}
		_WallAlbedo("WallAlbedo", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _WallNormal;
		uniform float4 _WallNormal_ST;
		uniform sampler2D _EdificioNoise;
		uniform float4 _EdificioNoise_ST;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float4 _Color0;
		uniform sampler2D _WallAlbedo;
		uniform float4 _WallAlbedo_ST;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 VentanaNormal125 = UnpackScaleNormal( float4( 0,0,0,0 ), float3(0,0,1).x );
			float2 uv_WallNormal = i.uv_texcoord * _WallNormal_ST.xy + _WallNormal_ST.zw;
			float3 WallNormal121 = UnpackNormal( float4( UnpackNormal( tex2D( _WallNormal, uv_WallNormal ) ) , 0.0 ) );
			float2 uv_EdificioNoise = i.uv_texcoord * _EdificioNoise_ST.xy + _EdificioNoise_ST.zw;
			float4 tex2DNode2 = tex2D( _EdificioNoise, uv_EdificioNoise );
			float4 EdificioNoiseRef111 = tex2DNode2;
			float3 lerpResult107 = lerp( VentanaNormal125 , WallNormal121 , EdificioNoiseRef111.rgb);
			o.Normal = lerpResult107;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 appendResult53 = (float4(ase_grabScreenPosNorm.r , ase_grabScreenPosNorm.g , 0.0 , 0.0));
			float4 screenColor54 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult53.xy);
			float4 WindowAlbedoRef117 = screenColor54;
			float2 uv_WallAlbedo = i.uv_texcoord * _WallAlbedo_ST.xy + _WallAlbedo_ST.zw;
			float4 WallAlbedoRef130 = ( _Color0 * tex2D( _WallAlbedo, uv_WallAlbedo ) );
			float EdificioNoiseRchannel109 = tex2DNode2.r;
			float4 lerpResult42 = lerp( WindowAlbedoRef117 , WallAlbedoRef130 , EdificioNoiseRchannel109);
			o.Albedo = lerpResult42.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
880;73;1039;918;-1742.89;-953.7479;1.9;True;False
Node;AmplifyShaderEditor.CommentaryNode;129;1222.292,795.7467;Inherit;False;1304.954;356.4802;Tomamos la posición e imagen de la cámara y la multiplicamos por un color azulado para conseguir un efecto de reflejo;4;117;54;53;55;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;127;1484.746,1538.166;Inherit;False;788.4121;259.8154;Creamos un Normal Plano para la ventana;3;125;106;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;124;1463.834,1206.48;Inherit;False;812.8613;280;Aplicamos Normal de la textura de ladrillos/pared;3;95;89;121;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;114;1419.006,1862.402;Inherit;False;925.4304;367.3191;Noise del edificio, separa las ventanas del resto de la textura;4;2;109;111;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;131;1413.622,282.4444;Inherit;False;834.6652;470.2638;Aplicamos la textura de la pared con el color deseado;4;17;96;15;130;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GrabScreenPosition;55;1272.292,940.2269;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;96;1463.622,522.7078;Inherit;True;Property;_WallAlbedo;WallAlbedo;3;0;Create;True;0;0;0;False;0;False;-1;None;8f6cc1114ecd6a94ba47f5eb6e78dd54;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;1;1469.005,1999.721;Inherit;True;Property;_EdificioNoise;EdificioNoise;0;0;Create;True;0;0;0;False;0;False;fc30540ca2fe1d8418f41b7e1fc41760;fc30540ca2fe1d8418f41b7e1fc41760;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;17;1477.796,337.2901;Inherit;False;Property;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.4622642,0.2133395,0.119927,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;108;1534.746,1609.982;Inherit;False;Constant;_Vector1;Vector 1;6;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;95;1513.834,1256.48;Inherit;True;Property;_WallNormal;WallNormal;2;0;Create;True;0;0;0;False;0;False;-1;None;1222710ff14552e48b2bb2187fee79ef;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;1619.755,955.5662;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;106;1757.786,1588.166;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;2;1755.803,1987.756;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnpackScaleNormalNode;89;1834.15,1263.332;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;136;2436.97,1237.703;Inherit;False;946.4092;873.3824;Results;3;133;128;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenColorNode;54;1830.213,906.6074;Inherit;False;Global;_GrabScreen0;Grab Screen 0;10;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;1849.53,412.2725;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;2066.696,1258.646;Inherit;False;WallNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;128;2525.175,1720.326;Inherit;False;470.1899;333.7786;Combinamos los Normals aplicados correctamente al Noise ;4;122;112;126;107;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;2024.288,427.6417;Inherit;False;WallAlbedoRef;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;133;2486.97,1287.703;Inherit;False;545.5745;354.8475;Combinamos textura y color de pared, con textura reflectiva de ventanas y lo aplicamos correctamente al Noise para generar el albedo;4;113;118;132;42;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;2046.155,1670.477;Inherit;False;VentanaNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;2079.436,2070.521;Inherit;False;EdificioNoiseRchannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;2080.257,1931.402;Inherit;False;EdificioNoiseRef;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;117;2282.246,845.7467;Inherit;False;WindowAlbedoRef;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;2577.239,1770.326;Inherit;False;125;VentanaNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;2552.688,1332.914;Inherit;False;117;WindowAlbedoRef;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;113;2536.97,1526.549;Inherit;False;109;EdificioNoiseRchannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;2560.855,1436.983;Inherit;False;130;WallAlbedoRef;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;2585.522,1938.105;Inherit;False;111;EdificioNoiseRef;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;2575.175,1852.498;Inherit;False;121;WallNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;42;2850.544,1362.141;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;107;2813.365,1776.693;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3128.38,1425.522;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Mauro_Pari_StreetBuilding;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;53;0;55;1
WireConnection;53;1;55;2
WireConnection;106;1;108;0
WireConnection;2;0;1;0
WireConnection;89;0;95;0
WireConnection;54;0;53;0
WireConnection;15;0;17;0
WireConnection;15;1;96;0
WireConnection;121;0;89;0
WireConnection;130;0;15;0
WireConnection;125;0;106;0
WireConnection;109;0;2;1
WireConnection;111;0;2;0
WireConnection;117;0;54;0
WireConnection;42;0;118;0
WireConnection;42;1;132;0
WireConnection;42;2;113;0
WireConnection;107;0;126;0
WireConnection;107;1;122;0
WireConnection;107;2;112;0
WireConnection;0;0;42;0
WireConnection;0;1;107;0
ASEEND*/
//CHKSM=F49C01DD576522EB3A84B5F45971CF5F0863E4DC