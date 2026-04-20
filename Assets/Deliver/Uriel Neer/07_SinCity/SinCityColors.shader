// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SinCityColors"
{
	Properties
	{
		_AlbedoTexture("AlbedoTexture", 2D) = "white" {}
		_ShadowLength0("ShadowLength0", Range( 0 , 1)) = 0.4454992
		_ShadowLength1("ShadowLength1", Range( 0 , 1)) = 0.4454992
		_ShadowLength2("ShadowLength2", Range( 0 , 1)) = 0.4454992
		_EnvironmentalShadowIntensity("EnvironmentalShadowIntensity", Range( 0 , 1)) = 0
		_PlaidMasks("PlaidMasks", 2D) = "white" {}
		_BlueMaskPattern("BlueMaskPattern", 2D) = "white" {}
		_RedMaskPattern("RedMaskPattern", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_EmissiveColor("EmissiveColor", Color) = (0,0,0,0)
		_EmissiveHolographicBias("EmissiveHolographicBias", Range( 0 , 1)) = 0
		_EmissiveFresnelBias("EmissiveFresnelBias", Range( 0 , 1)) = 0
		_EmissiveGlowStrength("EmissiveGlowStrength", Float) = 0
		_EmissiveHologramSpeed("EmissiveHologramSpeed", Float) = 0
		_EmissiveHologramFrequency("EmissiveHologramFrequency", Float) = 0
		[IntRange]_HologramDirection("HologramDirection", Range( 0 , 1)) = 0
		_EmissivePulseSpeed("EmissivePulseSpeed", Float) = 0
		_EmissiveFresnelScale("EmissiveFresnelScale", Range( 0 , 1)) = 0
		_EmissiveHolographicScale("EmissiveHolographicScale", Range( 0 , 1)) = 0
		[IntRange]_EmissivePulsationSwitch("EmissivePulsationSwitch", Range( 0 , 1)) = 0
		_ShadowTint("ShadowTint", Color) = (0,0,0,0)
		_EmissiveFresnelPower("EmissiveFresnelPower", Float) = 0
		[IntRange]_EmissiveHolographicSwitch("EmissiveHolographicSwitch", Range( 0 , 1)) = 0
		_EmissiveHolographicPower("EmissiveHolographicPower", Float) = 0
		_OutlineThickness("OutlineThickness", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = _OutlineThickness;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float4 color196 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			o.Emission = color196.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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
			float2 uv_texcoord;
			float4 screenPos;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _AlbedoTexture;
		uniform float4 _AlbedoTexture_ST;
		uniform sampler2D _PlaidMasks;
		uniform float4 _PlaidMasks_ST;
		uniform sampler2D _RedMaskPattern;
		uniform sampler2D _BlueMaskPattern;
		uniform float4 _EmissiveColor;
		uniform float _EmissiveGlowStrength;
		uniform float _EmissiveFresnelBias;
		uniform float _EmissiveFresnelScale;
		uniform float _EmissiveFresnelPower;
		uniform float _EmissivePulseSpeed;
		uniform float _EmissivePulsationSwitch;
		uniform float _EmissiveHologramSpeed;
		uniform float _HologramDirection;
		uniform float _EmissiveHologramFrequency;
		uniform float _EmissiveHolographicBias;
		uniform float _EmissiveHolographicScale;
		uniform float _EmissiveHolographicPower;
		uniform float _EmissiveHolographicSwitch;
		uniform float _ShadowLength0;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _ShadowLength1;
		uniform float _ShadowLength2;
		uniform float4 _ShadowTint;
		uniform float _EnvironmentalShadowIntensity;
		uniform float _OutlineThickness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float dotResult7 = dot( ase_worldlightDir , (WorldNormalVector( i , UnpackNormal( tex2D( _Normal, uv_Normal ) ) )) );
			float ShadowDotResult29 = dotResult7;
			float ShadowLength024 = step( (0.0 + (_ShadowLength0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 );
			float ShadowLength134 = step( (0.0 + (_ShadowLength1 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 );
			float ShadowLength240 = step( (0.0 + (_ShadowLength2 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 );
			float ShadowMerge56 = ( ( ShadowLength024 + ShadowLength134 + ShadowLength240 ) / 3.0 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 lerpResult54 = lerp( _ShadowTint , ase_lightColor , ShadowMerge56);
			float4 TintedShadow59 = lerpResult54;
			float4 LightIntesityControlledShadow66 = ( ShadowMerge56 * TintedShadow59 );
			float4 LightCast90 = ( 1.0 - LightIntesityControlledShadow66 );
			float4 EnvironmentalIntesityControlledShadow83 = ( LightIntesityControlledShadow66 + ( ( 1.0 - _EnvironmentalShadowIntensity ) * LightCast90 ) );
			float2 uv_AlbedoTexture = i.uv_texcoord * _AlbedoTexture_ST.xy + _AlbedoTexture_ST.zw;
			float4 BaseTexture18 = tex2D( _AlbedoTexture, uv_AlbedoTexture );
			float2 uv_PlaidMasks = i.uv_texcoord * _PlaidMasks_ST.xy + _PlaidMasks_ST.zw;
			float4 tex2DNode98 = tex2D( _PlaidMasks, uv_PlaidMasks );
			float4 temp_cast_3 = (tex2DNode98.g).xxxx;
			float4 MaskedTexture120 = ( BaseTexture18 - temp_cast_3 );
			float RedMask123 = tex2DNode98.r;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult112 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 ScreenPosition134 = appendResult112;
			float BlueMask124 = tex2DNode98.b;
			float4 PlaidedTexture105 = ( MaskedTexture120 + ( RedMask123 * tex2D( _RedMaskPattern, ScreenPosition134 ) ) + ( BlueMask124 * tex2D( _BlueMaskPattern, ScreenPosition134 ) ) );
			float4 CustomLighting4 = ( EnvironmentalIntesityControlledShadow83 * PlaidedTexture105 );
			c.rgb = CustomLighting4.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_AlbedoTexture = i.uv_texcoord * _AlbedoTexture_ST.xy + _AlbedoTexture_ST.zw;
			float4 BaseTexture18 = tex2D( _AlbedoTexture, uv_AlbedoTexture );
			float2 uv_PlaidMasks = i.uv_texcoord * _PlaidMasks_ST.xy + _PlaidMasks_ST.zw;
			float4 tex2DNode98 = tex2D( _PlaidMasks, uv_PlaidMasks );
			float4 temp_cast_0 = (tex2DNode98.g).xxxx;
			float4 MaskedTexture120 = ( BaseTexture18 - temp_cast_0 );
			float RedMask123 = tex2DNode98.r;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult112 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 ScreenPosition134 = appendResult112;
			float BlueMask124 = tex2DNode98.b;
			float4 PlaidedTexture105 = ( MaskedTexture120 + ( RedMask123 * tex2D( _RedMaskPattern, ScreenPosition134 ) ) + ( BlueMask124 * tex2D( _BlueMaskPattern, ScreenPosition134 ) ) );
			o.Albedo = PlaidedTexture105.rgb;
			float4 EmissiveColor249 = ( _EmissiveColor * _EmissiveGlowStrength );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV151 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode151 = ( _EmissiveFresnelBias + _EmissiveFresnelScale * pow( 1.0 - fresnelNdotV151, _EmissiveFresnelPower ) );
			float4 lerpResult239 = lerp( ( BlueMask124 * ( ( EmissiveColor249 * fresnelNode151 ) * (0.1 + (sin( ( _EmissivePulseSpeed * _Time.y ) ) - -1.0) * (1.0 - 0.1) / (1.0 - -1.0)) ) ) , ( EmissiveColor249 * BlueMask124 ) , (1.0 + (floor( _EmissivePulsationSwitch ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)));
			float4 PulsatingEmission197 = lerpResult239;
			float mulTime201 = _Time.y * _EmissiveHologramSpeed;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float lerpResult253 = lerp( ase_vertex3Pos.y , ase_vertex3Pos.z , _HologramDirection);
			float fresnelNdotV210 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode210 = ( _EmissiveHolographicBias + _EmissiveHolographicScale * pow( 1.0 - fresnelNdotV210, _EmissiveHolographicPower ) );
			float smoothstepResult219 = smoothstep( 0.0 , 1.0 , (0.0 + (( sin( ( ( mulTime201 + lerpResult253 ) * ( _EmissiveHologramFrequency * 6.28318548202515 ) ) ) + fresnelNode210 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			float4 lerpResult244 = lerp( ( PulsatingEmission197 * smoothstepResult219 ) , PulsatingEmission197 , (1.0 + (floor( _EmissiveHolographicSwitch ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)));
			float4 EmissiveTexture140 = lerpResult244;
			o.Emission = EmissiveTexture140.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
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
				float4 screenPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				vertexDataFunc( v, customInputData );
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
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
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
1299.143;73;1332;534;3451.655;1245.763;1.549245;True;False
Node;AmplifyShaderEditor.CommentaryNode;3;-3067.058,819.5052;Inherit;False;2726.167;927.5348;Custom lighting;5;23;62;57;21;252;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;21;-3060.801,853.9811;Inherit;False;1570.069;889.4493;Shadows Length;5;28;32;22;38;44;;0.4811321,0.4811321,0.4811321,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;44;-3056.431,1517.051;Inherit;False;986.547;221.8889;Light Source + Normal;5;29;7;13;133;15;;1,0.5009062,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;133;-3039.433,1552.517;Inherit;True;Property;_Normal;Normal;8;0;Create;True;0;0;0;False;0;False;-1;f6c18262b3c0eba4bb830f3d91682a4f;10ff51d2d87fb7b46b70b55f8551c146;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;15;-2753.027,1557.973;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;13;-2580.796,1561.525;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;38;-3056.795,1306.308;Inherit;False;936.7369;204.2241;Length 0;5;40;39;43;41;42;;1,0.3338987,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;22;-3055.876,888.9462;Inherit;False;936.7369;204.2241;Length 0;5;24;6;31;30;11;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;32;-3056.795,1095.429;Inherit;False;936.7369;204.2241;Length 0;5;34;33;37;35;36;;1,0.1991624,0,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;7;-2374.971,1558.683;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-3050.466,923.5622;Inherit;False;Property;_ShadowLength0;ShadowLength0;1;0;Create;True;0;0;0;False;0;False;0.4454992;0.011;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-2268.009,1552.915;Inherit;False;ShadowDotResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-3051.385,1340.925;Inherit;False;Property;_ShadowLength2;ShadowLength2;3;0;Create;True;0;0;0;False;0;False;0.4454992;0.366;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-3051.385,1130.045;Inherit;False;Property;_ShadowLength1;ShadowLength1;2;0;Create;True;0;0;0;False;0;False;0.4454992;0.153;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;-2624.923,1155.952;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;43;-2789.951,1345.744;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-2624.003,949.4692;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;31;-2789.032,928.3812;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-2624.923,1366.832;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;37;-2789.951,1134.865;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;33;-2427.386,1138.045;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;39;-2427.386,1348.925;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;6;-2426.466,931.5622;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-2310.308,1132.515;Inherit;False;ShadowLength1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-2309.389,926.0322;Inherit;False;ShadowLength0;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;28;-2106.056,888.5502;Inherit;False;609.0773;249.4517;Shadow Merge;6;56;27;26;46;45;25;;1,0.6412373,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-2310.308,1343.395;Inherit;False;ShadowLength2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-2099.076,1067.202;Inherit;False;40;ShadowLength2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-2097.343,997.8551;Inherit;False;34;ShadowLength1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-2097.113,928.6972;Inherit;False;24;ShadowLength0;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1900.051,933.6232;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-1783.456,930.3392;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-1674.716,924.0822;Inherit;False;ShadowMerge;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-1478.824,859.5541;Inherit;False;656.5383;365.5419;Ligth & Shadow Tint;4;59;58;54;69;;1,0.9176471,0,1;0;0
Node;AmplifyShaderEditor.LightColorNode;69;-1295.969,919.5172;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;252;-1480.054,898.1661;Inherit;False;Property;_ShadowTint;ShadowTint;20;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1146.74,1005.932;Inherit;False;56;ShadowMerge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;62;-1479.615,1229.994;Inherit;False;1131.244;485.7313;Shadow Intensity;3;81;80;131;;0.9652157,1,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;54;-1145.633,895.9112;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;80;-1470.905,1265.546;Inherit;False;1017.988;138.4938;Light Intensity;4;66;79;63;132;;0.8716522,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;163;-3067.324,-113.4824;Inherit;False;3809.661;930.7626;Simple Emissive Ears;14;140;197;220;198;153;141;243;234;223;222;221;164;165;166;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-1001.672,891.2211;Inherit;False;TintedShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;16;-3066.438,-781.1265;Inherit;False;2248.392;663.433;Texture;4;106;102;100;105;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-1083.392,1303.518;Inherit;False;56;ShadowMerge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-1454.82,1328.639;Inherit;False;59;TintedShadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;164;-2868.484,-46.52664;Inherit;False;763.8874;227.8832;Emissive Color;4;147;154;146;249;;0.6611066,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;166;-984.4626,-10.73318;Inherit;False;775.9763;255.8193;Pulse Timing;6;152;162;161;159;160;145;;1,0,0.9813728,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;100;-3060.663,-745.7525;Inherit;False;771.0408;226.9389;Base Textures;3;18;2;1;;0,1,0.7671809,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;1;-3053.114,-708.1334;Inherit;True;Property;_AlbedoTexture;AlbedoTexture;0;0;Create;True;0;0;0;False;0;False;None;88f736a7a6a78c549b320d944a33f48a;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleTimeNode;160;-932.6986,147.13;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-2681.856,36.777;Inherit;False;Property;_EmissiveGlowStrength;EmissiveGlowStrength;12;0;Create;True;0;0;0;False;0;False;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-977.4216,77.50631;Inherit;False;Property;_EmissivePulseSpeed;EmissivePulseSpeed;16;0;Create;True;0;0;0;False;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;102;-2287.116,-745.2547;Inherit;False;1282.271;625.7119;Plaid Patterns (Screen UVs);11;107;127;112;110;121;126;134;135;136;224;225;;0,0.5674076,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;165;-2095.915,-14.56644;Inherit;False;1094.825;256.5656;Emmisive Fresnel Illumination;5;156;150;151;157;158;;0.8482146,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-899.0504,1308.844;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;221;-3013.114,567.6493;Inherit;False;1126.001;244.8646;Hologram Lines;11;208;203;204;202;199;206;205;201;200;253;254;;1,0,0.6172376,1;0;0
Node;AmplifyShaderEditor.ColorNode;154;-2868.484,12.47336;Inherit;False;Property;_EmissiveColor;EmissiveColor;9;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.5908241,0.6590579,0.6698113,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;200;-2623.709,621.4442;Inherit;False;Property;_EmissiveHologramSpeed;EmissiveHologramSpeed;13;0;Create;True;0;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;131;-1471.183,1407.514;Inherit;False;600.6652;107.768;Lightsources Intensity;3;90;88;89;;0.08167672,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-1569.598,165.1989;Inherit;False;Property;_EmissiveFresnelPower;EmissiveFresnelPower;21;0;Create;True;0;0;0;False;0;False;0;-0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;-754.7697,81.85439;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-1826.396,142.4987;Inherit;False;Property;_EmissiveFresnelScale;EmissiveFresnelScale;17;0;Create;True;0;0;0;False;0;False;0;0.282;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-772.7174,1302.299;Inherit;False;LightIntesityControlledShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;254;-3007.623,741.9586;Inherit;False;Property;_HologramDirection;HologramDirection;15;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;110;-2270.086,-447.0248;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;156;-2087.681,119.9139;Inherit;False;Property;_EmissiveFresnelBias;EmissiveFresnelBias;11;0;Create;True;0;0;0;False;0;False;0;0.517;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;199;-3005.997,605.8048;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2776.113,-707.1334;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-2444.766,17.45017;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;106;-3061.075,-514.8109;Inherit;False;686.4744;289.8504;Remove Texture Sections (ALL);6;123;124;120;103;101;98;;0,0.8124149,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;234;-78.78432,-78.94908;Inherit;False;593.1792;440.076;Emissive Pulsation Switcher;7;241;240;239;238;237;236;251;;0,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;98;-3052.23,-405.5351;Inherit;True;Property;_PlaidMasks;PlaidMasks;5;0;Create;True;0;0;0;False;0;False;-1;f78e0e43a3e638e4b9f76673ac17fb1a;bccc2264b48e0eb498a14724b095de83;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;201;-2396.709,625.4442;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;151;-1356.308,74.86758;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;9;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;205;-2344.709,739.4442;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;161;-626.3248,82.9078;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;112;-2095.043,-417.8506;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-1458.378,1441.513;Inherit;False;66;LightIntesityControlledShadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;253;-2757.498,648.0671;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-2476.328,-711.5505;Inherit;False;BaseTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;206;-2595.709,711.4442;Inherit;False;Property;_EmissiveHologramFrequency;EmissiveHologramFrequency;14;0;Create;True;0;0;0;False;0;False;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;249;-2301.253,13.60481;Inherit;False;EmissiveColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;134;-1968.389,-422.567;Inherit;False;ScreenPosition;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;222;-1796.693,592.2906;Inherit;False;986.5856;224.1494;Holographic Fresnel;4;215;216;217;210;;1,0,0.3056655,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;88;-1187.899,1447.081;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;81;-1473.611,1517.621;Inherit;False;1111.267;190.8036;Environmental Intensity;7;83;97;92;84;93;65;91;;0.4393867,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;241;254.6707,280.8909;Inherit;False;Property;_EmissivePulsationSwitch;EmissivePulsationSwitch;19;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-3053.688,-480.1515;Inherit;False;18;BaseTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;202;-2244.709,626.4442;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;-2252.709,715.4442;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-2566.392,-338.0073;Inherit;False;BlueMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;162;-505.2509,81.85445;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;-1119.422,20.24557;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;217;-1272.556,745.8032;Inherit;False;Property;_EmissiveHolographicPower;EmissiveHolographicPower;23;0;Create;True;0;0;0;False;0;False;0;-0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;240;253.3716,219.7907;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;237;-68.88126,94.87723;Inherit;False;124;BlueMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;-69.53629,25.07718;Inherit;False;249;EmissiveColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1458.324,1633.17;Inherit;False;Property;_EnvironmentalShadowIntensity;EnvironmentalShadowIntensity;4;0;Create;True;0;0;0;False;0;False;0;0.839;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-1527.88,721.6281;Inherit;False;Property;_EmissiveHolographicScale;EmissiveHolographicScale;18;0;Create;True;0;0;0;False;0;False;0;0.282;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;203;-2115.708,627.4442;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;101;-2755.808,-475.2321;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-1961.934,-545.4939;Inherit;False;134;ScreenPosition;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1050.54,1440.696;Inherit;False;LightCast;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;123;-2565.898,-383.0679;Inherit;False;RedMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;-3064.527,-38.98988;Inherit;True;124;BlueMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;126;-1742.756,-634.5743;Inherit;False;559.7769;251.2958;RED Plaided Pattern;3;125;108;138;;0,0.05203342,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;127;-1741.899,-377.8661;Inherit;False;559.7769;251.2958;Blue Plaided Pattern;3;130;129;128;;0.4386287,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-331.8076,20.3848;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;216;-1790.637,699.0433;Inherit;False;Property;_EmissiveHolographicBias;EmissiveHolographicBias;10;0;Create;True;0;0;0;False;0;False;0;0.517;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;135;-1968.702,-290.1251;Inherit;False;134;ScreenPosition;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;138;-1738.006,-569.9204;Inherit;True;Property;_RedMaskPattern;RedMaskPattern;7;0;Create;True;0;0;0;False;0;False;-1;78d8be59e85608847a14772bfcb94a07;44257a51d6581b848aa7a9bc89684d09;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;129;-1736.413,-313.4856;Inherit;True;Property;_BlueMaskPattern;BlueMaskPattern;6;0;Create;True;0;0;0;False;0;False;-1;78d8be59e85608847a14772bfcb94a07;36f0bda85a9fecb4eafad974fc9cef2b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;130;-1469.997,-339.2277;Inherit;True;124;BlueMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;223;-700.3943,595.4891;Inherit;False;443.3587;197.619;Remmaping & Combining;3;209;218;219;;1,0,0.1553226,1;0;0
Node;AmplifyShaderEditor.FresnelNode;210;-1023.579,653.6315;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;93;-1192.235,1597.655;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-2557.483,-479.1134;Inherit;False;MaskedTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;208;-1993.708,627.4442;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-1467.264,-594.5496;Inherit;True;123;RedMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-196.9159,-45.73563;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;2,2,2,2;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;238;123.3029,29.92019;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-1061.035,1603.255;Inherit;False;90;LightCast;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;251;251.85,61.3826;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;-2264.716,-706.4079;Inherit;True;120;MaskedTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-907.9335,1583.755;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-1277.46,-589.379;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;243;-77.3373,366.6493;Inherit;False;593.1792;440.076;Emissive Holographic Switcher;5;248;246;245;244;250;;0,0,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;239;248.3496,-43.26779;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-1278.242,-335.5155;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;209;-694.3392,631.313;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-1460.112,1556.988;Inherit;False;66;LightIntesityControlledShadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;218;-578.9053,631.4713;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;250;260.0459,726.341;Inherit;False;Property;_EmissiveHolographicSwitch;EmissiveHolographicSwitch;22;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;-785.3339,1559.956;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;532.944,-47.96292;Inherit;True;PulsatingEmission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;107;-1126.322,-699.1086;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-997.9268,-704.4781;Inherit;True;PlaidedTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;-3063.021,385.6925;Inherit;True;197;PulsatingEmission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-675.9642,1555.824;Inherit;False;EnvironmentalIntesityControlledShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;245;254.8186,665.3895;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;-805.7569,860.5872;Inherit;False;326.3489;364.6601;Texture Merge;4;19;61;4;17;;0,1,0.55919,1;0;0
Node;AmplifyShaderEditor.SmoothstepOpNode;219;-406.3422,631.4713;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-192.0437,395.9949;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;246;253.8196,507.7895;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-799.3248,1036.835;Inherit;True;105;PlaidedTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;-801.0494,979.6201;Inherit;False;83;EnvironmentalIntesityControlledShadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;248;-12.81213,421.6411;Inherit;False;197;PulsatingEmission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-799.9571,901.3301;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;244;249.7966,402.3306;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;4;-667.855,896.2872;Inherit;False;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-3267.759,-912.8147;Inherit;False;Property;_OutlineThickness;OutlineThickness;24;0;Create;True;0;0;0;False;0;False;0;0.0005;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;196;-3460.687,-932.9883;Inherit;False;Constant;_OutlineColor;OutlineColor;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;140;522.4642,395.2713;Inherit;True;EmissiveTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;-3081.74,-1149.826;Inherit;False;140;EmissiveTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-2896.105,-1199.122;Inherit;False;105;PlaidedTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;224;-2068.569,-701.8867;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;225;-1921.893,-702.14;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;5;-2899.814,-959.4448;Inherit;False;4;CustomLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;195;-3082.386,-935.588;Inherit;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;187;-2706.557,-1193.528;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;SinCityColors;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;133;0
WireConnection;7;0;13;0
WireConnection;7;1;15;0
WireConnection;29;0;7;0
WireConnection;43;0;42;0
WireConnection;31;0;11;0
WireConnection;37;0;36;0
WireConnection;33;0;37;0
WireConnection;33;1;35;0
WireConnection;39;0;43;0
WireConnection;39;1;41;0
WireConnection;6;0;31;0
WireConnection;6;1;30;0
WireConnection;34;0;33;0
WireConnection;24;0;6;0
WireConnection;40;0;39;0
WireConnection;26;0;25;0
WireConnection;26;1;45;0
WireConnection;26;2;46;0
WireConnection;27;0;26;0
WireConnection;56;0;27;0
WireConnection;54;0;252;0
WireConnection;54;1;69;0
WireConnection;54;2;58;0
WireConnection;59;0;54;0
WireConnection;79;0;132;0
WireConnection;79;1;63;0
WireConnection;159;0;145;0
WireConnection;159;1;160;0
WireConnection;66;0;79;0
WireConnection;2;0;1;0
WireConnection;147;0;154;0
WireConnection;147;1;146;0
WireConnection;201;0;200;0
WireConnection;151;1;156;0
WireConnection;151;2;157;0
WireConnection;151;3;158;0
WireConnection;161;0;159;0
WireConnection;112;0;110;1
WireConnection;112;1;110;2
WireConnection;253;0;199;2
WireConnection;253;1;199;3
WireConnection;253;2;254;0
WireConnection;18;0;2;0
WireConnection;249;0;147;0
WireConnection;134;0;112;0
WireConnection;88;0;89;0
WireConnection;202;0;201;0
WireConnection;202;1;253;0
WireConnection;204;0;206;0
WireConnection;204;1;205;0
WireConnection;124;0;98;3
WireConnection;162;0;161;0
WireConnection;150;0;249;0
WireConnection;150;1;151;0
WireConnection;240;0;241;0
WireConnection;203;0;202;0
WireConnection;203;1;204;0
WireConnection;101;0;103;0
WireConnection;101;1;98;2
WireConnection;90;0;88;0
WireConnection;123;0;98;1
WireConnection;152;0;150;0
WireConnection;152;1;162;0
WireConnection;138;1;136;0
WireConnection;129;1;135;0
WireConnection;210;1;216;0
WireConnection;210;2;215;0
WireConnection;210;3;217;0
WireConnection;93;0;65;0
WireConnection;120;0;101;0
WireConnection;208;0;203;0
WireConnection;153;0;141;0
WireConnection;153;1;152;0
WireConnection;238;0;236;0
WireConnection;238;1;237;0
WireConnection;251;0;240;0
WireConnection;92;0;93;0
WireConnection;92;1;91;0
WireConnection;108;0;125;0
WireConnection;108;1;138;0
WireConnection;239;0;153;0
WireConnection;239;1;238;0
WireConnection;239;2;251;0
WireConnection;128;0;130;0
WireConnection;128;1;129;0
WireConnection;209;0;208;0
WireConnection;209;1;210;0
WireConnection;218;0;209;0
WireConnection;97;0;84;0
WireConnection;97;1;92;0
WireConnection;197;0;239;0
WireConnection;107;0;121;0
WireConnection;107;1;108;0
WireConnection;107;2;128;0
WireConnection;105;0;107;0
WireConnection;83;0;97;0
WireConnection;245;0;250;0
WireConnection;219;0;218;0
WireConnection;220;0;198;0
WireConnection;220;1;219;0
WireConnection;246;0;245;0
WireConnection;17;0;19;0
WireConnection;17;1;61;0
WireConnection;244;0;220;0
WireConnection;244;1;248;0
WireConnection;244;2;246;0
WireConnection;4;0;17;0
WireConnection;140;0;244;0
WireConnection;224;0;121;0
WireConnection;195;0;196;0
WireConnection;195;1;191;0
WireConnection;187;0;20;0
WireConnection;187;2;142;0
WireConnection;187;13;5;0
WireConnection;187;11;195;0
ASEEND*/
//CHKSM=39AFD423CC31DF47B7CCB64F3BC9681BAFDF35DD