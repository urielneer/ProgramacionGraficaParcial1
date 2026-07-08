// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/MonitorInterference"
{
	Properties
	{
		_Curvature("Curvature", Range( 0 , 0.4)) = 0
		_MainTex("_MainTex", 2D) = "bump" {}
		_ScanlineCount("ScanlineCount", Range( 0 , 400)) = 57.14444
		_ScanlineSpeed("ScanlineSpeed", Range( 0 , 4)) = 2.868261
		_StaticAmount("StaticAmount", Range( 0 , 1)) = 0.44
		_NoiseTex("NoiseTex", 2D) = "white" {}
		[Toggle(_TOGGLESCAN_ON)] _ToggleScan("ToggleScan", Float) = 0
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
		#pragma shader_feature_local _TOGGLESCAN_ON
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _MainTex;
		uniform float _Curvature;
		uniform sampler2D _NoiseTex;
		uniform float _StaticAmount;
		uniform float _ScanlineSpeed;
		uniform float _ScanlineCount;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (0.5).xx;
			float2 temp_output_2_0 = ( i.uv_texcoord - temp_cast_0 );
			float4 appendResult37 = (float4(( temp_output_2_0.x * 1.33 ) , 0.0 , 0.0 , 0.0));
			float2 temp_cast_1 = (0.5).xx;
			float2 Screen43 = ( ( pow( ( length( appendResult37 ) * _Curvature ) , 2.0 ) * temp_output_2_0 ) + i.uv_texcoord );
			float2 panner33 = ( 1.0 * _Time.y * float2( 17,-23 ) + Screen43);
			float4 lerpResult29 = lerp( tex2D( _MainTex, ( 1.0 - Screen43 ) ) , tex2D( _NoiseTex, panner33 ) , _StaticAmount);
			float mulTime23 = _Time.y * _ScanlineSpeed;
			float ScanLines42 = sin( ( ( ( 1.0 - Screen43.y ) + mulTime23 ) * ( _ScanlineCount * 1.0 ) ) );
			#ifdef _TOGGLESCAN_ON
				float staticSwitch66 = ScanLines42;
			#else
				float staticSwitch66 = 1.0;
			#endif
			o.Emission = ( lerpResult29 * staticSwitch66 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
175;73;869;382;-891.1741;226.3064;1.84076;True;False
Node;AmplifyShaderEditor.CommentaryNode;44;-1057.315,-721.8622;Inherit;False;2216.283;491.7119;Screen;18;11;10;6;5;7;37;1;38;35;34;36;2;3;8;9;39;43;50;Screen;0,0.7176819,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1007.315,-481.5068;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;38;-822.5308,-604.0059;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-788.2582,-595.7842;Inherit;False;Constant;_HalfScreen;HalfScreen;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2;-645.3002,-621.3566;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-480.7588,-542.8656;Inherit;False;Constant;_AspectCorrection;AspectCorrection;6;0;Create;True;0;0;0;False;0;False;1.33;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;34;-443.1439,-658.4656;Inherit;False;FLOAT;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-277.4355,-627.2443;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-140.635,-617.5168;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-25.46133,-505.5643;Inherit;False;Property;_Curvature;Curvature;0;0;Create;True;0;0;0;False;0;False;0;0;0;0.4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;5;82.327,-593.6876;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;243.7584,-446.9757;Inherit;False;Constant;_Powerx2;Powerx2;1;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;243.9047,-557.0593;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;440.4439,-458.2593;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;50;-514.8735,-438.4799;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;618.4351,-403.0366;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;39;-512.0929,-335.4944;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;748.7979,-365.15;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;941.6207,-382.2838;Inherit;False;Screen;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;61;-601.5692,-134.2004;Inherit;False;1207.032;435.3217;Scan Lines;11;56;58;25;22;59;23;24;26;21;27;42;Scan Lines;0.8147678,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-551.5692,-84.20038;Inherit;False;43;Screen;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-550.2737,73.2437;Inherit;False;Property;_ScanlineSpeed;ScanlineSpeed;3;0;Create;True;0;0;0;False;0;False;2.868261;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;58;-395.3558,-75.19427;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleTimeNode;23;-274.4222,58.65031;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;59;-278.0199,-49.6292;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-401.774,185.1213;Inherit;False;Property;_ScanlineCount;ScanlineCount;2;0;Create;True;0;0;0;False;0;False;57.14444;200;0;400;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-118.5048,-22.5907;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-82.79478,153.5874;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;44.5051,-21.9636;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;1306.494,-133.4777;Inherit;False;43;Screen;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;27;224.5046,-22.26206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;1285.249,-342.7606;Inherit;False;43;Screen;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;33;1494.84,-128.1187;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;17,-23;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;60;1494.184,-330.1205;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;381.4633,-25.6016;Inherit;True;ScanLines;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;1832.925,115.7649;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;32;1694.858,-155.9466;Inherit;True;Property;_NoiseTex;NoiseTex;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;1679.803,-365.3611;Inherit;True;Property;_MainTex;_MainTex;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;1676.718,44.30196;Inherit;False;Property;_StaticAmount;StaticAmount;4;0;Create;True;0;0;0;False;0;False;0.44;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;1809.264,208.5582;Inherit;False;42;ScanLines;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;2084.074,-174.5451;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;66;2047.221,90.20736;Inherit;False;Property;_ToggleScan;ToggleScan;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;2319.469,-83.01514;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2460.172,-131.7893;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Custom/MonitorInterference;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;1;0
WireConnection;2;0;38;0
WireConnection;2;1;3;0
WireConnection;34;0;2;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;37;0;36;0
WireConnection;5;0;37;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;50;0;2;0
WireConnection;10;0;8;0
WireConnection;10;1;50;0
WireConnection;39;0;1;0
WireConnection;11;0;10;0
WireConnection;11;1;39;0
WireConnection;43;0;11;0
WireConnection;58;0;56;0
WireConnection;23;0;25;0
WireConnection;59;0;58;1
WireConnection;26;0;59;0
WireConnection;26;1;23;0
WireConnection;24;0;22;0
WireConnection;21;0;26;0
WireConnection;21;1;24;0
WireConnection;27;0;21;0
WireConnection;33;0;49;0
WireConnection;60;0;48;0
WireConnection;42;0;27;0
WireConnection;32;1;33;0
WireConnection;13;1;60;0
WireConnection;29;0;13;0
WireConnection;29;1;32;0
WireConnection;29;2;30;0
WireConnection;66;1;67;0
WireConnection;66;0;47;0
WireConnection;31;0;29;0
WireConnection;31;1;66;0
WireConnection;0;2;31;0
ASEEND*/
//CHKSM=88FF8155B375D91FCB0DAAC5D1191F7F1B629154