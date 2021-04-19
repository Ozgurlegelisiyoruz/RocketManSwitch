Shader "TextMeshPro/Mobile/Distance Field Overlay" {
	Properties {
		_FaceColor ("Face Color", Vector) = (1,1,1,1)
		_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
		_OutlineColor ("Outline Color", Vector) = (0,0,0,1)
		_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
		_UnderlayColor ("Border Color", Vector) = (0,0,0,0.5)
		_UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
		_UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
		_UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
		_UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
		_WeightNormal ("Weight Normal", Float) = 0
		_WeightBold ("Weight Bold", Float) = 0.5
		_ShaderFlags ("Flags", Float) = 0
		_ScaleRatioA ("Scale RatioA", Float) = 1
		_ScaleRatioB ("Scale RatioB", Float) = 1
		_ScaleRatioC ("Scale RatioC", Float) = 1
		_MainTex ("Font Atlas", 2D) = "white" {}
		_TextureWidth ("Texture Width", Float) = 512
		_TextureHeight ("Texture Height", Float) = 512
		_GradientScale ("Gradient Scale", Float) = 5
		_ScaleX ("Scale X", Float) = 1
		_ScaleY ("Scale Y", Float) = 1
		_PerspectiveFilter ("Perspective Correction", Range(0, 1)) = 0.875
		_Sharpness ("Sharpness", Range(-1, 1)) = 0
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask 0 -1
			ZTest Always
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				WriteMask 0
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			Fog {
				Mode Off
			}
			GpuProgramID 6614
			Program "vp" {
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 53
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %46 %49 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %8 RelaxedPrecision 
					                                             OpDecorate %11 RelaxedPrecision 
					                                             OpDecorate %11 DescriptorSet 11 
					                                             OpDecorate %11 Binding 11 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %15 RelaxedPrecision 
					                                             OpDecorate %15 DescriptorSet 15 
					                                             OpDecorate %15 Binding 15 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 21 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %46 Location 46 
					                                             OpDecorate %47 RelaxedPrecision 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %49 Location 49 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypePointer Private %6 
					                         Private f32* %8 = OpVariable Private 
					                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %10 = OpTypePointer UniformConstant %9 
					UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                     %13 = OpTypeSampler 
					                                     %14 = OpTypePointer UniformConstant %13 
					            UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                     %17 = OpTypeSampledImage %9 
					                                     %19 = OpTypeVector %6 4 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                        Private f32* %29 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                 u32 %32 = OpConstant 0 
					                                     %33 = OpTypePointer Input %6 
					                                 f32 %42 = OpConstant 3.674022E-40 
					                                 f32 %43 = OpConstant 3.674022E-40 
					                                     %45 = OpTypePointer Output %19 
					                       Output f32_4* %46 = OpVariable Output 
					                        Input f32_4* %49 = OpVariable Input 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_4 %23 = OpLoad vs_TEXCOORD0 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                                             OpStore %8 %28 
					                                 f32 %30 = OpLoad %8 
					                          Input f32* %34 = OpAccessChain vs_TEXCOORD1 %32 
					                                 f32 %35 = OpLoad %34 
					                                 f32 %36 = OpFMul %30 %35 
					                          Input f32* %37 = OpAccessChain vs_TEXCOORD1 %27 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFNegate %38 
					                                 f32 %40 = OpFAdd %36 %39 
					                                             OpStore %29 %40 
					                                 f32 %41 = OpLoad %29 
					                                 f32 %44 = OpExtInst %1 43 %41 %42 %43 
					                                             OpStore %29 %44 
					                                 f32 %47 = OpLoad %29 
					                               f32_4 %48 = OpCompositeConstruct %47 %47 %47 %47 
					                               f32_4 %50 = OpLoad %49 
					                               f32_4 %51 = OpFMul %48 %50 
					                                             OpStore %46 %51 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 53
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %46 %49 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %8 RelaxedPrecision 
					                                             OpDecorate %11 RelaxedPrecision 
					                                             OpDecorate %11 DescriptorSet 11 
					                                             OpDecorate %11 Binding 11 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %15 RelaxedPrecision 
					                                             OpDecorate %15 DescriptorSet 15 
					                                             OpDecorate %15 Binding 15 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 21 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %46 Location 46 
					                                             OpDecorate %47 RelaxedPrecision 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %49 Location 49 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypePointer Private %6 
					                         Private f32* %8 = OpVariable Private 
					                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %10 = OpTypePointer UniformConstant %9 
					UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                     %13 = OpTypeSampler 
					                                     %14 = OpTypePointer UniformConstant %13 
					            UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                     %17 = OpTypeSampledImage %9 
					                                     %19 = OpTypeVector %6 4 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                        Private f32* %29 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                 u32 %32 = OpConstant 0 
					                                     %33 = OpTypePointer Input %6 
					                                 f32 %42 = OpConstant 3.674022E-40 
					                                 f32 %43 = OpConstant 3.674022E-40 
					                                     %45 = OpTypePointer Output %19 
					                       Output f32_4* %46 = OpVariable Output 
					                        Input f32_4* %49 = OpVariable Input 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_4 %23 = OpLoad vs_TEXCOORD0 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                                             OpStore %8 %28 
					                                 f32 %30 = OpLoad %8 
					                          Input f32* %34 = OpAccessChain vs_TEXCOORD1 %32 
					                                 f32 %35 = OpLoad %34 
					                                 f32 %36 = OpFMul %30 %35 
					                          Input f32* %37 = OpAccessChain vs_TEXCOORD1 %27 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFNegate %38 
					                                 f32 %40 = OpFAdd %36 %39 
					                                             OpStore %29 %40 
					                                 f32 %41 = OpLoad %29 
					                                 f32 %44 = OpExtInst %1 43 %41 %42 %43 
					                                             OpStore %29 %44 
					                                 f32 %47 = OpLoad %29 
					                               f32_4 %48 = OpCompositeConstruct %47 %47 %47 %47 
					                               f32_4 %50 = OpLoad %49 
					                               f32_4 %51 = OpFMul %48 %50 
					                                             OpStore %46 %51 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 53
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %46 %49 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %8 RelaxedPrecision 
					                                             OpDecorate %11 RelaxedPrecision 
					                                             OpDecorate %11 DescriptorSet 11 
					                                             OpDecorate %11 Binding 11 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %15 RelaxedPrecision 
					                                             OpDecorate %15 DescriptorSet 15 
					                                             OpDecorate %15 Binding 15 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 21 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %46 Location 46 
					                                             OpDecorate %47 RelaxedPrecision 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %49 Location 49 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypePointer Private %6 
					                         Private f32* %8 = OpVariable Private 
					                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %10 = OpTypePointer UniformConstant %9 
					UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                     %13 = OpTypeSampler 
					                                     %14 = OpTypePointer UniformConstant %13 
					            UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                     %17 = OpTypeSampledImage %9 
					                                     %19 = OpTypeVector %6 4 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                        Private f32* %29 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                 u32 %32 = OpConstant 0 
					                                     %33 = OpTypePointer Input %6 
					                                 f32 %42 = OpConstant 3.674022E-40 
					                                 f32 %43 = OpConstant 3.674022E-40 
					                                     %45 = OpTypePointer Output %19 
					                       Output f32_4* %46 = OpVariable Output 
					                        Input f32_4* %49 = OpVariable Input 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_4 %23 = OpLoad vs_TEXCOORD0 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                                             OpStore %8 %28 
					                                 f32 %30 = OpLoad %8 
					                          Input f32* %34 = OpAccessChain vs_TEXCOORD1 %32 
					                                 f32 %35 = OpLoad %34 
					                                 f32 %36 = OpFMul %30 %35 
					                          Input f32* %37 = OpAccessChain vs_TEXCOORD1 %27 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFNegate %38 
					                                 f32 %40 = OpFAdd %36 %39 
					                                             OpStore %29 %40 
					                                 f32 %41 = OpLoad %29 
					                                 f32 %44 = OpExtInst %1 43 %41 %42 %43 
					                                             OpStore %29 %44 
					                                 f32 %47 = OpLoad %29 
					                               f32_4 %48 = OpCompositeConstruct %47 %47 %47 %47 
					                               f32_4 %50 = OpLoad %49 
					                               f32_4 %51 = OpFMul %48 %50 
					                                             OpStore %46 %51 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_4 = vs_COLOR0.w * u_xlat16_1 + -0.00100000005;
					    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_4<0.0);
					#else
					    u_xlatb2 = u_xlat16_4<0.0;
					#endif
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_4 = vs_COLOR0.w * u_xlat16_1 + -0.00100000005;
					    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_4<0.0);
					#else
					    u_xlatb2 = u_xlat16_4<0.0;
					#endif
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_4 = vs_COLOR0.w * u_xlat16_1 + -0.00100000005;
					    u_xlat16_0 = vec4(u_xlat16_1) * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_4<0.0);
					#else
					    u_xlatb2 = u_xlat16_4<0.0;
					#endif
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 79
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %46 %60 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %8 RelaxedPrecision 
					                                             OpDecorate %11 RelaxedPrecision 
					                                             OpDecorate %11 DescriptorSet 11 
					                                             OpDecorate %11 Binding 11 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %15 RelaxedPrecision 
					                                             OpDecorate %15 DescriptorSet 15 
					                                             OpDecorate %15 Binding 15 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 21 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %46 Location 46 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %52 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %55 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %58 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 Location 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate %65 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypePointer Private %6 
					                         Private f32* %8 = OpVariable Private 
					                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %10 = OpTypePointer UniformConstant %9 
					UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                     %13 = OpTypeSampler 
					                                     %14 = OpTypePointer UniformConstant %13 
					            UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                     %17 = OpTypeSampledImage %9 
					                                     %19 = OpTypeVector %6 4 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                        Private f32* %29 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                 u32 %32 = OpConstant 0 
					                                     %33 = OpTypePointer Input %6 
					                                 f32 %42 = OpConstant 3.674022E-40 
					                                 f32 %43 = OpConstant 3.674022E-40 
					                        Private f32* %45 = OpVariable Private 
					                        Input f32_4* %46 = OpVariable Input 
					                                 f32 %51 = OpConstant 3.674022E-40 
					                                     %53 = OpTypePointer Private %19 
					                      Private f32_4* %54 = OpVariable Private 
					                                     %59 = OpTypePointer Output %19 
					                       Output f32_4* %60 = OpVariable Output 
					                                     %62 = OpTypeBool 
					                                     %63 = OpTypePointer Private %62 
					                       Private bool* %64 = OpVariable Private 
					                                     %68 = OpTypeInt 32 1 
					                                 i32 %69 = OpConstant 0 
					                                 i32 %70 = OpConstant 1 
					                                 i32 %72 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_4 %23 = OpLoad vs_TEXCOORD0 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                                             OpStore %8 %28 
					                                 f32 %30 = OpLoad %8 
					                          Input f32* %34 = OpAccessChain vs_TEXCOORD1 %32 
					                                 f32 %35 = OpLoad %34 
					                                 f32 %36 = OpFMul %30 %35 
					                          Input f32* %37 = OpAccessChain vs_TEXCOORD1 %27 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFNegate %38 
					                                 f32 %40 = OpFAdd %36 %39 
					                                             OpStore %29 %40 
					                                 f32 %41 = OpLoad %29 
					                                 f32 %44 = OpExtInst %1 43 %41 %42 %43 
					                                             OpStore %29 %44 
					                          Input f32* %47 = OpAccessChain %46 %27 
					                                 f32 %48 = OpLoad %47 
					                                 f32 %49 = OpLoad %29 
					                                 f32 %50 = OpFMul %48 %49 
					                                 f32 %52 = OpFAdd %50 %51 
					                                             OpStore %45 %52 
					                                 f32 %55 = OpLoad %29 
					                               f32_4 %56 = OpCompositeConstruct %55 %55 %55 %55 
					                               f32_4 %57 = OpLoad %46 
					                               f32_4 %58 = OpFMul %56 %57 
					                                             OpStore %54 %58 
					                               f32_4 %61 = OpLoad %54 
					                                             OpStore %60 %61 
					                                 f32 %65 = OpLoad %45 
					                                bool %66 = OpFOrdLessThan %65 %42 
					                                             OpStore %64 %66 
					                                bool %67 = OpLoad %64 
					                                 i32 %71 = OpSelect %67 %70 %69 
					                                 i32 %73 = OpIMul %71 %72 
					                                bool %74 = OpINotEqual %73 %69 
					                                             OpSelectionMerge %76 None 
					                                             OpBranchConditional %74 %75 %76 
					                                     %75 = OpLabel 
					                                             OpKill
					                                     %76 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 79
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %46 %60 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %8 RelaxedPrecision 
					                                             OpDecorate %11 RelaxedPrecision 
					                                             OpDecorate %11 DescriptorSet 11 
					                                             OpDecorate %11 Binding 11 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %15 RelaxedPrecision 
					                                             OpDecorate %15 DescriptorSet 15 
					                                             OpDecorate %15 Binding 15 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 21 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %46 Location 46 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %52 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %55 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %58 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 Location 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate %65 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypePointer Private %6 
					                         Private f32* %8 = OpVariable Private 
					                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %10 = OpTypePointer UniformConstant %9 
					UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                     %13 = OpTypeSampler 
					                                     %14 = OpTypePointer UniformConstant %13 
					            UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                     %17 = OpTypeSampledImage %9 
					                                     %19 = OpTypeVector %6 4 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                        Private f32* %29 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                 u32 %32 = OpConstant 0 
					                                     %33 = OpTypePointer Input %6 
					                                 f32 %42 = OpConstant 3.674022E-40 
					                                 f32 %43 = OpConstant 3.674022E-40 
					                        Private f32* %45 = OpVariable Private 
					                        Input f32_4* %46 = OpVariable Input 
					                                 f32 %51 = OpConstant 3.674022E-40 
					                                     %53 = OpTypePointer Private %19 
					                      Private f32_4* %54 = OpVariable Private 
					                                     %59 = OpTypePointer Output %19 
					                       Output f32_4* %60 = OpVariable Output 
					                                     %62 = OpTypeBool 
					                                     %63 = OpTypePointer Private %62 
					                       Private bool* %64 = OpVariable Private 
					                                     %68 = OpTypeInt 32 1 
					                                 i32 %69 = OpConstant 0 
					                                 i32 %70 = OpConstant 1 
					                                 i32 %72 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_4 %23 = OpLoad vs_TEXCOORD0 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                                             OpStore %8 %28 
					                                 f32 %30 = OpLoad %8 
					                          Input f32* %34 = OpAccessChain vs_TEXCOORD1 %32 
					                                 f32 %35 = OpLoad %34 
					                                 f32 %36 = OpFMul %30 %35 
					                          Input f32* %37 = OpAccessChain vs_TEXCOORD1 %27 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFNegate %38 
					                                 f32 %40 = OpFAdd %36 %39 
					                                             OpStore %29 %40 
					                                 f32 %41 = OpLoad %29 
					                                 f32 %44 = OpExtInst %1 43 %41 %42 %43 
					                                             OpStore %29 %44 
					                          Input f32* %47 = OpAccessChain %46 %27 
					                                 f32 %48 = OpLoad %47 
					                                 f32 %49 = OpLoad %29 
					                                 f32 %50 = OpFMul %48 %49 
					                                 f32 %52 = OpFAdd %50 %51 
					                                             OpStore %45 %52 
					                                 f32 %55 = OpLoad %29 
					                               f32_4 %56 = OpCompositeConstruct %55 %55 %55 %55 
					                               f32_4 %57 = OpLoad %46 
					                               f32_4 %58 = OpFMul %56 %57 
					                                             OpStore %54 %58 
					                               f32_4 %61 = OpLoad %54 
					                                             OpStore %60 %61 
					                                 f32 %65 = OpLoad %45 
					                                bool %66 = OpFOrdLessThan %65 %42 
					                                             OpStore %64 %66 
					                                bool %67 = OpLoad %64 
					                                 i32 %71 = OpSelect %67 %70 %69 
					                                 i32 %73 = OpIMul %71 %72 
					                                bool %74 = OpINotEqual %73 %69 
					                                             OpSelectionMerge %76 None 
					                                             OpBranchConditional %74 %75 %76 
					                                     %75 = OpLabel 
					                                             OpKill
					                                     %76 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 79
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %46 %60 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %8 RelaxedPrecision 
					                                             OpDecorate %11 RelaxedPrecision 
					                                             OpDecorate %11 DescriptorSet 11 
					                                             OpDecorate %11 Binding 11 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %15 RelaxedPrecision 
					                                             OpDecorate %15 DescriptorSet 15 
					                                             OpDecorate %15 Binding 15 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 21 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %46 Location 46 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %52 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %55 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %58 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 Location 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate %65 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypePointer Private %6 
					                         Private f32* %8 = OpVariable Private 
					                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %10 = OpTypePointer UniformConstant %9 
					UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
					                                     %13 = OpTypeSampler 
					                                     %14 = OpTypePointer UniformConstant %13 
					            UniformConstant sampler* %15 = OpVariable UniformConstant 
					                                     %17 = OpTypeSampledImage %9 
					                                     %19 = OpTypeVector %6 4 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                     %22 = OpTypeVector %6 2 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                        Private f32* %29 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                 u32 %32 = OpConstant 0 
					                                     %33 = OpTypePointer Input %6 
					                                 f32 %42 = OpConstant 3.674022E-40 
					                                 f32 %43 = OpConstant 3.674022E-40 
					                        Private f32* %45 = OpVariable Private 
					                        Input f32_4* %46 = OpVariable Input 
					                                 f32 %51 = OpConstant 3.674022E-40 
					                                     %53 = OpTypePointer Private %19 
					                      Private f32_4* %54 = OpVariable Private 
					                                     %59 = OpTypePointer Output %19 
					                       Output f32_4* %60 = OpVariable Output 
					                                     %62 = OpTypeBool 
					                                     %63 = OpTypePointer Private %62 
					                       Private bool* %64 = OpVariable Private 
					                                     %68 = OpTypeInt 32 1 
					                                 i32 %69 = OpConstant 0 
					                                 i32 %70 = OpConstant 1 
					                                 i32 %72 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_4 %23 = OpLoad vs_TEXCOORD0 
					                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                                             OpStore %8 %28 
					                                 f32 %30 = OpLoad %8 
					                          Input f32* %34 = OpAccessChain vs_TEXCOORD1 %32 
					                                 f32 %35 = OpLoad %34 
					                                 f32 %36 = OpFMul %30 %35 
					                          Input f32* %37 = OpAccessChain vs_TEXCOORD1 %27 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFNegate %38 
					                                 f32 %40 = OpFAdd %36 %39 
					                                             OpStore %29 %40 
					                                 f32 %41 = OpLoad %29 
					                                 f32 %44 = OpExtInst %1 43 %41 %42 %43 
					                                             OpStore %29 %44 
					                          Input f32* %47 = OpAccessChain %46 %27 
					                                 f32 %48 = OpLoad %47 
					                                 f32 %49 = OpLoad %29 
					                                 f32 %50 = OpFMul %48 %49 
					                                 f32 %52 = OpFAdd %50 %51 
					                                             OpStore %45 %52 
					                                 f32 %55 = OpLoad %29 
					                               f32_4 %56 = OpCompositeConstruct %55 %55 %55 %55 
					                               f32_4 %57 = OpLoad %46 
					                               f32_4 %58 = OpFMul %56 %57 
					                                             OpStore %54 %58 
					                               f32_4 %61 = OpLoad %54 
					                                             OpStore %60 %61 
					                                 f32 %65 = OpLoad %45 
					                                bool %66 = OpFOrdLessThan %65 %42 
					                                             OpStore %64 %66 
					                                bool %67 = OpLoad %64 
					                                 i32 %71 = OpSelect %67 %70 %69 
					                                 i32 %73 = OpIMul %71 %72 
					                                bool %74 = OpINotEqual %73 %69 
					                                             OpSelectionMerge %76 None 
					                                             OpBranchConditional %74 %75 %76 
					                                     %75 = OpLabel 
					                                             OpKill
					                                     %76 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in mediump vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
					#else
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					    u_xlat16_0 = vec4(u_xlat16_3) * vs_COLOR0;
					    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in mediump vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
					#else
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					    u_xlat16_0 = vec4(u_xlat16_3) * vs_COLOR0;
					    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in mediump vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
					#else
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					    u_xlat16_0 = vec4(u_xlat16_3) * vs_COLOR0;
					    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 97
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %64 %72 %87 %91 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 DescriptorSet 56 
					                                             OpDecorate %56 Binding 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 DescriptorSet 60 
					                                             OpDecorate %60 Binding 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 64 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %91 Location 91 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypeVector %6 4 
					                                     %11 = OpTypeStruct %10 
					                                     %12 = OpTypePointer Uniform %11 
					            Uniform struct {f32_4;}* %13 = OpVariable Uniform 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Uniform %10 
					                                     %26 = OpTypePointer Input %10 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %38 = OpConstant 3.674022E-40 
					                                 f32 %39 = OpConstant 3.674022E-40 
					                                     %43 = OpTypePointer Private %6 
					                        Private f32* %44 = OpVariable Private 
					                                     %45 = OpTypeInt 32 0 
					                                 u32 %46 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                        Private f32* %53 = OpVariable Private 
					                                     %54 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %55 = OpTypePointer UniformConstant %54 
					UniformConstant read_only Texture2D* %56 = OpVariable UniformConstant 
					                                     %58 = OpTypeSampler 
					                                     %59 = OpTypePointer UniformConstant %58 
					            UniformConstant sampler* %60 = OpVariable UniformConstant 
					                                     %62 = OpTypeSampledImage %54 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                                     %83 = OpTypePointer Private %10 
					                      Private f32_4* %84 = OpVariable Private 
					                        Input f32_4* %87 = OpVariable Input 
					                                     %90 = OpTypePointer Output %10 
					                       Output f32_4* %91 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %17 = OpAccessChain %13 %15 
					                               f32_4 %18 = OpLoad %17 
					                               f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                               f32_2 %20 = OpFNegate %19 
					                      Uniform f32_4* %21 = OpAccessChain %13 %15 
					                               f32_4 %22 = OpLoad %21 
					                               f32_2 %23 = OpVectorShuffle %22 %22 2 3 
					                               f32_2 %24 = OpFAdd %20 %23 
					                                             OpStore %9 %24 
					                               f32_2 %25 = OpLoad %9 
					                               f32_4 %28 = OpLoad vs_TEXCOORD2 
					                               f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                               f32_2 %30 = OpExtInst %1 4 %29 
					                               f32_2 %31 = OpFNegate %30 
					                               f32_2 %32 = OpFAdd %25 %31 
					                                             OpStore %9 %32 
					                               f32_2 %33 = OpLoad %9 
					                               f32_4 %34 = OpLoad vs_TEXCOORD2 
					                               f32_2 %35 = OpVectorShuffle %34 %34 2 3 
					                               f32_2 %36 = OpFMul %33 %35 
					                                             OpStore %9 %36 
					                               f32_2 %37 = OpLoad %9 
					                               f32_2 %40 = OpCompositeConstruct %38 %38 
					                               f32_2 %41 = OpCompositeConstruct %39 %39 
					                               f32_2 %42 = OpExtInst %1 43 %37 %40 %41 
					                                             OpStore %9 %42 
					                        Private f32* %47 = OpAccessChain %9 %46 
					                                 f32 %48 = OpLoad %47 
					                        Private f32* %50 = OpAccessChain %9 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpFMul %48 %51 
					                                             OpStore %44 %52 
					                 read_only Texture2D %57 = OpLoad %56 
					                             sampler %61 = OpLoad %60 
					          read_only Texture2DSampled %63 = OpSampledImage %57 %61 
					                               f32_4 %65 = OpLoad vs_TEXCOORD0 
					                               f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain vs_TEXCOORD1 %49 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                          Input f32* %77 = OpAccessChain vs_TEXCOORD1 %68 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpFNegate %78 
					                                 f32 %80 = OpFAdd %76 %79 
					                                             OpStore %70 %80 
					                                 f32 %81 = OpLoad %70 
					                                 f32 %82 = OpExtInst %1 43 %81 %38 %39 
					                                             OpStore %70 %82 
					                                 f32 %85 = OpLoad %70 
					                               f32_4 %86 = OpCompositeConstruct %85 %85 %85 %85 
					                               f32_4 %88 = OpLoad %87 
					                               f32_4 %89 = OpFMul %86 %88 
					                                             OpStore %84 %89 
					                                 f32 %92 = OpLoad %44 
					                               f32_4 %93 = OpCompositeConstruct %92 %92 %92 %92 
					                               f32_4 %94 = OpLoad %84 
					                               f32_4 %95 = OpFMul %93 %94 
					                                             OpStore %91 %95 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 97
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %64 %72 %87 %91 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 DescriptorSet 56 
					                                             OpDecorate %56 Binding 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 DescriptorSet 60 
					                                             OpDecorate %60 Binding 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 64 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %91 Location 91 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypeVector %6 4 
					                                     %11 = OpTypeStruct %10 
					                                     %12 = OpTypePointer Uniform %11 
					            Uniform struct {f32_4;}* %13 = OpVariable Uniform 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Uniform %10 
					                                     %26 = OpTypePointer Input %10 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %38 = OpConstant 3.674022E-40 
					                                 f32 %39 = OpConstant 3.674022E-40 
					                                     %43 = OpTypePointer Private %6 
					                        Private f32* %44 = OpVariable Private 
					                                     %45 = OpTypeInt 32 0 
					                                 u32 %46 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                        Private f32* %53 = OpVariable Private 
					                                     %54 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %55 = OpTypePointer UniformConstant %54 
					UniformConstant read_only Texture2D* %56 = OpVariable UniformConstant 
					                                     %58 = OpTypeSampler 
					                                     %59 = OpTypePointer UniformConstant %58 
					            UniformConstant sampler* %60 = OpVariable UniformConstant 
					                                     %62 = OpTypeSampledImage %54 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                                     %83 = OpTypePointer Private %10 
					                      Private f32_4* %84 = OpVariable Private 
					                        Input f32_4* %87 = OpVariable Input 
					                                     %90 = OpTypePointer Output %10 
					                       Output f32_4* %91 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %17 = OpAccessChain %13 %15 
					                               f32_4 %18 = OpLoad %17 
					                               f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                               f32_2 %20 = OpFNegate %19 
					                      Uniform f32_4* %21 = OpAccessChain %13 %15 
					                               f32_4 %22 = OpLoad %21 
					                               f32_2 %23 = OpVectorShuffle %22 %22 2 3 
					                               f32_2 %24 = OpFAdd %20 %23 
					                                             OpStore %9 %24 
					                               f32_2 %25 = OpLoad %9 
					                               f32_4 %28 = OpLoad vs_TEXCOORD2 
					                               f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                               f32_2 %30 = OpExtInst %1 4 %29 
					                               f32_2 %31 = OpFNegate %30 
					                               f32_2 %32 = OpFAdd %25 %31 
					                                             OpStore %9 %32 
					                               f32_2 %33 = OpLoad %9 
					                               f32_4 %34 = OpLoad vs_TEXCOORD2 
					                               f32_2 %35 = OpVectorShuffle %34 %34 2 3 
					                               f32_2 %36 = OpFMul %33 %35 
					                                             OpStore %9 %36 
					                               f32_2 %37 = OpLoad %9 
					                               f32_2 %40 = OpCompositeConstruct %38 %38 
					                               f32_2 %41 = OpCompositeConstruct %39 %39 
					                               f32_2 %42 = OpExtInst %1 43 %37 %40 %41 
					                                             OpStore %9 %42 
					                        Private f32* %47 = OpAccessChain %9 %46 
					                                 f32 %48 = OpLoad %47 
					                        Private f32* %50 = OpAccessChain %9 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpFMul %48 %51 
					                                             OpStore %44 %52 
					                 read_only Texture2D %57 = OpLoad %56 
					                             sampler %61 = OpLoad %60 
					          read_only Texture2DSampled %63 = OpSampledImage %57 %61 
					                               f32_4 %65 = OpLoad vs_TEXCOORD0 
					                               f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain vs_TEXCOORD1 %49 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                          Input f32* %77 = OpAccessChain vs_TEXCOORD1 %68 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpFNegate %78 
					                                 f32 %80 = OpFAdd %76 %79 
					                                             OpStore %70 %80 
					                                 f32 %81 = OpLoad %70 
					                                 f32 %82 = OpExtInst %1 43 %81 %38 %39 
					                                             OpStore %70 %82 
					                                 f32 %85 = OpLoad %70 
					                               f32_4 %86 = OpCompositeConstruct %85 %85 %85 %85 
					                               f32_4 %88 = OpLoad %87 
					                               f32_4 %89 = OpFMul %86 %88 
					                                             OpStore %84 %89 
					                                 f32 %92 = OpLoad %44 
					                               f32_4 %93 = OpCompositeConstruct %92 %92 %92 %92 
					                               f32_4 %94 = OpLoad %84 
					                               f32_4 %95 = OpFMul %93 %94 
					                                             OpStore %91 %95 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 97
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %64 %72 %87 %91 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 DescriptorSet 56 
					                                             OpDecorate %56 Binding 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 DescriptorSet 60 
					                                             OpDecorate %60 Binding 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 64 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %91 Location 91 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypeVector %6 4 
					                                     %11 = OpTypeStruct %10 
					                                     %12 = OpTypePointer Uniform %11 
					            Uniform struct {f32_4;}* %13 = OpVariable Uniform 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Uniform %10 
					                                     %26 = OpTypePointer Input %10 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %38 = OpConstant 3.674022E-40 
					                                 f32 %39 = OpConstant 3.674022E-40 
					                                     %43 = OpTypePointer Private %6 
					                        Private f32* %44 = OpVariable Private 
					                                     %45 = OpTypeInt 32 0 
					                                 u32 %46 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                        Private f32* %53 = OpVariable Private 
					                                     %54 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %55 = OpTypePointer UniformConstant %54 
					UniformConstant read_only Texture2D* %56 = OpVariable UniformConstant 
					                                     %58 = OpTypeSampler 
					                                     %59 = OpTypePointer UniformConstant %58 
					            UniformConstant sampler* %60 = OpVariable UniformConstant 
					                                     %62 = OpTypeSampledImage %54 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                                     %83 = OpTypePointer Private %10 
					                      Private f32_4* %84 = OpVariable Private 
					                        Input f32_4* %87 = OpVariable Input 
					                                     %90 = OpTypePointer Output %10 
					                       Output f32_4* %91 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %17 = OpAccessChain %13 %15 
					                               f32_4 %18 = OpLoad %17 
					                               f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                               f32_2 %20 = OpFNegate %19 
					                      Uniform f32_4* %21 = OpAccessChain %13 %15 
					                               f32_4 %22 = OpLoad %21 
					                               f32_2 %23 = OpVectorShuffle %22 %22 2 3 
					                               f32_2 %24 = OpFAdd %20 %23 
					                                             OpStore %9 %24 
					                               f32_2 %25 = OpLoad %9 
					                               f32_4 %28 = OpLoad vs_TEXCOORD2 
					                               f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                               f32_2 %30 = OpExtInst %1 4 %29 
					                               f32_2 %31 = OpFNegate %30 
					                               f32_2 %32 = OpFAdd %25 %31 
					                                             OpStore %9 %32 
					                               f32_2 %33 = OpLoad %9 
					                               f32_4 %34 = OpLoad vs_TEXCOORD2 
					                               f32_2 %35 = OpVectorShuffle %34 %34 2 3 
					                               f32_2 %36 = OpFMul %33 %35 
					                                             OpStore %9 %36 
					                               f32_2 %37 = OpLoad %9 
					                               f32_2 %40 = OpCompositeConstruct %38 %38 
					                               f32_2 %41 = OpCompositeConstruct %39 %39 
					                               f32_2 %42 = OpExtInst %1 43 %37 %40 %41 
					                                             OpStore %9 %42 
					                        Private f32* %47 = OpAccessChain %9 %46 
					                                 f32 %48 = OpLoad %47 
					                        Private f32* %50 = OpAccessChain %9 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpFMul %48 %51 
					                                             OpStore %44 %52 
					                 read_only Texture2D %57 = OpLoad %56 
					                             sampler %61 = OpLoad %60 
					          read_only Texture2DSampled %63 = OpSampledImage %57 %61 
					                               f32_4 %65 = OpLoad vs_TEXCOORD0 
					                               f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain vs_TEXCOORD1 %49 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                          Input f32* %77 = OpAccessChain vs_TEXCOORD1 %68 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpFNegate %78 
					                                 f32 %80 = OpFAdd %76 %79 
					                                             OpStore %70 %80 
					                                 f32 %81 = OpLoad %70 
					                                 f32 %82 = OpExtInst %1 43 %81 %38 %39 
					                                             OpStore %70 %82 
					                                 f32 %85 = OpLoad %70 
					                               f32_4 %86 = OpCompositeConstruct %85 %85 %85 %85 
					                               f32_4 %88 = OpLoad %87 
					                               f32_4 %89 = OpFMul %86 %88 
					                                             OpStore %84 %89 
					                                 f32 %92 = OpLoad %44 
					                               f32_4 %93 = OpCompositeConstruct %92 %92 %92 %92 
					                               f32_4 %94 = OpLoad %84 
					                               f32_4 %95 = OpFMul %93 %94 
					                                             OpStore %91 %95 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in mediump vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
					#else
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_4 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
					#else
					    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
					#endif
					    u_xlat16_0 = vec4(u_xlat16_4) * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
					    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_4<0.0);
					#else
					    u_xlatb2 = u_xlat16_4<0.0;
					#endif
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in mediump vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
					#else
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_4 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
					#else
					    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
					#endif
					    u_xlat16_0 = vec4(u_xlat16_4) * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
					    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_4<0.0);
					#else
					    u_xlatb2 = u_xlat16_4<0.0;
					#endif
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _FaceDilate;
					uniform 	float _OutlineSoftness;
					uniform 	mediump vec4 _OutlineColor;
					uniform 	float _OutlineWidth;
					uniform 	float _WeightNormal;
					uniform 	float _WeightBold;
					uniform 	float _ScaleRatioA;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					uniform 	float _GradientScale;
					uniform 	float _ScaleX;
					uniform 	float _ScaleY;
					uniform 	float _PerspectiveFilter;
					uniform 	float _Sharpness;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out mediump vec4 vs_COLOR1;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec4 u_xlat16_3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat16_3 = in_COLOR0 * _FaceColor;
					    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_3.xyz;
					    vs_COLOR0 = u_xlat16_3;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
					    u_xlat10 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
					    u_xlat1.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat1.xy;
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat1.xy = u_xlat2.ww / u_xlat1.xy;
					    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.xy;
					    u_xlat1.zw = vec2(0.25, 0.25) / u_xlat1.xy;
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat7 = _Sharpness + 1.0;
					    u_xlat2.x = u_xlat7 * u_xlat2.x;
					    u_xlat7 = u_xlat15 * u_xlat2.x;
					    u_xlat12 = (-_PerspectiveFilter) + 1.0;
					    u_xlat12 = u_xlat12 * abs(u_xlat7);
					    u_xlat15 = u_xlat15 * u_xlat2.x + (-u_xlat12);
					    u_xlat10 = abs(u_xlat10) * u_xlat15 + u_xlat12;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb15 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
					#else
					    u_xlatb15 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
					#endif
					    u_xlat10 = (u_xlatb15) ? u_xlat10 : u_xlat7;
					    u_xlat15 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat15 = u_xlat15 * u_xlat10 + 1.0;
					    u_xlat2.x = u_xlat10 / u_xlat15;
					    u_xlat10 = _OutlineWidth * _ScaleRatioA;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat15 = min(u_xlat10, 1.0);
					    u_xlat15 = sqrt(u_xlat15);
					    u_xlat4.x = in_COLOR0.w * _OutlineColor.w;
					    u_xlat4.xyz = _OutlineColor.xyz * u_xlat4.xxx + (-u_xlat16_3.xyz);
					    u_xlat4.w = _OutlineColor.w * in_COLOR0.w + (-u_xlat16_3.w);
					    u_xlat3 = vec4(u_xlat15) * u_xlat4 + u_xlat16_3;
					    vs_COLOR1 = u_xlat3;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat4.xy = u_xlat0.xy + (-u_xlat3.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    u_xlat1.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xy = (-u_xlat3.xy) + u_xlat3.zw;
					    vs_TEXCOORD0.zw = u_xlat4.xy / u_xlat0.xy;
					    vs_TEXCOORD2 = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0>=in_TEXCOORD1.y);
					#else
					    u_xlatb0 = 0.0>=in_TEXCOORD1.y;
					#endif
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat5 = (-_WeightNormal) + _WeightBold;
					    u_xlat0.x = u_xlat0.x * u_xlat5 + _WeightNormal;
					    u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
					    u_xlat0.x = u_xlat0.x * _ScaleRatioA;
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 0.5;
					    u_xlat2.w = u_xlat0.x * u_xlat2.x + -0.5;
					    u_xlat2.y = (-u_xlat10) * 0.5 + u_xlat2.w;
					    u_xlat2.z = u_xlat10 * 0.5 + u_xlat2.w;
					    vs_TEXCOORD1 = u_xlat2;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in mediump vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
					#else
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat0.y * u_xlat0.x;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_4 = u_xlat16_0.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.w);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
					#else
					    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
					#endif
					    u_xlat16_0 = vec4(u_xlat16_4) * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
					    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_4<0.0);
					#else
					    u_xlatb2 = u_xlat16_4<0.0;
					#endif
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 118
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %64 %72 %87 %101 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 DescriptorSet 56 
					                                             OpDecorate %56 Binding 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 DescriptorSet 60 
					                                             OpDecorate %60 Binding 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 64 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %98 RelaxedPrecision 
					                                             OpDecorate %99 RelaxedPrecision 
					                                             OpDecorate %101 RelaxedPrecision 
					                                             OpDecorate %101 Location 101 
					                                             OpDecorate %102 RelaxedPrecision 
					                                             OpDecorate %106 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypeVector %6 4 
					                                     %11 = OpTypeStruct %10 
					                                     %12 = OpTypePointer Uniform %11 
					            Uniform struct {f32_4;}* %13 = OpVariable Uniform 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Uniform %10 
					                                     %26 = OpTypePointer Input %10 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %38 = OpConstant 3.674022E-40 
					                                 f32 %39 = OpConstant 3.674022E-40 
					                                     %43 = OpTypePointer Private %6 
					                        Private f32* %44 = OpVariable Private 
					                                     %45 = OpTypeInt 32 0 
					                                 u32 %46 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                        Private f32* %53 = OpVariable Private 
					                                     %54 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %55 = OpTypePointer UniformConstant %54 
					UniformConstant read_only Texture2D* %56 = OpVariable UniformConstant 
					                                     %58 = OpTypeSampler 
					                                     %59 = OpTypePointer UniformConstant %58 
					            UniformConstant sampler* %60 = OpVariable UniformConstant 
					                                     %62 = OpTypeSampledImage %54 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                                     %83 = OpTypePointer Private %10 
					                      Private f32_4* %84 = OpVariable Private 
					                        Input f32_4* %87 = OpVariable Input 
					                                 f32 %94 = OpConstant 3.674022E-40 
					                                    %100 = OpTypePointer Output %10 
					                      Output f32_4* %101 = OpVariable Output 
					                                    %103 = OpTypeBool 
					                                    %104 = OpTypePointer Private %103 
					                      Private bool* %105 = OpVariable Private 
					                                i32 %109 = OpConstant 1 
					                                i32 %111 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %17 = OpAccessChain %13 %15 
					                               f32_4 %18 = OpLoad %17 
					                               f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                               f32_2 %20 = OpFNegate %19 
					                      Uniform f32_4* %21 = OpAccessChain %13 %15 
					                               f32_4 %22 = OpLoad %21 
					                               f32_2 %23 = OpVectorShuffle %22 %22 2 3 
					                               f32_2 %24 = OpFAdd %20 %23 
					                                             OpStore %9 %24 
					                               f32_2 %25 = OpLoad %9 
					                               f32_4 %28 = OpLoad vs_TEXCOORD2 
					                               f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                               f32_2 %30 = OpExtInst %1 4 %29 
					                               f32_2 %31 = OpFNegate %30 
					                               f32_2 %32 = OpFAdd %25 %31 
					                                             OpStore %9 %32 
					                               f32_2 %33 = OpLoad %9 
					                               f32_4 %34 = OpLoad vs_TEXCOORD2 
					                               f32_2 %35 = OpVectorShuffle %34 %34 2 3 
					                               f32_2 %36 = OpFMul %33 %35 
					                                             OpStore %9 %36 
					                               f32_2 %37 = OpLoad %9 
					                               f32_2 %40 = OpCompositeConstruct %38 %38 
					                               f32_2 %41 = OpCompositeConstruct %39 %39 
					                               f32_2 %42 = OpExtInst %1 43 %37 %40 %41 
					                                             OpStore %9 %42 
					                        Private f32* %47 = OpAccessChain %9 %46 
					                                 f32 %48 = OpLoad %47 
					                        Private f32* %50 = OpAccessChain %9 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpFMul %48 %51 
					                                             OpStore %44 %52 
					                 read_only Texture2D %57 = OpLoad %56 
					                             sampler %61 = OpLoad %60 
					          read_only Texture2DSampled %63 = OpSampledImage %57 %61 
					                               f32_4 %65 = OpLoad vs_TEXCOORD0 
					                               f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain vs_TEXCOORD1 %49 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                          Input f32* %77 = OpAccessChain vs_TEXCOORD1 %68 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpFNegate %78 
					                                 f32 %80 = OpFAdd %76 %79 
					                                             OpStore %70 %80 
					                                 f32 %81 = OpLoad %70 
					                                 f32 %82 = OpExtInst %1 43 %81 %38 %39 
					                                             OpStore %70 %82 
					                                 f32 %85 = OpLoad %70 
					                               f32_4 %86 = OpCompositeConstruct %85 %85 %85 %85 
					                               f32_4 %88 = OpLoad %87 
					                               f32_4 %89 = OpFMul %86 %88 
					                                             OpStore %84 %89 
					                        Private f32* %90 = OpAccessChain %84 %68 
					                                 f32 %91 = OpLoad %90 
					                                 f32 %92 = OpLoad %44 
					                                 f32 %93 = OpFMul %91 %92 
					                                 f32 %95 = OpFAdd %93 %94 
					                                             OpStore %70 %95 
					                                 f32 %96 = OpLoad %44 
					                               f32_4 %97 = OpCompositeConstruct %96 %96 %96 %96 
					                               f32_4 %98 = OpLoad %84 
					                               f32_4 %99 = OpFMul %97 %98 
					                                             OpStore %84 %99 
					                              f32_4 %102 = OpLoad %84 
					                                             OpStore %101 %102 
					                                f32 %106 = OpLoad %70 
					                               bool %107 = OpFOrdLessThan %106 %38 
					                                             OpStore %105 %107 
					                               bool %108 = OpLoad %105 
					                                i32 %110 = OpSelect %108 %109 %15 
					                                i32 %112 = OpIMul %110 %111 
					                               bool %113 = OpINotEqual %112 %15 
					                                             OpSelectionMerge %115 None 
					                                             OpBranchConditional %113 %114 %115 
					                                    %114 = OpLabel 
					                                             OpKill
					                                    %115 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 118
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %64 %72 %87 %101 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 DescriptorSet 56 
					                                             OpDecorate %56 Binding 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 DescriptorSet 60 
					                                             OpDecorate %60 Binding 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 64 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %98 RelaxedPrecision 
					                                             OpDecorate %99 RelaxedPrecision 
					                                             OpDecorate %101 RelaxedPrecision 
					                                             OpDecorate %101 Location 101 
					                                             OpDecorate %102 RelaxedPrecision 
					                                             OpDecorate %106 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypeVector %6 4 
					                                     %11 = OpTypeStruct %10 
					                                     %12 = OpTypePointer Uniform %11 
					            Uniform struct {f32_4;}* %13 = OpVariable Uniform 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Uniform %10 
					                                     %26 = OpTypePointer Input %10 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %38 = OpConstant 3.674022E-40 
					                                 f32 %39 = OpConstant 3.674022E-40 
					                                     %43 = OpTypePointer Private %6 
					                        Private f32* %44 = OpVariable Private 
					                                     %45 = OpTypeInt 32 0 
					                                 u32 %46 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                        Private f32* %53 = OpVariable Private 
					                                     %54 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %55 = OpTypePointer UniformConstant %54 
					UniformConstant read_only Texture2D* %56 = OpVariable UniformConstant 
					                                     %58 = OpTypeSampler 
					                                     %59 = OpTypePointer UniformConstant %58 
					            UniformConstant sampler* %60 = OpVariable UniformConstant 
					                                     %62 = OpTypeSampledImage %54 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                                     %83 = OpTypePointer Private %10 
					                      Private f32_4* %84 = OpVariable Private 
					                        Input f32_4* %87 = OpVariable Input 
					                                 f32 %94 = OpConstant 3.674022E-40 
					                                    %100 = OpTypePointer Output %10 
					                      Output f32_4* %101 = OpVariable Output 
					                                    %103 = OpTypeBool 
					                                    %104 = OpTypePointer Private %103 
					                      Private bool* %105 = OpVariable Private 
					                                i32 %109 = OpConstant 1 
					                                i32 %111 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %17 = OpAccessChain %13 %15 
					                               f32_4 %18 = OpLoad %17 
					                               f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                               f32_2 %20 = OpFNegate %19 
					                      Uniform f32_4* %21 = OpAccessChain %13 %15 
					                               f32_4 %22 = OpLoad %21 
					                               f32_2 %23 = OpVectorShuffle %22 %22 2 3 
					                               f32_2 %24 = OpFAdd %20 %23 
					                                             OpStore %9 %24 
					                               f32_2 %25 = OpLoad %9 
					                               f32_4 %28 = OpLoad vs_TEXCOORD2 
					                               f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                               f32_2 %30 = OpExtInst %1 4 %29 
					                               f32_2 %31 = OpFNegate %30 
					                               f32_2 %32 = OpFAdd %25 %31 
					                                             OpStore %9 %32 
					                               f32_2 %33 = OpLoad %9 
					                               f32_4 %34 = OpLoad vs_TEXCOORD2 
					                               f32_2 %35 = OpVectorShuffle %34 %34 2 3 
					                               f32_2 %36 = OpFMul %33 %35 
					                                             OpStore %9 %36 
					                               f32_2 %37 = OpLoad %9 
					                               f32_2 %40 = OpCompositeConstruct %38 %38 
					                               f32_2 %41 = OpCompositeConstruct %39 %39 
					                               f32_2 %42 = OpExtInst %1 43 %37 %40 %41 
					                                             OpStore %9 %42 
					                        Private f32* %47 = OpAccessChain %9 %46 
					                                 f32 %48 = OpLoad %47 
					                        Private f32* %50 = OpAccessChain %9 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpFMul %48 %51 
					                                             OpStore %44 %52 
					                 read_only Texture2D %57 = OpLoad %56 
					                             sampler %61 = OpLoad %60 
					          read_only Texture2DSampled %63 = OpSampledImage %57 %61 
					                               f32_4 %65 = OpLoad vs_TEXCOORD0 
					                               f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain vs_TEXCOORD1 %49 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                          Input f32* %77 = OpAccessChain vs_TEXCOORD1 %68 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpFNegate %78 
					                                 f32 %80 = OpFAdd %76 %79 
					                                             OpStore %70 %80 
					                                 f32 %81 = OpLoad %70 
					                                 f32 %82 = OpExtInst %1 43 %81 %38 %39 
					                                             OpStore %70 %82 
					                                 f32 %85 = OpLoad %70 
					                               f32_4 %86 = OpCompositeConstruct %85 %85 %85 %85 
					                               f32_4 %88 = OpLoad %87 
					                               f32_4 %89 = OpFMul %86 %88 
					                                             OpStore %84 %89 
					                        Private f32* %90 = OpAccessChain %84 %68 
					                                 f32 %91 = OpLoad %90 
					                                 f32 %92 = OpLoad %44 
					                                 f32 %93 = OpFMul %91 %92 
					                                 f32 %95 = OpFAdd %93 %94 
					                                             OpStore %70 %95 
					                                 f32 %96 = OpLoad %44 
					                               f32_4 %97 = OpCompositeConstruct %96 %96 %96 %96 
					                               f32_4 %98 = OpLoad %84 
					                               f32_4 %99 = OpFMul %97 %98 
					                                             OpStore %84 %99 
					                              f32_4 %102 = OpLoad %84 
					                                             OpStore %101 %102 
					                                f32 %106 = OpLoad %70 
					                               bool %107 = OpFOrdLessThan %106 %38 
					                                             OpStore %105 %107 
					                               bool %108 = OpLoad %105 
					                                i32 %110 = OpSelect %108 %109 %15 
					                                i32 %112 = OpIMul %110 %111 
					                               bool %113 = OpINotEqual %112 %15 
					                                             OpSelectionMerge %115 None 
					                                             OpBranchConditional %113 %114 %115 
					                                    %114 = OpLabel 
					                                             OpKill
					                                    %115 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 518
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %118 %123 %136 %155 %266 %391 %431 %438 %440 %510 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpDecorate %19 ArrayStride 19 
					                                                      OpDecorate %20 ArrayStride 20 
					                                                      OpDecorate %21 ArrayStride 21 
					                                                      OpMemberDecorate %22 0 Offset 22 
					                                                      OpMemberDecorate %22 1 Offset 22 
					                                                      OpMemberDecorate %22 2 Offset 22 
					                                                      OpMemberDecorate %22 3 Offset 22 
					                                                      OpMemberDecorate %22 4 Offset 22 
					                                                      OpMemberDecorate %22 5 Offset 22 
					                                                      OpMemberDecorate %22 6 RelaxedPrecision 
					                                                      OpMemberDecorate %22 6 Offset 22 
					                                                      OpMemberDecorate %22 7 Offset 22 
					                                                      OpMemberDecorate %22 8 Offset 22 
					                                                      OpMemberDecorate %22 9 RelaxedPrecision 
					                                                      OpMemberDecorate %22 9 Offset 22 
					                                                      OpMemberDecorate %22 10 Offset 22 
					                                                      OpMemberDecorate %22 11 Offset 22 
					                                                      OpMemberDecorate %22 12 Offset 22 
					                                                      OpMemberDecorate %22 13 Offset 22 
					                                                      OpMemberDecorate %22 14 Offset 22 
					                                                      OpMemberDecorate %22 15 Offset 22 
					                                                      OpMemberDecorate %22 16 Offset 22 
					                                                      OpMemberDecorate %22 17 Offset 22 
					                                                      OpMemberDecorate %22 18 Offset 22 
					                                                      OpMemberDecorate %22 19 Offset 22 
					                                                      OpMemberDecorate %22 20 Offset 22 
					                                                      OpMemberDecorate %22 21 Offset 22 
					                                                      OpMemberDecorate %22 22 Offset 22 
					                                                      OpMemberDecorate %22 23 Offset 22 
					                                                      OpDecorate %22 Block 
					                                                      OpDecorate %24 DescriptorSet 24 
					                                                      OpDecorate %24 Binding 24 
					                                                      OpMemberDecorate %116 0 BuiltIn 116 
					                                                      OpMemberDecorate %116 1 BuiltIn 116 
					                                                      OpMemberDecorate %116 2 BuiltIn 116 
					                                                      OpDecorate %116 Block 
					                                                      OpDecorate %122 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %123 Location 123 
					                                                      OpDecorate %124 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %129 RelaxedPrecision 
					                                                      OpDecorate %130 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %136 Location 136 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %266 Location 266 
					                                                      OpDecorate %357 RelaxedPrecision 
					                                                      OpDecorate %360 RelaxedPrecision 
					                                                      OpDecorate %361 RelaxedPrecision 
					                                                      OpDecorate %364 RelaxedPrecision 
					                                                      OpDecorate %365 RelaxedPrecision 
					                                                      OpDecorate %369 RelaxedPrecision 
					                                                      OpDecorate %370 RelaxedPrecision 
					                                                      OpDecorate %371 RelaxedPrecision 
					                                                      OpDecorate %376 RelaxedPrecision 
					                                                      OpDecorate %378 RelaxedPrecision 
					                                                      OpDecorate %379 RelaxedPrecision 
					                                                      OpDecorate %381 RelaxedPrecision 
					                                                      OpDecorate %382 RelaxedPrecision 
					                                                      OpDecorate %383 RelaxedPrecision 
					                                                      OpDecorate %389 RelaxedPrecision 
					                                                      OpDecorate %391 RelaxedPrecision 
					                                                      OpDecorate %391 Location 391 
					                                                      OpDecorate vs_TEXCOORD0 Location 431 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 438 
					                                                      OpDecorate %440 Location 440 
					                                                      OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 510 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %15 = OpTypeVector %6 3 
					                                              %16 = OpTypeInt 32 0 
					                                          u32 %17 = OpConstant 4 
					                                              %18 = OpTypeArray %10 %17 
					                                              %19 = OpTypeArray %10 %17 
					                                              %20 = OpTypeArray %10 %17 
					                                              %21 = OpTypeArray %10 %17 
					                                              %22 = OpTypeStruct %15 %10 %18 %19 %20 %21 %10 %6 %6 %10 %6 %6 %6 %6 %6 %6 %10 %6 %6 %6 %6 %6 %6 %6 
					                                              %23 = OpTypePointer Uniform %22 
					Uniform struct {f32_3; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32_4; f32; f32; f32; f32; f32; f32; f32;}* %24 = OpVariable Uniform 
					                                              %25 = OpTypeInt 32 1 
					                                          i32 %26 = OpConstant 14 
					                                              %27 = OpTypePointer Uniform %6 
					                                          i32 %30 = OpConstant 15 
					                                              %35 = OpTypePointer Private %10 
					                               Private f32_4* %36 = OpVariable Private 
					                                          i32 %39 = OpConstant 2 
					                                          i32 %40 = OpConstant 1 
					                                              %41 = OpTypePointer Uniform %10 
					                                          i32 %45 = OpConstant 0 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                              %80 = OpTypePointer Uniform %15 
					                               Private f32_4* %86 = OpVariable Private 
					                                          i32 %89 = OpConstant 5 
					                                         u32 %114 = OpConstant 1 
					                                             %115 = OpTypeArray %6 %114 
					                                             %116 = OpTypeStruct %10 %6 %115 
					                                             %117 = OpTypePointer Output %116 
					        Output struct {f32_4; f32; f32[1];}* %118 = OpVariable Output 
					                                             %120 = OpTypePointer Output %10 
					                              Private f32_4* %122 = OpVariable Private 
					                                Input f32_4* %123 = OpVariable Input 
					                                         i32 %125 = OpConstant 6 
					                               Output f32_4* %136 = OpVariable Output 
					                                             %138 = OpTypePointer Private %6 
					                                Private f32* %139 = OpVariable Private 
					                                             %154 = OpTypePointer Input %15 
					                                Input f32_3* %155 = OpVariable Input 
					                                         u32 %161 = OpConstant 0 
					                                         u32 %174 = OpConstant 2 
					                                         i32 %198 = OpConstant 4 
					                                         i32 %220 = OpConstant 20 
					                                         i32 %223 = OpConstant 21 
					                                Private f32* %237 = OpVariable Private 
					                                         i32 %243 = OpConstant 17 
					                                         i32 %246 = OpConstant 18 
					                                         f32 %250 = OpConstant 3.674022E-40 
					                                       f32_2 %251 = OpConstantComposite %250 %250 
					                                             %265 = OpTypePointer Input %7 
					                                Input f32_2* %266 = OpVariable Input 
					                                             %267 = OpTypePointer Input %6 
					                                         i32 %271 = OpConstant 19 
					                                Private f32* %276 = OpVariable Private 
					                                         i32 %277 = OpConstant 23 
					                                         f32 %280 = OpConstant 3.674022E-40 
					                                Private f32* %291 = OpVariable Private 
					                                         i32 %292 = OpConstant 22 
					                                             %314 = OpTypeBool 
					                                             %315 = OpTypePointer Private %314 
					                               Private bool* %316 = OpVariable Private 
					                                         u32 %317 = OpConstant 3 
					                                         f32 %320 = OpConstant 3.674022E-40 
					                                         i32 %326 = OpConstant 8 
					                                         i32 %329 = OpConstant 13 
					                                         i32 %341 = OpConstant 10 
					                              Private f32_4* %355 = OpVariable Private 
					                                         i32 %358 = OpConstant 9 
					                               Output f32_4* %391 = OpVariable Output 
					                                         i32 %393 = OpConstant 16 
					                                         f32 %396 = OpConstant 3.674022E-40 
					                                       f32_4 %397 = OpConstantComposite %396 %396 %396 %396 
					                                         f32 %400 = OpConstant 3.674022E-40 
					                                       f32_4 %401 = OpConstantComposite %400 %400 %400 %400 
					                                         f32 %411 = OpConstant 3.674022E-40 
					                                       f32_2 %412 = OpConstantComposite %411 %411 
					                       Output f32_4* vs_TEXCOORD0 = OpVariable Output 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                Input f32_2* %440 = OpVariable Input 
					                               Private bool* %444 = OpVariable Private 
					                                Private f32* %451 = OpVariable Private 
					                                         i32 %452 = OpConstant 11 
					                                         i32 %456 = OpConstant 12 
					                                         i32 %471 = OpConstant 7 
					                                         f32 %485 = OpConstant 3.674022E-40 
					                                         f32 %494 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                             %512 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                 Uniform f32* %28 = OpAccessChain %24 %26 
					                                          f32 %29 = OpLoad %28 
					                                 Uniform f32* %31 = OpAccessChain %24 %30 
					                                          f32 %32 = OpLoad %31 
					                                        f32_2 %33 = OpCompositeConstruct %29 %32 
					                                        f32_2 %34 = OpFAdd %14 %33 
					                                                      OpStore %9 %34 
					                                        f32_2 %37 = OpLoad %9 
					                                        f32_4 %38 = OpVectorShuffle %37 %37 1 1 1 1 
					                               Uniform f32_4* %42 = OpAccessChain %24 %39 %40 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_4 %44 = OpFMul %38 %43 
					                                                      OpStore %36 %44 
					                               Uniform f32_4* %46 = OpAccessChain %24 %39 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_2 %48 = OpLoad %9 
					                                        f32_4 %49 = OpVectorShuffle %48 %48 0 0 0 0 
					                                        f32_4 %50 = OpFMul %47 %49 
					                                        f32_4 %51 = OpLoad %36 
					                                        f32_4 %52 = OpFAdd %50 %51 
					                                                      OpStore %36 %52 
					                               Uniform f32_4* %53 = OpAccessChain %24 %39 %39 
					                                        f32_4 %54 = OpLoad %53 
					                                        f32_4 %55 = OpLoad %12 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 2 2 2 2 
					                                        f32_4 %57 = OpFMul %54 %56 
					                                        f32_4 %58 = OpLoad %36 
					                                        f32_4 %59 = OpFAdd %57 %58 
					                                                      OpStore %36 %59 
					                                        f32_4 %61 = OpLoad %36 
					                               Uniform f32_4* %63 = OpAccessChain %24 %39 %62 
					                                        f32_4 %64 = OpLoad %63 
					                                        f32_4 %65 = OpFAdd %61 %64 
					                                                      OpStore %60 %65 
					                               Uniform f32_4* %66 = OpAccessChain %24 %39 %62 
					                                        f32_4 %67 = OpLoad %66 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_4 %69 = OpLoad %12 
					                                        f32_3 %70 = OpVectorShuffle %69 %69 3 3 3 
					                                        f32_3 %71 = OpFMul %68 %70 
					                                        f32_4 %72 = OpLoad %36 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                                        f32_3 %74 = OpFAdd %71 %73 
					                                        f32_4 %75 = OpLoad %36 
					                                        f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
					                                                      OpStore %36 %76 
					                                        f32_4 %77 = OpLoad %36 
					                                        f32_3 %78 = OpVectorShuffle %77 %77 0 1 2 
					                                        f32_3 %79 = OpFNegate %78 
					                               Uniform f32_3* %81 = OpAccessChain %24 %45 
					                                        f32_3 %82 = OpLoad %81 
					                                        f32_3 %83 = OpFAdd %79 %82 
					                                        f32_4 %84 = OpLoad %36 
					                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
					                                                      OpStore %36 %85 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %88 = OpVectorShuffle %87 %87 1 1 1 1 
					                               Uniform f32_4* %90 = OpAccessChain %24 %89 %40 
					                                        f32_4 %91 = OpLoad %90 
					                                        f32_4 %92 = OpFMul %88 %91 
					                                                      OpStore %86 %92 
					                               Uniform f32_4* %93 = OpAccessChain %24 %89 %45 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %60 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 0 0 0 0 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %86 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %86 %99 
					                              Uniform f32_4* %100 = OpAccessChain %24 %89 %39 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpLoad %60 
					                                       f32_4 %103 = OpVectorShuffle %102 %102 2 2 2 2 
					                                       f32_4 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %86 
					                                       f32_4 %106 = OpFAdd %104 %105 
					                                                      OpStore %86 %106 
					                              Uniform f32_4* %107 = OpAccessChain %24 %89 %62 
					                                       f32_4 %108 = OpLoad %107 
					                                       f32_4 %109 = OpLoad %60 
					                                       f32_4 %110 = OpVectorShuffle %109 %109 3 3 3 3 
					                                       f32_4 %111 = OpFMul %108 %110 
					                                       f32_4 %112 = OpLoad %86 
					                                       f32_4 %113 = OpFAdd %111 %112 
					                                                      OpStore %60 %113 
					                                       f32_4 %119 = OpLoad %60 
					                               Output f32_4* %121 = OpAccessChain %118 %45 
					                                                      OpStore %121 %119 
					                                       f32_4 %124 = OpLoad %123 
					                              Uniform f32_4* %126 = OpAccessChain %24 %125 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_4 %128 = OpFMul %124 %127 
					                                                      OpStore %122 %128 
					                                       f32_4 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 3 3 3 
					                                       f32_4 %131 = OpLoad %122 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFMul %130 %132 
					                                       f32_4 %134 = OpLoad %122 
					                                       f32_4 %135 = OpVectorShuffle %134 %133 4 5 6 3 
					                                                      OpStore %122 %135 
					                                       f32_4 %137 = OpLoad %122 
					                                                      OpStore %136 %137 
					                                       f32_4 %140 = OpLoad %36 
					                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
					                                       f32_4 %142 = OpLoad %36 
					                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
					                                         f32 %144 = OpDot %141 %143 
					                                                      OpStore %139 %144 
					                                         f32 %145 = OpLoad %139 
					                                         f32 %146 = OpExtInst %1 32 %145 
					                                                      OpStore %139 %146 
					                                         f32 %147 = OpLoad %139 
					                                       f32_3 %148 = OpCompositeConstruct %147 %147 %147 
					                                       f32_4 %149 = OpLoad %36 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFMul %148 %150 
					                                       f32_4 %152 = OpLoad %36 
					                                       f32_4 %153 = OpVectorShuffle %152 %151 4 5 6 3 
					                                                      OpStore %36 %153 
					                                       f32_3 %156 = OpLoad %155 
					                              Uniform f32_4* %157 = OpAccessChain %24 %62 %45 
					                                       f32_4 %158 = OpLoad %157 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                         f32 %160 = OpDot %156 %159 
					                                Private f32* %162 = OpAccessChain %60 %161 
					                                                      OpStore %162 %160 
					                                       f32_3 %163 = OpLoad %155 
					                              Uniform f32_4* %164 = OpAccessChain %24 %62 %40 
					                                       f32_4 %165 = OpLoad %164 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                         f32 %167 = OpDot %163 %166 
					                                Private f32* %168 = OpAccessChain %60 %114 
					                                                      OpStore %168 %167 
					                                       f32_3 %169 = OpLoad %155 
					                              Uniform f32_4* %170 = OpAccessChain %24 %62 %39 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_3 %172 = OpVectorShuffle %171 %171 0 1 2 
					                                         f32 %173 = OpDot %169 %172 
					                                Private f32* %175 = OpAccessChain %60 %174 
					                                                      OpStore %175 %173 
					                                       f32_4 %176 = OpLoad %60 
					                                       f32_3 %177 = OpVectorShuffle %176 %176 0 1 2 
					                                       f32_4 %178 = OpLoad %60 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %177 %179 
					                                                      OpStore %139 %180 
					                                         f32 %181 = OpLoad %139 
					                                         f32 %182 = OpExtInst %1 32 %181 
					                                                      OpStore %139 %182 
					                                         f32 %183 = OpLoad %139 
					                                       f32_3 %184 = OpCompositeConstruct %183 %183 %183 
					                                       f32_4 %185 = OpLoad %60 
					                                       f32_3 %186 = OpVectorShuffle %185 %185 0 1 2 
					                                       f32_3 %187 = OpFMul %184 %186 
					                                       f32_4 %188 = OpLoad %60 
					                                       f32_4 %189 = OpVectorShuffle %188 %187 4 5 6 3 
					                                                      OpStore %60 %189 
					                                       f32_4 %190 = OpLoad %60 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                       f32_4 %192 = OpLoad %36 
					                                       f32_3 %193 = OpVectorShuffle %192 %192 0 1 2 
					                                         f32 %194 = OpDot %191 %193 
					                                                      OpStore %139 %194 
					                              Uniform f32_4* %195 = OpAccessChain %24 %40 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_2 %197 = OpVectorShuffle %196 %196 1 1 
					                              Uniform f32_4* %199 = OpAccessChain %24 %198 %40 
					                                       f32_4 %200 = OpLoad %199 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 0 1 
					                                       f32_2 %202 = OpFMul %197 %201 
					                                       f32_4 %203 = OpLoad %36 
					                                       f32_4 %204 = OpVectorShuffle %203 %202 4 5 2 3 
					                                                      OpStore %36 %204 
					                              Uniform f32_4* %205 = OpAccessChain %24 %198 %45 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_2 %207 = OpVectorShuffle %206 %206 0 1 
					                              Uniform f32_4* %208 = OpAccessChain %24 %40 
					                                       f32_4 %209 = OpLoad %208 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 0 
					                                       f32_2 %211 = OpFMul %207 %210 
					                                       f32_4 %212 = OpLoad %36 
					                                       f32_2 %213 = OpVectorShuffle %212 %212 0 1 
					                                       f32_2 %214 = OpFAdd %211 %213 
					                                       f32_4 %215 = OpLoad %36 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 2 3 
					                                                      OpStore %36 %216 
					                                       f32_4 %217 = OpLoad %36 
					                                       f32_2 %218 = OpVectorShuffle %217 %217 0 1 
					                                       f32_2 %219 = OpExtInst %1 4 %218 
					                                Uniform f32* %221 = OpAccessChain %24 %220 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %224 = OpAccessChain %24 %223 
					                                         f32 %225 = OpLoad %224 
					                                       f32_2 %226 = OpCompositeConstruct %222 %225 
					                                       f32_2 %227 = OpFMul %219 %226 
					                                       f32_4 %228 = OpLoad %36 
					                                       f32_4 %229 = OpVectorShuffle %228 %227 4 5 2 3 
					                                                      OpStore %36 %229 
					                                       f32_4 %230 = OpLoad %60 
					                                       f32_2 %231 = OpVectorShuffle %230 %230 3 3 
					                                       f32_4 %232 = OpLoad %36 
					                                       f32_2 %233 = OpVectorShuffle %232 %232 0 1 
					                                       f32_2 %234 = OpFDiv %231 %233 
					                                       f32_4 %235 = OpLoad %36 
					                                       f32_4 %236 = OpVectorShuffle %235 %234 4 5 2 3 
					                                                      OpStore %36 %236 
					                                       f32_4 %238 = OpLoad %36 
					                                       f32_2 %239 = OpVectorShuffle %238 %238 0 1 
					                                       f32_4 %240 = OpLoad %36 
					                                       f32_2 %241 = OpVectorShuffle %240 %240 0 1 
					                                         f32 %242 = OpDot %239 %241 
					                                                      OpStore %237 %242 
					                                Uniform f32* %244 = OpAccessChain %24 %243 
					                                         f32 %245 = OpLoad %244 
					                                Uniform f32* %247 = OpAccessChain %24 %246 
					                                         f32 %248 = OpLoad %247 
					                                       f32_2 %249 = OpCompositeConstruct %245 %248 
					                                       f32_2 %252 = OpFMul %249 %251 
					                                       f32_4 %253 = OpLoad %36 
					                                       f32_2 %254 = OpVectorShuffle %253 %253 0 1 
					                                       f32_2 %255 = OpFAdd %252 %254 
					                                       f32_4 %256 = OpLoad %36 
					                                       f32_4 %257 = OpVectorShuffle %256 %255 4 5 2 3 
					                                                      OpStore %36 %257 
					                                       f32_4 %258 = OpLoad %36 
					                                       f32_2 %259 = OpVectorShuffle %258 %258 0 1 
					                                       f32_2 %260 = OpFDiv %251 %259 
					                                       f32_4 %261 = OpLoad %36 
					                                       f32_4 %262 = OpVectorShuffle %261 %260 0 1 4 5 
					                                                      OpStore %36 %262 
					                                         f32 %263 = OpLoad %237 
					                                         f32 %264 = OpExtInst %1 32 %263 
					                                                      OpStore %237 %264 
					                                  Input f32* %268 = OpAccessChain %266 %114 
					                                         f32 %269 = OpLoad %268 
					                                         f32 %270 = OpExtInst %1 4 %269 
					                                Uniform f32* %272 = OpAccessChain %24 %271 
					                                         f32 %273 = OpLoad %272 
					                                         f32 %274 = OpFMul %270 %273 
					                                Private f32* %275 = OpAccessChain %60 %161 
					                                                      OpStore %275 %274 
					                                Uniform f32* %278 = OpAccessChain %24 %277 
					                                         f32 %279 = OpLoad %278 
					                                         f32 %281 = OpFAdd %279 %280 
					                                                      OpStore %276 %281 
					                                         f32 %282 = OpLoad %276 
					                                Private f32* %283 = OpAccessChain %60 %161 
					                                         f32 %284 = OpLoad %283 
					                                         f32 %285 = OpFMul %282 %284 
					                                Private f32* %286 = OpAccessChain %60 %161 
					                                                      OpStore %286 %285 
					                                         f32 %287 = OpLoad %237 
					                                Private f32* %288 = OpAccessChain %60 %161 
					                                         f32 %289 = OpLoad %288 
					                                         f32 %290 = OpFMul %287 %289 
					                                                      OpStore %276 %290 
					                                Uniform f32* %293 = OpAccessChain %24 %292 
					                                         f32 %294 = OpLoad %293 
					                                         f32 %295 = OpFNegate %294 
					                                         f32 %296 = OpFAdd %295 %280 
					                                                      OpStore %291 %296 
					                                         f32 %297 = OpLoad %291 
					                                         f32 %298 = OpLoad %276 
					                                         f32 %299 = OpExtInst %1 4 %298 
					                                         f32 %300 = OpFMul %297 %299 
					                                                      OpStore %291 %300 
					                                         f32 %301 = OpLoad %237 
					                                Private f32* %302 = OpAccessChain %60 %161 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                         f32 %305 = OpLoad %291 
					                                         f32 %306 = OpFNegate %305 
					                                         f32 %307 = OpFAdd %304 %306 
					                                                      OpStore %237 %307 
					                                         f32 %308 = OpLoad %139 
					                                         f32 %309 = OpExtInst %1 4 %308 
					                                         f32 %310 = OpLoad %237 
					                                         f32 %311 = OpFMul %309 %310 
					                                         f32 %312 = OpLoad %291 
					                                         f32 %313 = OpFAdd %311 %312 
					                                                      OpStore %139 %313 
					                                Uniform f32* %318 = OpAccessChain %24 %198 %62 %317 
					                                         f32 %319 = OpLoad %318 
					                                        bool %321 = OpFOrdEqual %319 %320 
					                                                      OpStore %316 %321 
					                                        bool %322 = OpLoad %316 
					                                         f32 %323 = OpLoad %139 
					                                         f32 %324 = OpLoad %276 
					                                         f32 %325 = OpSelect %322 %323 %324 
					                                                      OpStore %139 %325 
					                                Uniform f32* %327 = OpAccessChain %24 %326 
					                                         f32 %328 = OpLoad %327 
					                                Uniform f32* %330 = OpAccessChain %24 %329 
					                                         f32 %331 = OpLoad %330 
					                                         f32 %332 = OpFMul %328 %331 
					                                                      OpStore %237 %332 
					                                         f32 %333 = OpLoad %237 
					                                         f32 %334 = OpLoad %139 
					                                         f32 %335 = OpFMul %333 %334 
					                                         f32 %336 = OpFAdd %335 %280 
					                                                      OpStore %237 %336 
					                                         f32 %337 = OpLoad %139 
					                                         f32 %338 = OpLoad %237 
					                                         f32 %339 = OpFDiv %337 %338 
					                                Private f32* %340 = OpAccessChain %60 %161 
					                                                      OpStore %340 %339 
					                                Uniform f32* %342 = OpAccessChain %24 %341 
					                                         f32 %343 = OpLoad %342 
					                                Uniform f32* %344 = OpAccessChain %24 %329 
					                                         f32 %345 = OpLoad %344 
					                                         f32 %346 = OpFMul %343 %345 
					                                                      OpStore %139 %346 
					                                Private f32* %347 = OpAccessChain %60 %161 
					                                         f32 %348 = OpLoad %347 
					                                         f32 %349 = OpLoad %139 
					                                         f32 %350 = OpFMul %348 %349 
					                                                      OpStore %139 %350 
					                                         f32 %351 = OpLoad %139 
					                                         f32 %352 = OpExtInst %1 37 %351 %280 
					                                                      OpStore %237 %352 
					                                         f32 %353 = OpLoad %237 
					                                         f32 %354 = OpExtInst %1 31 %353 
					                                                      OpStore %237 %354 
					                                  Input f32* %356 = OpAccessChain %123 %317 
					                                         f32 %357 = OpLoad %356 
					                                Uniform f32* %359 = OpAccessChain %24 %358 %317 
					                                         f32 %360 = OpLoad %359 
					                                         f32 %361 = OpFMul %357 %360 
					                                Private f32* %362 = OpAccessChain %355 %161 
					                                                      OpStore %362 %361 
					                              Uniform f32_4* %363 = OpAccessChain %24 %358 
					                                       f32_4 %364 = OpLoad %363 
					                                       f32_3 %365 = OpVectorShuffle %364 %364 0 1 2 
					                                       f32_4 %366 = OpLoad %355 
					                                       f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
					                                       f32_3 %368 = OpFMul %365 %367 
					                                       f32_4 %369 = OpLoad %122 
					                                       f32_3 %370 = OpVectorShuffle %369 %369 0 1 2 
					                                       f32_3 %371 = OpFNegate %370 
					                                       f32_3 %372 = OpFAdd %368 %371 
					                                       f32_4 %373 = OpLoad %355 
					                                       f32_4 %374 = OpVectorShuffle %373 %372 4 5 6 3 
					                                                      OpStore %355 %374 
					                                Uniform f32* %375 = OpAccessChain %24 %358 %317 
					                                         f32 %376 = OpLoad %375 
					                                  Input f32* %377 = OpAccessChain %123 %317 
					                                         f32 %378 = OpLoad %377 
					                                         f32 %379 = OpFMul %376 %378 
					                                Private f32* %380 = OpAccessChain %122 %317 
					                                         f32 %381 = OpLoad %380 
					                                         f32 %382 = OpFNegate %381 
					                                         f32 %383 = OpFAdd %379 %382 
					                                Private f32* %384 = OpAccessChain %355 %317 
					                                                      OpStore %384 %383 
					                                         f32 %385 = OpLoad %237 
					                                       f32_4 %386 = OpCompositeConstruct %385 %385 %385 %385 
					                                       f32_4 %387 = OpLoad %355 
					                                       f32_4 %388 = OpFMul %386 %387 
					                                       f32_4 %389 = OpLoad %122 
					                                       f32_4 %390 = OpFAdd %388 %389 
					                                                      OpStore %86 %390 
					                                       f32_4 %392 = OpLoad %86 
					                                                      OpStore %391 %392 
					                              Uniform f32_4* %394 = OpAccessChain %24 %393 
					                                       f32_4 %395 = OpLoad %394 
					                                       f32_4 %398 = OpExtInst %1 40 %395 %397 
					                                                      OpStore %86 %398 
					                                       f32_4 %399 = OpLoad %86 
					                                       f32_4 %402 = OpExtInst %1 37 %399 %401 
					                                                      OpStore %86 %402 
					                                       f32_2 %403 = OpLoad %9 
					                                       f32_4 %404 = OpLoad %86 
					                                       f32_2 %405 = OpVectorShuffle %404 %404 0 1 
					                                       f32_2 %406 = OpFNegate %405 
					                                       f32_2 %407 = OpFAdd %403 %406 
					                                       f32_4 %408 = OpLoad %355 
					                                       f32_4 %409 = OpVectorShuffle %408 %407 4 5 2 3 
					                                                      OpStore %355 %409 
					                                       f32_2 %410 = OpLoad %9 
					                                       f32_2 %413 = OpFMul %410 %412 
					                                       f32_4 %414 = OpLoad %86 
					                                       f32_2 %415 = OpVectorShuffle %414 %414 0 1 
					                                       f32_2 %416 = OpFNegate %415 
					                                       f32_2 %417 = OpFAdd %413 %416 
					                                                      OpStore %9 %417 
					                                       f32_4 %418 = OpLoad %86 
					                                       f32_2 %419 = OpVectorShuffle %418 %418 2 3 
					                                       f32_2 %420 = OpFNegate %419 
					                                       f32_2 %421 = OpLoad %9 
					                                       f32_2 %422 = OpFAdd %420 %421 
					                                       f32_4 %423 = OpLoad %36 
					                                       f32_4 %424 = OpVectorShuffle %423 %422 4 5 2 3 
					                                                      OpStore %36 %424 
					                                       f32_4 %425 = OpLoad %86 
					                                       f32_2 %426 = OpVectorShuffle %425 %425 0 1 
					                                       f32_2 %427 = OpFNegate %426 
					                                       f32_4 %428 = OpLoad %86 
					                                       f32_2 %429 = OpVectorShuffle %428 %428 2 3 
					                                       f32_2 %430 = OpFAdd %427 %429 
					                                                      OpStore %9 %430 
					                                       f32_4 %432 = OpLoad %355 
					                                       f32_2 %433 = OpVectorShuffle %432 %432 0 1 
					                                       f32_2 %434 = OpLoad %9 
					                                       f32_2 %435 = OpFDiv %433 %434 
					                                       f32_4 %436 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %437 = OpVectorShuffle %436 %435 0 1 4 5 
					                                                      OpStore vs_TEXCOORD0 %437 
					                                       f32_4 %439 = OpLoad %36 
					                                                      OpStore vs_TEXCOORD2 %439 
					                                       f32_2 %441 = OpLoad %440 
					                                       f32_4 %442 = OpLoad vs_TEXCOORD0 
					                                       f32_4 %443 = OpVectorShuffle %442 %441 4 5 2 3 
					                                                      OpStore vs_TEXCOORD0 %443 
					                                  Input f32* %445 = OpAccessChain %266 %114 
					                                         f32 %446 = OpLoad %445 
					                                        bool %447 = OpFOrdGreaterThanEqual %320 %446 
					                                                      OpStore %444 %447 
					                                        bool %448 = OpLoad %444 
					                                         f32 %449 = OpSelect %448 %280 %320 
					                                Private f32* %450 = OpAccessChain %9 %161 
					                                                      OpStore %450 %449 
					                                Uniform f32* %453 = OpAccessChain %24 %452 
					                                         f32 %454 = OpLoad %453 
					                                         f32 %455 = OpFNegate %454 
					                                Uniform f32* %457 = OpAccessChain %24 %456 
					                                         f32 %458 = OpLoad %457 
					                                         f32 %459 = OpFAdd %455 %458 
					                                                      OpStore %451 %459 
					                                Private f32* %460 = OpAccessChain %9 %161 
					                                         f32 %461 = OpLoad %460 
					                                         f32 %462 = OpLoad %451 
					                                         f32 %463 = OpFMul %461 %462 
					                                Uniform f32* %464 = OpAccessChain %24 %452 
					                                         f32 %465 = OpLoad %464 
					                                         f32 %466 = OpFAdd %463 %465 
					                                Private f32* %467 = OpAccessChain %9 %161 
					                                                      OpStore %467 %466 
					                                Private f32* %468 = OpAccessChain %9 %161 
					                                         f32 %469 = OpLoad %468 
					                                         f32 %470 = OpFMul %469 %250 
					                                Uniform f32* %472 = OpAccessChain %24 %471 
					                                         f32 %473 = OpLoad %472 
					                                         f32 %474 = OpFAdd %470 %473 
					                                Private f32* %475 = OpAccessChain %9 %161 
					                                                      OpStore %475 %474 
					                                Private f32* %476 = OpAccessChain %9 %161 
					                                         f32 %477 = OpLoad %476 
					                                Uniform f32* %478 = OpAccessChain %24 %329 
					                                         f32 %479 = OpLoad %478 
					                                         f32 %480 = OpFMul %477 %479 
					                                Private f32* %481 = OpAccessChain %9 %161 
					                                                      OpStore %481 %480 
					                                Private f32* %482 = OpAccessChain %9 %161 
					                                         f32 %483 = OpLoad %482 
					                                         f32 %484 = OpFNegate %483 
					                                         f32 %486 = OpFMul %484 %485 
					                                         f32 %487 = OpFAdd %486 %485 
					                                Private f32* %488 = OpAccessChain %9 %161 
					                                                      OpStore %488 %487 
					                                Private f32* %489 = OpAccessChain %9 %161 
					                                         f32 %490 = OpLoad %489 
					                                Private f32* %491 = OpAccessChain %60 %161 
					                                         f32 %492 = OpLoad %491 
					                                         f32 %493 = OpFMul %490 %492 
					                                         f32 %495 = OpFAdd %493 %494 
					                                Private f32* %496 = OpAccessChain %60 %317 
					                                                      OpStore %496 %495 
					                                         f32 %497 = OpLoad %139 
					                                         f32 %498 = OpFNegate %497 
					                                         f32 %499 = OpFMul %498 %485 
					                                Private f32* %500 = OpAccessChain %60 %317 
					                                         f32 %501 = OpLoad %500 
					                                         f32 %502 = OpFAdd %499 %501 
					                                Private f32* %503 = OpAccessChain %60 %114 
					                                                      OpStore %503 %502 
					                                         f32 %504 = OpLoad %139 
					                                         f32 %505 = OpFMul %504 %485 
					                                Private f32* %506 = OpAccessChain %60 %317 
					                                         f32 %507 = OpLoad %506 
					                                         f32 %508 = OpFAdd %505 %507 
					                                Private f32* %509 = OpAccessChain %60 %174 
					                                                      OpStore %509 %508 
					                                       f32_4 %511 = OpLoad %60 
					                                                      OpStore vs_TEXCOORD1 %511 
					                                 Output f32* %513 = OpAccessChain %118 %45 %114 
					                                         f32 %514 = OpLoad %513 
					                                         f32 %515 = OpFNegate %514 
					                                 Output f32* %516 = OpAccessChain %118 %45 %114 
					                                                      OpStore %516 %515 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 118
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %64 %72 %87 %101 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 DescriptorSet 56 
					                                             OpDecorate %56 Binding 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %60 RelaxedPrecision 
					                                             OpDecorate %60 DescriptorSet 60 
					                                             OpDecorate %60 Binding 60 
					                                             OpDecorate %61 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 64 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %98 RelaxedPrecision 
					                                             OpDecorate %99 RelaxedPrecision 
					                                             OpDecorate %101 RelaxedPrecision 
					                                             OpDecorate %101 Location 101 
					                                             OpDecorate %102 RelaxedPrecision 
					                                             OpDecorate %106 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 2 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_2* %9 = OpVariable Private 
					                                     %10 = OpTypeVector %6 4 
					                                     %11 = OpTypeStruct %10 
					                                     %12 = OpTypePointer Uniform %11 
					            Uniform struct {f32_4;}* %13 = OpVariable Uniform 
					                                     %14 = OpTypeInt 32 1 
					                                 i32 %15 = OpConstant 0 
					                                     %16 = OpTypePointer Uniform %10 
					                                     %26 = OpTypePointer Input %10 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %38 = OpConstant 3.674022E-40 
					                                 f32 %39 = OpConstant 3.674022E-40 
					                                     %43 = OpTypePointer Private %6 
					                        Private f32* %44 = OpVariable Private 
					                                     %45 = OpTypeInt 32 0 
					                                 u32 %46 = OpConstant 1 
					                                 u32 %49 = OpConstant 0 
					                        Private f32* %53 = OpVariable Private 
					                                     %54 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %55 = OpTypePointer UniformConstant %54 
					UniformConstant read_only Texture2D* %56 = OpVariable UniformConstant 
					                                     %58 = OpTypeSampler 
					                                     %59 = OpTypePointer UniformConstant %58 
					            UniformConstant sampler* %60 = OpVariable UniformConstant 
					                                     %62 = OpTypeSampledImage %54 
					               Input f32_4* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                                     %83 = OpTypePointer Private %10 
					                      Private f32_4* %84 = OpVariable Private 
					                        Input f32_4* %87 = OpVariable Input 
					                                 f32 %94 = OpConstant 3.674022E-40 
					                                    %100 = OpTypePointer Output %10 
					                      Output f32_4* %101 = OpVariable Output 
					                                    %103 = OpTypeBool 
					                                    %104 = OpTypePointer Private %103 
					                      Private bool* %105 = OpVariable Private 
					                                i32 %109 = OpConstant 1 
					                                i32 %111 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                      Uniform f32_4* %17 = OpAccessChain %13 %15 
					                               f32_4 %18 = OpLoad %17 
					                               f32_2 %19 = OpVectorShuffle %18 %18 0 1 
					                               f32_2 %20 = OpFNegate %19 
					                      Uniform f32_4* %21 = OpAccessChain %13 %15 
					                               f32_4 %22 = OpLoad %21 
					                               f32_2 %23 = OpVectorShuffle %22 %22 2 3 
					                               f32_2 %24 = OpFAdd %20 %23 
					                                             OpStore %9 %24 
					                               f32_2 %25 = OpLoad %9 
					                               f32_4 %28 = OpLoad vs_TEXCOORD2 
					                               f32_2 %29 = OpVectorShuffle %28 %28 0 1 
					                               f32_2 %30 = OpExtInst %1 4 %29 
					                               f32_2 %31 = OpFNegate %30 
					                               f32_2 %32 = OpFAdd %25 %31 
					                                             OpStore %9 %32 
					                               f32_2 %33 = OpLoad %9 
					                               f32_4 %34 = OpLoad vs_TEXCOORD2 
					                               f32_2 %35 = OpVectorShuffle %34 %34 2 3 
					                               f32_2 %36 = OpFMul %33 %35 
					                                             OpStore %9 %36 
					                               f32_2 %37 = OpLoad %9 
					                               f32_2 %40 = OpCompositeConstruct %38 %38 
					                               f32_2 %41 = OpCompositeConstruct %39 %39 
					                               f32_2 %42 = OpExtInst %1 43 %37 %40 %41 
					                                             OpStore %9 %42 
					                        Private f32* %47 = OpAccessChain %9 %46 
					                                 f32 %48 = OpLoad %47 
					                        Private f32* %50 = OpAccessChain %9 %49 
					                                 f32 %51 = OpLoad %50 
					                                 f32 %52 = OpFMul %48 %51 
					                                             OpStore %44 %52 
					                 read_only Texture2D %57 = OpLoad %56 
					                             sampler %61 = OpLoad %60 
					          read_only Texture2DSampled %63 = OpSampledImage %57 %61 
					                               f32_4 %65 = OpLoad vs_TEXCOORD0 
					                               f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain vs_TEXCOORD1 %49 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                          Input f32* %77 = OpAccessChain vs_TEXCOORD1 %68 
					                                 f32 %78 = OpLoad %77 
					                                 f32 %79 = OpFNegate %78 
					                                 f32 %80 = OpFAdd %76 %79 
					                                             OpStore %70 %80 
					                                 f32 %81 = OpLoad %70 
					                                 f32 %82 = OpExtInst %1 43 %81 %38 %39 
					                                             OpStore %70 %82 
					                                 f32 %85 = OpLoad %70 
					                               f32_4 %86 = OpCompositeConstruct %85 %85 %85 %85 
					                               f32_4 %88 = OpLoad %87 
					                               f32_4 %89 = OpFMul %86 %88 
					                                             OpStore %84 %89 
					                        Private f32* %90 = OpAccessChain %84 %68 
					                                 f32 %91 = OpLoad %90 
					                                 f32 %92 = OpLoad %44 
					                                 f32 %93 = OpFMul %91 %92 
					                                 f32 %95 = OpFAdd %93 %94 
					                                             OpStore %70 %95 
					                                 f32 %96 = OpLoad %44 
					                               f32_4 %97 = OpCompositeConstruct %96 %96 %96 %96 
					                               f32_4 %98 = OpLoad %84 
					                               f32_4 %99 = OpFMul %97 %98 
					                                             OpStore %84 %99 
					                              f32_4 %102 = OpLoad %84 
					                                             OpStore %101 %102 
					                                f32 %106 = OpLoad %70 
					                               bool %107 = OpFOrdLessThan %106 %38 
					                                             OpStore %105 %107 
					                               bool %108 = OpLoad %105 
					                                i32 %110 = OpSelect %108 %109 %15 
					                                i32 %112 = OpIMul %110 %111 
					                               bool %113 = OpINotEqual %112 %15 
					                                             OpSelectionMerge %115 None 
					                                             OpBranchConditional %113 %114 %115 
					                                    %114 = OpLabel 
					                                             OpKill
					                                    %115 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv"
				}
			}
		}
	}
	CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}