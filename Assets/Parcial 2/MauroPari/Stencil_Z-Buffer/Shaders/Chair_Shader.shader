// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Chair_Shader"
{
	Properties
	{
		_ChairAlbedo("ChairAlbedo", 2D) = "white" {}
		_ChairNormal("ChairNormal", 2D) = "white" {}
		_ChairMetalSmooth("ChairMetal/Smooth", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _ChairNormal;
		uniform float4 _ChairNormal_ST;
		uniform sampler2D _ChairAlbedo;
		uniform float4 _ChairAlbedo_ST;
		uniform sampler2D _ChairMetalSmooth;
		uniform float4 _ChairMetalSmooth_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_ChairNormal = i.uv_texcoord * _ChairNormal_ST.xy + _ChairNormal_ST.zw;
			o.Normal = tex2D( _ChairNormal, uv_ChairNormal ).rgb;
			float2 uv_ChairAlbedo = i.uv_texcoord * _ChairAlbedo_ST.xy + _ChairAlbedo_ST.zw;
			o.Albedo = tex2D( _ChairAlbedo, uv_ChairAlbedo ).rgb;
			float2 uv_ChairMetalSmooth = i.uv_texcoord * _ChairMetalSmooth_ST.xy + _ChairMetalSmooth_ST.zw;
			float4 tex2DNode3 = tex2D( _ChairMetalSmooth, uv_ChairMetalSmooth );
			o.Metallic = tex2DNode3.r;
			o.Smoothness = tex2DNode3.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
886;73;1033;918;785.8987;422.5249;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-365.999,-84.52425;Inherit;True;Property;_ChairAlbedo;ChairAlbedo;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-373.799,120.8758;Inherit;True;Property;_ChairNormal;ChairNormal;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-368.5989,340.5751;Inherit;True;Property;_ChairMetalSmooth;ChairMetal/Smooth;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;70.2,89.70004;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Chair_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1;0
WireConnection;0;1;2;0
WireConnection;0;3;3;0
WireConnection;0;4;3;0
ASEEND*/
//CHKSM=64DEA945349F9BB4A635C941AC57C7FC3DA89E34