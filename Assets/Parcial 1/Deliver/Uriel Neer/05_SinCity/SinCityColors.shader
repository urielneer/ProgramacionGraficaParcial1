// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SinCityColors"
{
	Properties
	{

		[Header(Texture)]
		[Space]
		_GrayTexture("GrayTexture", 2D) = "white" {}
		[Space]
		_FleshMasks("FleshMasks", 2D) = "white" {}
		_FleshChannelR("FleshChannelR", Color) = (1,0,0,1)
		[IntRange]_EmissionFleshChannelR("EmissionFleshChannelR?", Range( 0 , 1)) = 0
		_FleshChannelG("FleshChannelG", Color) = (0,1,0,1)
		[IntRange]_EmissionFleshChannelG("EmissionFleshChannelG?", Range( 0 , 1)) = 0
		_FleshChannelB("FleshChannelB", Color) = (0,0,1,1)
		[IntRange]_EmissionFleshChannelB("EmissionFleshChannelB?", Range( 0 , 1)) = 0
		[Space]
		_EyesMasks("EyesMasks", 2D) = "white" {}
		_EyeChannelR("EyeChannelR", Color) = (1,0,0,1)
		[IntRange]_EmissionEyesChannelR("EmissionEyesChannelR?", Range( 0 , 1)) = 0
		_EyeChannelG("EyeChannelG", Color) = (0,1,0,1)
		[IntRange]_EmissionEyesChannelG("EmissionEyesChannelG?", Range( 0 , 1)) = 0
		_EyeChannelB("EyeChannelB", Color) = (0,0,1,1)
		[IntRange]_EmissionEyesChannelB("EmissionEyesChannelB?", Range( 0 , 1)) = 0
		[Space]
		_MetalMasks("MetalMasks", 2D) = "white" {}
		_MetalChannelR("MetalChannelR", Color) = (1,0,0,1)
		[IntRange]_EmissionMetalChannelR("EmissionMetalChannelR?", Range( 0 , 1)) = 0
		_MetalChannelG("MetalChannelG", Color) = (0,1,0,1)
		[IntRange]_EmissionMetalChannelG("EmissionMetalChannelG?", Range( 0 , 1)) = 0
		_MetalChannelB("MetalChannelB", Color) = (0,0,1,1)
		[IntRange]_EmissionMetalChannelB("EmissionMetalChannelB?", Range( 0 , 1)) = 0
		[Space]
		_WoodMasks("WoodMasks", 2D) = "white" {}
		_WoodChannelR("WoodChannelR", Color) = (1,0,0,1)
		[IntRange]_EmissionWoodChannelR("EmissionWoodChannelR?", Range( 0 , 1)) = 0
		_WoodChannelG("WoodChannelG", Color) = (0,1,0,1)
		[IntRange]_EmissionWoodChannelG("EmissionWoodChannelG?", Range( 0 , 1)) = 0
		_WoodChannelB("WoodChannelB", Color) = (0,0,1,1)
		[IntRange]_EmissionWoodChannelB("EmissionWoodChannelB?", Range( 0 , 1)) = 0
		[Space]
		_ClothMasks("ClothMasks", 2D) = "white" {}
		_ClothChannelR("ClothChannelR", Color) = (1,0,0,1)
		[IntRange]_EmissionClothChannelR("EmissionClothChannelR?", Range( 0 , 1)) = 0
		_ClothChannelG("ClothChannelG", Color) = (0,1,0,1)
		[IntRange]_EmissionClothChannelG("EmissionClothChannelG?", Range( 0 , 1)) = 0
		_ClothChannelB("ClothChannelB", Color) = (0,0,1,1)
		[IntRange]_EmissionClothChannelB("EmissionClothChannelB?", Range( 0 , 1)) = 0
		[Space]
		_Normal("Normal", 2D) = "bump" {}
		[Space(10)]
		[Header(Emissive)]
		[Space]
		_EmissiveGlowStrength("EmissiveGlowStrength", Float) = 0
		_EmissivePulseSpeed("EmissivePulseSpeed", Float) = 0
		[Space]
		_EmissiveFresnelBias("EmissiveFresnelBias", Range( 0 , 1)) = 0
		_EmissiveFresnelScale("EmissiveFresnelScale", Range( 0 , 1)) = 0
		_EmissiveFresnelPower("EmissiveFresnelPower", Float) = 0
		[Space(10)]
		[Header(Shadows)]
		[Space]
		_PencilMask("PencilMask", 2D) = "white" {}
		_ShadowTint("ShadowTint", Color) = (0,0,0,0)
		_EnvironmentalShadowIntensity("EnvironmentalShadowIntensity", Range( 0 , 1)) = 0
		_ShadowLength0("ShadowLength0", Range( 0 , 1)) = 0.4454992
		_ShadowLength1("ShadowLength1", Range( 0 , 1)) = 0.4454992
		_ShadowLength2("ShadowLength2", Range( 0 , 1)) = 0.4454992
		_ShadowLength3("ShadowLength3", Range( 0 , 1)) = 0.4454992
		[Space(10)]
		[Header(Miscaleneous)]
		[Space]
		_OutlineThickness("OutlineThickness", Float) = 0
		[Space(10)]
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

		uniform sampler2D _GrayTexture;
		uniform float4 _GrayTexture_ST;
		uniform sampler2D _FleshMasks;
		uniform float4 _FleshMasks_ST;
		uniform sampler2D _EyesMasks;
		uniform float4 _EyesMasks_ST;
		uniform sampler2D _MetalMasks;
		uniform float4 _MetalMasks_ST;
		uniform sampler2D _WoodMasks;
		uniform float4 _WoodMasks_ST;
		uniform sampler2D _ClothMasks;
		uniform float4 _ClothMasks_ST;
		uniform float4 _FleshChannelR;
		uniform float4 _FleshChannelG;
		uniform float4 _FleshChannelB;
		uniform float4 _EyeChannelR;
		uniform float4 _EyeChannelG;
		uniform float4 _EyeChannelB;
		uniform float4 _MetalChannelR;
		uniform float4 _MetalChannelG;
		uniform float4 _MetalChannelB;
		uniform float4 _WoodChannelR;
		uniform float4 _WoodChannelG;
		uniform float4 _WoodChannelB;
		uniform float4 _ClothChannelR;
		uniform float4 _ClothChannelG;
		uniform float4 _ClothChannelB;
		uniform float _EmissionMetalChannelB;
		uniform float _EmissionFleshChannelR;
		uniform float _EmissionFleshChannelG;
		uniform float _EmissionFleshChannelB;
		uniform float _EmissionEyesChannelR;
		uniform float _EmissionEyesChannelG;
		uniform float _EmissionEyesChannelB;
		uniform float _EmissionMetalChannelR;
		uniform float _EmissionMetalChannelG;
		uniform float _EmissionWoodChannelR;
		uniform float _EmissionWoodChannelG;
		uniform float _EmissionWoodChannelB;
		uniform float _EmissionClothChannelR;
		uniform float _EmissionClothChannelG;
		uniform float _EmissionClothChannelB;
		uniform float _EmissiveGlowStrength;
		uniform float _EmissiveFresnelBias;
		uniform float _EmissiveFresnelScale;
		uniform float _EmissiveFresnelPower;
		uniform float _EmissivePulseSpeed;
		uniform float _ShadowLength1;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _PencilMask;
		uniform float4 _PencilMask_ST;
		uniform float _ShadowLength2;
		uniform float _ShadowLength3;
		uniform float _ShadowLength0;
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
			float2 uv_PencilMask = i.uv_texcoord * _PencilMask_ST.xy + _PencilMask_ST.zw;
			float4 tex2DNode291 = tex2D( _PencilMask, uv_PencilMask );
			float ShadowBluePencil301 = tex2DNode291.b;
			float ShadowLength1285 = ( 1.0 - ( ( 1.0 - step( (0.0 + (_ShadowLength1 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 ) ) + ShadowBluePencil301 ) );
			float ShadowGreenPencil300 = tex2DNode291.g;
			float ShadowLength2288 = ( 1.0 - ( ( 1.0 - step( (0.0 + (_ShadowLength2 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 ) ) + ShadowGreenPencil300 ) );
			float ShadowRedPencil299 = tex2DNode291.r;
			float ShadowLength3287 = ( 1.0 - ( ( 1.0 - step( (0.0 + (_ShadowLength3 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 ) ) + ShadowRedPencil299 ) );
			float ShadowLength0286 = step( (0.0 + (_ShadowLength0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , ShadowDotResult29 );
			float ShadowMerge56 = ( ( ( ShadowLength1285 + ShadowLength2288 + ShadowLength3287 ) / 6.0 ) + ShadowLength0286 );
			float LightIntesityControlledShadow66 = ShadowMerge56;
			float LightCast90 = ( 1.0 - LightIntesityControlledShadow66 );
			float EnvironmentalIntesityControlledShadow83 = ( LightIntesityControlledShadow66 + ( ( 1.0 - _EnvironmentalShadowIntensity ) * LightCast90 ) );
			float2 uv_GrayTexture = i.uv_texcoord * _GrayTexture_ST.xy + _GrayTexture_ST.zw;
			float4 BaseTexture18 = tex2D( _GrayTexture, uv_GrayTexture );
			float2 uv_FleshMasks = i.uv_texcoord * _FleshMasks_ST.xy + _FleshMasks_ST.zw;
			float4 tex2DNode98 = tex2D( _FleshMasks, uv_FleshMasks );
			float2 uv_EyesMasks = i.uv_texcoord * _EyesMasks_ST.xy + _EyesMasks_ST.zw;
			float4 tex2DNode348 = tex2D( _EyesMasks, uv_EyesMasks );
			float2 uv_MetalMasks = i.uv_texcoord * _MetalMasks_ST.xy + _MetalMasks_ST.zw;
			float4 tex2DNode374 = tex2D( _MetalMasks, uv_MetalMasks );
			float2 uv_WoodMasks = i.uv_texcoord * _WoodMasks_ST.xy + _WoodMasks_ST.zw;
			float4 tex2DNode389 = tex2D( _WoodMasks, uv_WoodMasks );
			float2 uv_ClothMasks = i.uv_texcoord * _ClothMasks_ST.xy + _ClothMasks_ST.zw;
			float4 tex2DNode401 = tex2D( _ClothMasks, uv_ClothMasks );
			float4 FullyMaskedTexture360 = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( BaseTexture18 * ( 1.0 - tex2DNode98.r ) ) * ( 1.0 - tex2DNode98.g ) ) * ( 1.0 - tex2DNode98.b ) ) * ( 1.0 - tex2DNode348.r ) ) * ( 1.0 - tex2DNode348.g ) ) * ( 1.0 - tex2DNode348.b ) ) * ( 1.0 - tex2DNode374.r ) ) * ( 1.0 - tex2DNode374.g ) ) * ( 1.0 - tex2DNode374.b ) ) * ( 1.0 - tex2DNode389.r ) ) * ( 1.0 - tex2DNode389.g ) ) * ( 1.0 - tex2DNode389.b ) ) * ( 1.0 - tex2DNode401.r ) ) * ( 1.0 - tex2DNode401.g ) ) * ( 1.0 - tex2DNode401.b ) );
			float4 FleshMasks124 = tex2DNode98;
			float4 break423 = FleshMasks124;
			float4 EyesMasks345 = tex2DNode348;
			float4 break427 = EyesMasks345;
			float4 MetalMasks375 = tex2DNode374;
			float4 break436 = MetalMasks375;
			float4 WoodMasks390 = tex2DNode389;
			float4 break452 = WoodMasks390;
			float4 ClothMasks402 = tex2DNode401;
			float4 break456 = ClothMasks402;
			float4 ColoredTexture105 = ( ( ( ( ( FullyMaskedTexture360 + ( break423.r * _FleshChannelR ) + ( break423.g * _FleshChannelG ) + ( break423.b * _FleshChannelB ) ) + ( break427.r * _EyeChannelR ) + ( break427.g * _EyeChannelG ) + ( break427.b * _EyeChannelB ) ) + ( break436.r * _MetalChannelR ) + ( break436.g * _MetalChannelG ) + ( break436.b * _MetalChannelB ) ) + ( break452.r * _WoodChannelR ) + ( break452.g * _WoodChannelG ) + ( break452.b * _WoodChannelB ) ) + ( break456.r * _ClothChannelR ) + ( break456.g * _ClothChannelG ) + ( break456.b * _ClothChannelB ) );
			float4 CustomLighting4 = ( EnvironmentalIntesityControlledShadow83 * ColoredTexture105 );
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
			float2 uv_GrayTexture = i.uv_texcoord * _GrayTexture_ST.xy + _GrayTexture_ST.zw;
			float4 BaseTexture18 = tex2D( _GrayTexture, uv_GrayTexture );
			float2 uv_FleshMasks = i.uv_texcoord * _FleshMasks_ST.xy + _FleshMasks_ST.zw;
			float4 tex2DNode98 = tex2D( _FleshMasks, uv_FleshMasks );
			float2 uv_EyesMasks = i.uv_texcoord * _EyesMasks_ST.xy + _EyesMasks_ST.zw;
			float4 tex2DNode348 = tex2D( _EyesMasks, uv_EyesMasks );
			float2 uv_MetalMasks = i.uv_texcoord * _MetalMasks_ST.xy + _MetalMasks_ST.zw;
			float4 tex2DNode374 = tex2D( _MetalMasks, uv_MetalMasks );
			float2 uv_WoodMasks = i.uv_texcoord * _WoodMasks_ST.xy + _WoodMasks_ST.zw;
			float4 tex2DNode389 = tex2D( _WoodMasks, uv_WoodMasks );
			float2 uv_ClothMasks = i.uv_texcoord * _ClothMasks_ST.xy + _ClothMasks_ST.zw;
			float4 tex2DNode401 = tex2D( _ClothMasks, uv_ClothMasks );
			float4 FullyMaskedTexture360 = ( ( ( ( ( ( ( ( ( ( ( ( ( ( ( BaseTexture18 * ( 1.0 - tex2DNode98.r ) ) * ( 1.0 - tex2DNode98.g ) ) * ( 1.0 - tex2DNode98.b ) ) * ( 1.0 - tex2DNode348.r ) ) * ( 1.0 - tex2DNode348.g ) ) * ( 1.0 - tex2DNode348.b ) ) * ( 1.0 - tex2DNode374.r ) ) * ( 1.0 - tex2DNode374.g ) ) * ( 1.0 - tex2DNode374.b ) ) * ( 1.0 - tex2DNode389.r ) ) * ( 1.0 - tex2DNode389.g ) ) * ( 1.0 - tex2DNode389.b ) ) * ( 1.0 - tex2DNode401.r ) ) * ( 1.0 - tex2DNode401.g ) ) * ( 1.0 - tex2DNode401.b ) );
			float4 FleshMasks124 = tex2DNode98;
			float4 break423 = FleshMasks124;
			float4 EyesMasks345 = tex2DNode348;
			float4 break427 = EyesMasks345;
			float4 MetalMasks375 = tex2DNode374;
			float4 break436 = MetalMasks375;
			float4 WoodMasks390 = tex2DNode389;
			float4 break452 = WoodMasks390;
			float4 ClothMasks402 = tex2DNode401;
			float4 break456 = ClothMasks402;
			float4 ColoredTexture105 = ( ( ( ( ( FullyMaskedTexture360 + ( break423.r * _FleshChannelR ) + ( break423.g * _FleshChannelG ) + ( break423.b * _FleshChannelB ) ) + ( break427.r * _EyeChannelR ) + ( break427.g * _EyeChannelG ) + ( break427.b * _EyeChannelB ) ) + ( break436.r * _MetalChannelR ) + ( break436.g * _MetalChannelG ) + ( break436.b * _MetalChannelB ) ) + ( break452.r * _WoodChannelR ) + ( break452.g * _WoodChannelG ) + ( break452.b * _WoodChannelB ) ) + ( break456.r * _ClothChannelR ) + ( break456.g * _ClothChannelG ) + ( break456.b * _ClothChannelB ) );
			o.Albedo = ColoredTexture105.rgb;
			float4 break501 = MetalMasks375;
			float lerpResult582 = lerp( ( 1.0 - break501.b ) , 1.0 , _EmissionMetalChannelB);
			float4 break486 = FleshMasks124;
			float lerpResult544 = lerp( ( 1.0 - break486.r ) , 1.0 , _EmissionFleshChannelR);
			float lerpResult545 = lerp( ( 1.0 - break486.g ) , 1.0 , _EmissionFleshChannelG);
			float lerpResult548 = lerp( ( 1.0 - break486.b ) , 1.0 , _EmissionFleshChannelB);
			float4 break497 = EyesMasks345;
			float lerpResult553 = lerp( ( 1.0 - break497.r ) , 1.0 , _EmissionEyesChannelR);
			float lerpResult556 = lerp( ( 1.0 - break497.g ) , 1.0 , _EmissionEyesChannelG);
			float lerpResult559 = lerp( ( 1.0 - break497.b ) , 1.0 , _EmissionEyesChannelB);
			float lerpResult580 = lerp( ( 1.0 - break501.r ) , 1.0 , _EmissionMetalChannelR);
			float lerpResult581 = lerp( ( 1.0 - break501.g ) , 1.0 , _EmissionMetalChannelG);
			float4 break526 = WoodMasks390;
			float lerpResult596 = lerp( ( 1.0 - break526.r ) , 1.0 , _EmissionWoodChannelR);
			float lerpResult600 = lerp( ( 1.0 - break526.g ) , 1.0 , _EmissionWoodChannelG);
			float lerpResult601 = lerp( ( 1.0 - break526.b ) , 1.0 , _EmissionWoodChannelB);
			float4 break531 = ClothMasks402;
			float lerpResult608 = lerp( ( 1.0 - break531.r ) , 1.0 , _EmissionClothChannelR);
			float lerpResult611 = lerp( ( 1.0 - break531.g ) , 1.0 , _EmissionClothChannelG);
			float lerpResult612 = lerp( ( 1.0 - break531.b ) , 1.0 , _EmissionClothChannelB);
			float4 EmissiveColor249 = ( ( ( ( ( ( ( ( lerpResult582 * ( ( ( ( ( ( ( ( ColoredTexture105 * lerpResult544 ) * lerpResult545 ) * lerpResult548 ) * lerpResult553 ) * lerpResult556 ) * lerpResult559 ) * lerpResult580 ) * lerpResult581 ) ) * lerpResult596 ) * lerpResult600 ) * lerpResult601 ) * lerpResult608 ) * lerpResult611 ) * lerpResult612 ) * _EmissiveGlowStrength );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV151 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode151 = ( _EmissiveFresnelBias + _EmissiveFresnelScale * pow( 1.0 - fresnelNdotV151, _EmissiveFresnelPower ) );
			float4 PulsatingEmission197 = ( ( EmissiveColor249 * fresnelNode151 ) * (0.1 + (sin( ( _EmissivePulseSpeed * _Time.y ) ) - -1.0) * (1.0 - 0.1) / (1.0 - -1.0)) );
			o.Emission = PulsatingEmission197.rgb;
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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
-1913;6;1920;1013;2690.662;650.1761;1.140567;True;True
Node;AmplifyShaderEditor.CommentaryNode;16;-2707.969,-814.6557;Inherit;False;2455.694;2498.51;Texture;13;455;445;468;467;466;102;388;387;386;385;384;106;100;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;100;-2702.194,-779.2817;Inherit;False;771.0408;226.9389;Base Textures;3;18;2;1;;0,1,0.7671809,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;1;-2696.61,-739.6594;Inherit;True;Property;_GrayTexture;GrayTexture;0;0;Create;True;0;0;0;False;0;False;c376a2d96fb3e4241a9e94e21bbd377e;ab04b29b0c926c4448c2eecbb5a4a061;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;106;-2702.41,-516.8624;Inherit;False;1908.168;749.592;Remove Texture Sections (ALL);20;412;411;410;351;369;352;373;372;371;370;353;350;360;349;103;335;382;383;340;368;;0,0.8124149,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;335;-2509.816,-481.6844;Inherit;False;546.7932;338.8058;Flesh;8;98;336;339;124;255;337;338;263;;0,1,0.6140232,1;0;0
Node;AmplifyShaderEditor.SamplerNode;2;-2417.644,-740.6625;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;98;-2504.657,-394.8628;Inherit;True;Property;_FleshMasks;FleshMasks;10;0;Create;True;0;0;0;False;0;False;-1;c376a2d96fb3e4241a9e94e21bbd377e;6b8002cbe335d9748bb3e491c6bd3340;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-2117.859,-745.0796;Inherit;False;BaseTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;263;-2219.908,-394.1774;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-2693.777,-454.799;Inherit;True;18;BaseTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;255;-2085.915,-449.1232;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;336;-2219.701,-313.4951;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;337;-2086.418,-365.8116;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;339;-2220.324,-233.1519;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;338;-2087.041,-280.486;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;349;-1968.238,-249.7264;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;350;-1967.238,-249.7264;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;351;-1968.238,-250.7264;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;340;-1938.103,-480.1663;Inherit;False;546.7932;338.8058;Eyes;8;348;347;346;345;344;343;341;381;;0,1,0.7469664,1;0;0
Node;AmplifyShaderEditor.SamplerNode;348;-1932.944,-393.3447;Inherit;True;Property;_EyesMasks;EyesMasks;8;0;Create;True;0;0;0;False;0;False;-1;c376a2d96fb3e4241a9e94e21bbd377e;c376a2d96fb3e4241a9e94e21bbd377e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;352;-1968.238,-416.7264;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;353;-1969.238,-416.7264;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;341;-1648.195,-392.6593;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;347;-1647.988,-311.977;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;344;-1514.203,-447.6052;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;343;-1514.705,-364.2935;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;346;-1648.611,-231.6338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;381;-1515.461,-276.1771;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;369;-1396.658,-245.4175;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;370;-1395.658,-245.4175;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;368;-1366.523,-475.8574;Inherit;False;546.7932;338.8058;Metal;8;380;379;378;377;376;375;374;409;;0,1,0.8585176,1;0;0
Node;AmplifyShaderEditor.WireNode;371;-1396.658,-246.4175;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;372;-1396.658,-412.4175;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;374;-1361.364,-389.0358;Inherit;True;Property;_MetalMasks;MetalMasks;7;0;Create;True;0;0;0;False;0;False;-1;c376a2d96fb3e4241a9e94e21bbd377e;70f0a3d86727be240b4089da7b8a27dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;376;-1076.616,-388.3504;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;373;-1397.658,-412.4175;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;380;-1076.409,-307.6681;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;378;-942.6226,-443.2963;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;377;-943.1246,-359.9846;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;379;-1077.032,-227.3249;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;409;-943.848,-274.1175;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;384;-825.045,-243.3579;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;385;-824.045,-243.3579;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;386;-825.045,-244.3579;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;387;-825.045,-145.2699;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;388;-826.045,-145.2699;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;411;-2115.185,-148.5927;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;410;-2113.441,-147.1019;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;412;-2117.269,-147.5927;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;382;-2507.105,-116.5579;Inherit;False;546.7932;338.8058;Wood;15;408;400;399;398;397;396;395;394;393;392;391;390;389;413;414;;0,0.9897842,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;389;-2501.946,-29.73629;Inherit;True;Property;_WoodMasks;WoodMasks;9;0;Create;True;0;0;0;False;0;False;-1;c376a2d96fb3e4241a9e94e21bbd377e;c376a2d96fb3e4241a9e94e21bbd377e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;413;-2118.858,-55.46357;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;414;-2117.601,-54.20612;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;391;-2217.198,-29.05086;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;395;-2216.99,51.63142;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;393;-2083.206,-83.99685;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;-2083.708,-0.6850815;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;394;-2217.614,131.9745;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;408;-2083.452,84.83125;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;396;-1965.661,118.1908;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;397;-1964.661,118.1908;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;383;-1935.526,-112.249;Inherit;False;546.7932;338.8058;Cloth;8;407;406;405;404;403;402;401;417;;0,0.9073796,1,1;0;0
Node;AmplifyShaderEditor.WireNode;398;-1965.661,117.1908;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;401;-1930.367,-25.42739;Inherit;True;Property;_ClothMasks;ClothMasks;6;0;Create;True;0;0;0;False;0;False;-1;c376a2d96fb3e4241a9e94e21bbd377e;c376a2d96fb3e4241a9e94e21bbd377e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;399;-1965.661,-48.8091;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;403;-1645.619,-24.74196;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;400;-1966.661,-48.8091;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;102;-2702.285,233.5458;Inherit;False;2433.875;1443.889;Recolor Texture;7;105;469;470;121;435;425;421;;0,0.5674076,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;405;-1511.626,-79.68789;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;407;-1645.412,55.94032;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;406;-1646.035,136.2834;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-2504.483,-213.3872;Inherit;False;FleshMasks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;421;-2477.565,268.3714;Inherit;False;725.2771;691.2932;Flesh;9;107;418;424;128;420;419;108;423;422;;0,0.7672267,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;404;-1512.128,3.623825;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;422;-2469.666,356.9602;Inherit;True;124;FleshMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;425;-1748.985,269.7933;Inherit;False;725.2771;691.2932;Eyes;9;434;433;432;431;430;429;428;427;426;;0,0.638464,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;417;-1512.09,88.13772;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;-1932.77,-211.8691;Inherit;False;EyesMasks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;419;-2262.62,587.296;Inherit;False;Property;_FleshChannelG;FleshChannelG;22;0;Create;True;0;0;0;False;0;False;0,1,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;423;-2469.373,540.9318;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;435;-1020.219,268.5012;Inherit;False;725.2771;691.2932;Metal;10;444;443;442;441;440;439;438;437;436;465;;0,0.4968061,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;375;-1361.19,-207.5602;Inherit;False;MetalMasks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;420;-2262.287,792.3956;Inherit;False;Property;_FleshChannelB;FleshChannelB;29;0;Create;True;0;0;0;False;0;False;0,0,1,1;0.254717,0.2390504,0.2126647,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;360;-1339.632,-76.99996;Inherit;True;FullyMaskedTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;426;-1741.086,358.382;Inherit;True;345;EyesMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;418;-2256.852,381.7853;Inherit;False;Property;_FleshChannelR;FleshChannelR;24;0;Create;True;0;0;0;False;0;False;1,0,0,1;0.6132076,0.5750268,0.5750268,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-2065.432,569.2377;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-2063.514,385.7633;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;433;-1536.104,383.2071;Inherit;False;Property;_EyeChannelR;EyeChannelR;26;0;Create;True;0;0;0;False;0;False;1,0,0,1;0.4574819,0,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;121;-2690.605,296.8005;Inherit;True;360;FullyMaskedTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;429;-1534.04,588.7177;Inherit;False;Property;_EyeChannelG;EyeChannelG;20;0;Create;True;0;0;0;False;0;False;0,1,0,1;1,0,0.5869594,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;424;-2069.082,773.9104;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;430;-1540.207,795.1172;Inherit;False;Property;_EyeChannelB;EyeChannelB;30;0;Create;True;0;0;0;False;0;False;0,0,1,1;1,0,0.8064976,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;440;-1012.32,357.0898;Inherit;True;375;MetalMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;427;-1740.793,542.3535;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;436;-1012.027,541.0615;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;432;-1340.502,775.332;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;442;-807.3381,381.915;Inherit;False;Property;_MetalChannelR;MetalChannelR;27;0;Create;True;0;0;0;False;0;False;1,0,0,1;0.3584906,0.3584906,0.3584906,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;107;-1947.654,305.9043;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;431;-1338.44,570.6593;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;444;-811.4411,793.8251;Inherit;False;Property;_MetalChannelB;MetalChannelB;32;0;Create;True;0;0;0;False;0;False;0,0,1,1;0.2264151,0.2264151,0.2264151,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;428;-1339.699,364.9498;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;443;-805.2741,587.4257;Inherit;False;Property;_MetalChannelG;MetalChannelG;18;0;Create;True;0;0;0;False;0;False;0,1,0,1;0.6603774,0.6603774,0.6603774,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;439;-611.736,774.0399;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;438;-609.674,569.3672;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;434;-1219.074,307.3262;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;437;-610.933,363.6577;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;441;-490.3079,306.0341;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;465;-298.9629,341.5927;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;466;-299.8315,341.5927;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;467;-291.9592,955.3395;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;468;-291.959,957.9289;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;445;-2474.439,988.0989;Inherit;False;725.2771;691.2932;Wood;11;454;453;452;451;450;449;448;447;446;471;472;;0,0.4106255,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;390;-2501.772,151.7392;Inherit;False;WoodMasks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;470;-1977.819,957.929;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;469;-1977.82,957.9289;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;455;-1745.673,986.8068;Inherit;False;725.2771;691.2932;Cloth;9;464;463;462;461;460;459;458;457;456;;0,0.2870989,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;449;-2466.541,1076.688;Inherit;True;390;WoodMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;402;-1930.193,156.0481;Inherit;False;ClothMasks;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;451;-2261.559,1101.513;Inherit;False;Property;_WoodChannelR;WoodChannelR;28;0;Create;True;0;0;0;False;0;False;1,0,0,1;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;472;-1977.819,1056.335;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;453;-2264.499,1304.521;Inherit;False;Property;_WoodChannelG;WoodChannelG;21;0;Create;True;0;0;0;False;0;False;0,1,0,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;454;-2265.662,1513.423;Inherit;False;Property;_WoodChannelB;WoodChannelB;31;0;Create;True;0;0;0;False;0;False;0,0,1,1;0.671401,0,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;461;-1740.276,1075.395;Inherit;True;402;ClothMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;163;-2707.361,1684.112;Inherit;False;2551.35;1496.327;Emission;36;635;634;632;633;631;630;197;141;627;626;619;618;617;616;519;518;588;583;589;514;587;586;585;584;166;165;164;520;517;487;566;567;564;563;484;483;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;452;-2466.248,1260.659;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;447;-2063.895,1288.965;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;463;-1530.728,1305.731;Inherit;False;Property;_ClothChannelG;ClothChannelG;19;0;Create;True;0;0;0;False;0;False;0,1,0,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;471;-1977.82,1053.746;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;448;-2065.957,1493.637;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;464;-1536.895,1512.131;Inherit;False;Property;_ClothChannelB;ClothChannelB;33;0;Create;True;0;0;0;False;0;False;0,0,1,1;0.4150943,0.3892488,0.4141213,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;483;-2519.69,1720.633;Inherit;False;593.3545;654.8127;Flesh;14;496;499;548;545;494;550;549;547;546;544;482;542;486;485;;0.1153231,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;446;-2065.153,1083.255;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;456;-1737.481,1259.367;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;462;-1532.792,1100.221;Inherit;False;Property;_ClothChannelR;ClothChannelR;25;0;Create;True;0;0;0;False;0;False;1,0,0,1;0.2812211,0.3197634,0.3490566,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;458;-1335.128,1287.673;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;457;-1336.387,1081.963;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;450;-1944.528,1025.632;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;485;-2511.792,1809.221;Inherit;True;124;FleshMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;459;-1337.19,1492.345;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;460;-1215.762,1024.339;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;486;-2511.499,1993.193;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;482;-2299.193,1922.68;Inherit;False;Property;_EmissionFleshChannelR;EmissionFleshChannelR?;46;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;542;-2317.944,1815.066;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-1012.981,1018.906;Inherit;True;ColoredTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;546;-2300.225,2109.534;Inherit;False;Property;_EmissionFleshChannelG;EmissionFleshChannelG?;37;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;547;-2318.976,2001.92;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;544;-2181.141,1816.231;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;-2704.563,1758.604;Inherit;True;105;ColoredTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;494;-2050.535,1762.065;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;545;-2182.173,2003.085;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;550;-2317.581,2198.619;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-2298.83,2306.232;Inherit;False;Property;_EmissionFleshChannelB;EmissionFleshChannelB?;40;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;499;-2049.159,1954.538;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;548;-2180.778,2199.784;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;496;-2048.431,2143.865;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;484;-1898.528,1723.45;Inherit;False;586.9594;652.8127;Eyes;14;559;562;560;558;555;556;552;561;557;553;554;551;497;488;;0.1428552,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;488;-1890.627,1812.038;Inherit;True;345;EyesMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;563;-1932.971,2178.422;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;564;-1928.786,2178.422;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;497;-1890.334,1996.01;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;567;-1930.181,1793.394;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;551;-1697.792,1818.431;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;554;-1679.041,1926.046;Inherit;False;Property;_EmissionEyesChannelR;EmissionEyesChannelR?;41;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;553;-1560.989,1819.597;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;557;-1698.824,2005.285;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;566;-1930.181,1791.999;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;561;-1680.073,2112.9;Inherit;False;Property;_EmissionEyesChannelG;EmissionEyesChannelG?;42;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;552;-1430.384,1765.431;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;562;-1678.678,2307.598;Inherit;False;Property;_EmissionEyesChannelB;EmissionEyesChannelB?;43;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;556;-1562.021,2006.451;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;560;-1697.429,2199.984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;559;-1560.626,2201.15;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;555;-1429.008,1957.903;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;558;-1428.28,2147.231;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;487;-1290.722,1721.645;Inherit;False;599.2771;654.2932;Metal;14;579;582;576;508;574;501;492;581;573;578;580;575;572;577;;0.2361946,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;492;-1282.824,1778.234;Inherit;True;375;MetalMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;584;-1318.512,2177.687;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;585;-1315.394,2177.98;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;501;-1282.531,1962.206;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;586;-1316.394,1796.98;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;577;-1061.486,1925.276;Inherit;False;Property;_EmissionMetalChannelR;EmissionMetalChannelR?;44;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;572;-1080.237,1817.661;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;578;-1062.518,2112.13;Inherit;False;Property;_EmissionMetalChannelG;EmissionMetalChannelG?;34;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;587;-1315.394,1795.98;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;575;-1081.269,2004.515;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;580;-943.4341,1818.827;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;581;-944.4661,2005.681;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;579;-1059.123,2304.828;Inherit;False;Property;_EmissionMetalChannelB;EmissionMetalChannelB?;48;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;576;-1077.874,2197.214;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;573;-812.8281,1764.661;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;574;-811.4521,1957.133;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;582;-941.0711,2198.38;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;508;-809.382,2144.712;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;588;-698.3941,2173.98;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;583;-697.7277,2172.472;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;589;-696.3941,2371.98;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;514;-696.3345,2369.737;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;517;-2519.564,2401.36;Inherit;False;589.7771;647.4934;Wood;16;595;597;591;601;600;599;598;596;594;593;592;523;590;528;526;521;;0.3812494,0,1,1;0;0
Node;AmplifyShaderEditor.WireNode;518;-2084.499,2369.77;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;521;-2511.667,2489.949;Inherit;True;390;WoodMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;519;-2084.5,2369.77;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;526;-2511.374,2673.92;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;523;-2085.498,2467.415;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;594;-2317.179,2486.251;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;595;-2298.428,2593.865;Inherit;False;Property;_EmissionWoodChannelR;EmissionWoodChannelR?;45;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;597;-2299.46,2780.719;Inherit;False;Property;_EmissionWoodChannelG;EmissionWoodChannelG?;35;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;596;-2180.376,2487.417;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;590;-2085.501,2465.396;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;598;-2318.211,2673.106;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;599;-2316.816,2869.804;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;528;-2050.218,2434.536;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;591;-2298.065,2977.417;Inherit;False;Property;_EmissionWoodChannelB;EmissionWoodChannelB?;38;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;600;-2181.408,2674.271;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;3;-2712.004,3184.218;Inherit;False;3163.894;1345.15;Custom lighting;5;252;57;23;62;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;601;-2180.013,2870.969;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;592;-2048.395,2625.723;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;520;-1902.598,2401.768;Inherit;False;581.2771;645.2932;Cloth;14;613;612;610;615;614;611;609;608;607;606;605;602;522;531;;0.4950781,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;593;-2047.667,2815.051;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;21;-2705.747,3218.694;Inherit;False;1920.487;1302.04;Shadows Length;7;28;266;267;265;268;44;636;;0.4811321,0.4811321,0.4811321,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;522;-1896.201,2492.356;Inherit;True;402;ClothMasks;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;618;-1930.438,2847.319;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2703.611,4291.191;Inherit;False;986.547;221.8889;Light Source + Normal;5;29;7;15;13;133;;1,0.5009062,0,1;0;0
Node;AmplifyShaderEditor.WireNode;619;-1930.438,2845.319;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;531;-1894.406,2674.328;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;133;-2689.813,4325.058;Inherit;True;Property;_Normal;Normal;11;0;Create;True;0;0;0;False;0;False;-1;f6c18262b3c0eba4bb830f3d91682a4f;233518d21026a2e4397650a59649e438;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;616;-1932.22,2468.508;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;13;-2231.176,4334.065;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;607;-1710.425,2487.449;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;615;-1691.674,2595.063;Inherit;False;Property;_EmissionClothChannelR;EmissionClothChannelR?;47;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;15;-2403.407,4330.514;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;7;-2025.351,4331.224;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;265;-2704.669,4032.884;Inherit;False;1565.74;255.7807;Length 3;9;287;315;304;298;302;283;274;273;272;;1,0.5019608,0,1;0;0
Node;AmplifyShaderEditor.WireNode;617;-1930.621,2468.508;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;267;-2703.511,3771.629;Inherit;False;1563.47;256.2191;Length 2;9;288;314;307;305;306;284;279;278;269;;1,0.3338987,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;608;-1573.622,2488.614;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;614;-1692.706,2781.917;Inherit;False;Property;_EmissionClothChannelG;EmissionClothChannelG?;36;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;268;-2702.511,3513.75;Inherit;False;1563.25;255.8853;Length 1;9;285;313;308;312;309;281;280;277;270;;1,0.1991624,0,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;609;-1711.457,2674.304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-2697.102,3548.365;Inherit;False;Property;_ShadowLength1;ShadowLength1;2;0;Create;True;0;0;0;False;0;False;0.4454992;0.312;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;613;-1691.311,2975.615;Inherit;False;Property;_EmissionClothChannelB;EmissionClothChannelB?;39;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;611;-1574.654,2675.469;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;610;-1710.062,2868.002;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;272;-2699.259,4067.5;Inherit;False;Property;_ShadowLength3;ShadowLength3;4;0;Create;True;0;0;0;False;0;False;0.4454992;0.067;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;269;-2698.102,3806.245;Inherit;False;Property;_ShadowLength2;ShadowLength2;3;0;Create;True;0;0;0;False;0;False;0.4454992;0.254;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-1918.389,4325.456;Inherit;False;ShadowDotResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;636;-1713.993,4289.149;Inherit;False;919.1061;222.5225;Shadow Shapes;4;301;299;300;291;;1,0.6503882,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;602;-1443.465,2435.733;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-2271.64,3832.153;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;605;-1441.641,2626.921;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;273;-2272.798,4093.406;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;279;-2436.667,3811.065;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;277;-2270.64,3574.273;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;291;-1708.104,4324.444;Inherit;True;Property;_PencilMask;PencilMask;49;0;Create;True;0;0;0;False;0;False;-1;63af688346670ce469b96e962b8f48c9;63af688346670ce469b96e962b8f48c9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;612;-1573.259,2869.167;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;274;-2437.824,4072.319;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;280;-2435.667,3553.185;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;283;-2075.26,4075.5;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;300;-1213.286,4372.989;Inherit;False;ShadowGreenPencil;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;299;-1410.375,4348.093;Inherit;False;ShadowRedPencil;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;284;-2074.103,3814.245;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;301;-1001.45,4397.284;Inherit;False;ShadowBluePencil;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;606;-1440.913,2816.248;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;281;-2072.103,3561.365;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;306;-1800.375,3830.968;Inherit;False;300;ShadowGreenPencil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;305;-1960.178,3813.665;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;312;-1957.828,3558.771;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;627;-1330.939,2849.014;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;298;-1953.837,4076.486;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;302;-1795.674,4096.523;Inherit;False;299;ShadowRedPencil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;309;-1798.024,3575.486;Inherit;False;301;ShadowBluePencil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-1307.555,2403.847;Inherit;False;763.8874;227.8832;Emissive Color;7;147;146;249;624;625;620;621;;0.6611066,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;308;-1584.873,3556.98;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;307;-1587.224,3812.462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;304;-1595.56,4074.405;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;266;-2701.015,3254.813;Inherit;False;937.9504;258.2756;Length 0;5;282;276;275;271;286;;1,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;626;-1329.939,2848.014;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;314;-1475.1,3811.758;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;271;-2695.604,3289.428;Inherit;False;Property;_ShadowLength0;ShadowLength0;1;0;Create;True;0;0;0;False;0;False;0.4454992;0.472;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;313;-1474.294,3557.68;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;315;-1481.035,4073.773;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;624;-1332.939,2469.014;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;287;-1341.824,4071.868;Inherit;True;ShadowLength3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;28;-1760.988,3250.594;Inherit;False;867.011;261.9849;Shadow Merge;8;25;26;56;321;27;46;289;45;;1,0.8314501,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;276;-2269.142,3315.335;Inherit;False;29;ShadowDotResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-1295.228,2457.551;Inherit;False;Property;_EmissiveGlowStrength;EmissiveGlowStrength;13;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;288;-1335.185,3809.394;Inherit;True;ShadowLength2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;285;-1332.148,3554.073;Inherit;True;ShadowLength1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;275;-2434.171,3294.248;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;625;-1331.939,2469.014;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-1745.151,3362.246;Inherit;False;288;ShadowLength2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-1058.137,2438.224;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-1743.418,3292.899;Inherit;False;285;ShadowLength1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;282;-2071.604,3297.428;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;289;-1744.544,3432.646;Inherit;False;287;ShadowLength3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1548.126,3295.667;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;249;-913.6242,2433.378;Inherit;False;EmissiveColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;286;-1954.353,3292.5;Inherit;True;ShadowLength0;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1451.269,3429.634;Inherit;False;286;ShadowLength0;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-1404.532,3293.383;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;620;-727.4268,2466.71;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;321;-1247.969,3292.908;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;62;-775.0189,3591.612;Inherit;False;1131.244;485.7313;Shadow Intensity;3;81;80;131;;0.9652157,1,0,1;0;0
Node;AmplifyShaderEditor.WireNode;621;-727.4266,2469.111;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;165;-1307.149,2634.745;Inherit;False;1094.825;256.5656;Emmisive Fresnel Illumination;7;156;150;151;157;158;622;623;;0.8482146,0,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-1083.792,3286.126;Inherit;True;ShadowMerge;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-1298.915,2769.226;Inherit;False;Property;_EmissiveFresnelBias;EmissiveFresnelBias;12;0;Create;True;0;0;0;False;0;False;0;0.422;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-780.8304,2814.511;Inherit;False;Property;_EmissiveFresnelPower;EmissiveFresnelPower;17;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-1037.629,2791.811;Inherit;False;Property;_EmissiveFresnelScale;EmissiveFresnelScale;15;0;Create;True;0;0;0;False;0;False;0;0.14;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;80;-766.3091,3627.164;Inherit;False;604.4206;114.2682;Light Intensity;2;66;132;;0.8716522,1,0,1;0;0
Node;AmplifyShaderEditor.WireNode;623;-730.9394,2696.014;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;622;-732.9394,2696.014;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-745.643,3666.866;Inherit;False;56;ShadowMerge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;151;-567.541,2724.18;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;9;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;-330.655,2669.558;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-434.9681,3665.647;Inherit;False;LightIntesityControlledShadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;131;-766.5869,3769.132;Inherit;False;600.6652;107.768;Lightsources Intensity;3;90;88;89;;0.08167672,1,0,1;0;0
Node;AmplifyShaderEditor.WireNode;634;-217.9077,2701.468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-753.782,3803.13;Inherit;False;66;LightIntesityControlledShadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;88;-483.3037,3808.699;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;635;-217.9077,2699.468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;81;-769.0149,3879.239;Inherit;False;1111.267;190.8036;Environmental Intensity;7;83;97;92;84;93;65;91;;0.4393867,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-345.9445,3802.314;Inherit;False;LightCast;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;632;-217.9077,2885.468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-753.7279,3994.788;Inherit;False;Property;_EnvironmentalShadowIntensity;EnvironmentalShadowIntensity;5;0;Create;True;0;0;0;False;0;False;0;0.53;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;633;-218.9077,2885.468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;166;-1306.83,2910.888;Inherit;False;775.9763;255.8193;Pulse Timing;8;152;162;161;159;160;145;628;629;;1,0,0.9813728,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-356.4396,3964.873;Inherit;False;90;LightCast;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;93;-487.6396,3959.273;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;631;-698.9077,2885.468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-203.338,3945.373;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-1299.789,2999.129;Inherit;False;Property;_EmissivePulseSpeed;EmissivePulseSpeed;14;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;160;-1255.066,3068.752;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-755.516,3918.606;Inherit;False;66;LightIntesityControlledShadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;630;-700.9077,2884.468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;-80.7383,3921.574;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;-1077.137,3003.477;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;629;-699.2503,2974.156;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;161;-948.6916,3004.53;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;-775.2689,4083.89;Inherit;False;326.3489;364.6601;Texture Merge;4;19;61;4;17;;0,1,0.55919,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;28.63148,3917.442;Inherit;False;EnvironmentalIntesityControlledShadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;162;-827.6171,3003.477;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;628;-699.2504,2972.862;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-768.8369,4260.141;Inherit;True;105;ColoredTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;-770.5615,4202.926;Inherit;False;83;EnvironmentalIntesityControlledShadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-654.1729,2942.006;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-769.4691,4124.634;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;57;-774.2279,3221.172;Inherit;False;656.5383;365.5419;Ligth & Shadow Tint;4;59;58;54;69;;1,0.9176471,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;4;-637.3669,4119.591;Inherit;False;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;196;-2697.445,-990.994;Inherit;False;Constant;_OutlineColor;OutlineColor;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;-521.1399,2937.51;Inherit;True;PulsatingEmission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-2504.516,-970.8204;Inherit;False;Property;_OutlineThickness;OutlineThickness;23;0;Create;True;0;0;0;False;0;False;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-297.0684,3255.182;Inherit;False;TintedShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;54;-441.0376,3257.529;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;69;-591.3735,3281.135;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;58;-442.1446,3367.55;Inherit;False;56;ShadowMerge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;252;-775.4579,3259.784;Inherit;False;Property;_ShadowTint;ShadowTint;16;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;20;-2135.171,-1255.409;Inherit;False;105;ColoredTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;5;-2138.88,-1015.732;Inherit;False;4;CustomLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;-2320.806,-1206.113;Inherit;False;197;PulsatingEmission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;195;-2319.145,-993.5938;Inherit;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;187;-1945.622,-1249.815;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;SinCityColors;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;18;0;2;0
WireConnection;263;0;98;1
WireConnection;255;0;103;0
WireConnection;255;1;263;0
WireConnection;336;0;98;2
WireConnection;337;0;255;0
WireConnection;337;1;336;0
WireConnection;339;0;98;3
WireConnection;338;0;337;0
WireConnection;338;1;339;0
WireConnection;349;0;338;0
WireConnection;350;0;349;0
WireConnection;351;0;350;0
WireConnection;352;0;351;0
WireConnection;353;0;352;0
WireConnection;341;0;348;1
WireConnection;347;0;348;2
WireConnection;344;0;353;0
WireConnection;344;1;341;0
WireConnection;343;0;344;0
WireConnection;343;1;347;0
WireConnection;346;0;348;3
WireConnection;381;0;343;0
WireConnection;381;1;346;0
WireConnection;369;0;381;0
WireConnection;370;0;369;0
WireConnection;371;0;370;0
WireConnection;372;0;371;0
WireConnection;376;0;374;1
WireConnection;373;0;372;0
WireConnection;380;0;374;2
WireConnection;378;0;373;0
WireConnection;378;1;376;0
WireConnection;377;0;378;0
WireConnection;377;1;380;0
WireConnection;379;0;374;3
WireConnection;409;0;377;0
WireConnection;409;1;379;0
WireConnection;384;0;409;0
WireConnection;385;0;384;0
WireConnection;386;0;385;0
WireConnection;387;0;386;0
WireConnection;388;0;387;0
WireConnection;411;0;388;0
WireConnection;410;0;411;0
WireConnection;412;0;410;0
WireConnection;413;0;412;0
WireConnection;414;0;413;0
WireConnection;391;0;389;1
WireConnection;395;0;389;2
WireConnection;393;0;414;0
WireConnection;393;1;391;0
WireConnection;392;0;393;0
WireConnection;392;1;395;0
WireConnection;394;0;389;3
WireConnection;408;0;392;0
WireConnection;408;1;394;0
WireConnection;396;0;408;0
WireConnection;397;0;396;0
WireConnection;398;0;397;0
WireConnection;399;0;398;0
WireConnection;403;0;401;1
WireConnection;400;0;399;0
WireConnection;405;0;400;0
WireConnection;405;1;403;0
WireConnection;407;0;401;2
WireConnection;406;0;401;3
WireConnection;124;0;98;0
WireConnection;404;0;405;0
WireConnection;404;1;407;0
WireConnection;417;0;404;0
WireConnection;417;1;406;0
WireConnection;345;0;348;0
WireConnection;423;0;422;0
WireConnection;375;0;374;0
WireConnection;360;0;417;0
WireConnection;128;0;423;1
WireConnection;128;1;419;0
WireConnection;108;0;423;0
WireConnection;108;1;418;0
WireConnection;424;0;423;2
WireConnection;424;1;420;0
WireConnection;427;0;426;0
WireConnection;436;0;440;0
WireConnection;432;0;427;2
WireConnection;432;1;430;0
WireConnection;107;0;121;0
WireConnection;107;1;108;0
WireConnection;107;2;128;0
WireConnection;107;3;424;0
WireConnection;431;0;427;1
WireConnection;431;1;429;0
WireConnection;428;0;427;0
WireConnection;428;1;433;0
WireConnection;439;0;436;2
WireConnection;439;1;444;0
WireConnection;438;0;436;1
WireConnection;438;1;443;0
WireConnection;434;0;107;0
WireConnection;434;1;428;0
WireConnection;434;2;431;0
WireConnection;434;3;432;0
WireConnection;437;0;436;0
WireConnection;437;1;442;0
WireConnection;441;0;434;0
WireConnection;441;1;437;0
WireConnection;441;2;438;0
WireConnection;441;3;439;0
WireConnection;465;0;441;0
WireConnection;466;0;465;0
WireConnection;467;0;466;0
WireConnection;468;0;467;0
WireConnection;390;0;389;0
WireConnection;470;0;468;0
WireConnection;469;0;470;0
WireConnection;402;0;401;0
WireConnection;472;0;469;0
WireConnection;452;0;449;0
WireConnection;447;0;452;1
WireConnection;447;1;453;0
WireConnection;471;0;472;0
WireConnection;448;0;452;2
WireConnection;448;1;454;0
WireConnection;446;0;452;0
WireConnection;446;1;451;0
WireConnection;456;0;461;0
WireConnection;458;0;456;1
WireConnection;458;1;463;0
WireConnection;457;0;456;0
WireConnection;457;1;462;0
WireConnection;450;0;471;0
WireConnection;450;1;446;0
WireConnection;450;2;447;0
WireConnection;450;3;448;0
WireConnection;459;0;456;2
WireConnection;459;1;464;0
WireConnection;460;0;450;0
WireConnection;460;1;457;0
WireConnection;460;2;458;0
WireConnection;460;3;459;0
WireConnection;486;0;485;0
WireConnection;542;0;486;0
WireConnection;105;0;460;0
WireConnection;547;0;486;1
WireConnection;544;0;542;0
WireConnection;544;2;482;0
WireConnection;494;0;141;0
WireConnection;494;1;544;0
WireConnection;545;0;547;0
WireConnection;545;2;546;0
WireConnection;550;0;486;2
WireConnection;499;0;494;0
WireConnection;499;1;545;0
WireConnection;548;0;550;0
WireConnection;548;2;549;0
WireConnection;496;0;499;0
WireConnection;496;1;548;0
WireConnection;563;0;496;0
WireConnection;564;0;563;0
WireConnection;497;0;488;0
WireConnection;567;0;564;0
WireConnection;551;0;497;0
WireConnection;553;0;551;0
WireConnection;553;2;554;0
WireConnection;557;0;497;1
WireConnection;566;0;567;0
WireConnection;552;0;566;0
WireConnection;552;1;553;0
WireConnection;556;0;557;0
WireConnection;556;2;561;0
WireConnection;560;0;497;2
WireConnection;559;0;560;0
WireConnection;559;2;562;0
WireConnection;555;0;552;0
WireConnection;555;1;556;0
WireConnection;558;0;555;0
WireConnection;558;1;559;0
WireConnection;584;0;558;0
WireConnection;585;0;584;0
WireConnection;501;0;492;0
WireConnection;586;0;585;0
WireConnection;572;0;501;0
WireConnection;587;0;586;0
WireConnection;575;0;501;1
WireConnection;580;0;572;0
WireConnection;580;2;577;0
WireConnection;581;0;575;0
WireConnection;581;2;578;0
WireConnection;576;0;501;2
WireConnection;573;0;587;0
WireConnection;573;1;580;0
WireConnection;574;0;573;0
WireConnection;574;1;581;0
WireConnection;582;0;576;0
WireConnection;582;2;579;0
WireConnection;508;0;582;0
WireConnection;508;1;574;0
WireConnection;588;0;508;0
WireConnection;583;0;588;0
WireConnection;589;0;583;0
WireConnection;514;0;589;0
WireConnection;518;0;514;0
WireConnection;519;0;518;0
WireConnection;526;0;521;0
WireConnection;523;0;519;0
WireConnection;594;0;526;0
WireConnection;596;0;594;0
WireConnection;596;2;595;0
WireConnection;590;0;523;0
WireConnection;598;0;526;1
WireConnection;599;0;526;2
WireConnection;528;0;590;0
WireConnection;528;1;596;0
WireConnection;600;0;598;0
WireConnection;600;2;597;0
WireConnection;601;0;599;0
WireConnection;601;2;591;0
WireConnection;592;0;528;0
WireConnection;592;1;600;0
WireConnection;593;0;592;0
WireConnection;593;1;601;0
WireConnection;618;0;593;0
WireConnection;619;0;618;0
WireConnection;531;0;522;0
WireConnection;616;0;619;0
WireConnection;607;0;531;0
WireConnection;15;0;133;0
WireConnection;7;0;13;0
WireConnection;7;1;15;0
WireConnection;617;0;616;0
WireConnection;608;0;607;0
WireConnection;608;2;615;0
WireConnection;609;0;531;1
WireConnection;611;0;609;0
WireConnection;611;2;614;0
WireConnection;610;0;531;2
WireConnection;29;0;7;0
WireConnection;602;0;617;0
WireConnection;602;1;608;0
WireConnection;605;0;602;0
WireConnection;605;1;611;0
WireConnection;279;0;269;0
WireConnection;612;0;610;0
WireConnection;612;2;613;0
WireConnection;274;0;272;0
WireConnection;280;0;270;0
WireConnection;283;0;274;0
WireConnection;283;1;273;0
WireConnection;300;0;291;2
WireConnection;299;0;291;1
WireConnection;284;0;279;0
WireConnection;284;1;278;0
WireConnection;301;0;291;3
WireConnection;606;0;605;0
WireConnection;606;1;612;0
WireConnection;281;0;280;0
WireConnection;281;1;277;0
WireConnection;305;0;284;0
WireConnection;312;0;281;0
WireConnection;627;0;606;0
WireConnection;298;0;283;0
WireConnection;308;0;312;0
WireConnection;308;1;309;0
WireConnection;307;0;305;0
WireConnection;307;1;306;0
WireConnection;304;0;298;0
WireConnection;304;1;302;0
WireConnection;626;0;627;0
WireConnection;314;0;307;0
WireConnection;313;0;308;0
WireConnection;315;0;304;0
WireConnection;624;0;626;0
WireConnection;287;0;315;0
WireConnection;288;0;314;0
WireConnection;285;0;313;0
WireConnection;275;0;271;0
WireConnection;625;0;624;0
WireConnection;147;0;625;0
WireConnection;147;1;146;0
WireConnection;282;0;275;0
WireConnection;282;1;276;0
WireConnection;26;0;45;0
WireConnection;26;1;46;0
WireConnection;26;2;289;0
WireConnection;249;0;147;0
WireConnection;286;0;282;0
WireConnection;27;0;26;0
WireConnection;620;0;249;0
WireConnection;321;0;27;0
WireConnection;321;1;25;0
WireConnection;621;0;620;0
WireConnection;56;0;321;0
WireConnection;623;0;621;0
WireConnection;622;0;623;0
WireConnection;151;1;156;0
WireConnection;151;2;157;0
WireConnection;151;3;158;0
WireConnection;150;0;622;0
WireConnection;150;1;151;0
WireConnection;66;0;132;0
WireConnection;634;0;150;0
WireConnection;88;0;89;0
WireConnection;635;0;634;0
WireConnection;90;0;88;0
WireConnection;632;0;635;0
WireConnection;633;0;632;0
WireConnection;93;0;65;0
WireConnection;631;0;633;0
WireConnection;92;0;93;0
WireConnection;92;1;91;0
WireConnection;630;0;631;0
WireConnection;97;0;84;0
WireConnection;97;1;92;0
WireConnection;159;0;145;0
WireConnection;159;1;160;0
WireConnection;629;0;630;0
WireConnection;161;0;159;0
WireConnection;83;0;97;0
WireConnection;162;0;161;0
WireConnection;628;0;629;0
WireConnection;152;0;628;0
WireConnection;152;1;162;0
WireConnection;17;0;19;0
WireConnection;17;1;61;0
WireConnection;4;0;17;0
WireConnection;197;0;152;0
WireConnection;59;0;54;0
WireConnection;54;0;252;0
WireConnection;54;1;69;1
WireConnection;54;2;58;0
WireConnection;195;0;196;0
WireConnection;195;1;191;0
WireConnection;187;0;20;0
WireConnection;187;2;142;0
WireConnection;187;13;5;0
WireConnection;187;11;195;0
ASEEND*/
//CHKSM=6EE99CBA21656E85F0AA4866630ACC41DE57548D