// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mateo_Chavit_Alley_Wall"
{
	Properties
	{
		_WallTexture("Wall Texture", 2D) = "white" {}
		_WallNormals("Wall Normals", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (0,0,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		_WallOcclusion("Wall Occlusion", 2D) = "white" {}
		_Wallcolor("Wall color", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform sampler2D _WallOcclusion;
		uniform float2 _Tiling;
		uniform float2 _Offset;
		uniform sampler2D _WallNormals;
		uniform sampler2D _WallTexture;
		uniform float4 _Wallcolor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 UVCorrect11 = ( ( ase_worldPos * float3( _Tiling ,  0.0 ) ) + float3( _Offset ,  0.0 ) );
			v.vertex.xyz += tex2Dlod( _WallOcclusion, float4( UVCorrect11.xy, 0, 0.0) ).rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 UVCorrect11 = ( ( ase_worldPos * float3( _Tiling ,  0.0 ) ) + float3( _Offset ,  0.0 ) );
			o.Normal = tex2D( _WallNormals, UVCorrect11.xy ).rgb;
			o.Albedo = ( tex2D( _WallTexture, UVCorrect11.xy ) * _Wallcolor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
258;73;783;374;1581.398;570.0455;1.928933;True;False
Node;AmplifyShaderEditor.CommentaryNode;5;-1795.321,-104.07;Inherit;False;910.5723;432.4921;UV correct;6;11;10;9;8;7;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;6;-1745.321,-54.06992;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;7;-1742.196,108.5929;Inherit;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1459.667,15.54409;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;9;-1468.125,164.422;Inherit;False;Property;_Offset;Offset;3;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-1251.576,100.1341;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;20;-877.9415,-526.1038;Inherit;False;884.0256;557.7026;Alley wall texture;5;13;2;1;18;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-1108.749,93.39651;Inherit;False;UVCorrect;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;13;-768.4885,-281.257;Inherit;False;11;UVCorrect;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-827.9415,-476.1038;Inherit;True;Property;_WallTexture;Wall Texture;0;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;1;-583.9916,-363.9437;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;16;-626.8193,303.5049;Inherit;True;Property;_WallOcclusion;Wall Occlusion;4;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;17;-508.5459,518.7918;Inherit;False;11;UVCorrect;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-581.1136,228.2343;Inherit;False;11;UVCorrect;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;4;-605.8836,43.67427;Inherit;True;Property;_WallNormals;Wall Normals;1;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;18;-587.9974,-180.4013;Inherit;False;Property;_Wallcolor;Wall color;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-313.1918,331.4127;Inherit;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-155.9159,-178.4723;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-361.7533,111.2882;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Mateo_Chavit_Alley_Wall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;11;0;10;0
WireConnection;1;0;2;0
WireConnection;1;1;13;0
WireConnection;15;0;16;0
WireConnection;15;1;17;0
WireConnection;19;0;1;0
WireConnection;19;1;18;0
WireConnection;3;0;4;0
WireConnection;3;1;12;0
WireConnection;0;0;19;0
WireConnection;0;1;3;0
WireConnection;0;11;15;0
ASEEND*/
//CHKSM=E29CA5AC6F0D4FD60461BCC49CE9C04D65B45AAE