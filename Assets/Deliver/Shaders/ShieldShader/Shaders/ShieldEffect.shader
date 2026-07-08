// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ShieldEffect"
{
	Properties
	{
		[HDR]_BaseColor("BaseColor", Color) = (0,0.8167534,1,0)
		[HDR]_RimColor("RimColor", Color) = (0,0.9806142,1,0)
		[HDR]_HexColor("HexColor", Color) = (0,0.681592,1,0)
		_BaseAlpha("BaseAlpha", Range( 0 , 1)) = 0.12
		_RimPower("RimPower", Range( 0 , 3)) = 2.4
		_HexIntensity("HexIntensity", Range( 0 , 2)) = 1.5
		_HexAlpha("HexAlpha", Range( 0 , 1)) = 0.2
		_RimIntensity("RimIntensity", Range( 0 , 3)) = 2.5
		_HexTiling("HexTiling", Range( 0 , 10)) = 8
		_HexPattern("HexPattern", 2D) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
		BlendOp Add
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite Off
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
				float3 ase_normal : NORMAL;
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

			uniform float4 _BaseColor;
			uniform float _RimPower;
			uniform float _RimIntensity;
			uniform float4 _RimColor;
			uniform sampler2D _HexPattern;
			uniform float _HexTiling;
			uniform float _HexIntensity;
			uniform float4 _HexColor;
			uniform float _BaseAlpha;
			uniform float _HexAlpha;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord1.xyz = ase_worldNormal;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
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
				float4 break75 = _BaseColor;
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(WorldPosition);
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = i.ase_texcoord1.xyz;
				float fresnelNdotV9 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode9 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV9, _RimPower ) );
				float RimMask72 = ( fresnelNode9 * _RimIntensity );
				float4 break76 = _RimColor;
				float RimColorR81 = ( RimMask72 * break76.r );
				float2 texCoord34 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner35 = ( 1.0 * _Time.y * float2( 0.3,0.8 ) + ( texCoord34 * _HexTiling ));
				float HexMask38 = (tex2D( _HexPattern, panner35 )).r;
				float HexColorMask74 = ( HexMask38 * _HexIntensity );
				float4 break77 = _HexColor;
				float HexColorR84 = ( 0 * break77.r );
				float RimColorG103 = ( 0 * break76.g );
				float HexColorG108 = ( HexColorMask74 * break77.g );
				float RimColorB106 = ( break76.b * 0 );
				float HexColorB113 = ( break77.b * HexColorMask74 );
				float RimAlpha30 = ( fresnelNode9 * 0.2 );
				float FinalHexAlpha49 = ( _HexAlpha * HexMask38 );
				float FinalAlpha54 = saturate( ( ( _BaseAlpha + RimAlpha30 ) + FinalHexAlpha49 ) );
				float4 appendResult64 = (float4(0 , ( ( break75.g + RimColorG103 ) + HexColorG108 ) , ( ( break75.b + RimColorB106 ) + HexColorB113 ) , FinalAlpha54));
				
				
				finalColor = appendResult64;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
