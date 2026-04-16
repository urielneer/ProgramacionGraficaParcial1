// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mateo_Chavit_Water"
{
	Properties
	{
		_VoronoiSpeed("Voronoi Speed", Range( 0 , 4)) = 0
		_OffsetSpeed("Offset Speed", Range( 0 , 4)) = 0
		_VoronoiScale("Voronoi Scale", Float) = 0
		_Color1("Color 1", Color) = (0,0,0,0)
		_Offset("Offset", Vector) = (1,0.5,0,0)
		_Color2("Color 2", Color) = (0,0,0,0)
		_Max("Max", Range( 0 , 1)) = 0
		_Min("Min", Range( 0 , 1)) = 0
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_OffsetScale("Offset Scale", Range( 0 , 3)) = 3
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
			float2 uv_texcoord;
		};

		uniform float _Min;
		uniform float _Max;
		uniform float2 _Offset;
		uniform float _OffsetSpeed;
		uniform float _OffsetScale;
		uniform float3 _Vector0;
		uniform float4 _Color1;
		uniform float4 _Color2;
		uniform float _VoronoiScale;
		uniform float _VoronoiSpeed;


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


		float2 voronoihash2( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi2( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
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
			 		float2 o = voronoihash2( n + g );
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


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, 0.0);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float simplePerlin2D27 = snoise( (v.texcoord.xy*1.0 + ( _Time.y * _Offset * _OffsetSpeed ))*_OffsetScale );
			simplePerlin2D27 = simplePerlin2D27*0.5 + 0.5;
			float smoothstepResult18 = smoothstep( _Min , _Max , ( 1.0 - simplePerlin2D27 ));
			v.vertex.xyz += ( smoothstepResult18 * _Vector0 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float time2 = ( _Time.y * _VoronoiSpeed );
			float2 coords2 = i.uv_texcoord * _VoronoiScale;
			float2 id2 = 0;
			float2 uv2 = 0;
			float voroi2 = voronoi2( coords2, time2, id2, uv2, 0 );
			float4 lerpResult1 = lerp( _Color1 , _Color2 , voroi2);
			o.Albedo = lerpResult1.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
258;73;783;374;1385.997;561.757;2.413648;False;False
Node;AmplifyShaderEditor.CommentaryNode;28;-1967.11,241.3539;Inherit;False;1721.18;456.6123;Wave effect;14;9;12;10;15;13;25;14;27;20;17;19;22;18;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-1867.11,393.9661;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;12;-1850.38,459.2103;Inherit;False;Property;_Offset;Offset;4;0;Create;True;0;0;0;False;0;False;1,0.5;1,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;10;-1917.11,581.9656;Inherit;False;Property;_OffsetSpeed;Offset Speed;1;0;Create;True;0;0;0;False;0;False;0;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;15;-1632.087,291.3539;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1603.939,420.9191;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;29;-1170.627,-425.188;Inherit;False;1152;639.8825;Water texture;8;5;4;3;6;7;8;2;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1419.366,479.6655;Inherit;False;Property;_OffsetScale;Offset Scale;9;0;Create;True;0;0;0;False;0;False;3;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-1353.597,353.6382;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;27;-1126.545,299.5307;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;4;-989.6273,-52.3055;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1120.627,39.6945;Inherit;False;Property;_VoronoiSpeed;Voronoi Speed;0;0;Create;True;0;0;0;False;0;False;0;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-791.6273,98.6945;Inherit;False;Property;_VoronoiScale;Voronoi Scale;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-790.6273,-14.3055;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-892.6433,297.4545;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1009.239,407.5057;Inherit;False;Property;_Min;Min;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1007.74,488.3856;Inherit;False;Property;_Max;Max;6;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;18;-642.2824,373.0565;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;2;-526.6273,5.694504;Inherit;False;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.ColorNode;7;-495.4258,-375.188;Inherit;False;Property;_Color1;Color 1;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-494.4263,-195.7885;Inherit;False;Property;_Color2;Color 2;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;22;-635.3149,498.3827;Inherit;False;Property;_Vector0;Vector 0;8;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-407.9317,393.1361;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;23;-223.0584,456.2637;Inherit;False;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;1;-200.6273,-41.3055;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Mateo_Chavit_Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;13;2;10;0
WireConnection;14;0;15;0
WireConnection;14;2;13;0
WireConnection;27;0;14;0
WireConnection;27;1;25;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;17;0;27;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;18;2;20;0
WireConnection;2;1;3;0
WireConnection;2;2;6;0
WireConnection;21;0;18;0
WireConnection;21;1;22;0
WireConnection;1;0;7;0
WireConnection;1;1;8;0
WireConnection;1;2;2;0
WireConnection;0;0;1;0
WireConnection;0;11;21;0
WireConnection;0;14;23;0
ASEEND*/
//CHKSM=0E9607B4B9D914BE956334EF4875C0FDE0C9001E