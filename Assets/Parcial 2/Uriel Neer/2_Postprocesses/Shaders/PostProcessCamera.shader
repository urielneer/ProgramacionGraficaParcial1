// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PostProcessCamera"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		[HideInInspector][IntRange]_IsDamaged("IsDamaged?", Range( 0 , 1)) = 0
		[HideInInspector][IntRange]_IsFlashBanged("IsFlashBanged?", Range( 0 , 1)) = 0
		_FlashBang_GradientTimeScale("FlashBang_GradientTimeScale", Float) = 0
		_FlashBang_MaxBorderSize("FlashBang_MaxBorderSize", Range( 0.0001 , 0.5)) = 3
		_FlashBang_MinBorderSize("FlashBang_MinBorderSize", Range( 0.0001 , 0.5)) = 3
		_FlashBang_MinSaturation("FlashBang_MinSaturation", Range( 0 , 1)) = 3
		_FlashBang_MaxSaturation("FlashBang_MaxSaturation", Range( 0 , 1)) = 3
		[HideInInspector][IntRange]_IsHealing("IsHealing?", Range( 0 , 1)) = 0
		[HideInInspector][IntRange]_IsUsingCamera("IsUsingCamera?", Range( 0 , 1)) = 0
		[HideInInspector][IntRange]_IsDrunk("IsDrunk?", Range( 0 , 1)) = 0
		[HideInInspector]_FlashBangAction1("FlashBangAction1", Color) = (0,0,0,0)
		[HideInInspector]_DamageAction1("DamageAction1", Color) = (0,0,0,0)
		[HideInInspector]_HealAction1("HealAction1", Color) = (0,0,0,0)
		[HideInInspector]_WakeUpAction1("WakeUpAction1", Color) = (0,0,0,0)
		[HideInInspector]_WakeUpAction2("WakeUpAction2", Color) = (0,0,0,0)
		[HideInInspector]_UseCameraAction1("UseCameraAction1", Color) = (0,0,0,0)
		[HideInInspector]_DrunkAction1("DrunkAction1", Color) = (0,0,0,0)
		_Damage_FluctuationRange("Damage_FluctuationRange", Vector) = (0,0,0,0)
		_Damage_Radiuses("Damage_Radiuses", Vector) = (0,0,0,0)
		_Damage_Speeds("Damage_Speeds", Vector) = (0,0,0,0)
		_Damage_Distortion("Damage_Distortion", Vector) = (0,0,0,0)
		_Damage_VignetteBlurr("Damage_VignetteBlurr", Vector) = (0,0,0,0)
		_Damage_Color1("Damage_Color1", Color) = (0,0,0,0)
		_Heal_TintColor2("Heal_TintColor2", Color) = (0,0,0,0)
		_Heal_TintColor1("Heal_TintColor1", Color) = (0,0,0,0)
		_Damage_Color2("Damage_Color2", Color) = (0,0,0,0)
		_Heal_BorderColor2("Heal_BorderColor2", Color) = (0,0,0,0)
		_Heal_BorderColor1("Heal_BorderColor1", Color) = (0,0,0,0)
		_Heal_LineColor1("Heal_LineColor1", Color) = (0,0,0,0)
		_Damage_Color3("Damage_Color3", Color) = (0,0,0,0)
		_Heal_LineColor2("Heal_LineColor2", Color) = (0,0,0,0)
		[HideInInspector]_Damage_Alpha("Damage_Alpha", Float) = 0
		[HideInInspector]_FlashBang_Alpha("FlashBang_Alpha", Float) = 0
		[HideInInspector]_Heal_Alpha("Heal_Alpha", Float) = 0
		[HideInInspector]_Drunk_Alpha("Drunk_Alpha", Float) = 0
		[HideInInspector]_UseCamera_Alpha("UseCamera_Alpha", Float) = 0
		[HideInInspector]_WakeUp_Alpha("WakeUp_Alpha", Float) = 0
		_Heal_ValueFrame("Heal_ValueFrame", Vector) = (0,0,0,0)
		_Heal_BorderSize("Heal_BorderSize", Vector) = (0,0,0,0)
		_Heal_LineSpeed("Heal_LineSpeed", Float) = 0
		_Heal_GradientTimeScale("Heal_GradientTimeScale", Float) = 0
		_Heal_LineFrequency("Heal_LineFrequency", Float) = 0
		_Drunk_Speed("Drunk_Speed", Float) = 0
		_Drunk_Strength("Drunk_Strength", Vector) = (0.01,0.1,0,0)
		_Drunk_Hue("Drunk_Hue", Vector) = (0,0,0,0)
		_UseCamera_RecDistortion("UseCamera_RecDistortion", Vector) = (1,2,0,0)
		_UseCamera_RecRadius("UseCamera_RecRadius", Float) = 3000
		_UseCamera_Pixels("UseCamera_Pixels", Vector) = (4096,1024,0,0)
		_UseCamera_RecDisplacement("UseCamera_RecDisplacement", Vector) = (0.5,0.5,0,0)
		_WakeUp_EyeRadius("WakeUp_EyeRadius", Float) = 3000
		_WakeUp_Time("WakeUp_Time", Float) = 3000
		_WakeUp_Blinking("WakeUp_Blinking", Float) = 3000
		_WakeUp_EyeSize("WakeUp_EyeSize", Vector) = (1,1,0,0)

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				float4 ase_texcoord4 : TEXCOORD4;
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float2 _UseCamera_Pixels;
			uniform float _IsUsingCamera;
			uniform float _Drunk_Speed;
			uniform float2 _Drunk_Strength;
			uniform float2 _Drunk_Hue;
			uniform float _Drunk_Alpha;
			uniform float4 _DrunkAction1;
			uniform float _IsDrunk;
			uniform float _FlashBang_Alpha;
			uniform float4 _FlashBangAction1;
			uniform float _FlashBang_MinSaturation;
			uniform float _FlashBang_MaxSaturation;
			uniform float _FlashBang_GradientTimeScale;
			uniform float _FlashBang_MinBorderSize;
			uniform float _FlashBang_MaxBorderSize;
			uniform float _IsFlashBanged;
			uniform float2 _Damage_VignetteBlurr;
			uniform float3 _Damage_Speeds;
			uniform float2 _Damage_Distortion;
			uniform float3 _Damage_FluctuationRange;
			uniform float3 _Damage_Radiuses;
			uniform float4 _Damage_Color1;
			uniform float4 _Damage_Color2;
			uniform float4 _Damage_Color3;
			uniform float _Damage_Alpha;
			uniform float4 _DamageAction1;
			uniform float _IsDamaged;
			uniform float2 _Heal_ValueFrame;
			uniform float _Heal_Alpha;
			uniform float4 _Heal_TintColor1;
			uniform float4 _Heal_TintColor2;
			uniform float _Heal_GradientTimeScale;
			uniform float2 _Heal_BorderSize;
			uniform float4 _Heal_BorderColor1;
			uniform float4 _Heal_BorderColor2;
			uniform float _Heal_LineSpeed;
			uniform float _Heal_LineFrequency;
			uniform float4 _Heal_LineColor1;
			uniform float4 _Heal_LineColor2;
			uniform float4 _HealAction1;
			uniform float _IsHealing;
			uniform float _UseCamera_Alpha;
			uniform float2 _UseCamera_RecDisplacement;
			uniform float2 _UseCamera_RecDistortion;
			uniform float _UseCamera_RecRadius;
			uniform float4 _UseCameraAction1;
			uniform float _WakeUp_Alpha;
			uniform float4 _WakeUpAction1;
			uniform float2 _WakeUp_EyeSize;
			uniform float _WakeUp_Time;
			uniform float _WakeUp_EyeRadius;
			uniform float _WakeUp_Blinking;
			uniform float4 _WakeUpAction2;
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float3 RGBToHSV(float3 c)
			{
				float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
				float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
				float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
				float d = q.x - min( q.w, q.y );
				float e = 1.0e-10;
				return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord4 = screenPos;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 UC_Pixels891 = _UseCamera_Pixels;
				float2 break897 = UC_Pixels891;
				float pixelWidth733 =  1.0f / break897.x;
				float pixelHeight733 = 1.0f / break897.y;
				half2 pixelateduv733 = half2((int)(uv_MainTex.x / pixelWidth733) * pixelWidth733, (int)(uv_MainTex.y / pixelHeight733) * pixelHeight733);
				float IsUsingCamera50 = _IsUsingCamera;
				int lerpResult14_g4 = lerp( 0 , 1 , (float)(int)IsUsingCamera50);
				float2 lerpResult9_g4 = lerp( uv_MainTex , pixelateduv733 , (float)lerpResult14_g4);
				float2 PostCameraUV742 = lerpResult9_g4;
				float4 ScreenRGB14 = tex2D( _MainTex, PostCameraUV742 );
				float2 DefaultUVs42_g5 = PostCameraUV742;
				float2 _1 = float2(0.1,0.1);
				float2 break117_g5 = _Drunk_Strength;
				float temp_output_18_0_g5 = (break117_g5.x + (sin( ( _Drunk_Speed * _SinTime.w ) ) - -1.0) * (break117_g5.y - break117_g5.x) / (1.0 - -1.0));
				float2 Center57_g5 = ( DefaultUVs42_g5 + ( ( DefaultUVs42_g5 - float2( 0.5,0.5 ) ) * ( temp_output_18_0_g5 * -1.0 ) ) );
				float3 appendResult112_g5 = (float3(1.0 , 1.0 , 0.0));
				float dotResult56_g5 = dot( float3( _1 ,  0.0 ) , appendResult112_g5 );
				float2 lerpResult54_g5 = lerp( ( DefaultUVs42_g5 + ( _1 * temp_output_18_0_g5 ) ) , Center57_g5 , ( 1.0 - dotResult56_g5 ));
				float4 DrunkRGB1755 = tex2D( _MainTex, lerpResult54_g5 );
				float2 _2 = float2(0.1,-0.1);
				float3 appendResult113_g5 = (float3(0.0 , 1.0 , 1.0));
				float dotResult69_g5 = dot( float3( _2 ,  0.0 ) , appendResult113_g5 );
				float2 lerpResult67_g5 = lerp( ( DefaultUVs42_g5 + ( _2 * temp_output_18_0_g5 ) ) , Center57_g5 , ( 1.0 - dotResult69_g5 ));
				float4 DrunkRGB2766 = tex2D( _MainTex, lerpResult67_g5 );
				float2 _3 = float2(-0.1,-0.1);
				float3 appendResult114_g5 = (float3(1.0 , 0.0 , 1.0));
				float dotResult79_g5 = dot( float3( _3 ,  0.0 ) , appendResult114_g5 );
				float2 lerpResult77_g5 = lerp( ( DefaultUVs42_g5 + ( _3 * temp_output_18_0_g5 ) ) , Center57_g5 , ( 1.0 - dotResult79_g5 ));
				float4 DrunkRGB3774 = tex2D( _MainTex, lerpResult77_g5 );
				float2 _4 = float2(-0.1,0.1);
				float3 appendResult115_g5 = (float3(0.0 , 0.0 , 0.0));
				float dotResult89_g5 = dot( float3( _4 ,  0.0 ) , appendResult115_g5 );
				float2 lerpResult87_g5 = lerp( ( DefaultUVs42_g5 + ( _4 * temp_output_18_0_g5 ) ) , Center57_g5 , ( 1.0 - dotResult89_g5 ));
				float4 DrunkRGB4773 = tex2D( _MainTex, lerpResult87_g5 );
				float3 hsvTorgb3_g337 = RGBToHSV( saturate( ( ( ScreenRGB14 * float4( 0.5,0.5,0.5,0.5019608 ) ) + ( DrunkRGB1755 * float4( 0.125,0.125,0.125,0.1254902 ) ) + ( DrunkRGB2766 * float4( 0.125,0.125,0.125,0.1254902 ) ) + ( DrunkRGB3774 * float4( 0.125,0.125,0.125,0.1254902 ) ) + ( DrunkRGB4773 * float4( 0.1254902,0.1254902,0.1254902,0.1254902 ) ) ) ).rgb );
				float Dr_Alpha523 = _Drunk_Alpha;
				float lerpResult16_g337 = lerp( 0.0 , 1.0 , ( (_Drunk_Hue.x + (sin( _Time.y ) - -1.0) * (_Drunk_Hue.y - _Drunk_Hue.x) / (1.0 - -1.0)) * Dr_Alpha523 ));
				float lerpResult17_g337 = lerp( 0.0 , 1.0 , 1.0);
				float lerpResult18_g337 = lerp( 0.0 , 1.0 , 1.0);
				float3 hsvTorgb8_g337 = HSVToRGB( float3(( hsvTorgb3_g337.x * lerpResult16_g337 ),( hsvTorgb3_g337.y * lerpResult17_g337 ),( hsvTorgb3_g337.z * lerpResult18_g337 )) );
				float3 break863 = hsvTorgb8_g337;
				float4 appendResult862 = (float4(break863.x , break863.y , break863.z , 1.0));
				float4 DrunkAction1254 = _DrunkAction1;
				float4 break658 = DrunkAction1254;
				int lerpResult14_g338 = lerp( 0 , 1 , (float)(int)break658.r);
				float4 lerpResult9_g338 = lerp( ScreenRGB14 , appendResult862 , (float)lerpResult14_g338);
				int lerpResult15_g338 = lerp( 0 , 1 , (float)(int)break658.g);
				float4 lerpResult5_g338 = lerp( lerpResult9_g338 , appendResult862 , (float)lerpResult15_g338);
				int lerpResult18_g338 = lerp( 0 , 1 , (float)(int)break658.b);
				float4 lerpResult4_g338 = lerp( lerpResult5_g338 , appendResult862 , (float)lerpResult18_g338);
				float4 PostDrunk16 = lerpResult4_g338;
				float IsDrunk49 = _IsDrunk;
				int lerpResult14_g361 = lerp( 0 , 1 , (float)(int)IsDrunk49);
				float4 lerpResult9_g361 = lerp( ScreenRGB14 , PostDrunk16 , (float)lerpResult14_g361);
				int lerpResult14_g339 = lerp( 0 , 1 , (float)(int)IsDrunk49);
				float4 lerpResult9_g339 = lerp( ScreenRGB14 , PostDrunk16 , (float)lerpResult14_g339);
				float4 temp_output_417_0 = lerpResult9_g339;
				float4 color260 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 FB_Color278 = color260;
				float FB_Alpha519 = _FlashBang_Alpha;
				float4 temp_output_546_0 = ( temp_output_417_0 + ( FB_Color278 * FB_Alpha519 ) );
				float4 FlashBangAction1252 = _FlashBangAction1;
				float4 break368 = FlashBangAction1252;
				int lerpResult14_g343 = lerp( 0 , 1 , (float)(int)break368.r);
				float4 lerpResult9_g343 = lerp( temp_output_417_0 , temp_output_546_0 , (float)lerpResult14_g343);
				int lerpResult15_g343 = lerp( 0 , 1 , (float)(int)break368.g);
				float4 lerpResult5_g343 = lerp( lerpResult9_g343 , temp_output_546_0 , (float)lerpResult15_g343);
				float4 Screen215_g340 = ScreenRGB14;
				float3 hsvTorgb3_g342 = RGBToHSV( Screen215_g340.rgb );
				float lerpResult16_g342 = lerp( 0.0 , 1.0 , 1.0);
				float Time289_g340 = _Time.y;
				float FB_MinSaturation288 = _FlashBang_MinSaturation;
				float FB_MaxSaturation289 = _FlashBang_MaxSaturation;
				float Alpha308_g340 = FB_Alpha519;
				float lerpResult17_g342 = lerp( 0.0 , 1.0 , ( 1.0 - ( (FB_MinSaturation288 + (( sin( Time289_g340 ) * 0.2 ) - -1.0) * (FB_MaxSaturation289 - FB_MinSaturation288) / (1.0 - -1.0)) * Alpha308_g340 ) ));
				float lerpResult18_g342 = lerp( 0.0 , 1.0 , 1.0);
				float3 hsvTorgb8_g342 = HSVToRGB( float3(( hsvTorgb3_g342.x * lerpResult16_g342 ),( hsvTorgb3_g342.y * lerpResult17_g342 ),( hsvTorgb3_g342.z * lerpResult18_g342 )) );
				float3 break316_g340 = hsvTorgb8_g342;
				float4 appendResult317_g340 = (float4(break316_g340.x , break316_g340.y , break316_g340.z , 1.0));
				float FB_GradientTimeScale287 = _FlashBang_GradientTimeScale;
				float mulTime293_g340 = _Time.y * FB_GradientTimeScale287;
				float FlashBangTime291_g340 = mulTime293_g340;
				float temp_output_90_0_g340 = sin( FlashBangTime291_g340 );
				float FB_MinBorderSize290 = _FlashBang_MinBorderSize;
				float temp_output_170_0_g340 = FB_MinBorderSize290;
				float temp_output_171_0_g340 = ( temp_output_170_0_g340 / 4.0 );
				float temp_output_167_0_g340 = (( temp_output_170_0_g340 - temp_output_171_0_g340 ) + (temp_output_90_0_g340 - -1.0) * (( temp_output_170_0_g340 + temp_output_171_0_g340 ) - ( temp_output_170_0_g340 - temp_output_171_0_g340 )) / (1.0 - -1.0));
				float FB_MaxBorderSize291 = _FlashBang_MaxBorderSize;
				float temp_output_39_0_g340 = FB_MaxBorderSize291;
				float temp_output_176_0_g340 = ( temp_output_39_0_g340 / 4.0 );
				float temp_output_168_0_g340 = (( temp_output_39_0_g340 - temp_output_176_0_g340 ) + (temp_output_90_0_g340 - -1.0) * (( temp_output_39_0_g340 + temp_output_176_0_g340 ) - ( temp_output_39_0_g340 - temp_output_176_0_g340 )) / (1.0 - -1.0));
				float2 appendResult141_g340 = (float2(temp_output_167_0_g340 , temp_output_168_0_g340));
				float2 DistortionX43_g341 = appendResult141_g340;
				float2 break45_g341 = DistortionX43_g341;
				float2 appendResult140_g340 = (float2(0.5 , 0.5));
				float2 texCoord1_g341 = i.uv.xy * float2( 1,1 ) + appendResult140_g340;
				float2 break98_g341 = UC_Pixels891;
				float pixelWidth30_g341 =  1.0f / break98_g341.x;
				float pixelHeight30_g341 = 1.0f / break98_g341.y;
				half2 pixelateduv30_g341 = half2((int)(texCoord1_g341.x / pixelWidth30_g341) * pixelWidth30_g341, (int)(texCoord1_g341.y / pixelHeight30_g341) * pixelHeight30_g341);
				float2 lerpResult32_g341 = lerp( texCoord1_g341 , pixelateduv30_g341 , (float)(int)IsUsingCamera50);
				float2 break81_g341 = ( lerpResult32_g341 - float2( 0.5,0.5 ) );
				float PosX56_g341 = break81_g341.x;
				float smoothstepResult41_g341 = smoothstep( break45_g341.x , break45_g341.y , PosX56_g341);
				float2 break47_g341 = ( 1.0 - DistortionX43_g341 );
				float smoothstepResult42_g341 = smoothstep( break47_g341.x , break47_g341.y , PosX56_g341);
				float temp_output_40_0_g341 = ( smoothstepResult41_g341 * smoothstepResult42_g341 );
				float2 appendResult142_g340 = (float2(temp_output_167_0_g340 , temp_output_168_0_g340));
				float2 DistortionY71_g341 = appendResult142_g340;
				float2 break60_g341 = DistortionY71_g341;
				float PosY57_g341 = break81_g341.y;
				float smoothstepResult58_g341 = smoothstep( break60_g341.x , break60_g341.y , PosY57_g341);
				float2 break62_g341 = ( 1.0 - DistortionY71_g341 );
				float smoothstepResult61_g341 = smoothstep( break62_g341.x , break62_g341.y , PosY57_g341);
				float temp_output_65_0_g341 = ( smoothstepResult58_g341 * smoothstepResult61_g341 );
				float temp_output_72_0_g341 = ( temp_output_40_0_g341 * temp_output_65_0_g341 );
				float4 appendResult96_g341 = (float4(temp_output_72_0_g341 , temp_output_72_0_g341 , temp_output_72_0_g341 , temp_output_72_0_g341));
				float4 Color67_g340 = FB_Color278;
				float4 temp_output_1035_0 = ( appendResult317_g340 + ( ( ( 1.0 - appendResult96_g341 ) * Color67_g340 ) * Alpha308_g340 ) );
				int lerpResult18_g343 = lerp( 0 , 1 , (float)(int)break368.b);
				float4 lerpResult4_g343 = lerp( lerpResult5_g343 , temp_output_1035_0 , (float)lerpResult18_g343);
				int lerpResult32_g343 = lerp( 0 , 1 , (float)(int)break368.a);
				float4 lerpResult21_g343 = lerp( lerpResult4_g343 , temp_output_1035_0 , (float)lerpResult32_g343);
				float4 PostFlashBang24 = lerpResult21_g343;
				float IsFlashBanged42 = _IsFlashBanged;
				int lerpResult15_g361 = lerp( 0 , 1 , (float)(int)IsFlashBanged42);
				float4 lerpResult5_g361 = lerp( lerpResult9_g361 , PostFlashBang24 , (float)lerpResult15_g361);
				int lerpResult14_g344 = lerp( 0 , 1 , (float)(int)IsDrunk49);
				float4 lerpResult9_g344 = lerp( ScreenRGB14 , PostDrunk16 , (float)lerpResult14_g344);
				int lerpResult15_g344 = lerp( 0 , 1 , (float)(int)IsFlashBanged42);
				float4 lerpResult5_g344 = lerp( lerpResult9_g344 , PostFlashBang24 , (float)lerpResult15_g344);
				float4 temp_output_392_0 = lerpResult5_g344;
				float2 Da_VignetteBlurr472 = _Damage_VignetteBlurr;
				float2 VignetteBlurr94_g345 = Da_VignetteBlurr472;
				float2 break226_g345 = VignetteBlurr94_g345;
				float4 temp_cast_53 = (break226_g345.x).xxxx;
				float4 temp_cast_54 = (break226_g345.y).xxxx;
				float2 texCoord1_g347 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float2 Pixels33_g345 = UC_Pixels891;
				float2 break38_g345 = Pixels33_g345;
				float pixelWidth30_g347 =  1.0f / break38_g345.x;
				float pixelHeight30_g347 = 1.0f / break38_g345.y;
				half2 pixelateduv30_g347 = half2((int)(texCoord1_g347.x / pixelWidth30_g347) * pixelWidth30_g347, (int)(texCoord1_g347.y / pixelHeight30_g347) * pixelHeight30_g347);
				int IsPixelated32_g345 = (int)IsUsingCamera50;
				float2 lerpResult32_g347 = lerp( texCoord1_g347 , pixelateduv30_g347 , (float)IsPixelated32_g345);
				float2 break5_g347 = ( lerpResult32_g347 - float2( 0.5,0.5 ) );
				float temp_output_78_0_g345 = sin( _Time.y );
				float VignetteTime40_g345 = temp_output_78_0_g345;
				float3 Da_Speeds437 = _Damage_Speeds;
				float3 break7_g345 = Da_Speeds437;
				float SpeedRadius122_g345 = break7_g345.x;
				float temp_output_222_0_g345 = ( VignetteTime40_g345 * SpeedRadius122_g345 );
				float2 Da_Distortion436 = _Damage_Distortion;
				float2 Distortion34_g345 = Da_Distortion436;
				float2 break107_g345 = Distortion34_g345;
				float3 Da_FluctuationRange435 = _Damage_FluctuationRange;
				float3 break11_g345 = Da_FluctuationRange435;
				float FluctuationRange116_g345 = break11_g345.x;
				float temp_output_143_0_g345 = ( break107_g345.x * FluctuationRange116_g345 );
				float temp_output_144_0_g345 = ( break107_g345.y * FluctuationRange116_g345 );
				float2 appendResult97_g345 = (float2((( break107_g345.x - temp_output_143_0_g345 ) + (temp_output_222_0_g345 - -1.0) * (( break107_g345.x + temp_output_143_0_g345 ) - ( break107_g345.x - temp_output_143_0_g345 )) / (1.0 - -1.0)) , (( break107_g345.y - temp_output_144_0_g345 ) + (temp_output_222_0_g345 - -1.0) * (( break107_g345.y + temp_output_144_0_g345 ) - ( break107_g345.y - temp_output_144_0_g345 )) / (1.0 - -1.0))));
				float2 VignetteDistortion1146_g345 = appendResult97_g345;
				float2 break28_g347 = VignetteDistortion1146_g345;
				float2 appendResult10_g347 = (float2(( ( break5_g347.x / _ScreenParams.y ) * break28_g347.x ) , ( ( break5_g347.y / _ScreenParams.x ) * break28_g347.y )));
				float3 Da_Radiuses434 = _Damage_Radiuses;
				float3 break9_g345 = Da_Radiuses434;
				float Radius113_g345 = break9_g345.x;
				float temp_output_16_0_g347 = ( 1.0 - distance( ( appendResult10_g347 * Radius113_g345 ) , float2( 0,0 ) ) );
				float4 appendResult24_g347 = (float4(temp_output_16_0_g347 , temp_output_16_0_g347 , temp_output_16_0_g347 , temp_output_16_0_g347));
				float4 smoothstepResult80_g345 = smoothstep( temp_cast_53 , temp_cast_54 , appendResult24_g347);
				float4 Da_Color1440 = _Damage_Color1;
				float4 Color131_g345 = Da_Color1440;
				float4 temp_cast_57 = (break226_g345.x).xxxx;
				float4 temp_cast_58 = (break226_g345.y).xxxx;
				float2 texCoord1_g348 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float2 break44_g345 = Pixels33_g345;
				float pixelWidth30_g348 =  1.0f / break44_g345.x;
				float pixelHeight30_g348 = 1.0f / break44_g345.y;
				half2 pixelateduv30_g348 = half2((int)(texCoord1_g348.x / pixelWidth30_g348) * pixelWidth30_g348, (int)(texCoord1_g348.y / pixelHeight30_g348) * pixelHeight30_g348);
				float2 lerpResult32_g348 = lerp( texCoord1_g348 , pixelateduv30_g348 , (float)IsPixelated32_g345);
				float2 break5_g348 = ( lerpResult32_g348 - float2( 0.5,0.5 ) );
				float SpeedRadius223_g345 = break7_g345.y;
				float temp_output_223_0_g345 = ( VignetteTime40_g345 * SpeedRadius223_g345 );
				float2 break172_g345 = Distortion34_g345;
				float FluctuationRange217_g345 = break11_g345.y;
				float temp_output_175_0_g345 = ( break172_g345.x * FluctuationRange217_g345 );
				float temp_output_176_0_g345 = ( break172_g345.y * FluctuationRange217_g345 );
				float2 appendResult181_g345 = (float2((( break172_g345.x - temp_output_175_0_g345 ) + (temp_output_223_0_g345 - -1.0) * (( break172_g345.x + temp_output_175_0_g345 ) - ( break172_g345.x - temp_output_175_0_g345 )) / (1.0 - -1.0)) , (( break172_g345.y - temp_output_176_0_g345 ) + (temp_output_223_0_g345 - -1.0) * (( break172_g345.y + temp_output_176_0_g345 ) - ( break172_g345.y - temp_output_176_0_g345 )) / (1.0 - -1.0))));
				float2 VignetteDistortion2182_g345 = appendResult181_g345;
				float2 break28_g348 = VignetteDistortion2182_g345;
				float2 appendResult10_g348 = (float2(( ( break5_g348.x / _ScreenParams.y ) * break28_g348.x ) , ( ( break5_g348.y / _ScreenParams.x ) * break28_g348.y )));
				float Radius214_g345 = break9_g345.y;
				float temp_output_16_0_g348 = ( 1.0 - distance( ( appendResult10_g348 * Radius214_g345 ) , float2( 0,0 ) ) );
				float4 appendResult24_g348 = (float4(temp_output_16_0_g348 , temp_output_16_0_g348 , temp_output_16_0_g348 , temp_output_16_0_g348));
				float4 smoothstepResult81_g345 = smoothstep( temp_cast_57 , temp_cast_58 , appendResult24_g348);
				float4 Da_Color2439 = _Damage_Color2;
				float4 Color262_g345 = Da_Color2439;
				float4 temp_cast_60 = (break226_g345.x).xxxx;
				float4 temp_cast_61 = (break226_g345.y).xxxx;
				float2 texCoord1_g346 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float2 break54_g345 = Pixels33_g345;
				float pixelWidth30_g346 =  1.0f / break54_g345.x;
				float pixelHeight30_g346 = 1.0f / break54_g345.y;
				half2 pixelateduv30_g346 = half2((int)(texCoord1_g346.x / pixelWidth30_g346) * pixelWidth30_g346, (int)(texCoord1_g346.y / pixelHeight30_g346) * pixelHeight30_g346);
				float2 lerpResult32_g346 = lerp( texCoord1_g346 , pixelateduv30_g346 , (float)IsPixelated32_g345);
				float2 break5_g346 = ( lerpResult32_g346 - float2( 0.5,0.5 ) );
				float SpeedRadius324_g345 = break7_g345.z;
				float temp_output_224_0_g345 = ( VignetteTime40_g345 * SpeedRadius324_g345 );
				float2 break207_g345 = Distortion34_g345;
				float FluctuationRange318_g345 = break11_g345.z;
				float temp_output_209_0_g345 = ( break207_g345.x * FluctuationRange318_g345 );
				float temp_output_210_0_g345 = ( break207_g345.y * FluctuationRange318_g345 );
				float2 appendResult213_g345 = (float2((( break207_g345.x - temp_output_209_0_g345 ) + (temp_output_224_0_g345 - -1.0) * (( break207_g345.x + temp_output_209_0_g345 ) - ( break207_g345.x - temp_output_209_0_g345 )) / (1.0 - -1.0)) , (( break207_g345.y - temp_output_210_0_g345 ) + (temp_output_224_0_g345 - -1.0) * (( break207_g345.y + temp_output_210_0_g345 ) - ( break207_g345.y - temp_output_210_0_g345 )) / (1.0 - -1.0))));
				float2 VignetteDistortion3214_g345 = appendResult213_g345;
				float2 break28_g346 = VignetteDistortion3214_g345;
				float2 appendResult10_g346 = (float2(( ( break5_g346.x / _ScreenParams.y ) * break28_g346.x ) , ( ( break5_g346.y / _ScreenParams.x ) * break28_g346.y )));
				float Radius315_g345 = break9_g345.z;
				float temp_output_16_0_g346 = ( 1.0 - distance( ( appendResult10_g346 * Radius315_g345 ) , float2( 0,0 ) ) );
				float4 appendResult24_g346 = (float4(temp_output_16_0_g346 , temp_output_16_0_g346 , temp_output_16_0_g346 , temp_output_16_0_g346));
				float4 smoothstepResult82_g345 = smoothstep( temp_cast_60 , temp_cast_61 , appendResult24_g346);
				float4 Da_Color3438 = _Damage_Color3;
				float4 Color364_g345 = Da_Color3438;
				float Da_Alpha520 = _Damage_Alpha;
				float4 temp_output_698_0 = ( ( ( ( ( 1.0 - smoothstepResult80_g345 ) * Color131_g345 ) + ( ( 1.0 - smoothstepResult81_g345 ) * Color262_g345 ) + ( ( 1.0 - smoothstepResult82_g345 ) * Color364_g345 ) ) * Da_Alpha520 ) + temp_output_392_0 );
				float4 DamageAction1256 = _DamageAction1;
				float4 break541 = DamageAction1256;
				int lerpResult14_g349 = lerp( 0 , 1 , (float)(int)break541.r);
				float4 lerpResult9_g349 = lerp( temp_output_392_0 , temp_output_698_0 , (float)lerpResult14_g349);
				int lerpResult15_g349 = lerp( 0 , 1 , (float)(int)break541.g);
				float4 lerpResult5_g349 = lerp( lerpResult9_g349 , temp_output_698_0 , (float)lerpResult15_g349);
				int lerpResult18_g349 = lerp( 0 , 1 , (float)(int)break541.b);
				float4 lerpResult4_g349 = lerp( lerpResult5_g349 , temp_output_698_0 , (float)lerpResult18_g349);
				float4 PostDamage22 = lerpResult4_g349;
				float IsDamaged48 = _IsDamaged;
				int lerpResult18_g361 = lerp( 0 , 1 , (float)(int)IsDamaged48);
				float4 lerpResult4_g361 = lerp( lerpResult5_g361 , PostDamage22 , (float)lerpResult18_g361);
				int lerpResult14_g350 = lerp( 0 , 1 , (float)(int)IsDrunk49);
				float4 lerpResult9_g350 = lerp( ScreenRGB14 , PostDrunk16 , (float)lerpResult14_g350);
				int lerpResult15_g350 = lerp( 0 , 1 , (float)(int)IsFlashBanged42);
				float4 lerpResult5_g350 = lerp( lerpResult9_g350 , PostFlashBang24 , (float)lerpResult15_g350);
				int lerpResult18_g350 = lerp( 0 , 1 , (float)(int)IsDamaged48);
				float4 lerpResult4_g350 = lerp( lerpResult5_g350 , PostDamage22 , (float)lerpResult18_g350);
				float4 temp_output_386_0 = lerpResult4_g350;
				float4 Screen12_g351 = temp_output_386_0;
				float3 hsvTorgb3_g353 = RGBToHSV( Screen12_g351.rgb );
				float lerpResult16_g353 = lerp( 0.0 , 1.0 , 1.0);
				float lerpResult17_g353 = lerp( 0.0 , 1.0 , 1.0);
				float Time38_g351 = _Time.y;
				float2 H_ValueFrame619 = _Heal_ValueFrame;
				float2 break634 = H_ValueFrame619;
				float H_Alpha522 = _Heal_Alpha;
				float Alpha30_g351 = H_Alpha522;
				float lerpResult18_g353 = lerp( 0.0 , 1.0 , ( 1.0 - ( (break634.x + (( sin( Time38_g351 ) * 0.2 ) - -1.0) * (break634.y - break634.x) / (1.0 - -1.0)) * Alpha30_g351 ) ));
				float3 hsvTorgb8_g353 = HSVToRGB( float3(( hsvTorgb3_g353.x * lerpResult16_g353 ),( hsvTorgb3_g353.y * lerpResult17_g353 ),( hsvTorgb3_g353.z * lerpResult18_g353 )) );
				float3 break44_g351 = hsvTorgb8_g353;
				float4 appendResult16_g351 = (float4(break44_g351.x , break44_g351.y , break44_g351.z , 1.0));
				float4 H_ColorTint1595 = _Heal_TintColor1;
				float4 TintColorA63_g351 = H_ColorTint1595;
				float4 H_ColorTint2599 = _Heal_TintColor2;
				float4 TintColorB66_g351 = H_ColorTint2599;
				float4 lerpResult85_g351 = lerp( TintColorA63_g351 , TintColorB66_g351 , (0.0 + (sin( _Time.y ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
				float H_GradientTimeScale621 = _Heal_GradientTimeScale;
				float mulTime19_g351 = _Time.y * H_GradientTimeScale621;
				float FlashBangTime33_g351 = mulTime19_g351;
				float temp_output_51_0_g351 = sin( FlashBangTime33_g351 );
				float2 H_BorderSize620 = _Heal_BorderSize;
				float2 break637 = H_BorderSize620;
				float temp_output_52_0_g351 = break637.x;
				float temp_output_57_0_g351 = ( temp_output_52_0_g351 / 4.0 );
				float temp_output_49_0_g351 = (( temp_output_52_0_g351 - temp_output_57_0_g351 ) + (temp_output_51_0_g351 - -1.0) * (( temp_output_52_0_g351 + temp_output_57_0_g351 ) - ( temp_output_52_0_g351 - temp_output_57_0_g351 )) / (1.0 - -1.0));
				float temp_output_40_0_g351 = break637.y;
				float temp_output_50_0_g351 = ( temp_output_40_0_g351 / 4.0 );
				float temp_output_42_0_g351 = (( temp_output_40_0_g351 - temp_output_50_0_g351 ) + (temp_output_51_0_g351 - -1.0) * (( temp_output_40_0_g351 + temp_output_50_0_g351 ) - ( temp_output_40_0_g351 - temp_output_50_0_g351 )) / (1.0 - -1.0));
				float2 appendResult35_g351 = (float2(temp_output_49_0_g351 , temp_output_42_0_g351));
				float2 DistortionX43_g352 = appendResult35_g351;
				float2 break45_g352 = DistortionX43_g352;
				float2 appendResult58_g351 = (float2(0.5 , 0.5));
				float2 texCoord1_g352 = i.uv.xy * float2( 1,1 ) + appendResult58_g351;
				float2 break98_g352 = UC_Pixels891;
				float pixelWidth30_g352 =  1.0f / break98_g352.x;
				float pixelHeight30_g352 = 1.0f / break98_g352.y;
				half2 pixelateduv30_g352 = half2((int)(texCoord1_g352.x / pixelWidth30_g352) * pixelWidth30_g352, (int)(texCoord1_g352.y / pixelHeight30_g352) * pixelHeight30_g352);
				float2 lerpResult32_g352 = lerp( texCoord1_g352 , pixelateduv30_g352 , (float)(int)IsUsingCamera50);
				float2 break81_g352 = ( lerpResult32_g352 - float2( 0.5,0.5 ) );
				float PosX56_g352 = break81_g352.x;
				float smoothstepResult41_g352 = smoothstep( break45_g352.x , break45_g352.y , PosX56_g352);
				float2 break47_g352 = ( 1.0 - DistortionX43_g352 );
				float smoothstepResult42_g352 = smoothstep( break47_g352.x , break47_g352.y , PosX56_g352);
				float temp_output_40_0_g352 = ( smoothstepResult41_g352 * smoothstepResult42_g352 );
				float2 appendResult47_g351 = (float2(temp_output_49_0_g351 , temp_output_42_0_g351));
				float2 DistortionY71_g352 = appendResult47_g351;
				float2 break60_g352 = DistortionY71_g352;
				float PosY57_g352 = break81_g352.y;
				float smoothstepResult58_g352 = smoothstep( break60_g352.x , break60_g352.y , PosY57_g352);
				float2 break62_g352 = ( 1.0 - DistortionY71_g352 );
				float smoothstepResult61_g352 = smoothstep( break62_g352.x , break62_g352.y , PosY57_g352);
				float temp_output_65_0_g352 = ( smoothstepResult58_g352 * smoothstepResult61_g352 );
				float temp_output_72_0_g352 = ( temp_output_40_0_g352 * temp_output_65_0_g352 );
				float4 appendResult96_g352 = (float4(temp_output_72_0_g352 , temp_output_72_0_g352 , temp_output_72_0_g352 , temp_output_72_0_g352));
				float4 temp_output_14_0_g351 = appendResult96_g352;
				float4 H_ColorBorder1594 = _Heal_BorderColor1;
				float4 BorderColorA13_g351 = H_ColorBorder1594;
				float4 H_ColorBorder2601 = _Heal_BorderColor2;
				float4 BorderColorB70_g351 = H_ColorBorder2601;
				float4 lerpResult72_g351 = lerp( BorderColorA13_g351 , BorderColorB70_g351 , (0.0 + (sin( _Time.y ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
				float4 screenPos = i.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float H_LineSpeed622 = _Heal_LineSpeed;
				float mulTime21_g351 = _Time.y * H_LineSpeed622;
				float H_LineFrequency624 = _Heal_LineFrequency;
				float H_LineSharpness625 = 0.1;
				float4 H_ColorLine1593 = _Heal_LineColor1;
				float4 LineColorA65_g351 = H_ColorLine1593;
				float4 H_ColorLine2600 = _Heal_LineColor2;
				float4 LineColorB71_g351 = H_ColorLine2600;
				float4 lerpResult78_g351 = lerp( LineColorA65_g351 , LineColorB71_g351 , (0.0 + (sin( _Time.y ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
				float H_LineTransparency623 = 0.5;
				float4 temp_output_1036_61 = ( ( appendResult16_g351 * lerpResult85_g351 ) + ( ( ( 1.0 - temp_output_14_0_g351 ) * lerpResult72_g351 ) * Alpha30_g351 ) + ( ( ( step( frac( ( ( ase_screenPosNorm.y - mulTime21_g351 ) * H_LineFrequency624 ) ) , H_LineSharpness625 ) * lerpResult78_g351 ) * H_LineTransparency623 ) * Alpha30_g351 ) );
				float4 HealAction1257 = _HealAction1;
				float4 break585 = HealAction1257;
				int lerpResult14_g354 = lerp( 0 , 1 , (float)(int)break585.r);
				float4 lerpResult9_g354 = lerp( temp_output_386_0 , temp_output_1036_61 , (float)lerpResult14_g354);
				int lerpResult15_g354 = lerp( 0 , 1 , (float)(int)break585.g);
				float4 lerpResult5_g354 = lerp( lerpResult9_g354 , temp_output_1036_61 , (float)lerpResult15_g354);
				int lerpResult18_g354 = lerp( 0 , 1 , (float)(int)break585.b);
				float4 lerpResult4_g354 = lerp( lerpResult5_g354 , temp_output_1036_61 , (float)lerpResult18_g354);
				float4 PostHeal20 = lerpResult4_g354;
				float IsHealing52 = _IsHealing;
				int lerpResult32_g361 = lerp( 0 , 1 , (float)(int)IsHealing52);
				float4 lerpResult21_g361 = lerp( lerpResult4_g361 , PostHeal20 , (float)lerpResult32_g361);
				int lerpResult14_g355 = lerp( 0 , 1 , (float)(int)IsDrunk49);
				float4 lerpResult9_g355 = lerp( ScreenRGB14 , PostDrunk16 , (float)lerpResult14_g355);
				int lerpResult15_g355 = lerp( 0 , 1 , (float)(int)IsFlashBanged42);
				float4 lerpResult5_g355 = lerp( lerpResult9_g355 , PostFlashBang24 , (float)lerpResult15_g355);
				int lerpResult18_g355 = lerp( 0 , 1 , (float)(int)IsDamaged48);
				float4 lerpResult4_g355 = lerp( lerpResult5_g355 , PostDamage22 , (float)lerpResult18_g355);
				int lerpResult32_g355 = lerp( 0 , 1 , (float)(int)IsHealing52);
				float4 lerpResult21_g355 = lerp( lerpResult4_g355 , PostHeal20 , (float)lerpResult32_g355);
				float4 temp_output_389_0 = lerpResult21_g355;
				float3 hsvTorgb3_g359 = RGBToHSV( temp_output_389_0.rgb );
				float lerpResult16_g359 = lerp( 0.0 , 1.0 , 1.0);
				float lerpResult17_g359 = lerp( 0.0 , 1.0 , 0.7);
				float lerpResult18_g359 = lerp( 0.0 , 1.0 , 0.6);
				float3 hsvTorgb8_g359 = HSVToRGB( float3(( hsvTorgb3_g359.x * lerpResult16_g359 ),( hsvTorgb3_g359.y * lerpResult17_g359 ),( hsvTorgb3_g359.z * lerpResult18_g359 )) );
				float3 break12_g356 = hsvTorgb8_g359;
				float4 appendResult13_g356 = (float4(break12_g356.x , break12_g356.y , break12_g356.z , 1.0));
				float UC_Alpha524 = _UseCamera_Alpha;
				float Alpha79_g356 = UC_Alpha524;
				float4 temp_output_9_0_g356 = ( ase_screenPosNorm + _Time.y );
				float simplePerlin3D10_g356 = snoise( temp_output_9_0_g356.xyz*30.0 );
				simplePerlin3D10_g356 = simplePerlin3D10_g356*0.5 + 0.5;
				float2 break19_g357 = float2( -18,0.05 );
				float4 temp_output_1_0_g357 = temp_output_9_0_g356;
				float4 sinIn7_g357 = sin( temp_output_1_0_g357 );
				float4 sinInOffset6_g357 = sin( ( temp_output_1_0_g357 + 1.0 ) );
				float lerpResult20_g357 = lerp( break19_g357.x , break19_g357.y , frac( ( sin( ( ( sinIn7_g357 - sinInOffset6_g357 ) * 91.2228 ) ) * 43758.55 ) ).x);
				float4 color56_g356 = IsGammaSpace() ? float4(0.2126,0.7152,0.0722,1) : float4(0.03716727,0.4699402,0.006236819,1);
				float4 ToFloat66_g356 = color56_g356;
				float dotResult55_g356 = dot( ( lerpResult20_g357 + sinIn7_g357 ) , ToFloat66_g356 );
				float temp_output_18_0_g356 = ( Alpha79_g356 * ( step( simplePerlin3D10_g356 , (0.05 + (sin( _SinTime.w ) - -1.0) * (0.1 - 0.05) / (1.0 - -1.0)) ) + ( 1.0 - step( dotResult55_g356 , 0.0 ) ) ) );
				float4 appendResult59_g356 = (float4(temp_output_18_0_g356 , temp_output_18_0_g356 , temp_output_18_0_g356 , 1.0));
				float2 UC_RecDisplacement908 = _UseCamera_RecDisplacement;
				float2 texCoord1_g358 = i.uv.xy * float2( 1,1 ) + UC_RecDisplacement908;
				float2 break43_g356 = UC_Pixels891;
				float pixelWidth30_g358 =  1.0f / break43_g356.x;
				float pixelHeight30_g358 = 1.0f / break43_g356.y;
				half2 pixelateduv30_g358 = half2((int)(texCoord1_g358.x / pixelWidth30_g358) * pixelWidth30_g358, (int)(texCoord1_g358.y / pixelHeight30_g358) * pixelHeight30_g358);
				float2 lerpResult32_g358 = lerp( texCoord1_g358 , pixelateduv30_g358 , (float)(int)IsUsingCamera50);
				float2 break5_g358 = ( lerpResult32_g358 - float2( 0.5,0.5 ) );
				float2 UC_RecDistortion906 = _UseCamera_RecDistortion;
				float2 break28_g358 = UC_RecDistortion906;
				float2 appendResult10_g358 = (float2(( ( break5_g358.x / _ScreenParams.y ) * break28_g358.x ) , ( ( break5_g358.y / _ScreenParams.x ) * break28_g358.y )));
				float UC_RecRadius904 = _UseCamera_RecRadius;
				float temp_output_16_0_g358 = ( 1.0 - distance( ( appendResult10_g358 * UC_RecRadius904 ) , float2( 0,0 ) ) );
				float4 appendResult24_g358 = (float4(temp_output_16_0_g358 , temp_output_16_0_g358 , temp_output_16_0_g358 , temp_output_16_0_g358));
				float4 temp_output_50_0_g356 = step( appendResult24_g358 , float4( 0,0,0,0 ) );
				float mulTime74_g356 = _Time.y * 2.0;
				float temp_output_73_0_g356 = step( 0.0 , sin( mulTime74_g356 ) );
				float temp_output_77_0_g356 = ( 1.0 - temp_output_73_0_g356 );
				float4 lerpResult78_g356 = lerp( ( temp_output_50_0_g356 * Alpha79_g356 ) , float4( 1,1,1,1 ) , temp_output_77_0_g356);
				float4 lerpResult76_g356 = lerp( ( 1.0 - ( temp_output_50_0_g356 * temp_output_73_0_g356 ) ) , float4( 0,0,0,0 ) , temp_output_77_0_g356);
				float4 color53_g356 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
				float4 temp_output_1042_0 = ( ( ( appendResult13_g356 + appendResult59_g356 ) * lerpResult78_g356 ) + ( lerpResult76_g356 * ( Alpha79_g356 * color53_g356 ) ) );
				float4 UseCameraAction1253 = _UseCameraAction1;
				float4 break661 = UseCameraAction1253;
				int lerpResult14_g360 = lerp( 0 , 1 , (float)(int)break661.r);
				float4 lerpResult9_g360 = lerp( temp_output_389_0 , temp_output_1042_0 , (float)lerpResult14_g360);
				int lerpResult15_g360 = lerp( 0 , 1 , (float)(int)break661.g);
				float4 lerpResult5_g360 = lerp( lerpResult9_g360 , temp_output_1042_0 , (float)lerpResult15_g360);
				int lerpResult18_g360 = lerp( 0 , 1 , (float)(int)break661.b);
				float4 lerpResult4_g360 = lerp( lerpResult5_g360 , temp_output_1042_0 , (float)lerpResult18_g360);
				float4 PostCamera27 = lerpResult4_g360;
				int lerpResult23_g361 = lerp( 0 , 1 , (float)(int)IsUsingCamera50);
				float4 lerpResult22_g361 = lerp( lerpResult21_g361 , PostCamera27 , (float)lerpResult23_g361);
				float4 temp_output_390_0 = lerpResult22_g361;
				float WU_Alpha525 = _WakeUp_Alpha;
				float4 WakeUpAction1258 = _WakeUpAction1;
				float4 break668 = WakeUpAction1258;
				int lerpResult14_g366 = lerp( 0 , 1 , (float)(int)break668.r);
				float4 lerpResult9_g366 = lerp( temp_output_390_0 , ( temp_output_390_0 * WU_Alpha525 ) , (float)lerpResult14_g366);
				int lerpResult15_g366 = lerp( 0 , 1 , (float)(int)break668.g);
				float4 lerpResult5_g366 = lerp( lerpResult9_g366 , float4( 0,0,0,0 ) , (float)lerpResult15_g366);
				float2 texCoord1_g365 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float pixelWidth30_g365 =  1.0f / 1000.0;
				float pixelHeight30_g365 = 1.0f / 1000.0;
				half2 pixelateduv30_g365 = half2((int)(texCoord1_g365.x / pixelWidth30_g365) * pixelWidth30_g365, (int)(texCoord1_g365.y / pixelHeight30_g365) * pixelHeight30_g365);
				float2 lerpResult32_g365 = lerp( texCoord1_g365 , pixelateduv30_g365 , (float)0);
				float2 break5_g365 = ( lerpResult32_g365 - float2( 0.5,0.5 ) );
				float2 WU_EyeSize965 = _WakeUp_EyeSize;
				float2 break11_g364 = WU_EyeSize965;
				float WU_Time984 = _WakeUp_Time;
				float mulTime15_g364 = _Time.y * WU_Time984;
				float temp_output_17_0_g364 = (0.0 + (sin( mulTime15_g364 ) - -1.0) * (break11_g364.y - 0.0) / (1.0 - -1.0));
				float2 appendResult10_g364 = (float2(break11_g364.x , temp_output_17_0_g364));
				float2 break28_g365 = appendResult10_g364;
				float2 appendResult10_g365 = (float2(( ( break5_g365.x / _ScreenParams.y ) * break28_g365.x ) , ( ( break5_g365.y / _ScreenParams.x ) * break28_g365.y )));
				float WU_EyeRadius963 = _WakeUp_EyeRadius;
				float temp_output_16_0_g365 = ( 1.0 - distance( ( appendResult10_g365 * WU_EyeRadius963 ) , float2( 0,0 ) ) );
				float4 appendResult24_g365 = (float4(temp_output_16_0_g365 , temp_output_16_0_g365 , temp_output_16_0_g365 , temp_output_16_0_g365));
				int lerpResult18_g366 = lerp( 0 , 1 , (float)(int)break668.b);
				float4 lerpResult4_g366 = lerp( lerpResult5_g366 , ( temp_output_390_0 * appendResult24_g365 ) , (float)lerpResult18_g366);
				float2 texCoord1_g363 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float pixelWidth30_g363 =  1.0f / 1000.0;
				float pixelHeight30_g363 = 1.0f / 1000.0;
				half2 pixelateduv30_g363 = half2((int)(texCoord1_g363.x / pixelWidth30_g363) * pixelWidth30_g363, (int)(texCoord1_g363.y / pixelHeight30_g363) * pixelHeight30_g363);
				float2 lerpResult32_g363 = lerp( texCoord1_g363 , pixelateduv30_g363 , (float)0);
				float2 break5_g363 = ( lerpResult32_g363 - float2( 0.5,0.5 ) );
				float2 break13_g362 = WU_EyeSize965;
				float WU_Blinking987 = _WakeUp_Blinking;
				float mulTime9_g362 = _Time.y * ( WU_Time984 / WU_Blinking987 );
				float2 appendResult7_g362 = (float2(break13_g362.x , ( break13_g362.y - (0.0 + (sin( mulTime9_g362 ) - -1.0) * (break13_g362.y - 0.0) / (1.0 - -1.0)) )));
				float2 break28_g363 = appendResult7_g362;
				float2 appendResult10_g363 = (float2(( ( break5_g363.x / _ScreenParams.y ) * break28_g363.x ) , ( ( break5_g363.y / _ScreenParams.x ) * break28_g363.y )));
				float temp_output_16_0_g363 = ( 1.0 - distance( ( appendResult10_g363 * WU_EyeRadius963 ) , float2( 0,0 ) ) );
				float4 appendResult24_g363 = (float4(temp_output_16_0_g363 , temp_output_16_0_g363 , temp_output_16_0_g363 , temp_output_16_0_g363));
				float4 temp_output_1032_0 = ( temp_output_390_0 * ( appendResult24_g363 * WU_Alpha525 ) );
				int lerpResult32_g366 = lerp( 0 , 1 , (float)(int)break668.a);
				float4 lerpResult21_g366 = lerp( lerpResult4_g366 , temp_output_1032_0 , (float)lerpResult32_g366);
				float4 WakeUpAction2508 = _WakeUpAction2;
				int lerpResult23_g366 = lerp( 0 , 1 , (float)(int)WakeUpAction2508.r);
				float4 lerpResult22_g366 = lerp( lerpResult21_g366 , temp_output_1032_0 , (float)lerpResult23_g366);
				float4 PostWakeUp18 = lerpResult22_g366;
				

				finalColor = PostWakeUp18;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
-1553;73;1113;573;-82.04523;1132.306;1.581415;True;False
Node;AmplifyShaderEditor.CommentaryNode;725;-1025.226,1651.842;Inherit;False;2896.365;570.9409;Camera;8;908;907;906;905;891;890;904;903;;1,0,0.8365736,1;0;0
Node;AmplifyShaderEditor.Vector2Node;890;-780.9621,1747.302;Inherit;False;Property;_UseCamera_Pixels;UseCamera_Pixels;53;0;Create;True;0;0;0;False;0;False;4096,1024;4096,1024;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;726;-1273.312,-1192.727;Inherit;False;1508.324;881.5215;Screen UV Distortion;10;897;736;14;754;742;740;727;738;728;896;;1,0.9504018,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;555;239.4769,-975.9851;Inherit;False;1627.4;665.7764;Script Variables;43;51;42;46;39;50;47;48;44;12;45;49;52;522;500;523;501;502;524;525;503;519;499;520;498;505;507;510;513;504;258;372;509;511;253;373;254;374;257;371;256;370;252;369;;0.02353477,0,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;891;-780.9357,1863.776;Inherit;False;UC_Pixels;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;28;-1413.362,-1116.679;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;896;-1025.434,-971.2059;Inherit;False;891;UC_Pixels;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;728;-1261.63,-1157.452;Inherit;False;220.1751;304.2274;Regular;1;732;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;47;260.0762,-521.647;Inherit;False;Property;_IsUsingCamera;IsUsingCamera?;9;2;[HideInInspector];[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;738;-836.0522,-1122.203;Inherit;False;263.9512;264.3229;Camera;1;733;;1,0,0.8365736,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;897;-1022.351,-1058.216;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;515.6049,-519.9588;Inherit;False;IsUsingCamera;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;732;-1248.529,-1117.184;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;736;-550.0048,-1001.827;Inherit;False;50;IsUsingCamera;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCPixelate;733;-820.1823,-1082.46;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;1000;False;2;FLOAT;1000;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;777;-1300.43,-1083.881;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;740;-549.4415,-1106.679;Inherit;False;Uriel_SimpleVector2 Selector;-1;;4;1ab15d379cefe6548b02dd0ed3b1b65d;0;3;11;FLOAT2;0,0;False;15;FLOAT2;0,0;False;13;INT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;742;-254.8396,-1110.752;Inherit;False;PostCameraUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;727;-1263.999,-763.4995;Inherit;False;1500.069;443.6183;Drunk;11;755;766;773;29;765;774;771;819;747;822;772;;0.4784314,0,1,1;0;0
Node;AmplifyShaderEditor.WireNode;776;-1299.68,-1084.519;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;744;-1299.597,-1085.795;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;783;-1301.404,-1085.943;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;768;-1298.754,-1084.755;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;747;-1257.539,-684.4431;Inherit;False;742;PostCameraUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;759;-1299.763,-1087.639;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;819;-1229.733,-497.9465;Inherit;False;Property;_Drunk_Speed;Drunk_Speed;48;0;Create;True;0;0;0;False;0;False;0;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;822;-1230.932,-621.5462;Inherit;False;Property;_Drunk_Strength;Drunk_Strength;49;0;Create;True;0;0;0;False;0;False;0.01,0.1;0.01,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;778;-1301.018,-518.6088;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;779;-1303.018,-517.6088;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;767;-1299.977,-1085.978;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;1018;-1062.045,-679.5099;Inherit;True;Uriel_Drunk_SwayDistortion;-1;;5;440d3153309743f46a421b8bc85f190f;0;4;15;FLOAT2;0.5,0.5;False;19;FLOAT2;4,0;False;8;FLOAT;0.75;False;61;FLOAT3;0,0,0;False;4;FLOAT2;0;FLOAT2;102;FLOAT2;100;FLOAT2;101
Node;AmplifyShaderEditor.WireNode;743;-1299.597,-1085.794;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;758;-1299.763,-1087.639;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;782;-1299.825,-1087.522;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;771;-239.1294,-544.5786;Inherit;True;Property;_TextureSample3;Texture Sample 3;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;769;-1303.744,-648.4102;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;781;-1303.647,-486.1516;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;757;-1299.762,-1109.439;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;745;-1302.353,-682.8414;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;770;-1303.744,-649.6339;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;746;-1302.353,-681.2415;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;780;-1305.541,-484.5726;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;756;-1301.216,-1107.985;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;774;33.11347,-507.4035;Inherit;False;DrunkRGB3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;718;-31.90497,-305.9843;Inherit;False;1232.267;3227.794;Shaders;31;910;911;909;892;888;902;893;859;793;788;835;860;800;797;836;805;807;798;833;792;808;806;834;803;802;801;804;1038;1039;1040;1041;;0.6981132,0.6948202,0.6948202,1;0;0
Node;AmplifyShaderEditor.SamplerNode;29;-241.6816,-715.0894;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;754;-69.05523,-1133.575;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;804;-23.56528,-98.83175;Inherit;False;774;DrunkRGB3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;765;-802.0231,-684.3239;Inherit;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;772;-799.4709,-513.8132;Inherit;True;Property;_TextureSample4;Texture Sample 4;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;755;31.56123,-683.9143;Inherit;False;DrunkRGB1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;773;-519.0642,-513.9145;Inherit;False;DrunkRGB4;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-73.16747,-958.4424;Inherit;False;ScreenRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;801;152.4926,-93.06635;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.125,0.125,0.125,0.1254902;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;766;-521.6165,-684.4251;Inherit;False;DrunkRGB2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;834;856.8026,72.35897;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;792;271.0637,-211.3935;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;808;270.7365,-35.31619;Inherit;False;773;DrunkRGB4;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;803;278.0348,-124.8317;Inherit;False;766;DrunkRGB2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;806;570.1347,-60.23172;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;501;1453.291,-848.533;Inherit;False;Property;_Drunk_Alpha;Drunk_Alpha;40;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;802;-19.66529,-188.5317;Inherit;False;755;DrunkRGB1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;523;1597.067,-848.304;Inherit;False;Dr_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;800;453.6217,-119.9048;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.125,0.125,0.125,0.1254902;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;805;571.4346,-60.23171;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;836;448.2385,53.49162;Inherit;False;Property;_Drunk_Hue;Drunk_Hue;50;0;Create;True;0;0;0;False;0;False;0,0;0.75,0.9;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;807;451.7329,-29.74711;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.1254902,0.1254902,0.1254902,0.1254902;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;833;853.8026,10.35897;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;798;150.0291,-184.2262;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.125,0.125,0.125,0.1254902;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;797;452.0601,-205.8244;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.5,0.5,0.5,0.5019608;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;835;1021.803,10.35897;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;788;604.2085,-206.2398;Inherit;False;5;5;0;COLOR;0.5,0.5,0.5,0.5019608;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;860;856.3516,-59.55183;Inherit;False;523;Dr_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;859;1020.352,-78.55183;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;793;718.105,-206.1244;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1034;843.8026,-206.641;Inherit;False;Uriel_HSVReadjustment;-1;;337;8b9acfc5fb713664a9fa50d7d5dae1d8;0;4;9;COLOR;0,0,0,0;False;10;FLOAT;1;False;11;FLOAT;1;False;12;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;724;-583.1591,-273.7707;Inherit;False;2453.483;463.0695;Drunk;1;863;;0.4784961,0,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;863;1136.679,-205.0066;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;723;1198.713,-305.1474;Inherit;False;673.4225;3227.208;Select Current Shader Actions;30;27;659;878;661;880;877;879;660;875;881;876;882;24;518;368;319;16;656;858;871;658;657;870;868;854;866;864;865;867;862;;0.4716981,0.4561232,0.4561232,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;862;1241.251,-205.2518;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;867;1365.308,-176.025;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;865;1365.308,-175.025;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;864;1364.308,-176.025;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;374;1662.727,-764.4509;Inherit;False;Property;_DrunkAction1;DrunkAction1;21;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;254;1663.425,-603.2286;Inherit;False;DrunkAction1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;866;1367.308,-173.025;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;854;1367.768,-173.7723;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;870;1366.308,-127.025;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;717;-584.6627,-305.8817;Inherit;False;552.4869;3225.498;Select Active Shaders;16;389;66;67;68;62;63;61;64;17;65;54;842;841;843;844;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;657;1236.406,-33.84798;Inherit;False;254;DrunkAction1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;868;1366.308,-86.02499;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;658;1409.05,-28.53401;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;858;1367.355,-85.16904;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;13;-542.7553,-241.4476;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;871;1366.308,-127.025;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;656;1405.457,-230.0249;Inherit;False;Uriel_TripleColorSelector;-1;;338;68eae7d6c234c244a816739ac0f6ff6b;0;7;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;265.5445,-391.4064;Inherit;False;Property;_IsDrunk;IsDrunk?;10;2;[HideInInspector];[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;1692.473,-234.702;Inherit;False;PostDrunk;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;556;-1291.094,192.2091;Inherit;False;3160.996;444.6543;Flash Bang;34;278;260;288;289;290;291;160;170;176;173;287;200;691;25;38;43;417;357;526;296;279;295;545;294;293;292;546;530;547;528;527;376;885;895;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;514.9743,-391.1481;Inherit;False;IsDrunk;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-334.4791,328.2223;Inherit;False;49;IsDrunk;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-546.3407,292.9208;Inherit;False;16;PostDrunk;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;-545.4696,225.7215;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;417;-337.0784,219.7459;Inherit;False;Uriel_SimpleColorSelector;-1;;339;211687b70dc7e754fa92527f6fd124ea;0;3;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;844;-67.33362,249.6071;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;499;760.006,-922.1605;Inherit;False;Property;_FlashBang_Alpha;FlashBang_Alpha;38;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;260;-1276.984,230.4989;Inherit;False;Constant;_FlashBang_Color;FlashBang_Color;17;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;278;-1272.785,396.9307;Inherit;False;FB_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-1077.77,300.8958;Inherit;False;Property;_FlashBang_MinSaturation;FlashBang_MinSaturation;5;0;Create;True;0;0;0;False;0;False;3;0.569;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;843;-66.33362,251.6071;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;176;-1078.071,368.8032;Inherit;False;Property;_FlashBang_MaxSaturation;FlashBang_MaxSaturation;6;0;Create;True;0;0;0;False;0;False;3;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;519;930.4083,-922.1238;Inherit;False;FB_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-1073.452,230.2206;Inherit;False;Property;_FlashBang_GradientTimeScale;FlashBang_GradientTimeScale;2;0;Create;True;0;0;0;False;0;False;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;170;-1080.081,435.9167;Inherit;False;Property;_FlashBang_MinBorderSize;FlashBang_MinBorderSize;4;0;Create;True;0;0;0;False;0;False;3;0.061;0.0001;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-1079.942,502.8095;Inherit;False;Property;_FlashBang_MaxBorderSize;FlashBang_MaxBorderSize;3;0;Create;True;0;0;0;False;0;False;3;0.134;0.0001;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;357;8.651165,262.4991;Inherit;False;278;FB_Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;287;-804.774,229.8283;Inherit;False;FB_GradientTimeScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;841;-68.33362,275.6071;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;526;-29.97701,507.2057;Inherit;False;519;FB_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;288;-773.1936,298.904;Inherit;False;FB_MinSaturation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;289;-771.2725,365.9071;Inherit;False;FB_MaxSaturation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;-778.4609,504.2735;Inherit;False;FB_MaxBorderSize;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;290;-775.3922,436.3358;Inherit;False;FB_MinBorderSize;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;296;694.5967,413.7585;Inherit;False;288;FB_MinSaturation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;376;-24.7822,336.7841;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;294;455.1407,435.8012;Inherit;False;289;FB_MaxSaturation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;842;-68.33362,274.6071;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;885;268.0865,532.7567;Inherit;False;50;IsUsingCamera;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;292;456.2881,389.716;Inherit;False;287;FB_GradientTimeScale;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;295;695.3584,461.5187;Inherit;False;290;FB_MinBorderSize;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;452.6836,485.9736;Inherit;False;291;FB_MaxBorderSize;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;545;178.9256,267.9298;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;895;690.4958,556.7928;Inherit;False;891;UC_Pixels;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;279;695.6326,365.0953;Inherit;False;278;FB_Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1035;904.3831,346.819;Inherit;False;Uriel_FlashBang_2_RegainSight;-1;;340;8afafd4ab87642a498d39a82af6dab06;0;10;1;COLOR;0,0,0,0;False;298;COLOR;0,0,0,0;False;292;FLOAT;0;False;179;FLOAT;0;False;305;FLOAT;0;False;170;FLOAT;0.025;False;39;FLOAT;0.025;False;307;FLOAT;0.3;False;300;INT;0;False;301;FLOAT2;1000,1000;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;546;311.1576,244.2671;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;688;1186.68,376.7766;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;530;416.9715,275.4497;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;369;731.058,-764.6296;Inherit;False;Property;_FlashBangAction1;FlashBangAction1;11;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;689;1185.68,376.7766;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;252;730.9123,-602.847;Inherit;False;FlashBangAction1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;547;415.9693,275.9455;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;528;414.2583,322.7293;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;690;1185.68,422.7766;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;319;1217.989,471.428;Inherit;False;252;FlashBangAction1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;691;1184.68,423.7766;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;527;412.937,322.7293;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;368;1411.774,476.61;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;518;1414.532,225.9433;Inherit;False;Uriel_CuadrupleColorSelector;-1;;343;19200bcae6cce8140b6e878eb2345ccd;0;9;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;31;COLOR;0,0,0,0;False;30;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;39;264.3641,-744.2711;Inherit;False;Property;_IsFlashBanged;IsFlashBanged?;1;2;[HideInInspector];[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;557;-1740.477,634.9081;Inherit;False;3609.133;419.2181;Damage;49;437;436;430;429;435;434;425;440;431;433;438;439;432;472;471;531;428;22;536;687;541;684;683;686;542;681;680;685;682;698;450;451;447;540;470;448;452;446;449;539;538;40;53;23;41;392;786;886;894;;0,1,0.981899,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;520.7259,-743.751;Inherit;False;IsFlashBanged;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;1691.521,220.9696;Inherit;False;PostFlashBang;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-350.7047,889.6486;Inherit;False;42;IsFlashBanged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-529.2062,669.7847;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-531.4999,805.9913;Inherit;False;24;PostFlashBang;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-530.5432,738.4683;Inherit;False;16;PostDrunk;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-347.8049,823.8616;Inherit;False;49;IsDrunk;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;392;-345.7923,669.4065;Inherit;False;Uriel_DoubleColorSelector;-1;;344;5f9106392216f6346a0866b5250f9a30;0;5;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;786;-27.06482,699.9163;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;430;-1729.414,671.6428;Inherit;False;Property;_Damage_Distortion;Damage_Distortion;26;0;Create;True;0;0;0;False;0;False;0,0;1,2.13;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;433;-988.6613,672.205;Inherit;False;Property;_Damage_Color3;Damage_Color3;35;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.2924521,0.02715633,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;428;-1411.49,909.7721;Inherit;False;Property;_Damage_FluctuationRange;Damage_FluctuationRange;23;0;Create;True;0;0;0;False;0;False;0,0,0;0.1,0.05,0.075;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;432;-1171.246,671.5457;Inherit;False;Property;_Damage_Color2;Damage_Color2;31;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.3962257,0,0.02764372,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;429;-1729.414,786.9778;Inherit;False;Property;_Damage_Speeds;Damage_Speeds;25;0;Create;True;0;0;0;False;0;False;0,0,0;2,2,2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;498;771.7878,-853.6306;Inherit;False;Property;_Damage_Alpha;Damage_Alpha;37;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;425;-973.0068,901.0267;Inherit;False;Property;_Damage_Radiuses;Damage_Radiuses;24;0;Create;True;0;0;0;False;0;False;0,0,0;620.8,802.3,917.8;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;431;-1354.396,673.4958;Inherit;False;Property;_Damage_Color1;Damage_Color1;28;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.8113207,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;538;-29.01656,700.1633;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;471;-800.1061,673.4573;Inherit;False;Property;_Damage_VignetteBlurr;Damage_VignetteBlurr;27;0;Create;True;0;0;0;False;0;False;0,0;0,0.42;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;539;-31.40474,723.7752;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;438;-991.3062,834.5511;Inherit;False;Da_Color3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;472;-799.4261,785.1155;Inherit;False;Da_VignetteBlurr;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;434;-763.8988,901.0262;Inherit;False;Da_Radiuses;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;436;-1541.63,672.6429;Inherit;False;Da_Distortion;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;440;-1351.821,834.4887;Inherit;False;Da_Color1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;437;-1553.563,787.9774;Inherit;False;Da_Speeds;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;435;-1177.305,909.7712;Inherit;False;Da_FluctuationRange;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;520;929.272,-853.3441;Inherit;False;Da_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;439;-1172.998,835.3035;Inherit;False;Da_Color2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;449;512.0315,735.9954;Inherit;False;437;Da_Speeds;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;540;-29.40474,723.7752;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;447;511.2905,785.4304;Inherit;False;435;Da_FluctuationRange;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;450;511.5356,833.1485;Inherit;False;440;Da_Color1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;470;321.1956,813.4658;Inherit;False;472;Da_VignetteBlurr;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;531;-63.05989,906.0496;Inherit;False;520;Da_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;894;325.6138,954.1746;Inherit;False;891;UC_Pixels;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;452;511.1746,881.9545;Inherit;False;438;Da_Color3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;448;322.2147,763.8297;Inherit;False;436;Da_Distortion;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;451;322.1175,859.5989;Inherit;False;439;Da_Color2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;886;137.3873,929.522;Inherit;False;50;IsUsingCamera;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;446;321.5204,713.0233;Inherit;False;434;Da_Radiuses;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;698;732.8032,694.3967;Inherit;False;Uriel_Damage_Loop;-1;;345;80f18160e2fc290448fd9b9fd30a867f;0;13;237;FLOAT;0;False;76;COLOR;0,0,0,0;False;8;FLOAT3;3000,1500,500;False;6;FLOAT3;4,6,8;False;35;FLOAT2;0.98,2.25;False;10;FLOAT3;0.075,0.075,0.075;False;95;FLOAT2;0,0.1;False;30;COLOR;0.4705882,0,0,1;False;63;COLOR;0.5176471,0,0.03529412,1;False;65;COLOR;0.5490196,0.05098039,0,1;False;242;FLOAT;0;False;28;INT;0;False;29;FLOAT2;1000,1000;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;370;1103.104,-765.6965;Inherit;False;Property;_DamageAction1;DamageAction1;14;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;682;1064.594,724.0803;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;685;1068.969,721.8928;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;681;1070.062,722.9864;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;680;1067.875,722.9866;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;256;1099.892,-607.2079;Inherit;False;DamageAction1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;686;1069.218,819.2294;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;542;1209.981,869.8375;Inherit;False;256;DamageAction1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;683;1070.063,770.0142;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;541;1406.764,875.1652;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;684;1070.063,770.0142;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;687;1069.218,820.3232;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;267.8933,-589.7648;Inherit;False;Property;_IsDamaged;IsDamaged?;0;2;[HideInInspector];[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;536;1407.169,670.2787;Inherit;False;Uriel_TripleColorSelector;-1;;349;68eae7d6c234c244a816739ac0f6ff6b;0;7;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;516.2846,-588.487;Inherit;False;IsDamaged;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;626;-1739.393,1055.503;Inherit;False;3611.899;593.5086;Heal;67;594;600;601;593;595;599;597;592;598;596;590;591;629;630;632;602;603;605;606;619;604;620;622;621;624;607;623;608;625;396;585;676;675;677;674;584;672;678;679;673;635;639;628;643;641;642;644;645;640;646;637;627;636;634;633;638;56;55;59;58;57;60;386;787;21;20;887;;0.467875,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;1683.581,665.0576;Inherit;False;PostDamage;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-373.6437,1358.273;Inherit;False;42;IsFlashBanged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-372.5656,1292.713;Inherit;False;49;IsDrunk;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-566.5831,1224.047;Inherit;False;24;PostFlashBang;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-566.2686,1157.885;Inherit;False;16;PostDrunk;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-565.5899,1291.938;Inherit;False;22;PostDamage;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-375.2438,1425.361;Inherit;False;48;IsDamaged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-567.296,1089.849;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;386;-373.1906,1089.716;Inherit;False;Uriel_TripleColorSelector;-1;;350;68eae7d6c234c244a816739ac0f6ff6b;0;7;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;602;-1143.218,1096.99;Inherit;False;Property;_Heal_ValueFrame;Heal_ValueFrame;43;0;Create;True;0;0;0;False;0;False;0,0;0.2,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;603;-843.4856,1097.429;Inherit;False;Property;_Heal_BorderSize;Heal_BorderSize;44;0;Create;True;0;0;0;False;0;False;0,0;0.015,0.05;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;787;-83.09711,1118.851;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;598;-1547.196,1475.044;Inherit;False;Property;_Heal_LineColor2;Heal_LineColor2;36;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0.122641,0.0408801,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;606;-1140.786,1427.317;Inherit;False;Property;_Heal_LineFrequency;Heal_LineFrequency;47;0;Create;True;0;0;0;False;0;False;0;7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;605;-1141.08,1356.907;Inherit;False;Property;_Heal_LineSpeed;Heal_LineSpeed;45;0;Create;True;0;0;0;False;0;False;0;0.45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;597;-1549.847,1309.333;Inherit;False;Property;_Heal_BorderColor2;Heal_BorderColor2;32;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0.2641504,0.231002,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;591;-1730.959,1418.949;Inherit;False;Property;_Heal_LineColor1;Heal_LineColor1;34;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,1,0.3333327,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;619;-1141.677,1211.624;Inherit;False;H_ValueFrame;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;632;-81.63118,1120.326;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;590;-1732.285,1092.83;Inherit;False;Property;_Heal_TintColor1;Heal_TintColor1;30;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.5333333,1,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;500;1441.326,-920.9186;Inherit;False;Property;_Heal_Alpha;Heal_Alpha;39;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;604;-1140.325,1285.407;Inherit;False;Property;_Heal_GradientTimeScale;Heal_GradientTimeScale;46;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;592;-1733.612,1253.238;Inherit;False;Property;_Heal_BorderColor1;Heal_BorderColor1;33;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,1,0.4134733,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;608;-1145.524,1566.807;Inherit;False;Constant;_Heal_LineSharpness;Heal_LineSharpness;45;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;-843.485,1213.063;Inherit;False;H_BorderSize;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;596;-1548.522,1148.927;Inherit;False;Property;_Heal_TintColor2;Heal_TintColor2;29;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;607;-1140.534,1496.963;Inherit;False;Constant;_Heal_LineTransparency;Heal_LineTransparency;45;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;601;-1354.869,1308.035;Inherit;False;H_ColorBorder2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;630;-83.16963,1146.095;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;625;-794.9487,1566.797;Inherit;False;H_LineSharpness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;622;-781.9188,1357.749;Inherit;False;H_LineSpeed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;624;-794.8037,1428.46;Inherit;False;H_LineFrequency;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;623;-808.2053,1496.508;Inherit;False;H_LineTransparency;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;595;-1344.83,1095.43;Inherit;False;H_ColorTint1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;638;467.8824,1281.759;Inherit;False;620;H_BorderSize;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;594;-1350.133,1255.838;Inherit;False;H_ColorBorder1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;633;126.2393,1187.343;Inherit;False;619;H_ValueFrame;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;621;-815.1722,1285.701;Inherit;False;H_GradientTimeScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;522;1574.939,-920.5565;Inherit;False;H_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;593;-1355.384,1417.649;Inherit;False;H_ColorLine1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;599;-1346.967,1151.526;Inherit;False;H_ColorTint2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;600;-1357.521,1473.745;Inherit;False;H_ColorLine2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;627;125.6971,1136.637;Inherit;False;595;H_ColorTint1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;887;464.3783,1522.659;Inherit;False;50;IsUsingCamera;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;636;124.8824,1257.759;Inherit;False;601;H_ColorBorder2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;629;-84.90047,1144.364;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;628;467.9661,1161.522;Inherit;False;599;H_ColorTint2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;640;461.8824,1352.759;Inherit;False;593;H_ColorLine1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;641;118.8824,1377.759;Inherit;False;600;H_ColorLine2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;646;-57.41158,1497.741;Inherit;False;522;H_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;458.8824,1449.759;Inherit;False;623;H_LineTransparency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;893;294.5912,1545.077;Inherit;False;891;UC_Pixels;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;645;116.3824,1471.241;Inherit;False;625;H_LineSharpness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;642;462.8824,1401.759;Inherit;False;622;H_LineSpeed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;634;320.3077,1191.898;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;639;120.8824,1329.759;Inherit;False;621;H_GradientTimeScale;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;643;116.8824,1427.586;Inherit;False;624;H_LineFrequency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;637;652.3479,1286.053;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;635;469.8824,1230.759;Inherit;False;594;H_ColorBorder1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1036;769.364,1117.567;Inherit;False;Uriel_Heal_Loop;-1;;351;0b84c1c4107e27a4298550d923b366c2;0;19;41;COLOR;1,1,1,1;False;62;COLOR;0.2327131,0.4245283,0.01001246,1;False;68;COLOR;0.351461,0.4622642,0.006541462,1;False;11;FLOAT;0.7;False;54;FLOAT;0.85;False;60;COLOR;0,1,0.7258883,1;False;69;COLOR;0,1,0.3039217,1;False;52;FLOAT;0.025;False;40;FLOAT;0.1;False;6;FLOAT;1;False;64;COLOR;0,0.3773585,0.1257861,1;False;67;COLOR;0.2745097,1,0,1;False;25;FLOAT;0.45;False;26;FLOAT;6;False;93;FLOAT;0.5;False;28;FLOAT;0.1;False;37;FLOAT;1;False;15;INT;0;False;55;FLOAT2;1000,1000;False;1;FLOAT4;61
Node;AmplifyShaderEditor.WireNode;673;1055.126,1148.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;679;1055.126,1147.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;371;1476.744,-765.3603;Inherit;False;Property;_HealAction1;HealAction1;16;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;1476.524,-605.015;Inherit;False;HealAction1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;672;1055.126,1145.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;678;1055.126,1146.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;584;1243.097,1288.641;Inherit;False;257;HealAction1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;674;1055.126,1196.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;677;1056.126,1242.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;676;1054.126,1242.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;675;1055.126,1194.394;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;585;1409.918,1293.778;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;45;265.897,-457.7277;Inherit;False;Property;_IsHealing;IsHealing?;7;2;[HideInInspector];[IntRange];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;396;1406.324,1092.287;Inherit;False;Uriel_TripleColorSelector;-1;;354;68eae7d6c234c244a816739ac0f6ff6b;0;7;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;1683.138,1087.018;Inherit;False;PostHeal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;517.9575,-456.5152;Inherit;False;IsHealing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;-333.596,1997.481;Inherit;False;42;IsFlashBanged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;-334.9179,2132.319;Inherit;False;52;IsHealing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-537.6497,1948.373;Inherit;False;20;PostHeal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;-331.3999,1935.587;Inherit;False;49;IsDrunk;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-537.7833,1882.021;Inherit;False;22;PostDamage;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-537.3078,1747.398;Inherit;False;16;PostDrunk;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-538.9638,1816.536;Inherit;False;24;PostFlashBang;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;-536.6767,1680.336;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-333.8957,2064.168;Inherit;False;48;IsDamaged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;389;-336.9988,1684.985;Inherit;False;Uriel_CuadrupleColorSelector;-1;;355;19200bcae6cce8140b6e878eb2345ccd;0;9;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;31;COLOR;0,0,0,0;False;30;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;1040;-35.77043,1715.585;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;903;-1012.555,1701.024;Inherit;False;Property;_UseCamera_RecRadius;UseCamera_RecRadius;52;0;Create;True;0;0;0;False;0;False;3000;19000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;905;-1016.865,1837.8;Inherit;False;Property;_UseCamera_RecDistortion;UseCamera_RecDistortion;51;0;Create;True;0;0;0;False;0;False;1,2;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;907;-847.2982,2030.477;Inherit;False;Property;_UseCamera_RecDisplacement;UseCamera_RecDisplacement;54;0;Create;True;0;0;0;False;0;False;0.5,0.5;0.45,-0.385;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;1041;-37.05186,1715.585;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;502;1100.229,-851.4199;Inherit;False;Property;_UseCamera_Alpha;UseCamera_Alpha;41;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;906;-1016.839,1951.894;Inherit;False;UC_RecDistortion;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1039;-38.33325,1738.65;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;904;-1010.468,1768.729;Inherit;False;UC_RecRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;524;1278.31,-852.7167;Inherit;False;UC_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;908;-847.272,2145.967;Inherit;False;UC_RecDisplacement;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;902;300.241,1797.105;Inherit;False;524;UC_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;888;98.10815,1821.735;Inherit;False;50;IsUsingCamera;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;911;87.59638,1718.534;Inherit;False;904;UC_RecRadius;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;909;465.9341,1750.657;Inherit;False;906;UC_RecDistortion;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1038;-39.61468,1738.651;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;892;504.988,1845.26;Inherit;False;891;UC_Pixels;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;910;662.2415,1775.642;Inherit;False;908;UC_RecDisplacement;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1042;883.0569,1706.491;Inherit;False;Uriel_Camera;-1;;356;08bd67d8e8b398a46a05ccd8dcc9236a;0;7;4;COLOR;0,0,0,0;False;40;FLOAT;3000;False;41;FLOAT2;1,2;False;39;FLOAT2;0,0;False;6;FLOAT;0.3;False;44;INT;1;False;42;FLOAT2;1000,1000;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;882;1366.749,1736.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;373;1291.359,-763.1755;Inherit;False;Property;_UseCameraAction1;UseCameraAction1;19;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;876;1367.749,1737.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;875;1367.749,1736.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;881;1366.749,1738.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;253;1289.481,-604.0743;Inherit;False;UseCameraAction1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;877;1365.749,1782.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;660;1208.444,1880.152;Inherit;False;253;UseCameraAction1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;879;1366.749,1832.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;880;1366.749,1831.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;878;1366.749,1781.805;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;661;1411.088,1885.466;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;659;1407.495,1683.975;Inherit;False;Uriel_TripleColorSelector;-1;;360;68eae7d6c234c244a816739ac0f6ff6b;0;7;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;1693.019,1679.161;Inherit;False;PostCamera;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;874;-826.1793,2226.244;Inherit;False;2698.893;693.751;Camera;53;984;983;963;987;965;986;962;964;18;944;670;948;951;668;953;954;966;671;967;669;981;947;985;998;666;980;979;664;946;665;978;992;991;990;1003;996;995;993;994;390;80;74;72;77;79;70;26;73;71;78;76;1031;1027;;0,1,0.2280874,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-564.3995,2389.93;Inherit;False;24;PostFlashBang;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-559.0853,2516.767;Inherit;False;20;PostHeal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-344.2185,2572.831;Inherit;False;49;IsDrunk;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;-556.7435,2583.038;Inherit;False;27;PostCamera;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-343.2492,2771.987;Inherit;False;52;IsHealing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-562.2184,2453.415;Inherit;False;22;PostDamage;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;-347.9273,2636.148;Inherit;False;42;IsFlashBanged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-344.6688,2838.611;Inherit;False;50;IsUsingCamera;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-565.3245,2328.141;Inherit;False;16;PostDrunk;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;-563.1124,2265.731;Inherit;False;14;ScreenRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-344.2271,2704.836;Inherit;False;48;IsDamaged;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;390;-345.8241,2272.117;Inherit;False;Uriel_QuintupleColorSelector;-1;;361;31cee3057a501844bbe43a769aec214a;0;11;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;31;COLOR;0,0,0,0;False;30;INT;0;False;29;COLOR;0,0,0,0;False;28;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;994;-73.34264,2301.492;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;993;-74.64261,2301.492;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;983;-779.5801,2756.013;Inherit;False;Property;_WakeUp_Time;WakeUp_Time;56;0;Create;True;0;0;0;False;0;False;3000;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;962;-785.5773,2276.169;Inherit;False;Property;_WakeUp_EyeRadius;WakeUp_EyeRadius;55;0;Create;True;0;0;0;False;0;False;3000;150;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;503;1109.823,-920.0489;Inherit;False;Property;_WakeUp_Alpha;WakeUp_Alpha;42;1;[HideInInspector];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;986;-786.6486,2609.088;Inherit;False;Property;_WakeUp_Blinking;WakeUp_Blinking;57;0;Create;True;0;0;0;False;0;False;3000;0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;964;-784.3848,2415.734;Inherit;False;Property;_WakeUp_EyeSize;WakeUp_EyeSize;58;0;Create;True;0;0;0;False;0;False;1,1;1.8,150;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;995;-71.74261,2468.192;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;963;-786.7701,2345.355;Inherit;False;WU_EyeRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;965;-786.7706,2531.441;Inherit;False;WU_EyeSize;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;984;-780.7729,2825.199;Inherit;False;WU_Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;987;-787.8414,2678.274;Inherit;False;WU_Blinking;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;525;1266.718,-919.264;Inherit;False;WU_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;990;727.0319,2488.995;Inherit;False;984;WU_Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1031;725.145,2422.763;Inherit;False;525;WU_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;996;-71.74265,2469.492;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1003;726.8062,2525.502;Inherit;False;987;WU_Blinking;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;991;725.05,2561.481;Inherit;False;963;WU_EyeRadius;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;992;725.7501,2594.282;Inherit;False;965;WU_EyeSize;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;665;-72.3822,2302.131;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1032;958.67,2436.912;Inherit;False;Uriel_Eyes_2_WakeUpBlink;-1;;362;3f559232b69e6004ea00c86a10697d89;0;6;5;COLOR;0,0,0,0;False;26;FLOAT;0;False;10;FLOAT;2;False;16;FLOAT;2;False;15;FLOAT;150;False;14;FLOAT2;0.8,150;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;978;-72.18018,2300.377;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;946;1200.407,2467.762;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;664;-71.78969,2302.243;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;372;915.5759,-763.7722;Inherit;False;Property;_WakeUpAction1;WakeUpAction1;17;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;979;-72.18018,2302.377;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;513;916.1284,-538.5968;Inherit;False;Property;_WakeUpAction2;WakeUpAction2;18;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;980;-71.18018,2422.377;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;916.4313,-602.4569;Inherit;False;WakeUpAction1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;508;917.6628,-374.259;Inherit;False;WakeUpAction2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;666;-73.3822,2327.131;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;998;1203.304,2468;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;669;1215.657,2565.552;Inherit;False;258;WakeUpAction1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;966;104.3379,2483.264;Inherit;False;963;WU_EyeRadius;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;671;1215.066,2699.293;Inherit;False;508;WakeUpAction2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;967;106.038,2514.065;Inherit;False;965;WU_EyeSize;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;954;-72.00116,2324.911;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;985;107.3198,2445.777;Inherit;False;984;WU_Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;953;-12.36337,2313.624;Inherit;False;525;WU_Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;947;1199.08,2519.933;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;981;-71.18018,2422.377;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;951;150.5389,2294.349;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;668;1418.177,2570.656;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;670;1418.71,2704.428;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;948;1200.752,2518.26;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1027;297.4649,2394.063;Inherit;False;Uriel_Eyes_1_QuickOpen;-1;;364;47e9cbd793375844f84e61b71de271c1;0;4;5;COLOR;0,0,0,0;False;16;FLOAT;2;False;7;FLOAT;150;False;9;FLOAT2;0.8,150;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;944;1417.781,2271.703;Inherit;False;Uriel_QuintupleColorSelector;-1;;366;31cee3057a501844bbe43a769aec214a;0;11;11;COLOR;0,0,0,0;False;12;COLOR;0,0,0,0;False;13;INT;0;False;17;COLOR;0,0,0,0;False;16;INT;0;False;20;COLOR;0,0,0,0;False;19;INT;0;False;31;COLOR;0,0,0,0;False;30;INT;0;False;29;COLOR;0,0,0,0;False;28;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;515;1473.828,-372.6575;Inherit;False;HealAction2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;505;730.4157,-539.421;Inherit;False;Property;_FlashBangAction2;FlashBangAction2;12;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;512;1288.677,-371.3877;Inherit;False;UseCameraAction2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;262.2564,-675.1315;Inherit;False;Property;_IsWakingUp;IsWakingUp?;8;2;[HideInInspector];[IntRange];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;507;1478.01,-533.7667;Inherit;False;Property;_HealAction2;HealAction2;15;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;514;1105.698,-375.9504;Inherit;False;DamageAction2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;509;1661.643,-532.1478;Inherit;False;Property;_DrunkAction2;DrunkAction2;22;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;510;1102.909,-535.6388;Inherit;False;Property;_DamageAction2;DamageAction2;13;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;1685.962,2265.994;Inherit;False;PostWakeUp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;516.143,-675.285;Inherit;False;IsWakingUp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;504;728.9594,-377.958;Inherit;False;FlashBangAction2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;511;1290.145,-533.4447;Inherit;False;Property;_UseCameraAction2;UseCameraAction2;20;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;506;1659.902,-371.223;Inherit;False;DrunkAction2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;31;1915.981,2272.502;Float;False;True;-1;2;ASEMaterialInspector;0;4;PostProcessCamera;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;891;0;890;0
WireConnection;897;0;896;0
WireConnection;50;0;47;0
WireConnection;732;2;28;0
WireConnection;733;0;732;0
WireConnection;733;1;897;0
WireConnection;733;2;897;1
WireConnection;777;0;28;0
WireConnection;740;11;732;0
WireConnection;740;15;733;0
WireConnection;740;13;736;0
WireConnection;742;0;740;0
WireConnection;776;0;777;0
WireConnection;744;0;28;0
WireConnection;783;0;28;0
WireConnection;768;0;28;0
WireConnection;759;0;28;0
WireConnection;778;0;776;0
WireConnection;779;0;778;0
WireConnection;767;0;768;0
WireConnection;1018;15;747;0
WireConnection;1018;19;822;0
WireConnection;1018;8;819;0
WireConnection;743;0;744;0
WireConnection;758;0;759;0
WireConnection;782;0;783;0
WireConnection;771;0;779;0
WireConnection;771;1;1018;100
WireConnection;769;0;767;0
WireConnection;781;0;782;0
WireConnection;757;0;758;0
WireConnection;745;0;743;0
WireConnection;770;0;769;0
WireConnection;746;0;745;0
WireConnection;780;0;781;0
WireConnection;756;0;757;0
WireConnection;774;0;771;0
WireConnection;29;0;746;0
WireConnection;29;1;1018;0
WireConnection;754;0;756;0
WireConnection;754;1;742;0
WireConnection;765;0;770;0
WireConnection;765;1;1018;102
WireConnection;772;0;780;0
WireConnection;772;1;1018;101
WireConnection;755;0;29;0
WireConnection;773;0;772;0
WireConnection;14;0;754;0
WireConnection;801;0;804;0
WireConnection;766;0;765;0
WireConnection;806;0;801;0
WireConnection;523;0;501;0
WireConnection;800;0;803;0
WireConnection;805;0;806;0
WireConnection;807;0;808;0
WireConnection;833;0;834;0
WireConnection;798;0;802;0
WireConnection;797;0;792;0
WireConnection;835;0;833;0
WireConnection;835;3;836;1
WireConnection;835;4;836;2
WireConnection;788;0;797;0
WireConnection;788;1;798;0
WireConnection;788;2;800;0
WireConnection;788;3;805;0
WireConnection;788;4;807;0
WireConnection;859;0;835;0
WireConnection;859;1;860;0
WireConnection;793;0;788;0
WireConnection;1034;9;793;0
WireConnection;1034;10;859;0
WireConnection;863;0;1034;0
WireConnection;862;0;863;0
WireConnection;862;1;863;1
WireConnection;862;2;863;2
WireConnection;867;0;862;0
WireConnection;865;0;862;0
WireConnection;864;0;867;0
WireConnection;254;0;374;0
WireConnection;866;0;865;0
WireConnection;854;0;864;0
WireConnection;870;0;854;0
WireConnection;868;0;866;0
WireConnection;658;0;657;0
WireConnection;858;0;868;0
WireConnection;871;0;870;0
WireConnection;656;11;13;0
WireConnection;656;12;862;0
WireConnection;656;13;658;0
WireConnection;656;17;871;0
WireConnection;656;16;658;1
WireConnection;656;20;858;0
WireConnection;656;19;658;2
WireConnection;16;0;656;0
WireConnection;49;0;12;0
WireConnection;417;11;38;0
WireConnection;417;12;25;0
WireConnection;417;13;43;0
WireConnection;844;0;417;0
WireConnection;278;0;260;0
WireConnection;843;0;844;0
WireConnection;519;0;499;0
WireConnection;287;0;200;0
WireConnection;841;0;843;0
WireConnection;288;0;173;0
WireConnection;289;0;176;0
WireConnection;291;0;160;0
WireConnection;290;0;170;0
WireConnection;842;0;841;0
WireConnection;545;0;357;0
WireConnection;545;1;526;0
WireConnection;1035;1;376;0
WireConnection;1035;298;279;0
WireConnection;1035;292;292;0
WireConnection;1035;179;296;0
WireConnection;1035;305;294;0
WireConnection;1035;170;295;0
WireConnection;1035;39;293;0
WireConnection;1035;307;526;0
WireConnection;1035;300;885;0
WireConnection;1035;301;895;0
WireConnection;546;0;842;0
WireConnection;546;1;545;0
WireConnection;688;0;1035;0
WireConnection;530;0;546;0
WireConnection;689;0;688;0
WireConnection;252;0;369;0
WireConnection;547;0;530;0
WireConnection;528;0;547;0
WireConnection;690;0;689;0
WireConnection;691;0;690;0
WireConnection;527;0;528;0
WireConnection;368;0;319;0
WireConnection;518;11;417;0
WireConnection;518;12;546;0
WireConnection;518;13;368;0
WireConnection;518;17;527;0
WireConnection;518;16;368;1
WireConnection;518;20;1035;0
WireConnection;518;19;368;2
WireConnection;518;31;691;0
WireConnection;518;30;368;3
WireConnection;42;0;39;0
WireConnection;24;0;518;0
WireConnection;392;11;40;0
WireConnection;392;12;41;0
WireConnection;392;13;53;0
WireConnection;392;17;23;0
WireConnection;392;16;54;0
WireConnection;786;0;392;0
WireConnection;538;0;786;0
WireConnection;539;0;538;0
WireConnection;438;0;433;0
WireConnection;472;0;471;0
WireConnection;434;0;425;0
WireConnection;436;0;430;0
WireConnection;440;0;431;0
WireConnection;437;0;429;0
WireConnection;435;0;428;0
WireConnection;520;0;498;0
WireConnection;439;0;432;0
WireConnection;540;0;539;0
WireConnection;698;76;540;0
WireConnection;698;8;446;0
WireConnection;698;6;449;0
WireConnection;698;35;448;0
WireConnection;698;10;447;0
WireConnection;698;95;470;0
WireConnection;698;30;450;0
WireConnection;698;63;451;0
WireConnection;698;65;452;0
WireConnection;698;242;531;0
WireConnection;698;28;886;0
WireConnection;698;29;894;0
WireConnection;682;0;698;0
WireConnection;685;0;698;0
WireConnection;681;0;685;0
WireConnection;680;0;682;0
WireConnection;256;0;370;0
WireConnection;686;0;681;0
WireConnection;683;0;680;0
WireConnection;541;0;542;0
WireConnection;684;0;683;0
WireConnection;687;0;686;0
WireConnection;536;11;392;0
WireConnection;536;12;698;0
WireConnection;536;13;541;0
WireConnection;536;17;684;0
WireConnection;536;16;541;1
WireConnection;536;20;687;0
WireConnection;536;19;541;2
WireConnection;48;0;44;0
WireConnection;22;0;536;0
WireConnection;386;11;55;0
WireConnection;386;12;21;0
WireConnection;386;13;60;0
WireConnection;386;17;56;0
WireConnection;386;16;58;0
WireConnection;386;20;57;0
WireConnection;386;19;59;0
WireConnection;787;0;386;0
WireConnection;619;0;602;0
WireConnection;632;0;787;0
WireConnection;620;0;603;0
WireConnection;601;0;597;0
WireConnection;630;0;632;0
WireConnection;625;0;608;0
WireConnection;622;0;605;0
WireConnection;624;0;606;0
WireConnection;623;0;607;0
WireConnection;595;0;590;0
WireConnection;594;0;592;0
WireConnection;621;0;604;0
WireConnection;522;0;500;0
WireConnection;593;0;591;0
WireConnection;599;0;596;0
WireConnection;600;0;598;0
WireConnection;629;0;630;0
WireConnection;634;0;633;0
WireConnection;637;0;638;0
WireConnection;1036;41;629;0
WireConnection;1036;62;627;0
WireConnection;1036;68;628;0
WireConnection;1036;11;634;0
WireConnection;1036;54;634;1
WireConnection;1036;60;635;0
WireConnection;1036;69;636;0
WireConnection;1036;52;637;0
WireConnection;1036;40;637;1
WireConnection;1036;6;639;0
WireConnection;1036;64;640;0
WireConnection;1036;67;641;0
WireConnection;1036;25;642;0
WireConnection;1036;26;643;0
WireConnection;1036;93;644;0
WireConnection;1036;28;645;0
WireConnection;1036;37;646;0
WireConnection;1036;15;887;0
WireConnection;1036;55;893;0
WireConnection;673;0;1036;61
WireConnection;679;0;1036;61
WireConnection;257;0;371;0
WireConnection;672;0;673;0
WireConnection;678;0;679;0
WireConnection;674;0;672;0
WireConnection;677;0;678;0
WireConnection;676;0;677;0
WireConnection;675;0;674;0
WireConnection;585;0;584;0
WireConnection;396;11;386;0
WireConnection;396;12;1036;61
WireConnection;396;13;585;0
WireConnection;396;17;675;0
WireConnection;396;16;585;1
WireConnection;396;20;676;0
WireConnection;396;19;585;2
WireConnection;20;0;396;0
WireConnection;52;0;45;0
WireConnection;389;11;64;0
WireConnection;389;12;17;0
WireConnection;389;13;68;0
WireConnection;389;17;61;0
WireConnection;389;16;65;0
WireConnection;389;20;62;0
WireConnection;389;19;66;0
WireConnection;389;31;63;0
WireConnection;389;30;67;0
WireConnection;1040;0;389;0
WireConnection;1041;0;1040;0
WireConnection;906;0;905;0
WireConnection;1039;0;1041;0
WireConnection;904;0;903;0
WireConnection;524;0;502;0
WireConnection;908;0;907;0
WireConnection;1038;0;1039;0
WireConnection;1042;4;1038;0
WireConnection;1042;40;911;0
WireConnection;1042;41;909;0
WireConnection;1042;39;910;0
WireConnection;1042;6;902;0
WireConnection;1042;44;888;0
WireConnection;1042;42;892;0
WireConnection;882;0;1042;0
WireConnection;876;0;1042;0
WireConnection;875;0;876;0
WireConnection;881;0;882;0
WireConnection;253;0;373;0
WireConnection;877;0;875;0
WireConnection;879;0;881;0
WireConnection;880;0;879;0
WireConnection;878;0;877;0
WireConnection;661;0;660;0
WireConnection;659;11;389;0
WireConnection;659;12;1042;0
WireConnection;659;13;661;0
WireConnection;659;17;878;0
WireConnection;659;16;661;1
WireConnection;659;20;880;0
WireConnection;659;19;661;2
WireConnection;27;0;659;0
WireConnection;390;11;70;0
WireConnection;390;12;26;0
WireConnection;390;13;79;0
WireConnection;390;17;71;0
WireConnection;390;16;76;0
WireConnection;390;20;72;0
WireConnection;390;19;77;0
WireConnection;390;31;73;0
WireConnection;390;30;78;0
WireConnection;390;29;74;0
WireConnection;390;28;80;0
WireConnection;994;0;390;0
WireConnection;993;0;994;0
WireConnection;995;0;993;0
WireConnection;963;0;962;0
WireConnection;965;0;964;0
WireConnection;984;0;983;0
WireConnection;987;0;986;0
WireConnection;525;0;503;0
WireConnection;996;0;995;0
WireConnection;665;0;390;0
WireConnection;1032;5;996;0
WireConnection;1032;26;1031;0
WireConnection;1032;10;990;0
WireConnection;1032;16;1003;0
WireConnection;1032;15;991;0
WireConnection;1032;14;992;0
WireConnection;978;0;390;0
WireConnection;946;0;1032;0
WireConnection;664;0;665;0
WireConnection;979;0;978;0
WireConnection;980;0;979;0
WireConnection;258;0;372;0
WireConnection;508;0;513;0
WireConnection;666;0;664;0
WireConnection;998;0;946;0
WireConnection;954;0;666;0
WireConnection;947;0;998;0
WireConnection;981;0;980;0
WireConnection;951;0;954;0
WireConnection;951;1;953;0
WireConnection;668;0;669;0
WireConnection;670;0;671;0
WireConnection;948;0;947;0
WireConnection;1027;5;981;0
WireConnection;1027;16;985;0
WireConnection;1027;7;966;0
WireConnection;1027;9;967;0
WireConnection;944;11;390;0
WireConnection;944;12;951;0
WireConnection;944;13;668;0
WireConnection;944;16;668;1
WireConnection;944;20;1027;0
WireConnection;944;19;668;2
WireConnection;944;31;1032;0
WireConnection;944;30;668;3
WireConnection;944;29;948;0
WireConnection;944;28;670;0
WireConnection;515;0;507;0
WireConnection;512;0;511;0
WireConnection;514;0;510;0
WireConnection;18;0;944;0
WireConnection;51;0;46;0
WireConnection;504;0;505;0
WireConnection;506;0;509;0
WireConnection;31;0;18;0
ASEEND*/
//CHKSM=D7FB12C93E2AA9E3C72FCDD3425F9101A0D37FB9