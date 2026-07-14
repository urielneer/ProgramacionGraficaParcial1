// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Water"
{
	Properties
	{
		_WaveDirection("Wave Direction", Vector) = (0,0,0,0)
		_Frequency("Frequency", Range( 0.01 , 0.05)) = 0.01
		_Speed("Speed", Float) = 0
		_Amplitude("Amplitude", Float) = 0
		_ColorAngle("ColorAngle", Float) = 0
		_ColorScale("ColorScale", Float) = 4
		_WaterColorA("WaterColorA", Color) = (0,0.06952152,0.509434,0)
		_WaterColorB("WaterColorB", Color) = (0,0.2666605,0.6415094,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float2 _WaveDirection;
		uniform float _Frequency;
		uniform float _Speed;
		uniform float _Amplitude;
		uniform float4 _WaterColorA;
		uniform float4 _WaterColorB;
		uniform float _ColorScale;
		uniform float _ColorAngle;


		float2 voronoihash20( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi20( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash20( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, 0.0);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float dotResult5_g1 = dot( (ase_worldPos).xz , _WaveDirection );
			float WaveEffect14 = ( sin( ( ( dotResult5_g1 * _Frequency ) + ( _Time.y * _Speed ) ) ) * _Amplitude );
			float3 temp_cast_0 = (WaveEffect14).xxx;
			v.vertex.xyz += temp_cast_0;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float time20 = ( _Time.y * _ColorAngle );
			float2 coords20 = i.uv_texcoord * _ColorScale;
			float2 id20 = 0;
			float2 uv20 = 0;
			float fade20 = 0.5;
			float voroi20 = 0;
			float rest20 = 0;
			for( int it20 = 0; it20 <2; it20++ ){
			voroi20 += fade20 * voronoi20( coords20, time20, id20, uv20, 0 );
			rest20 += fade20;
			coords20 *= 2;
			fade20 *= 0.5;
			}//Voronoi20
			voroi20 /= rest20;
			float4 lerpResult26 = lerp( _WaterColorA , _WaterColorB , voroi20);
			float4 WaterColor30 = lerpResult26;
			o.Albedo = WaterColor30.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
197;73;847;382;3001.834;666.5656;3.935097;True;False
Node;AmplifyShaderEditor.CommentaryNode;31;-2339.107,-450.7148;Inherit;False;1192.933;726.2263;Water Color;9;26;22;23;21;24;20;28;27;30;Water Color;0,0.2362418,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;15;-859.9894,-891.1786;Inherit;False;1174.305;541.8028;WaveEffect;9;9;4;2;3;6;10;13;33;14;Wave Effect;0,0.6503696,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-2289.107,-13.89231;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2276.501,61.87524;Inherit;False;Property;_ColorAngle;ColorAngle;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-2100.173,-3.095904;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2100.003,109.4138;Inherit;False;Property;_ColorScale;ColorScale;10;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-826.4103,-611.9149;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;3;-621.497,-615.8807;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-653.9055,-693.8182;Inherit;False;Property;_Frequency;Frequency;6;0;Create;True;0;0;0;False;0;False;0.01;0;0.01;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-361.3217,-737.6205;Inherit;False;Property;_Speed;Speed;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-369.4605,-838.35;Inherit;False;Property;_Amplitude;Amplitude;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-383.8734,-463.6628;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;20;-1935.4,-26.48884;Inherit;True;0;0;1;3;2;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.ColorNode;28;-1946.115,-216.4883;Inherit;False;Property;_WaterColorB;WaterColorB;12;0;Create;True;0;0;0;False;0;False;0,0.2666605,0.6415094,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-1952.04,-400.7148;Inherit;False;Property;_WaterColorA;WaterColorA;11;0;Create;True;0;0;0;False;0;False;0,0.06952152,0.509434,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;4;-622.8033,-533.6862;Inherit;False;Property;_WaveDirection;Wave Direction;0;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;33;-152.8247,-669.6108;Inherit;False;WaveFunction;1;;1;e006864c249a68a468658f1ac54a744a;0;6;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT2;0,0;False;23;FLOAT2;0,0;False;24;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;-1656.607,-246.7687;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;125.6857,-684.6636;Inherit;False;WaveEffect;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-1370.173,-252.8558;Inherit;False;WaterColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;19;-254.7464,356.8542;Inherit;False;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-244.2271,282.0725;Inherit;False;14;WaveEffect;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-194.3148,-6.587402;Inherit;False;30;WaterColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;24;0
WireConnection;23;1;21;0
WireConnection;3;0;2;0
WireConnection;20;1;23;0
WireConnection;20;2;22;0
WireConnection;33;18;13;0
WireConnection;33;19;10;0
WireConnection;33;20;6;0
WireConnection;33;21;3;0
WireConnection;33;23;4;0
WireConnection;33;24;9;0
WireConnection;26;0;27;0
WireConnection;26;1;28;0
WireConnection;26;2;20;0
WireConnection;14;0;33;0
WireConnection;30;0;26;0
WireConnection;0;0;32;0
WireConnection;0;11;18;0
WireConnection;0;14;19;0
ASEEND*/
//CHKSM=36E1DEF45E0060F9ABCFE7803B9F02B6EA6061A3