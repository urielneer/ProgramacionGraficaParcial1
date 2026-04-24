// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mateo_Chavit_Water"
{
	Properties
	{
		_VoronoiSpeed("Voronoi Speed", Range( 0 , 4)) = 0
		_ColorSpeed("Color Speed", Range( 0 , 4)) = 1.036993
		_OffsetSpeed("Offset Speed", Range( 0 , 4)) = 0
		_VoronoiScale("Voronoi Scale", Float) = 0
		_ColorScale("Color Scale", Float) = 0.78
		_WaterColor1("Water Color 1", Color) = (0,0,0,0)
		_WaterColor2("Water Color 2", Color) = (0,0,0,0)
		_Offset("Offset", Vector) = (1,0.5,0,0)
		_WaterColor3("Water Color 3", Color) = (0,0,0,0)
		_Max("Max", Range( 0 , 1)) = 0
		_Min("Min", Range( 0 , 1)) = 1
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_WaveScale("Wave Scale", Float) = 3
		_DepthBias("DepthBias", Float) = 0
		_DpethColorBias("DpethColorBias", Float) = 0
		_DepthColorScale("DepthColorScale", Float) = 0
		_DepthScale("DepthScale", Float) = 0
		_DepthColorPow("DepthColorPow", Float) = 0
		_DepthPower("DepthPower", Float) = 0
		_FoamColor("FoamColor", Color) = (0,0,0,0)
		_Edge("Edge", Float) = 0
		_Divide("Divide", Float) = 0
		_FoamSpeed("Foam Speed", Range( 0 , 2)) = 0
		_FoamScale("Foam Scale", Float) = 0
		_DepthDistance("Depth Distance", Range( 0 , 0.2)) = 0
		_DepthColorDist("DepthColorDist", Range( 0 , 1)) = 0
		_DepthColor("DepthColor", Color) = (0,0,0,0)

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _Min;
			uniform float _Max;
			uniform float2 _Offset;
			uniform float _OffsetSpeed;
			uniform float _WaveScale;
			uniform float3 _Vector0;
			uniform float4 _WaterColor1;
			uniform float4 _WaterColor2;
			uniform float _ColorScale;
			uniform float _ColorSpeed;
			uniform float4 _WaterColor3;
			uniform float _VoronoiScale;
			uniform float _VoronoiSpeed;
			uniform float4 _DepthColor;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _DepthColorDist;
			uniform float _DpethColorBias;
			uniform float _DepthColorScale;
			uniform float _DepthColorPow;
			uniform float4 _FoamColor;
			uniform float _FoamScale;
			uniform float _FoamSpeed;
			uniform float _Divide;
			uniform float _Edge;
			uniform float _DepthDistance;
			uniform float _DepthBias;
			uniform float _DepthScale;
			uniform float _DepthPower;
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
			
					float2 voronoihash37( float2 p )
					{
						
						p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
						return frac( sin( p ) *43758.5453);
					}
			
					float voronoi37( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
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
						 		float2 o = voronoihash37( n + g );
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
			
					float2 voronoihash75( float2 p )
					{
						
						p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
						return frac( sin( p ) *43758.5453);
					}
			
					float voronoi75( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
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
						 		float2 o = voronoihash75( n + g );
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
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float simplePerlin2D27 = snoise( (v.ase_texcoord.xy*1.0 + ( _Time.y * _Offset * _OffsetSpeed ))*_WaveScale );
				simplePerlin2D27 = simplePerlin2D27*0.5 + 0.5;
				float smoothstepResult18 = smoothstep( _Min , _Max , ( 1.0 - simplePerlin2D27 ));
				float3 Waves30 = ( smoothstepResult18 * _Vector0 );
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord2 = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = Waves30;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float time37 = ( _Time.y * _ColorSpeed );
				float2 coords37 = i.ase_texcoord1.xy * _ColorScale;
				float2 id37 = 0;
				float2 uv37 = 0;
				float fade37 = 0.5;
				float voroi37 = 0;
				float rest37 = 0;
				for( int it37 = 0; it37 <5; it37++ ){
				voroi37 += fade37 * voronoi37( coords37, time37, id37, uv37, 0 );
				rest37 += fade37;
				coords37 *= 2;
				fade37 *= 0.5;
				}//Voronoi37
				voroi37 /= rest37;
				float4 lerpResult42 = lerp( _WaterColor1 , _WaterColor2 , saturate( voroi37 ));
				float time2 = ( _Time.y * _VoronoiSpeed );
				float2 coords2 = i.ase_texcoord1.xy * _VoronoiScale;
				float2 id2 = 0;
				float2 uv2 = 0;
				float fade2 = 0.5;
				float voroi2 = 0;
				float rest2 = 0;
				for( int it2 = 0; it2 <5; it2++ ){
				voroi2 += fade2 * voronoi2( coords2, time2, id2, uv2, 0 );
				rest2 += fade2;
				coords2 *= 2;
				fade2 *= 0.5;
				}//Voronoi2
				voroi2 /= rest2;
				float4 lerpResult1 = lerp( lerpResult42 , _WaterColor3 , voroi2);
				float4 WaterEffect40 = lerpResult1;
				float4 screenPos = i.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth99 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth99 = abs( ( screenDepth99 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthColorDist ) );
				float DepthColor106 = ( 1.0 - pow( ( ( distanceDepth99 + _DpethColorBias ) * _DepthColorScale ) , _DepthColorPow ) );
				float smoothstepResult111 = smoothstep( 0.0 , 1.0 , DepthColor106);
				float4 lerpResult108 = lerp( WaterEffect40 , _DepthColor , smoothstepResult111);
				float time75 = ( _Time.y * _FoamSpeed );
				float4 appendResult72 = (float4(WorldPosition.x , WorldPosition.z , 0.0 , 0.0));
				float2 coords75 = ( ( appendResult72 / _Divide ) * _Edge ).xy * _FoamScale;
				float2 id75 = 0;
				float2 uv75 = 0;
				float fade75 = 0.5;
				float voroi75 = 0;
				float rest75 = 0;
				for( int it75 = 0; it75 <6; it75++ ){
				voroi75 += fade75 * voronoi75( coords75, time75, id75, uv75, 0 );
				rest75 += fade75;
				coords75 *= 2;
				fade75 *= 0.5;
				}//Voronoi75
				voroi75 /= rest75;
				float4 Foam77 = ( 1.0 - ( _FoamColor * voroi75 ) );
				float screenDepth56 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth56 = abs( ( screenDepth56 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthDistance ) );
				float FoamDepthFade65 = ( 1.0 - pow( ( ( distanceDepth56 + _DepthBias ) * _DepthScale ) , _DepthPower ) );
				float smoothstepResult88 = smoothstep( 0.0 , 0.3 , FoamDepthFade65);
				float4 lerpResult90 = lerp( lerpResult108 , Foam77 , ( smoothstepResult88 * Foam77 ));
				
				
				finalColor = lerpResult90;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
207;73;854;368;1074.598;124.9518;1.548632;True;False
Node;AmplifyShaderEditor.CommentaryNode;95;-1314.392,-604.2749;Inherit;False;1719.284;282.4043;FoamDepthFade;10;94;58;56;57;60;62;59;61;64;65;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;86;-1227.681,-1194.387;Inherit;False;1485.851;577.8837;Foam;15;71;72;80;83;82;79;73;84;81;74;78;75;76;77;93;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;431.531,-597.0103;Inherit;False;1711.283;282.4039;DepthColor;10;97;98;99;100;101;102;103;104;105;106;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;71;-1177.681,-1059.797;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;44;-3224.132,-1041.54;Inherit;False;1766.517;914.4575;Water Texture;17;33;34;35;36;5;4;37;43;39;6;3;7;8;42;2;1;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-1264.392,-506.8072;Inherit;False;Property;_DepthDistance;Depth Distance;24;0;Create;True;0;0;0;False;0;False;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;481.531,-499.5422;Inherit;False;Property;_DepthColorDist;DepthColorDist;25;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;33;-3043.133,-745.1088;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;99;788.2746,-542.7892;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;918.8677,-436.7297;Inherit;False;Property;_DpethColorBias;DpethColorBias;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-3174.132,-653.1082;Inherit;False;Property;_ColorSpeed;Color Speed;1;0;Create;True;0;0;0;False;0;False;1.036993;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-827.055,-443.9947;Inherit;False;Property;_DepthBias;DepthBias;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-972.7866,-890.0139;Inherit;False;Property;_Divide;Divide;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;72;-970.4139,-1035.417;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;31;-3304.154,-115.4224;Inherit;False;1932.782;456.6115;Wave Effect;15;10;27;17;9;12;15;13;25;14;19;20;18;22;21;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DepthFade;56;-957.6482,-550.0542;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-602.5299,-437.8714;Inherit;False;Property;_DepthScale;DepthScale;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;100;1100.338,-542.0409;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;1129.393,-427.6064;Inherit;False;Property;_DepthColorScale;DepthColorScale;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-3204.154,37.18979;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-645.5848,-549.3059;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2845.134,-594.1082;Inherit;False;Property;_ColorScale;Color Scale;4;0;Create;True;0;0;0;False;0;False;0.78;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;82;-821.0496,-849.9053;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-916.4373,-776.5293;Inherit;False;Property;_FoamSpeed;Foam Speed;22;0;Create;True;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;12;-3187.424,102.434;Inherit;False;Property;_Offset;Offset;7;0;Create;True;0;0;0;False;0;False;1,0.5;1,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-2844.134,-707.1085;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;73;-803.551,-1035.417;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-806.7334,-923.2488;Inherit;False;Property;_Edge;Edge;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-3254.154,225.1891;Inherit;False;Property;_OffsetSpeed;Offset Speed;2;0;Create;True;0;0;0;False;0;False;0;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2837.93,-302.082;Inherit;False;Property;_VoronoiSpeed;Voronoi Speed;0;0;Create;True;0;0;0;False;0;False;0;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-384.725,-442.9362;Inherit;False;Property;_DepthPower;DepthPower;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-614.552,-994.5525;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-608.2592,-849.9052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-445.5081,-548.0394;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;37;-2580.133,-687.1083;Inherit;False;0;0;1;0;5;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-2940.983,64.14279;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;15;-2946.049,-80.05387;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;84;-611.9281,-732.5042;Inherit;False;Property;_FoamScale;Foam Scale;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;4;-2706.929,-394.0819;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;1300.414,-540.7744;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;1346.197,-422.6712;Inherit;False;Property;_DepthColorPow;DepthColorPow;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2661.925,130.388;Inherit;False;Property;_WaveScale;Wave Scale;12;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-2367.49,-636.7697;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;104;1500.491,-542.0406;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-2690.641,-3.138069;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;7;-2405.541,-991.5396;Inherit;False;Property;_WaterColor1;Water Color 1;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;75;-427.257,-919.6345;Inherit;True;0;0;1;0;6;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.ColorNode;43;-2404.602,-818.1957;Inherit;False;Property;_WaterColor2;Water Color 2;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;61;-245.4316,-549.3056;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;78;-492.5688,-1144.387;Inherit;False;Property;_FoamColor;FoamColor;19;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-2508.93,-243.082;Inherit;False;Property;_VoronoiScale;Voronoi Scale;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-2507.93,-356.082;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;105;1703.543,-547.0103;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-2259.938,-501.4914;Inherit;False;Property;_WaterColor3;Water Color 3;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;27;-2463.589,-57.24557;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;42;-2114.292,-620.6849;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VoronoiNode;2;-2243.931,-336.082;Inherit;False;0;0;1;0;5;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-235.0212,-970.7147;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;64;-42.37975,-554.2753;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;93;-113.7242,-974.9809;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;17;-2229.687,-59.32177;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;1918.814,-547.0101;Inherit;False;DepthColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2346.282,50.7294;Inherit;False;Property;_Min;Min;10;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1;-1857.484,-390.3355;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2344.783,131.6093;Inherit;False;Property;_Max;Max;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;172.892,-554.2751;Inherit;False;FoamDepthFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;34.17096,-975.823;Inherit;False;Foam;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;110;-772.5042,205.0967;Inherit;False;106;DepthColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;-764.083,333.6471;Inherit;False;65;FoamDepthFade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;18;-1979.326,16.28019;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;22;-1972.358,141.6064;Inherit;False;Property;_Vector0;Vector 0;11;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-1681.618,-387.8018;Inherit;False;WaterEffect;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1744.975,36.3598;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-632.4772,-38.16177;Inherit;False;40;WaterEffect;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;109;-635.7947,38.25344;Inherit;False;Property;_DepthColor;DepthColor;26;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;88;-523.4138,338.6539;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;111;-513.1986,205.4162;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-524.949,475.9423;Inherit;False;77;Foam;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;108;-313.4327,65.62973;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-1595.372,73.32909;Inherit;False;Waves;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-340.574,292.4587;Inherit;False;77;Foam;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-319.282,376.4261;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-50.60164,443.2776;Inherit;False;30;Waves;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;90;-88.48096,285.4284;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;66;161.8501,332.4172;Float;False;True;-1;2;ASEMaterialInspector;100;1;Mateo_Chavit_Water;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;99;0;97;0
WireConnection;72;0;71;1
WireConnection;72;1;71;3
WireConnection;56;0;94;0
WireConnection;100;0;99;0
WireConnection;100;1;98;0
WireConnection;57;0;56;0
WireConnection;57;1;58;0
WireConnection;36;0;33;0
WireConnection;36;1;34;0
WireConnection;73;0;72;0
WireConnection;73;1;80;0
WireConnection;74;0;73;0
WireConnection;74;1;79;0
WireConnection;81;0;82;0
WireConnection;81;1;83;0
WireConnection;59;0;57;0
WireConnection;59;1;60;0
WireConnection;37;1;36;0
WireConnection;37;2;35;0
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;13;2;10;0
WireConnection;103;0;100;0
WireConnection;103;1;101;0
WireConnection;39;0;37;0
WireConnection;104;0;103;0
WireConnection;104;1;102;0
WireConnection;14;0;15;0
WireConnection;14;2;13;0
WireConnection;75;0;74;0
WireConnection;75;1;81;0
WireConnection;75;2;84;0
WireConnection;61;0;59;0
WireConnection;61;1;62;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;105;0;104;0
WireConnection;27;0;14;0
WireConnection;27;1;25;0
WireConnection;42;0;7;0
WireConnection;42;1;43;0
WireConnection;42;2;39;0
WireConnection;2;1;3;0
WireConnection;2;2;6;0
WireConnection;76;0;78;0
WireConnection;76;1;75;0
WireConnection;64;0;61;0
WireConnection;93;0;76;0
WireConnection;17;0;27;0
WireConnection;106;0;105;0
WireConnection;1;0;42;0
WireConnection;1;1;8;0
WireConnection;1;2;2;0
WireConnection;65;0;64;0
WireConnection;77;0;93;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;18;2;20;0
WireConnection;40;0;1;0
WireConnection;21;0;18;0
WireConnection;21;1;22;0
WireConnection;88;0;68;0
WireConnection;111;0;110;0
WireConnection;108;0;54;0
WireConnection;108;1;109;0
WireConnection;108;2;111;0
WireConnection;30;0;21;0
WireConnection;91;0;88;0
WireConnection;91;1;92;0
WireConnection;90;0;108;0
WireConnection;90;1;85;0
WireConnection;90;2;91;0
WireConnection;66;0;90;0
WireConnection;66;1;32;0
ASEEND*/
//CHKSM=E2FDA6CF07C202E2CE78F5B669739D8BD35AC2DE