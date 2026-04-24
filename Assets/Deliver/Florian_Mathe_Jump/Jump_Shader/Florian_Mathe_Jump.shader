// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Florian_Mathe_Jump"
{
	Properties
	{
		_Arrow_Tiling("Arrow_Tiling", Vector) = (6,10,0,0)
		_Arrow_Speed("Arrow_Speed", Float) = -1
		_ArrowText("ArrowText", 2D) = "white" {}
		[HDR]_Arrow_Color("Arrow_Color", Color) = (0.8693228,1.748995,1.676551,0)
		_Columns_Offset("Columns_Offset", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
		};

		uniform sampler2D _ArrowText;
		uniform float _Arrow_Speed;
		uniform float2 _Arrow_Tiling;
		uniform float _Columns_Offset;
		uniform float4 _Arrow_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult6 = (float2(0.0 , _Arrow_Speed));
			float2 temp_output_3_0 = ( _Arrow_Tiling * i.uv_texcoord );
			float temp_output_33_0 = (temp_output_3_0).x;
			float4 appendResult40 = (float4(temp_output_33_0 , ( ( fmod( floor( temp_output_33_0 ) , 2.0 ) * _Columns_Offset ) + (temp_output_3_0).y ) , 0.0 , 0.0));
			float2 panner4 = ( 1.0 * _Time.y * appendResult6 + appendResult40.xy);
			float Ycoords63 = (i.uv_texcoord).y;
			float smoothstepResult62 = smoothstep( 0.15 , 0.0 , Ycoords63);
			float3 ase_worldNormal = i.worldNormal;
			float dotResult32 = dot( float3(0,1,0) , ase_worldNormal );
			float smoothstepResult48 = smoothstep( 0.99 , 0.8 , Ycoords63);
			o.Emission = ( ( ( ( tex2D( _ArrowText, panner4 ) + smoothstepResult62 ) * _Arrow_Color ) * step( abs( dotResult32 ) , 0.8 ) ) * smoothstepResult48 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;53;1360;694;4505.954;1318.452;6.514973;True;True
Node;AmplifyShaderEditor.CommentaryNode;67;-2223.773,342.9151;Inherit;False;452.4342;374.0326;Base para el tiling de flechas;3;2;1;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;2;-2113.369,392.9151;Inherit;False;Property;_Arrow_Tiling;Arrow_Tiling;1;0;Create;True;0;0;0;False;0;False;6,10;5,3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-2173.773,557.9476;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1933.339,476.9441;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;42;-1702.309,246.6283;Inherit;False;1065.213;476.7199;Offset vertical entre columnas juxtapuestas;8;33;34;35;36;38;37;39;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;33;-1671.203,317.0966;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;34;-1459.172,391.2048;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FmodOpNode;35;-1313.744,392.2859;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1391.127,499.5411;Inherit;False;Property;_Columns_Offset;Columns_Offset;5;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;38;-1195.896,582.5178;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;-562.0988,306.4542;Inherit;False;957.1565;422.6916;Panning de flechas;4;7;4;6;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;50;-567.8199,849.0502;Inherit;False;1272.856;383.2897;Frnaja de color en la base del cilindro;5;47;62;63;53;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1144.357,476.8155;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-532.2208,977.4495;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-959.5188,588.3481;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-512.0988,586.8686;Inherit;False;Property;_Arrow_Speed;Arrow_Speed;2;0;Create;True;0;0;0;False;0;False;-1;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;47;-316.0795,968.3488;Inherit;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;41;451.827,1357.098;Inherit;False;1150.066;663.9537;Mascara para no dibujar en las "Tapas" del cilindro;9;24;23;26;29;25;32;30;31;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-328.3435,564.9514;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;-794.947,322.5544;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;4;-242.0675,372.8997;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;31;529.7666,1407.098;Inherit;False;Constant;_Vector1;Vector 1;7;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;30;504.7666,1565.099;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;63;-42.90181,1011.441;Inherit;False;Ycoords;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;55.55334,424.5732;Inherit;True;Property;_ArrowText;ArrowText;3;0;Create;True;0;0;0;False;0;False;-1;None;57b181613e640483093e251452058b3d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;62;209.4272,948.6458;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.15;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;32;721.7666,1526.098;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;68;857.6754,886.225;Inherit;False;446.9402;376.6701;Custom color para flechas;2;9;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;555.0789,921.8299;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.AbsOpNode;25;875.5625,1725.03;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;854.7666,1867.098;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;66;1764.705,1378.333;Inherit;False;541.6412;435.7248;Transparencia de las flechas al subir;3;64;48;51;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;9;907.6754,1050.895;Inherit;False;Property;_Arrow_Color;Arrow_Color;4;1;[HDR];Create;True;0;0;0;False;0;False;0.8693228,1.748995,1.676551,0;0.06585798,0.1324092,0.1275565,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;64;1792.296,1572.734;Inherit;False;63;Ycoords;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;26;1035.003,1755.839;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;1142.616,936.225;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;48;1964.198,1574.75;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.99;False;2;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;1356.258,1443.469;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;2165.477,1437.083;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;24;681.2202,1724.925;Inherit;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;23;501.8271,1719.646;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2493.706,1393.547;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Florian_Mathe_Jump;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;33;0;3;0
WireConnection;34;0;33;0
WireConnection;35;0;34;0
WireConnection;38;0;3;0
WireConnection;37;0;35;0
WireConnection;37;1;36;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;47;0;53;0
WireConnection;6;1;5;0
WireConnection;40;0;33;0
WireConnection;40;1;39;0
WireConnection;4;0;40;0
WireConnection;4;2;6;0
WireConnection;63;0;47;0
WireConnection;7;1;4;0
WireConnection;62;0;63;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;61;0;7;0
WireConnection;61;1;62;0
WireConnection;25;0;32;0
WireConnection;26;0;25;0
WireConnection;26;1;29;0
WireConnection;10;0;61;0
WireConnection;10;1;9;0
WireConnection;48;0;64;0
WireConnection;27;0;10;0
WireConnection;27;1;26;0
WireConnection;51;0;27;0
WireConnection;51;1;48;0
WireConnection;24;0;23;0
WireConnection;0;2;51;0
ASEEND*/
//CHKSM=D073506A031F74B94C1B60D5CDC745F72D2BCE78