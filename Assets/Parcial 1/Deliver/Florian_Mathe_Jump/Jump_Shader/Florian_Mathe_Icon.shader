// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Florian_Mathe_Icon"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HDR]_Color_Base("Color_Base", Color) = (0,0.5490196,2.494118,0)
		_Pulse_Speed("Pulse_Speed", Range( 0.1 , 10)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Pulse_Speed;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float4 _Color_Base;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			//Calculate new billboard vertex position and normal;
			float3 upCamVec = normalize ( UNITY_MATRIX_V._m10_m11_m12 );
			float3 forwardCamVec = -normalize ( UNITY_MATRIX_V._m20_m21_m22 );
			float3 rightCamVec = normalize( UNITY_MATRIX_V._m00_m01_m02 );
			float4x4 rotationCamMatrix = float4x4( rightCamVec, 0, upCamVec, 0, forwardCamVec, 0, 0, 0, 0, 1 );
			v.normal = normalize( mul( float4( v.normal , 0 ), rotationCamMatrix )).xyz;
			//This unfortunately must be made to take non-uniform scaling into account;
			//Transform to world coords, apply rotation and transform back to local;
			v.vertex = mul( v.vertex , unity_ObjectToWorld );
			v.vertex = mul( v.vertex , rotationCamMatrix );
			v.vertex = mul( v.vertex , unity_WorldToObject );
			float TimeSin29 = sin( ( _Time.y * _Pulse_Speed ) );
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz += ( 0 + ( ( (0.9 + (TimeSin29 - -1.0) * (1.1 - 0.9) / (1.0 - -1.0)) * ase_vertex3Pos ) - ase_vertex3Pos ) );
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float TimeSin29 = sin( ( _Time.y * _Pulse_Speed ) );
			o.Emission = ( tex2D( _TextureSample0, uv_TextureSample0 ).a * ( _Color_Base * (0.5 + (TimeSin29 - -1.0) * (1.5 - 0.5) / (1.0 - -1.0)) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;53;1360;694;2284.45;501.0033;3.170385;True;True
Node;AmplifyShaderEditor.CommentaryNode;28;-1210.42,424.7607;Inherit;False;783.1482;303.4072;Base sinusoidal para animacion del icono;6;30;29;15;13;12;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1190.189,587.5757;Inherit;False;Property;_Pulse_Speed;Pulse_Speed;3;0;Create;True;0;0;0;False;0;False;1;5;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-1113.566,513.59;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-893.3702,535.1996;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;15;-755.8867,537.2326;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-622.1417,469.5841;Inherit;False;TimeSin;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;27;-285.6762,681.0001;Inherit;False;622.9317;427.8828;Escalado sinusoidal;4;21;23;24;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-606.0704,639.7875;Inherit;False;29;TimeSin;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;22;-234.1866,731.0001;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.9;False;4;FLOAT;1.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;31;-344.317,64.47266;Inherit;False;760.0001;561.8626;Color "intermitente";4;19;18;17;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;21;-235.6762,925.8828;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-34.06093,825.9218;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;19;-248.1095,419.3352;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-294.317,212.7168;Inherit;False;Property;_Color_Base;Color_Base;2;1;[HDR];Create;True;0;0;0;False;0;False;0,0.5490196,2.494118,0;0,1.655188,2.494118,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;171.2555,799.231;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-52.50908,216.0562;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-121.5974,-184.0451;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;d6ede71708e64450a9037213243072ca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BillboardNode;16;457.5569,474.6973;Inherit;False;Spherical;False;0;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;180.6832,114.4727;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;627.6912,560.9567;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;7;743.9933,76.36789;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Florian_Mathe_Icon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;4;1;False;-1;1;False;-1;0;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;10;0
WireConnection;13;1;12;0
WireConnection;15;0;13;0
WireConnection;29;0;15;0
WireConnection;22;0;30;0
WireConnection;23;0;22;0
WireConnection;23;1;21;0
WireConnection;19;0;29;0
WireConnection;24;0;23;0
WireConnection;24;1;21;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;20;0;8;4
WireConnection;20;1;18;0
WireConnection;26;0;16;0
WireConnection;26;1;24;0
WireConnection;7;2;20;0
WireConnection;7;11;26;0
ASEEND*/
//CHKSM=DFC287E5596047603212268E840D263C4B61E092