660;73;1259;918;5086.627;3133.075;7.111337;True;False
Node;AmplifyShaderEditor.CommentaryNode;42;-1630.26,852.0809;Inherit;False;1487.923;313.791;Máscara que define el patron hexagonal ;7;34;14;37;35;8;36;38;;0.4078431,0.9333333,0.5843138,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1580.26,1049.871;Inherit;False;Property;_HexTiling;HexTiling;8;0;Create;True;0;0;0;False;0;False;8;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-1559.893,902.0809;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1302.403,940.4833;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;35;-1117.458,940.9162;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.3,0.8;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;20;-1633.585,177.7358;Inherit;False;1361.325;617.7886;Fresnel para hacer el borde. Se puede manjear intensidad y color;9;9;6;27;28;30;29;17;13;72;;0.4078431,0.9333333,0.5843138,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1581.95,477.021;Inherit;False;Property;_RimPower;RimPower;4;0;Create;True;0;0;0;False;0;False;2.4;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-938.1884,929.1735;Inherit;True;Property;_HexPattern;HexPattern;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;9;-1260.392,353.0463;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;36;-604.6739,957.1336;Inherit;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;-1624.41,1227.121;Inherit;False;752.1581;254.6844;Color de la máscara del patrón Hexagonal;4;74;39;40;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;88;1123.72,913.4684;Inherit;False;1109.932;574.3885;RimColor Splitteado;12;92;91;76;11;104;101;81;102;106;105;100;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-366.3354,957.6176;Inherit;False;HexMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;-1626.512,-553.6625;Inherit;False;1475.332;672.9127;Combinación de Alfa de HexMask y Alfa de Rim (Sumado a BaseAlpha);3;57;52;51;;0.4097098,0.9339623,0.5831598,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1263.638,577.2543;Inherit;False;Property;_RimIntensity;RimIntensity;7;0;Create;True;0;0;0;False;0;False;2.5;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-953.7276,336.3649;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;29;-985.1802,290.5949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;51;-1605.733,-204.8871;Inherit;False;757.8477;259.1708;Mascara de Hexagonos + float = Alfa de los hexágonos (HexAlpha);4;47;49;48;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;11;1152.019,1041.639;Inherit;False;Property;_RimColor;RimColor;1;1;[HDR];Create;True;0;0;0;False;0;False;0,0.9806142,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;39;-1527.626,1275.356;Inherit;False;38;HexMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-54.63804,908.6697;Inherit;False;1114.939;567.0632;HexColor Splitteado;12;108;109;112;113;111;114;107;84;94;93;77;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1574.41,1379.094;Inherit;False;Property;_HexIntensity;HexIntensity;5;0;Create;True;0;0;0;False;0;False;1.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-956.3778,442.9886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-705.8746,258.55;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-781.442,472.4165;Inherit;False;RimMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1285.501,1277.122;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-8.537947,1037.485;Inherit;False;Property;_HexColor;HexColor;2;1;[HDR];Create;True;0;0;0;False;0;False;0,0.681592,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-495.0926,339.5324;Inherit;False;RimAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1555.734,-154.8871;Inherit;False;Property;_HexAlpha;HexAlpha;6;0;Create;True;0;0;0;False;0;False;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1515.341,-61.71611;Inherit;False;38;HexMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;76;1352.25,1059.867;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;52;-1588.275,-495.9879;Inherit;False;666.3881;269.2134;Alfa del fresnel + Alfa Base;3;32;5;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1272.374,-107.5909;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;1313.902,1348.229;Inherit;False;72;RimMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;1345.94,968.8456;Inherit;False;72;RimMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-1416.912,-323.7402;Inherit;False;30;RimAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;101;1557.907,1216.53;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;89;22.41944,-525.163;Inherit;False;1910.941;1352.48;BaseColor Splitteado;8;115;130;131;129;128;75;4;63;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;1609.308,1153.227;Inherit;False;72;RimMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1467.475,-427.9946;Inherit;False;Property;_BaseAlpha;BaseAlpha;3;0;Create;True;0;0;0;False;0;False;0.12;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;-1109.567,1288.579;Inherit;False;HexColorMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;77;212.6582,1068.251;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;109;451.6826,1134.374;Inherit;False;74;HexColorMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;1543.339,1033.846;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;172.2676,965.7122;Inherit;False;74;HexColorMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;114;434.1666,1205.365;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-859.1838,-477.9532;Inherit;False;663.3922;207.6299;Combinación del alfa del Rim y alfa del Hexmask;3;50;33;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-1090.885,-96.39646;Inherit;False;FinalHexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;1551.804,1278.031;Inherit;False;2;2;0;FLOAT;0;False;1;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-1136.142,-410.229;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;1800.568,1171.034;Inherit;False;2;2;0;OBJECT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;92.7148,-80.17019;Inherit;False;Property;_BaseColor;BaseColor;0;1;[HDR];Create;True;0;0;0;False;0;False;0,0.8167534,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;112;181.5391,1358.464;Inherit;False;74;HexColorMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;1981.598,1209.128;Inherit;False;RimColorG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;1681.497,1028.468;Inherit;False;RimColorR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;1742.903,1314.429;Inherit;False;RimColorB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;75;302.5681,-57.93922;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;129;465.1375,-22.30066;Inherit;False;640.8952;351.98;Final Green Color;4;117;120;118;121;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;367.3775,1013.64;Inherit;False;2;2;0;OBJECT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;128;461.2947,345.2055;Inherit;False;647.4291;348.7139;Final Blue Color;4;124;127;125;126;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;412.0557,1274.498;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;131;463.8972,-398.1977;Inherit;False;604.9703;355.8004;Final Red Color;4;97;95;98;96;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-809.1766,-411.4641;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;642.9388,1152.18;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;609.5361,1310.896;Inherit;False;HexColorB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;508.649,1021.57;Inherit;False;HexColorR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;511.2949,499.2822;Inherit;False;106;RimColorB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;33;-618.4376,-404.4496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;130;409.593,330.1437;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;115;453.856,-264.4236;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;513.2375,162.1723;Inherit;False;103;RimColorG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;513.8972,-240.2998;Inherit;False;81;RimColorR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;809.4685,1172.391;Inherit;False;HexColorG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;729.0383,188.9783;Inherit;False;108;HexColorG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;1206.969,-23.30604;Inherit;False;466.4763;358.1036;Fórmula RGB Final + Alpha Chain;3;64;3;65;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;125;689.3443,395.2055;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;704.9984,-158.3972;Inherit;False;84;HexColorR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;-433.6541,-413.5397;Inherit;False;FinalAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;702.3953,581.1854;Inherit;False;113;HexColorB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;689.3996,-348.1979;Inherit;False;2;2;0;FLOAT;0;False;1;OBJECT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;700.7872,56.19562;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;900.1695,-256.7298;Inherit;False;2;2;0;OBJECT;;False;1;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;124;892.1966,495.3852;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;1231.204,262.6519;Inherit;False;54;FinalAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;925.3692,116.2418;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;64;1261.972,83.05353;Inherit;False;COLOR;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;3;1443.282,109.4532;Float;False;True;-1;2;ASEMaterialInspector;100;1;ShieldEffect;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;3;1;False;-1;10;False;-1;True;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;2;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;37;0;34;0
WireConnection;37;1;14;0
WireConnection;35;0;37;0
WireConnection;8;1;35;0
WireConnection;9;3;6;0
WireConnection;36;0;8;0
WireConnection;38;0;36;0
WireConnection;29;0;9;0
WireConnection;17;0;9;0
WireConnection;17;1;13;0
WireConnection;27;0;29;0
WireConnection;27;1;28;0
WireConnection;72;0;17;0
WireConnection;40;0;39;0
WireConnection;40;1;7;0
WireConnection;30;0;27;0
WireConnection;76;0;11;0
WireConnection;48;0;25;0
WireConnection;48;1;47;0
WireConnection;101;0;76;1
WireConnection;74;0;40;0
WireConnection;77;0;12;0
WireConnection;91;0;92;0
WireConnection;91;1;76;0
WireConnection;114;0;77;1
WireConnection;49;0;48;0
WireConnection;104;0;76;2
WireConnection;104;1;105;0
WireConnection;31;0;5;0
WireConnection;31;1;32;0
WireConnection;100;0;102;0
WireConnection;100;1;101;0
WireConnection;103;0;100;0
WireConnection;81;0;91;0
WireConnection;106;0;104;0
WireConnection;75;0;4;0
WireConnection;93;0;94;0
WireConnection;93;1;77;0
WireConnection;111;0;77;2
WireConnection;111;1;112;0
WireConnection;50;0;31;0
WireConnection;50;1;49;0
WireConnection;107;0;109;0
WireConnection;107;1;114;0
WireConnection;113;0;111;0
WireConnection;84;0;93;0
WireConnection;33;0;50;0
WireConnection;130;0;75;2
WireConnection;115;0;75;0
WireConnection;108;0;107;0
WireConnection;125;0;130;0
WireConnection;125;1;126;0
WireConnection;54;0;33;0
WireConnection;95;0;115;0
WireConnection;95;1;96;0
WireConnection;120;0;75;1
WireConnection;120;1;121;0
WireConnection;97;0;95;0
WireConnection;97;1;98;0
WireConnection;124;0;125;0
WireConnection;124;1;127;0
WireConnection;117;0;120;0
WireConnection;117;1;118;0
WireConnection;64;0;97;0
WireConnection;64;1;117;0
WireConnection;64;2;124;0
WireConnection;64;3;65;0
WireConnection;3;0;64;0
ASEEND*/
//CHKSM=0DBEA5CCD36DBB04EDC67F6A33F866EFEF9FE5F8