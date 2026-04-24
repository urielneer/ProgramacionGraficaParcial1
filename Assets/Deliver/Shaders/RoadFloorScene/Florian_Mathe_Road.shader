// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Florian_Mathe_Road"
{
	Properties
	{
		_Tiling_Dirt("Tiling_Dirt", Float) = 0.5
		_Albedo_Dirt("Albedo_Dirt", 2D) = "white" {}
		_Normal_Dirt("Normal_Dirt", 2D) = "white" {}
		_Albedo_Paving("Albedo_Paving", 2D) = "white" {}
		_Normal_Paving("Normal_Paving", 2D) = "white" {}
		_Paving_Tiling("Paving_Tiling", Float) = 0.3
		_Voronoi_Scale("Voronoi_Scale", Float) = 0
		_Pavement_Size("Pavement_Size", Range( 0 , 1)) = 0
		_Voronoi_Angle("Voronoi_Angle", Range( 0 , 16)) = 0
		_Pavement_Border("Pavement_Border", Range( 0 , 1)) = 0.78
		_Paving_Deformation("Paving_Deformation", Range( 0 , 1)) = 0
		_Paving_Height("Paving_Height", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _Pavement_Size;
		uniform float _Pavement_Border;
		uniform float _Voronoi_Angle;
		uniform float _Voronoi_Scale;
		uniform float _Paving_Deformation;
		uniform float _Paving_Height;
		uniform sampler2D _Normal_Dirt;
		uniform float _Tiling_Dirt;
		uniform sampler2D _Normal_Paving;
		uniform float _Paving_Tiling;
		uniform sampler2D _Albedo_Dirt;
		uniform sampler2D _Albedo_Paving;


		float2 voronoihash24( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi24( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
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
			 		float2 o = voronoihash24( n + g );
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
			return F1;
		}


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, 0.01);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float time24 = _Voronoi_Angle;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult22 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_23_0 = ( appendResult22 * _Voronoi_Scale );
			float simplePerlin2D30 = snoise( temp_output_23_0 );
			simplePerlin2D30 = simplePerlin2D30*0.5 + 0.5;
			float2 coords24 = ( temp_output_23_0 + ( simplePerlin2D30 * _Paving_Deformation ) ) * 1.0;
			float2 id24 = 0;
			float2 uv24 = 0;
			float voroi24 = voronoi24( coords24, time24, id24, uv24, 0 );
			float smoothstepResult26 = smoothstep( _Pavement_Size , _Pavement_Border , voroi24);
			float temp_output_29_0 = ( 1.0 - smoothstepResult26 );
			float3 appendResult41 = (float3(0.0 , ( temp_output_29_0 * _Paving_Height ) , 0.0));
			v.vertex.xyz += appendResult41;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult10 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_5_0 = ( appendResult10 * _Tiling_Dirt );
			float2 appendResult13 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_14_0 = ( appendResult13 * _Paving_Tiling );
			float time24 = _Voronoi_Angle;
			float2 appendResult22 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_23_0 = ( appendResult22 * _Voronoi_Scale );
			float simplePerlin2D30 = snoise( temp_output_23_0 );
			simplePerlin2D30 = simplePerlin2D30*0.5 + 0.5;
			float2 coords24 = ( temp_output_23_0 + ( simplePerlin2D30 * _Paving_Deformation ) ) * 1.0;
			float2 id24 = 0;
			float2 uv24 = 0;
			float voroi24 = voronoi24( coords24, time24, id24, uv24, 0 );
			float smoothstepResult26 = smoothstep( _Pavement_Size , _Pavement_Border , voroi24);
			float temp_output_29_0 = ( 1.0 - smoothstepResult26 );
			float4 lerpResult37 = lerp( tex2D( _Normal_Dirt, temp_output_5_0 ) , tex2D( _Normal_Paving, temp_output_14_0 ) , temp_output_29_0);
			o.Normal = lerpResult37.rgb;
			float4 lerpResult36 = lerp( tex2D( _Albedo_Dirt, temp_output_5_0 ) , tex2D( _Albedo_Paving, temp_output_14_0 ) , temp_output_29_0);
			o.Albedo = lerpResult36.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
295;165;1360;694;272.4097;-561.5928;1.673357;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;21;-1390.63,1303.781;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;20;-1356.913,1479.922;Inherit;False;Property;_Voronoi_Scale;Voronoi_Scale;6;0;Create;True;0;0;0;False;0;False;0;1.79;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-1198.404,1312.886;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1041.469,1394.994;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;30;-884.4714,1544.213;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-959.4716,1691.214;Inherit;False;Property;_Paving_Deformation;Paving_Deformation;10;0;Create;True;0;0;0;False;0;False;0;0.12;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-668.4715,1597.213;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-514.4055,1560.091;Inherit;False;Property;_Voronoi_Angle;Voronoi_Angle;8;0;Create;True;0;0;0;False;0;False;0;0;0;16;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-561.3083,1382.836;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-520.069,236.2827;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;11;-494.983,717.8038;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;28;-71.6001,1571.819;Inherit;False;Property;_Pavement_Border;Pavement_Border;9;0;Create;True;0;0;0;False;0;False;0.78;0.08;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-57.39142,1463.119;Inherit;False;Property;_Pavement_Size;Pavement_Size;7;0;Create;True;0;0;0;False;0;False;0;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;24;-301.5904,1388.26;Inherit;False;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.DynamicAppendNode;13;-302.757,726.9092;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-327.843,245.3882;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-380.4521,474.0369;Inherit;False;Property;_Tiling_Dirt;Tiling_Dirt;0;0;Create;True;0;0;0;False;0;False;0.5;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-314.84,1006.883;Inherit;False;Property;_Paving_Tiling;Paving_Tiling;5;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;26;213.2453,1387.253;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;29;390.2977,1291.418;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;466.1488,1459.358;Inherit;False;Property;_Paving_Height;Paving_Height;11;0;Create;True;0;0;0;False;0;False;0;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-128.7412,835.1636;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-153.827,353.6425;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;8;29.99684,305.1194;Inherit;True;Property;_Albedo_Dirt;Albedo_Dirt;1;0;Create;True;0;0;0;False;0;False;-1;None;cc390f9ea16fc4df092cb67b7fe6fd7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;644.9077,1388.981;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;11.78023,991.9439;Inherit;True;Property;_Normal_Paving;Normal_Paving;4;0;Create;True;0;0;0;False;0;False;-1;None;cbb3bec6b0cf141a5b6b5bcb2d8bc344;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;30.04231,523.2116;Inherit;True;Property;_Normal_Dirt;Normal_Dirt;2;0;Create;True;0;0;0;False;0;False;-1;None;ed6deb81e7c7743c4a43c982119fcdcb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;5.556412,785.2974;Inherit;True;Property;_Albedo_Paving;Albedo_Paving;3;0;Create;True;0;0;0;False;0;False;-1;None;0c9deafa7055d459db1f98886568e20e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;36;536.5427,672.8514;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;41;796.923,1356.608;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;37;544.2275,828.8129;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;42;708.0281,990.0029;Inherit;False;1;0;FLOAT;0.01;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;962.2057,657.111;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Florian_Mathe_Road;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;0;20;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;21;1
WireConnection;22;1;21;3
WireConnection;23;0;22;0
WireConnection;23;1;20;0
WireConnection;30;0;23;0
WireConnection;32;0;30;0
WireConnection;32;1;31;0
WireConnection;33;0;23;0
WireConnection;33;1;32;0
WireConnection;24;0;33;0
WireConnection;24;1;25;0
WireConnection;13;0;11;1
WireConnection;13;1;11;3
WireConnection;10;0;1;1
WireConnection;10;1;1;3
WireConnection;26;0;24;0
WireConnection;26;1;27;0
WireConnection;26;2;28;0
WireConnection;29;0;26;0
WireConnection;14;0;13;0
WireConnection;14;1;17;0
WireConnection;5;0;10;0
WireConnection;5;1;3;0
WireConnection;8;1;5;0
WireConnection;40;0;29;0
WireConnection;40;1;38;0
WireConnection;19;1;14;0
WireConnection;9;1;5;0
WireConnection;18;1;14;0
WireConnection;36;0;8;0
WireConnection;36;1;18;0
WireConnection;36;2;29;0
WireConnection;41;1;40;0
WireConnection;37;0;9;0
WireConnection;37;1;19;0
WireConnection;37;2;29;0
WireConnection;0;0;36;0
WireConnection;0;1;37;0
WireConnection;0;11;41;0
WireConnection;0;14;42;0
ASEEND*/
//CHKSM=192BB401C280503F603302643338522FA160573E