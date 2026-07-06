// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/MonitorInterference"
{
	Properties
	{
		_Curvature("Curvature", Range( 0 , 0.4)) = 0.15
		_MainTex("_MainTex", 2D) = "bump" {}
		_ScanlineCount("ScanlineCount", Range( 0 , 400)) = 0
		_ScanlineSpeed("ScanlineSpeed", Range( 1 , 4)) = 2
		_StaticAmount("StaticAmount", Range( 0 , 1)) = 0.44
		_NoiseTex("NoiseTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _MainTex;
		uniform float _Curvature;
		uniform sampler2D _NoiseTex;
		uniform float _StaticAmount;
		uniform float _ScanlineCount;
		uniform float _ScanlineSpeed;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (0.5).xx;
			float2 temp_output_2_0 = ( i.uv_texcoord - temp_cast_0 );
			float2 break34 = temp_output_2_0;
			float4 appendResult37 = (float4(( break34.x * 1.33 ) , break34.y , 0.0 , 0.0));
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_11_0 = ( ( pow( ( length( appendResult37 ) * _Curvature ) , 2.0 ) * temp_output_2_0 ) + i.uv_texcoord );
			float2 temp_cast_3 = (0.5).xx;
			float2 panner33 = ( 1.0 * _Time.y * float2( 17,-23 ) + temp_output_11_0);
			float4 lerpResult29 = lerp( float4( UnpackNormal( tex2D( _MainTex, temp_output_11_0 ) ) , 0.0 ) , tex2D( _NoiseTex, panner33 ) , _StaticAmount);
			float2 temp_cast_4 = (0.5).xx;
			o.Emission = ( lerpResult29 * (0.4 + (sin( ( ( temp_output_11_0.y * _ScanlineCount ) + ( _Time.y * _ScanlineSpeed ) ) ) - -1.0) * (1.0 - 0.4) / (1.0 - -1.0)) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
8;81;1904;904;299.8652;216.8807;1.003106;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;112.3,7.000015;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;142.5,206;Inherit;False;Constant;_HalfScreen;HalfScreen;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2;282.2666,126.1273;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;34;365.1941,223.483;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;35;264.8833,343.8557;Inherit;False;Constant;_AspectCorrection;AspectCorrection;6;0;Create;True;0;0;0;False;0;False;1.33;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;431.399,254.5786;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;562.8056,382.9771;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;7;621.5,277;Inherit;False;Property;_Curvature;Curvature;0;0;Create;True;0;0;0;False;0;False;0.15;0;0;0.4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;5;603.6183,151.109;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;727.5,118;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;935.5,241;Inherit;False;Constant;_Powerx2;Powerx2;1;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;958.5,93;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;1134.5,13;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;1273.5,107;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;1857.733,575.918;Inherit;False;Property;_ScanlineSpeed;ScanlineSpeed;3;0;Create;True;0;0;0;False;0;False;2;0;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;23;1771.733,513.918;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;1439.733,428.918;Inherit;False;Property;_ScanlineCount;ScanlineCount;2;0;Create;True;0;0;0;False;0;False;0;200;0;400;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;20;1446.733,281.918;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;1948.733,470.918;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;1643.733,328.918;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;1794.733,311.918;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;33;1551.397,-185.3054;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;17,-23;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;27;1619.733,241.918;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;32;1727.506,-215.121;Inherit;True;Property;_NoiseTex;NoiseTex;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;1420.628,-15.7884;Inherit;True;Property;_MainTex;_MainTex;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;1874.464,129.4711;Inherit;False;Property;_StaticAmount;StaticAmount;4;0;Create;True;0;0;0;False;0;False;0.44;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;2032.703,8.465426;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;1757.603,199.5885;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.4;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;2217.314,99.99545;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2460.172,-131.7893;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Custom/MonitorInterference;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;34;0;2;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;37;0;36;0
WireConnection;37;1;34;1
WireConnection;5;0;37;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;10;0;8;0
WireConnection;10;1;2;0
WireConnection;11;0;10;0
WireConnection;11;1;1;0
WireConnection;20;0;11;0
WireConnection;24;0;23;0
WireConnection;24;1;25;0
WireConnection;21;0;20;1
WireConnection;21;1;22;0
WireConnection;26;0;21;0
WireConnection;26;1;24;0
WireConnection;33;0;11;0
WireConnection;27;0;26;0
WireConnection;32;1;33;0
WireConnection;13;1;11;0
WireConnection;29;0;13;0
WireConnection;29;1;32;0
WireConnection;29;2;30;0
WireConnection;28;0;27;0
WireConnection;31;0;29;0
WireConnection;31;1;28;0
WireConnection;0;2;31;0
ASEEND*/
//CHKSM=273975127FC2FE9B195A76EB725B5E95A3A04B4B