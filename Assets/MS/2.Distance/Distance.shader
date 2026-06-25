// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Distance"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_CutoutSize("_CutoutSize ", Range( 0 , 0.135)) = 0.1
		_OffsetBorder("_OffsetBorder", Range( 0 , 0.2)) = 0.2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPosition;
		};

		uniform float2 _PlayerScreenPos;
		uniform float _CutoutSize;
		uniform float _OffsetBorder;
		uniform float _Cutoff = 0.5;


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float temp_output_4_0 = ( distance( ase_screenPosNorm , float4( _PlayerScreenPos, 0.0 , 0.0 ) ) - _CutoutSize );
			float4 color19 = IsGammaSpace() ? float4(1,0.5001359,0,1) : float4(1,0.2141669,0,1);
			o.Emission = ( ( 1.0 - ( temp_output_4_0 - _OffsetBorder ) ) * color19 ).rgb;
			o.Alpha = 1;
			float2 clipScreen7 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither7 = Dither4x4Bayer( fmod(clipScreen7.x, 4), fmod(clipScreen7.y, 4) );
			float smoothstepResult6 = smoothstep( 0.0 , 1.0 , temp_output_4_0);
			dither7 = step( dither7, smoothstepResult6 );
			clip( dither7 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
178;81;707;527;-248.9314;638.0294;1.6;False;False
Node;AmplifyShaderEditor.CommentaryNode;30;35.72865,-208.6979;Inherit;False;1114.477;508.6625;Agujero por Posicion;7;1;3;2;4;5;6;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;1;85.72865,-158.698;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;3;95.31036,-0.3365328;Inherit;False;Global;_PlayerScreenPos;_PlayerScreenPos;1;0;Create;True;0;0;0;False;0;False;0.5,0.5;0.5,0.4234386;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;28;42.4004,-553.821;Inherit;False;1091.836;350.2817;Borde;5;22;27;17;18;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;2;292.8932,-116.4372;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;323.8187,-24.95874;Inherit;False;Property;_CutoutSize;_CutoutSize ;1;0;Create;True;0;0;0;False;0;False;0.1;0;0;0.135;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;92.40043,-400.5694;Inherit;False;Property;_OffsetBorder;_OffsetBorder;2;0;Create;True;0;0;0;False;0;False;0.2;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;428.2463,-113.6896;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;400.6476,-404.052;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;534.2546,-503.8203;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;570.389,-415.5386;Inherit;False;Constant;_Color2;Color 2;4;0;Create;True;0;0;0;False;0;False;1,0.5001359,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;6;624.5237,-96.46519;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;730.0916,-481.8729;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DitheringNode;7;826.7266,-100.8867;Inherit;False;0;False;4;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;3;SAMPLERSTATE;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1176.457,-382.1542;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Custom/Distance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;4;0;2;0
WireConnection;4;1;5;0
WireConnection;27;0;4;0
WireConnection;27;1;22;0
WireConnection;17;0;27;0
WireConnection;6;0;4;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;7;0;6;0
WireConnection;0;2;18;0
WireConnection;0;10;7;0
ASEEND*/
//CHKSM=5158C4E04A472DD41E6822978516C60E5D96927F