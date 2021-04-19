Shader "TextMeshPro/Bitmap Custom Atlas" {
	Properties {
		_MainTex ("Font Atlas", 2D) = "white" {}
		_FaceTex ("Font Texture", 2D) = "white" {}
		_FaceColor ("Text Color", Vector) = (1,1,1,1)
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_Padding ("Padding", Float) = 0
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask 0 -1
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
			GpuProgramID 32766
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 47
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %44 Location 44 
					                                             OpDecorate %45 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Output %7 
					                       Output f32_4* %44 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                               f32_4 %45 = OpLoad %34 
					                                             OpStore %44 %45 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 47
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %44 Location 44 
					                                             OpDecorate %45 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Output %7 
					                       Output f32_4* %44 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                               f32_4 %45 = OpLoad %34 
					                                             OpStore %44 %45 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 47
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %44 Location 44 
					                                             OpDecorate %45 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Output %7 
					                       Output f32_4* %44 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                               f32_4 %45 = OpLoad %34 
					                                             OpStore %44 %45 
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_2<0.0);
					#else
					    u_xlatb0 = u_xlat16_2<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_2<0.0);
					#else
					    u_xlatb0 = u_xlat16_2<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_2<0.0);
					#else
					    u_xlatb0 = u_xlat16_2<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 76
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %45 %56 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %45 Location 45 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %52 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 Location 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %61 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %38 = OpTypePointer Private %6 
					                        Private f32* %39 = OpVariable Private 
					                                     %40 = OpTypeInt 32 0 
					                                 u32 %41 = OpConstant 3 
					                                     %44 = OpTypePointer Input %7 
					                        Input f32_4* %45 = OpVariable Input 
					                                     %46 = OpTypePointer Input %6 
					                                 f32 %50 = OpConstant 3.674022E-40 
					                                     %55 = OpTypePointer Output %7 
					                       Output f32_4* %56 = OpVariable Output 
					                                     %58 = OpTypeBool 
					                                     %59 = OpTypePointer Private %58 
					                       Private bool* %60 = OpVariable Private 
					                                 f32 %62 = OpConstant 3.674022E-40 
					                                     %65 = OpTypeInt 32 1 
					                                 i32 %66 = OpConstant 0 
					                                 i32 %67 = OpConstant 1 
					                                 i32 %69 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                        Private f32* %42 = OpAccessChain %34 %41 
					                                 f32 %43 = OpLoad %42 
					                          Input f32* %47 = OpAccessChain %45 %41 
					                                 f32 %48 = OpLoad %47 
					                                 f32 %49 = OpFMul %43 %48 
					                                 f32 %51 = OpFAdd %49 %50 
					                                             OpStore %39 %51 
					                               f32_4 %52 = OpLoad %34 
					                               f32_4 %53 = OpLoad %45 
					                               f32_4 %54 = OpFMul %52 %53 
					                                             OpStore %34 %54 
					                               f32_4 %57 = OpLoad %34 
					                                             OpStore %56 %57 
					                                 f32 %61 = OpLoad %39 
					                                bool %63 = OpFOrdLessThan %61 %62 
					                                             OpStore %60 %63 
					                                bool %64 = OpLoad %60 
					                                 i32 %68 = OpSelect %64 %67 %66 
					                                 i32 %70 = OpIMul %68 %69 
					                                bool %71 = OpINotEqual %70 %66 
					                                             OpSelectionMerge %73 None 
					                                             OpBranchConditional %71 %72 %73 
					                                     %72 = OpLabel 
					                                             OpKill
					                                     %73 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 76
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %45 %56 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %45 Location 45 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %52 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 Location 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %61 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %38 = OpTypePointer Private %6 
					                        Private f32* %39 = OpVariable Private 
					                                     %40 = OpTypeInt 32 0 
					                                 u32 %41 = OpConstant 3 
					                                     %44 = OpTypePointer Input %7 
					                        Input f32_4* %45 = OpVariable Input 
					                                     %46 = OpTypePointer Input %6 
					                                 f32 %50 = OpConstant 3.674022E-40 
					                                     %55 = OpTypePointer Output %7 
					                       Output f32_4* %56 = OpVariable Output 
					                                     %58 = OpTypeBool 
					                                     %59 = OpTypePointer Private %58 
					                       Private bool* %60 = OpVariable Private 
					                                 f32 %62 = OpConstant 3.674022E-40 
					                                     %65 = OpTypeInt 32 1 
					                                 i32 %66 = OpConstant 0 
					                                 i32 %67 = OpConstant 1 
					                                 i32 %69 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                        Private f32* %42 = OpAccessChain %34 %41 
					                                 f32 %43 = OpLoad %42 
					                          Input f32* %47 = OpAccessChain %45 %41 
					                                 f32 %48 = OpLoad %47 
					                                 f32 %49 = OpFMul %43 %48 
					                                 f32 %51 = OpFAdd %49 %50 
					                                             OpStore %39 %51 
					                               f32_4 %52 = OpLoad %34 
					                               f32_4 %53 = OpLoad %45 
					                               f32_4 %54 = OpFMul %52 %53 
					                                             OpStore %34 %54 
					                               f32_4 %57 = OpLoad %34 
					                                             OpStore %56 %57 
					                                 f32 %61 = OpLoad %39 
					                                bool %63 = OpFOrdLessThan %61 %62 
					                                             OpStore %60 %63 
					                                bool %64 = OpLoad %60 
					                                 i32 %68 = OpSelect %64 %67 %66 
					                                 i32 %70 = OpIMul %68 %69 
					                                bool %71 = OpINotEqual %70 %66 
					                                             OpSelectionMerge %73 None 
					                                             OpBranchConditional %71 %72 %73 
					                                     %72 = OpLabel 
					                                             OpKill
					                                     %73 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 76
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %45 %56 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %45 Location 45 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %52 RelaxedPrecision 
					                                             OpDecorate %53 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %56 RelaxedPrecision 
					                                             OpDecorate %56 Location 56 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %61 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %38 = OpTypePointer Private %6 
					                        Private f32* %39 = OpVariable Private 
					                                     %40 = OpTypeInt 32 0 
					                                 u32 %41 = OpConstant 3 
					                                     %44 = OpTypePointer Input %7 
					                        Input f32_4* %45 = OpVariable Input 
					                                     %46 = OpTypePointer Input %6 
					                                 f32 %50 = OpConstant 3.674022E-40 
					                                     %55 = OpTypePointer Output %7 
					                       Output f32_4* %56 = OpVariable Output 
					                                     %58 = OpTypeBool 
					                                     %59 = OpTypePointer Private %58 
					                       Private bool* %60 = OpVariable Private 
					                                 f32 %62 = OpConstant 3.674022E-40 
					                                     %65 = OpTypeInt 32 1 
					                                 i32 %66 = OpConstant 0 
					                                 i32 %67 = OpConstant 1 
					                                 i32 %69 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                        Private f32* %42 = OpAccessChain %34 %41 
					                                 f32 %43 = OpLoad %42 
					                          Input f32* %47 = OpAccessChain %45 %41 
					                                 f32 %48 = OpLoad %47 
					                                 f32 %49 = OpFMul %43 %48 
					                                 f32 %51 = OpFAdd %49 %50 
					                                             OpStore %39 %51 
					                               f32_4 %52 = OpLoad %34 
					                               f32_4 %53 = OpLoad %45 
					                               f32_4 %54 = OpFMul %52 %53 
					                                             OpStore %34 %54 
					                               f32_4 %57 = OpLoad %34 
					                                             OpStore %56 %57 
					                                 f32 %61 = OpLoad %39 
					                                bool %63 = OpFOrdLessThan %61 %62 
					                                             OpStore %60 %63 
					                                bool %64 = OpLoad %60 
					                                 i32 %68 = OpSelect %64 %67 %66 
					                                 i32 %70 = OpIMul %68 %69 
					                                bool %71 = OpINotEqual %70 %66 
					                                             OpSelectionMerge %73 None 
					                                             OpBranchConditional %71 %72 %73 
					                                     %72 = OpLabel 
					                                             OpKill
					                                     %73 = OpLabel 
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec2 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    SV_Target0 = u_xlat16_0 * vec4(u_xlat16_2);
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec2 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    SV_Target0 = u_xlat16_0 * vec4(u_xlat16_2);
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec2 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    SV_Target0 = u_xlat16_0 * vec4(u_xlat16_2);
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
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 93
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %60 %87 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpMemberDecorate %45 0 Offset 45 
					                                             OpDecorate %45 Block 
					                                             OpDecorate %47 DescriptorSet 47 
					                                             OpDecorate %47 Binding 47 
					                                             OpDecorate vs_TEXCOORD2 Location 60 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %90 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Private %20 
					                      Private f32_2* %44 = OpVariable Private 
					                                     %45 = OpTypeStruct %7 
					                                     %46 = OpTypePointer Uniform %45 
					            Uniform struct {f32_4;}* %47 = OpVariable Uniform 
					                                     %48 = OpTypeInt 32 1 
					                                 i32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Uniform %7 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %71 = OpConstant 3.674022E-40 
					                                 f32 %72 = OpConstant 3.674022E-40 
					                                     %76 = OpTypePointer Private %6 
					                        Private f32* %77 = OpVariable Private 
					                                     %78 = OpTypeInt 32 0 
					                                 u32 %79 = OpConstant 1 
					                                 u32 %82 = OpConstant 0 
					                                     %86 = OpTypePointer Output %7 
					                       Output f32_4* %87 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                      Uniform f32_4* %51 = OpAccessChain %47 %49 
					                               f32_4 %52 = OpLoad %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpFNegate %53 
					                      Uniform f32_4* %55 = OpAccessChain %47 %49 
					                               f32_4 %56 = OpLoad %55 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_2 %58 = OpFAdd %54 %57 
					                                             OpStore %44 %58 
					                               f32_2 %59 = OpLoad %44 
					                               f32_4 %61 = OpLoad vs_TEXCOORD2 
					                               f32_2 %62 = OpVectorShuffle %61 %61 0 1 
					                               f32_2 %63 = OpExtInst %1 4 %62 
					                               f32_2 %64 = OpFNegate %63 
					                               f32_2 %65 = OpFAdd %59 %64 
					                                             OpStore %44 %65 
					                               f32_2 %66 = OpLoad %44 
					                               f32_4 %67 = OpLoad vs_TEXCOORD2 
					                               f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                               f32_2 %69 = OpFMul %66 %68 
					                                             OpStore %44 %69 
					                               f32_2 %70 = OpLoad %44 
					                               f32_2 %73 = OpCompositeConstruct %71 %71 
					                               f32_2 %74 = OpCompositeConstruct %72 %72 
					                               f32_2 %75 = OpExtInst %1 43 %70 %73 %74 
					                                             OpStore %44 %75 
					                        Private f32* %80 = OpAccessChain %44 %79 
					                                 f32 %81 = OpLoad %80 
					                        Private f32* %83 = OpAccessChain %44 %82 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %85 = OpFMul %81 %84 
					                                             OpStore %77 %85 
					                               f32_4 %88 = OpLoad %34 
					                                 f32 %89 = OpLoad %77 
					                               f32_4 %90 = OpCompositeConstruct %89 %89 %89 %89 
					                               f32_4 %91 = OpFMul %88 %90 
					                                             OpStore %87 %91 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 93
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %60 %87 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpMemberDecorate %45 0 Offset 45 
					                                             OpDecorate %45 Block 
					                                             OpDecorate %47 DescriptorSet 47 
					                                             OpDecorate %47 Binding 47 
					                                             OpDecorate vs_TEXCOORD2 Location 60 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %90 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Private %20 
					                      Private f32_2* %44 = OpVariable Private 
					                                     %45 = OpTypeStruct %7 
					                                     %46 = OpTypePointer Uniform %45 
					            Uniform struct {f32_4;}* %47 = OpVariable Uniform 
					                                     %48 = OpTypeInt 32 1 
					                                 i32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Uniform %7 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %71 = OpConstant 3.674022E-40 
					                                 f32 %72 = OpConstant 3.674022E-40 
					                                     %76 = OpTypePointer Private %6 
					                        Private f32* %77 = OpVariable Private 
					                                     %78 = OpTypeInt 32 0 
					                                 u32 %79 = OpConstant 1 
					                                 u32 %82 = OpConstant 0 
					                                     %86 = OpTypePointer Output %7 
					                       Output f32_4* %87 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                      Uniform f32_4* %51 = OpAccessChain %47 %49 
					                               f32_4 %52 = OpLoad %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpFNegate %53 
					                      Uniform f32_4* %55 = OpAccessChain %47 %49 
					                               f32_4 %56 = OpLoad %55 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_2 %58 = OpFAdd %54 %57 
					                                             OpStore %44 %58 
					                               f32_2 %59 = OpLoad %44 
					                               f32_4 %61 = OpLoad vs_TEXCOORD2 
					                               f32_2 %62 = OpVectorShuffle %61 %61 0 1 
					                               f32_2 %63 = OpExtInst %1 4 %62 
					                               f32_2 %64 = OpFNegate %63 
					                               f32_2 %65 = OpFAdd %59 %64 
					                                             OpStore %44 %65 
					                               f32_2 %66 = OpLoad %44 
					                               f32_4 %67 = OpLoad vs_TEXCOORD2 
					                               f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                               f32_2 %69 = OpFMul %66 %68 
					                                             OpStore %44 %69 
					                               f32_2 %70 = OpLoad %44 
					                               f32_2 %73 = OpCompositeConstruct %71 %71 
					                               f32_2 %74 = OpCompositeConstruct %72 %72 
					                               f32_2 %75 = OpExtInst %1 43 %70 %73 %74 
					                                             OpStore %44 %75 
					                        Private f32* %80 = OpAccessChain %44 %79 
					                                 f32 %81 = OpLoad %80 
					                        Private f32* %83 = OpAccessChain %44 %82 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %85 = OpFMul %81 %84 
					                                             OpStore %77 %85 
					                               f32_4 %88 = OpLoad %34 
					                                 f32 %89 = OpLoad %77 
					                               f32_4 %90 = OpCompositeConstruct %89 %89 %89 %89 
					                               f32_4 %91 = OpFMul %88 %90 
					                                             OpStore %87 %91 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 93
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %60 %87 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpMemberDecorate %45 0 Offset 45 
					                                             OpDecorate %45 Block 
					                                             OpDecorate %47 DescriptorSet 47 
					                                             OpDecorate %47 Binding 47 
					                                             OpDecorate vs_TEXCOORD2 Location 60 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 Location 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %90 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Private %20 
					                      Private f32_2* %44 = OpVariable Private 
					                                     %45 = OpTypeStruct %7 
					                                     %46 = OpTypePointer Uniform %45 
					            Uniform struct {f32_4;}* %47 = OpVariable Uniform 
					                                     %48 = OpTypeInt 32 1 
					                                 i32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Uniform %7 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %71 = OpConstant 3.674022E-40 
					                                 f32 %72 = OpConstant 3.674022E-40 
					                                     %76 = OpTypePointer Private %6 
					                        Private f32* %77 = OpVariable Private 
					                                     %78 = OpTypeInt 32 0 
					                                 u32 %79 = OpConstant 1 
					                                 u32 %82 = OpConstant 0 
					                                     %86 = OpTypePointer Output %7 
					                       Output f32_4* %87 = OpVariable Output 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                      Uniform f32_4* %51 = OpAccessChain %47 %49 
					                               f32_4 %52 = OpLoad %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpFNegate %53 
					                      Uniform f32_4* %55 = OpAccessChain %47 %49 
					                               f32_4 %56 = OpLoad %55 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_2 %58 = OpFAdd %54 %57 
					                                             OpStore %44 %58 
					                               f32_2 %59 = OpLoad %44 
					                               f32_4 %61 = OpLoad vs_TEXCOORD2 
					                               f32_2 %62 = OpVectorShuffle %61 %61 0 1 
					                               f32_2 %63 = OpExtInst %1 4 %62 
					                               f32_2 %64 = OpFNegate %63 
					                               f32_2 %65 = OpFAdd %59 %64 
					                                             OpStore %44 %65 
					                               f32_2 %66 = OpLoad %44 
					                               f32_4 %67 = OpLoad vs_TEXCOORD2 
					                               f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                               f32_2 %69 = OpFMul %66 %68 
					                                             OpStore %44 %69 
					                               f32_2 %70 = OpLoad %44 
					                               f32_2 %73 = OpCompositeConstruct %71 %71 
					                               f32_2 %74 = OpCompositeConstruct %72 %72 
					                               f32_2 %75 = OpExtInst %1 43 %70 %73 %74 
					                                             OpStore %44 %75 
					                        Private f32* %80 = OpAccessChain %44 %79 
					                                 f32 %81 = OpLoad %80 
					                        Private f32* %83 = OpAccessChain %44 %82 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %85 = OpFMul %81 %84 
					                                             OpStore %77 %85 
					                               f32_4 %88 = OpLoad %34 
					                                 f32 %89 = OpLoad %77 
					                               f32_4 %90 = OpCompositeConstruct %89 %89 %89 %89 
					                               f32_4 %91 = OpFMul %88 %90 
					                                             OpStore %87 %91 
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec2 u_xlat1;
					mediump vec4 u_xlat16_1;
					bool u_xlatb1;
					mediump float u_xlat16_2;
					mediump float u_xlat16_5;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    u_xlat16_5 = u_xlat16_0.w * u_xlat16_2 + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_2);
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat16_5<0.0);
					#else
					    u_xlatb1 = u_xlat16_5<0.0;
					#endif
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec2 u_xlat1;
					mediump vec4 u_xlat16_1;
					bool u_xlatb1;
					mediump float u_xlat16_2;
					mediump float u_xlat16_5;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    u_xlat16_5 = u_xlat16_0.w * u_xlat16_2 + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_2);
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat16_5<0.0);
					#else
					    u_xlatb1 = u_xlat16_5<0.0;
					#endif
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
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
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _FaceTex_ST;
					uniform 	mediump vec4 _FaceColor;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = in_POSITION0.w * 0.5;
					    u_xlat0.xy = u_xlat0.xx / _ScreenParams.xy;
					    u_xlat6.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.xy = roundEven(u_xlat6.xy);
					    u_xlat6.xy = u_xlat6.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat1.ww * u_xlat6.xy;
					    gl_Position.zw = u_xlat1.zw;
					    vs_COLOR0 = in_COLOR0 * _FaceColor;
					    u_xlat6.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat6.x = floor(u_xlat6.x);
					    u_xlat6.y = (-u_xlat6.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat6.xy = u_xlat6.xy * _FaceTex_ST.xy;
					    vs_TEXCOORD1.xy = u_xlat6.xy * vec2(0.001953125, 0.001953125) + _FaceTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat6.x = _ScreenParams.x * hlslcc_mtx4x4glstate_matrix_projection[0].x;
					    u_xlat6.y = _ScreenParams.y * hlslcc_mtx4x4glstate_matrix_projection[1].y;
					    u_xlat0.xy = u_xlat1.ww / abs(u_xlat6.xy);
					    u_xlat0.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat0.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
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
					UNITY_LOCATION(1) uniform mediump sampler2D _FaceTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					vec2 u_xlat1;
					mediump vec4 u_xlat16_1;
					bool u_xlatb1;
					mediump float u_xlat16_2;
					mediump float u_xlat16_5;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD1.xy);
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    u_xlat16_5 = u_xlat16_0.w * u_xlat16_2 + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_2);
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat16_5<0.0);
					#else
					    u_xlatb1 = u_xlat16_5<0.0;
					#endif
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
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
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 116
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %60 %99 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpMemberDecorate %45 0 Offset 45 
					                                             OpDecorate %45 Block 
					                                             OpDecorate %47 DescriptorSet 47 
					                                             OpDecorate %47 Binding 47 
					                                             OpDecorate vs_TEXCOORD2 Location 60 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %90 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %99 RelaxedPrecision 
					                                             OpDecorate %99 Location 99 
					                                             OpDecorate %100 RelaxedPrecision 
					                                             OpDecorate %104 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Private %20 
					                      Private f32_2* %44 = OpVariable Private 
					                                     %45 = OpTypeStruct %7 
					                                     %46 = OpTypePointer Uniform %45 
					            Uniform struct {f32_4;}* %47 = OpVariable Uniform 
					                                     %48 = OpTypeInt 32 1 
					                                 i32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Uniform %7 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %71 = OpConstant 3.674022E-40 
					                                 f32 %72 = OpConstant 3.674022E-40 
					                                     %76 = OpTypePointer Private %6 
					                        Private f32* %77 = OpVariable Private 
					                                     %78 = OpTypeInt 32 0 
					                                 u32 %79 = OpConstant 1 
					                                 u32 %82 = OpConstant 0 
					                        Private f32* %86 = OpVariable Private 
					                                 u32 %87 = OpConstant 3 
					                                 f32 %92 = OpConstant 3.674022E-40 
					                                     %98 = OpTypePointer Output %7 
					                       Output f32_4* %99 = OpVariable Output 
					                                    %101 = OpTypeBool 
					                                    %102 = OpTypePointer Private %101 
					                      Private bool* %103 = OpVariable Private 
					                                i32 %107 = OpConstant 1 
					                                i32 %109 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                      Uniform f32_4* %51 = OpAccessChain %47 %49 
					                               f32_4 %52 = OpLoad %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpFNegate %53 
					                      Uniform f32_4* %55 = OpAccessChain %47 %49 
					                               f32_4 %56 = OpLoad %55 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_2 %58 = OpFAdd %54 %57 
					                                             OpStore %44 %58 
					                               f32_2 %59 = OpLoad %44 
					                               f32_4 %61 = OpLoad vs_TEXCOORD2 
					                               f32_2 %62 = OpVectorShuffle %61 %61 0 1 
					                               f32_2 %63 = OpExtInst %1 4 %62 
					                               f32_2 %64 = OpFNegate %63 
					                               f32_2 %65 = OpFAdd %59 %64 
					                                             OpStore %44 %65 
					                               f32_2 %66 = OpLoad %44 
					                               f32_4 %67 = OpLoad vs_TEXCOORD2 
					                               f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                               f32_2 %69 = OpFMul %66 %68 
					                                             OpStore %44 %69 
					                               f32_2 %70 = OpLoad %44 
					                               f32_2 %73 = OpCompositeConstruct %71 %71 
					                               f32_2 %74 = OpCompositeConstruct %72 %72 
					                               f32_2 %75 = OpExtInst %1 43 %70 %73 %74 
					                                             OpStore %44 %75 
					                        Private f32* %80 = OpAccessChain %44 %79 
					                                 f32 %81 = OpLoad %80 
					                        Private f32* %83 = OpAccessChain %44 %82 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %85 = OpFMul %81 %84 
					                                             OpStore %77 %85 
					                        Private f32* %88 = OpAccessChain %34 %87 
					                                 f32 %89 = OpLoad %88 
					                                 f32 %90 = OpLoad %77 
					                                 f32 %91 = OpFMul %89 %90 
					                                 f32 %93 = OpFAdd %91 %92 
					                                             OpStore %86 %93 
					                               f32_4 %94 = OpLoad %34 
					                                 f32 %95 = OpLoad %77 
					                               f32_4 %96 = OpCompositeConstruct %95 %95 %95 %95 
					                               f32_4 %97 = OpFMul %94 %96 
					                                             OpStore %34 %97 
					                              f32_4 %100 = OpLoad %34 
					                                             OpStore %99 %100 
					                                f32 %104 = OpLoad %86 
					                               bool %105 = OpFOrdLessThan %104 %71 
					                                             OpStore %103 %105 
					                               bool %106 = OpLoad %103 
					                                i32 %108 = OpSelect %106 %107 %49 
					                                i32 %110 = OpIMul %108 %109 
					                               bool %111 = OpINotEqual %110 %49 
					                                             OpSelectionMerge %113 None 
					                                             OpBranchConditional %111 %112 %113 
					                                    %112 = OpLabel 
					                                             OpKill
					                                    %113 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 116
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %60 %99 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpMemberDecorate %45 0 Offset 45 
					                                             OpDecorate %45 Block 
					                                             OpDecorate %47 DescriptorSet 47 
					                                             OpDecorate %47 Binding 47 
					                                             OpDecorate vs_TEXCOORD2 Location 60 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %90 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %99 RelaxedPrecision 
					                                             OpDecorate %99 Location 99 
					                                             OpDecorate %100 RelaxedPrecision 
					                                             OpDecorate %104 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Private %20 
					                      Private f32_2* %44 = OpVariable Private 
					                                     %45 = OpTypeStruct %7 
					                                     %46 = OpTypePointer Uniform %45 
					            Uniform struct {f32_4;}* %47 = OpVariable Uniform 
					                                     %48 = OpTypeInt 32 1 
					                                 i32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Uniform %7 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %71 = OpConstant 3.674022E-40 
					                                 f32 %72 = OpConstant 3.674022E-40 
					                                     %76 = OpTypePointer Private %6 
					                        Private f32* %77 = OpVariable Private 
					                                     %78 = OpTypeInt 32 0 
					                                 u32 %79 = OpConstant 1 
					                                 u32 %82 = OpConstant 0 
					                        Private f32* %86 = OpVariable Private 
					                                 u32 %87 = OpConstant 3 
					                                 f32 %92 = OpConstant 3.674022E-40 
					                                     %98 = OpTypePointer Output %7 
					                       Output f32_4* %99 = OpVariable Output 
					                                    %101 = OpTypeBool 
					                                    %102 = OpTypePointer Private %101 
					                      Private bool* %103 = OpVariable Private 
					                                i32 %107 = OpConstant 1 
					                                i32 %109 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                      Uniform f32_4* %51 = OpAccessChain %47 %49 
					                               f32_4 %52 = OpLoad %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpFNegate %53 
					                      Uniform f32_4* %55 = OpAccessChain %47 %49 
					                               f32_4 %56 = OpLoad %55 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_2 %58 = OpFAdd %54 %57 
					                                             OpStore %44 %58 
					                               f32_2 %59 = OpLoad %44 
					                               f32_4 %61 = OpLoad vs_TEXCOORD2 
					                               f32_2 %62 = OpVectorShuffle %61 %61 0 1 
					                               f32_2 %63 = OpExtInst %1 4 %62 
					                               f32_2 %64 = OpFNegate %63 
					                               f32_2 %65 = OpFAdd %59 %64 
					                                             OpStore %44 %65 
					                               f32_2 %66 = OpLoad %44 
					                               f32_4 %67 = OpLoad vs_TEXCOORD2 
					                               f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                               f32_2 %69 = OpFMul %66 %68 
					                                             OpStore %44 %69 
					                               f32_2 %70 = OpLoad %44 
					                               f32_2 %73 = OpCompositeConstruct %71 %71 
					                               f32_2 %74 = OpCompositeConstruct %72 %72 
					                               f32_2 %75 = OpExtInst %1 43 %70 %73 %74 
					                                             OpStore %44 %75 
					                        Private f32* %80 = OpAccessChain %44 %79 
					                                 f32 %81 = OpLoad %80 
					                        Private f32* %83 = OpAccessChain %44 %82 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %85 = OpFMul %81 %84 
					                                             OpStore %77 %85 
					                        Private f32* %88 = OpAccessChain %34 %87 
					                                 f32 %89 = OpLoad %88 
					                                 f32 %90 = OpLoad %77 
					                                 f32 %91 = OpFMul %89 %90 
					                                 f32 %93 = OpFAdd %91 %92 
					                                             OpStore %86 %93 
					                               f32_4 %94 = OpLoad %34 
					                                 f32 %95 = OpLoad %77 
					                               f32_4 %96 = OpCompositeConstruct %95 %95 %95 %95 
					                               f32_4 %97 = OpFMul %94 %96 
					                                             OpStore %34 %97 
					                              f32_4 %100 = OpLoad %34 
					                                             OpStore %99 %100 
					                                f32 %104 = OpLoad %86 
					                               bool %105 = OpFOrdLessThan %104 %71 
					                                             OpStore %103 %105 
					                               bool %106 = OpLoad %103 
					                                i32 %108 = OpSelect %106 %107 %49 
					                                i32 %110 = OpIMul %108 %109 
					                               bool %111 = OpINotEqual %110 %49 
					                                             OpSelectionMerge %113 None 
					                                             OpBranchConditional %111 %112 %113 
					                                    %112 = OpLabel 
					                                             OpKill
					                                    %113 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 260
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %135 %149 %150 %157 %183 %192 %193 %213 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpMemberDecorate %29 0 Offset 29 
					                                                      OpMemberDecorate %29 1 Offset 29 
					                                                      OpMemberDecorate %29 2 Offset 29 
					                                                      OpMemberDecorate %29 3 Offset 29 
					                                                      OpMemberDecorate %29 4 Offset 29 
					                                                      OpMemberDecorate %29 5 RelaxedPrecision 
					                                                      OpMemberDecorate %29 5 Offset 29 
					                                                      OpMemberDecorate %29 6 Offset 29 
					                                                      OpMemberDecorate %29 7 Offset 29 
					                                                      OpMemberDecorate %29 8 Offset 29 
					                                                      OpMemberDecorate %29 9 Offset 29 
					                                                      OpMemberDecorate %29 10 Offset 29 
					                                                      OpDecorate %29 Block 
					                                                      OpDecorate %31 DescriptorSet 31 
					                                                      OpDecorate %31 Binding 31 
					                                                      OpMemberDecorate %133 0 BuiltIn 133 
					                                                      OpMemberDecorate %133 1 BuiltIn 133 
					                                                      OpMemberDecorate %133 2 BuiltIn 133 
					                                                      OpDecorate %133 Block 
					                                                      OpDecorate %149 RelaxedPrecision 
					                                                      OpDecorate %149 Location 149 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %154 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %157 Location 157 
					                                                      OpDecorate vs_TEXCOORD1 Location 183 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %193 Location 193 
					                                                      OpDecorate vs_TEXCOORD2 Location 213 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %13 = OpTypeInt 32 0 
					                                          u32 %14 = OpConstant 3 
					                                              %15 = OpTypePointer Input %6 
					                                          f32 %18 = OpConstant 3.674022E-40 
					                                          u32 %20 = OpConstant 0 
					                                              %21 = OpTypePointer Private %6 
					                                          u32 %25 = OpConstant 4 
					                                              %26 = OpTypeArray %10 %25 
					                                              %27 = OpTypeArray %10 %25 
					                                              %28 = OpTypeArray %10 %25 
					                                              %29 = OpTypeStruct %10 %26 %27 %28 %10 %10 %6 %6 %10 %6 %6 
					                                              %30 = OpTypePointer Uniform %29 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32; f32_4; f32; f32;}* %31 = OpVariable Uniform 
					                                              %32 = OpTypeInt 32 1 
					                                          i32 %33 = OpConstant 0 
					                                              %34 = OpTypePointer Uniform %10 
					                               Private f32_2* %39 = OpVariable Private 
					                                          i32 %42 = OpConstant 6 
					                                              %43 = OpTypePointer Uniform %6 
					                                          i32 %46 = OpConstant 7 
					                                              %54 = OpTypePointer Private %10 
					                               Private f32_4* %55 = OpVariable Private 
					                                          i32 %58 = OpConstant 1 
					                                          i32 %69 = OpConstant 2 
					                                          i32 %78 = OpConstant 3 
					                               Private f32_4* %82 = OpVariable Private 
					                                       f32_2 %117 = OpConstantComposite %18 %18 
					                                         u32 %131 = OpConstant 1 
					                                             %132 = OpTypeArray %6 %131 
					                                             %133 = OpTypeStruct %10 %6 %132 
					                                             %134 = OpTypePointer Output %133 
					        Output struct {f32_4; f32; f32[1];}* %135 = OpVariable Output 
					                                             %140 = OpTypePointer Output %10 
					                               Output f32_4* %149 = OpVariable Output 
					                                Input f32_4* %150 = OpVariable Input 
					                                         i32 %152 = OpConstant 5 
					                                             %156 = OpTypePointer Input %7 
					                                Input f32_2* %157 = OpVariable Input 
					                                         f32 %160 = OpConstant 3.674022E-40 
					                                         f32 %170 = OpConstant 3.674022E-40 
					                                         i32 %177 = OpConstant 4 
					                                             %182 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
					                                         f32 %185 = OpConstant 3.674022E-40 
					                                       f32_2 %186 = OpConstantComposite %185 %185 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                Input f32_2* %193 = OpVariable Input 
					                                         i32 %195 = OpConstant 8 
					                                         f32 %198 = OpConstant 3.674022E-40 
					                                       f32_4 %199 = OpConstantComposite %198 %198 %198 %198 
					                                         f32 %202 = OpConstant 3.674022E-40 
					                                       f32_4 %203 = OpConstantComposite %202 %202 %202 %202 
					                                         f32 %206 = OpConstant 3.674022E-40 
					                                       f32_2 %207 = OpConstantComposite %206 %206 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                         i32 %238 = OpConstant 9 
					                                         i32 %241 = OpConstant 10 
					                                         f32 %245 = OpConstant 3.674022E-40 
					                                       f32_2 %246 = OpConstantComposite %245 %245 
					                                             %254 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %35 = OpAccessChain %31 %33 
					                                        f32_4 %36 = OpLoad %35 
					                                        f32_2 %37 = OpVectorShuffle %36 %36 0 1 
					                                        f32_2 %38 = OpFDiv %24 %37 
					                                                      OpStore %9 %38 
					                                        f32_4 %40 = OpLoad %12 
					                                        f32_2 %41 = OpVectorShuffle %40 %40 0 1 
					                                 Uniform f32* %44 = OpAccessChain %31 %42 
					                                          f32 %45 = OpLoad %44 
					                                 Uniform f32* %47 = OpAccessChain %31 %46 
					                                          f32 %48 = OpLoad %47 
					                                        f32_2 %49 = OpCompositeConstruct %45 %48 
					                                        f32_2 %50 = OpFAdd %41 %49 
					                                                      OpStore %39 %50 
					                                        f32_2 %51 = OpLoad %9 
					                                        f32_2 %52 = OpLoad %39 
					                                        f32_2 %53 = OpFAdd %51 %52 
					                                                      OpStore %9 %53 
					                                        f32_2 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 1 1 1 1 
					                               Uniform f32_4* %59 = OpAccessChain %31 %58 %58 
					                                        f32_4 %60 = OpLoad %59 
					                                        f32_4 %61 = OpFMul %57 %60 
					                                                      OpStore %55 %61 
					                               Uniform f32_4* %62 = OpAccessChain %31 %58 %33 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_2 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 0 0 0 0 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %55 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %55 %68 
					                               Uniform f32_4* %70 = OpAccessChain %31 %58 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_4 %72 = OpLoad %12 
					                                        f32_4 %73 = OpVectorShuffle %72 %72 2 2 2 2 
					                                        f32_4 %74 = OpFMul %71 %73 
					                                        f32_4 %75 = OpLoad %55 
					                                        f32_4 %76 = OpFAdd %74 %75 
					                                                      OpStore %55 %76 
					                                        f32_4 %77 = OpLoad %55 
					                               Uniform f32_4* %79 = OpAccessChain %31 %58 %78 
					                                        f32_4 %80 = OpLoad %79 
					                                        f32_4 %81 = OpFAdd %77 %80 
					                                                      OpStore %55 %81 
					                                        f32_4 %83 = OpLoad %55 
					                                        f32_4 %84 = OpVectorShuffle %83 %83 1 1 1 1 
					                               Uniform f32_4* %85 = OpAccessChain %31 %78 %58 
					                                        f32_4 %86 = OpLoad %85 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                                      OpStore %82 %87 
					                               Uniform f32_4* %88 = OpAccessChain %31 %78 %33 
					                                        f32_4 %89 = OpLoad %88 
					                                        f32_4 %90 = OpLoad %55 
					                                        f32_4 %91 = OpVectorShuffle %90 %90 0 0 0 0 
					                                        f32_4 %92 = OpFMul %89 %91 
					                                        f32_4 %93 = OpLoad %82 
					                                        f32_4 %94 = OpFAdd %92 %93 
					                                                      OpStore %82 %94 
					                               Uniform f32_4* %95 = OpAccessChain %31 %78 %69 
					                                        f32_4 %96 = OpLoad %95 
					                                        f32_4 %97 = OpLoad %55 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 2 2 2 2 
					                                        f32_4 %99 = OpFMul %96 %98 
					                                       f32_4 %100 = OpLoad %82 
					                                       f32_4 %101 = OpFAdd %99 %100 
					                                                      OpStore %82 %101 
					                              Uniform f32_4* %102 = OpAccessChain %31 %78 %78 
					                                       f32_4 %103 = OpLoad %102 
					                                       f32_4 %104 = OpLoad %55 
					                                       f32_4 %105 = OpVectorShuffle %104 %104 3 3 3 3 
					                                       f32_4 %106 = OpFMul %103 %105 
					                                       f32_4 %107 = OpLoad %82 
					                                       f32_4 %108 = OpFAdd %106 %107 
					                                                      OpStore %55 %108 
					                                       f32_4 %109 = OpLoad %55 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_4 %111 = OpLoad %55 
					                                       f32_2 %112 = OpVectorShuffle %111 %111 3 3 
					                                       f32_2 %113 = OpFDiv %110 %112 
					                                                      OpStore %39 %113 
					                              Uniform f32_4* %114 = OpAccessChain %31 %33 
					                                       f32_4 %115 = OpLoad %114 
					                                       f32_2 %116 = OpVectorShuffle %115 %115 0 1 
					                                       f32_2 %118 = OpFMul %116 %117 
					                                       f32_4 %119 = OpLoad %55 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 2 3 
					                                                      OpStore %55 %120 
					                                       f32_2 %121 = OpLoad %39 
					                                       f32_4 %122 = OpLoad %55 
					                                       f32_2 %123 = OpVectorShuffle %122 %122 0 1 
					                                       f32_2 %124 = OpFMul %121 %123 
					                                                      OpStore %39 %124 
					                                       f32_2 %125 = OpLoad %39 
					                                       f32_2 %126 = OpExtInst %1 2 %125 
					                                                      OpStore %39 %126 
					                                       f32_2 %127 = OpLoad %39 
					                                       f32_4 %128 = OpLoad %55 
					                                       f32_2 %129 = OpVectorShuffle %128 %128 0 1 
					                                       f32_2 %130 = OpFDiv %127 %129 
					                                                      OpStore %39 %130 
					                                       f32_4 %136 = OpLoad %55 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 3 3 
					                                       f32_2 %138 = OpLoad %39 
					                                       f32_2 %139 = OpFMul %137 %138 
					                               Output f32_4* %141 = OpAccessChain %135 %33 
					                                       f32_4 %142 = OpLoad %141 
					                                       f32_4 %143 = OpVectorShuffle %142 %139 4 5 2 3 
					                                                      OpStore %141 %143 
					                                       f32_4 %144 = OpLoad %55 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 3 
					                               Output f32_4* %146 = OpAccessChain %135 %33 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_4 %148 = OpVectorShuffle %147 %145 0 1 4 5 
					                                                      OpStore %146 %148 
					                                       f32_4 %151 = OpLoad %150 
					                              Uniform f32_4* %153 = OpAccessChain %31 %152 
					                                       f32_4 %154 = OpLoad %153 
					                                       f32_4 %155 = OpFMul %151 %154 
					                                                      OpStore %149 %155 
					                                  Input f32* %158 = OpAccessChain %157 %20 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %161 = OpFMul %159 %160 
					                                Private f32* %162 = OpAccessChain %39 %20 
					                                                      OpStore %162 %161 
					                                Private f32* %163 = OpAccessChain %39 %20 
					                                         f32 %164 = OpLoad %163 
					                                         f32 %165 = OpExtInst %1 8 %164 
					                                Private f32* %166 = OpAccessChain %39 %20 
					                                                      OpStore %166 %165 
					                                Private f32* %167 = OpAccessChain %39 %20 
					                                         f32 %168 = OpLoad %167 
					                                         f32 %169 = OpFNegate %168 
					                                         f32 %171 = OpFMul %169 %170 
					                                  Input f32* %172 = OpAccessChain %157 %20 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFAdd %171 %173 
					                                Private f32* %175 = OpAccessChain %39 %131 
					                                                      OpStore %175 %174 
					                                       f32_2 %176 = OpLoad %39 
					                              Uniform f32_4* %178 = OpAccessChain %31 %177 
					                                       f32_4 %179 = OpLoad %178 
					                                       f32_2 %180 = OpVectorShuffle %179 %179 0 1 
					                                       f32_2 %181 = OpFMul %176 %180 
					                                                      OpStore %39 %181 
					                                       f32_2 %184 = OpLoad %39 
					                                       f32_2 %187 = OpFMul %184 %186 
					                              Uniform f32_4* %188 = OpAccessChain %31 %177 
					                                       f32_4 %189 = OpLoad %188 
					                                       f32_2 %190 = OpVectorShuffle %189 %189 2 3 
					                                       f32_2 %191 = OpFAdd %187 %190 
					                                                      OpStore vs_TEXCOORD1 %191 
					                                       f32_2 %194 = OpLoad %193 
					                                                      OpStore vs_TEXCOORD0 %194 
					                              Uniform f32_4* %196 = OpAccessChain %31 %195 
					                                       f32_4 %197 = OpLoad %196 
					                                       f32_4 %200 = OpExtInst %1 40 %197 %199 
					                                                      OpStore %82 %200 
					                                       f32_4 %201 = OpLoad %82 
					                                       f32_4 %204 = OpExtInst %1 37 %201 %203 
					                                                      OpStore %82 %204 
					                                       f32_2 %205 = OpLoad %9 
					                                       f32_2 %208 = OpFMul %205 %207 
					                                       f32_4 %209 = OpLoad %82 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 1 
					                                       f32_2 %211 = OpFNegate %210 
					                                       f32_2 %212 = OpFAdd %208 %211 
					                                                      OpStore %9 %212 
					                                       f32_4 %214 = OpLoad %82 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                Uniform f32* %221 = OpAccessChain %31 %33 %20 
					                                         f32 %222 = OpLoad %221 
					                                Uniform f32* %223 = OpAccessChain %31 %69 %33 %20 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                Private f32* %226 = OpAccessChain %39 %20 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %31 %33 %131 
					                                         f32 %228 = OpLoad %227 
					                                Uniform f32* %229 = OpAccessChain %31 %69 %58 %131 
					                                         f32 %230 = OpLoad %229 
					                                         f32 %231 = OpFMul %228 %230 
					                                Private f32* %232 = OpAccessChain %39 %131 
					                                                      OpStore %232 %231 
					                                       f32_4 %233 = OpLoad %55 
					                                       f32_2 %234 = OpVectorShuffle %233 %233 3 3 
					                                       f32_2 %235 = OpLoad %39 
					                                       f32_2 %236 = OpExtInst %1 4 %235 
					                                       f32_2 %237 = OpFDiv %234 %236 
					                                                      OpStore %9 %237 
					                                Uniform f32* %239 = OpAccessChain %31 %238 
					                                         f32 %240 = OpLoad %239 
					                                Uniform f32* %242 = OpAccessChain %31 %241 
					                                         f32 %243 = OpLoad %242 
					                                       f32_2 %244 = OpCompositeConstruct %240 %243 
					                                       f32_2 %247 = OpFMul %244 %246 
					                                       f32_2 %248 = OpLoad %9 
					                                       f32_2 %249 = OpFAdd %247 %248 
					                                                      OpStore %9 %249 
					                                       f32_2 %250 = OpLoad %9 
					                                       f32_2 %251 = OpFDiv %246 %250 
					                                       f32_4 %252 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %253 = OpVectorShuffle %252 %251 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %253 
					                                 Output f32* %255 = OpAccessChain %135 %33 %131 
					                                         f32 %256 = OpLoad %255 
					                                         f32 %257 = OpFNegate %256 
					                                 Output f32* %258 = OpAccessChain %135 %33 %131 
					                                                      OpStore %258 %257 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 116
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %31 %40 %60 %99 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 22 
					                                             OpDecorate %25 RelaxedPrecision 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %26 DescriptorSet 26 
					                                             OpDecorate %26 Binding 26 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %28 DescriptorSet 28 
					                                             OpDecorate %28 Binding 28 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %40 Location 40 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpMemberDecorate %45 0 Offset 45 
					                                             OpDecorate %45 Block 
					                                             OpDecorate %47 DescriptorSet 47 
					                                             OpDecorate %47 Binding 47 
					                                             OpDecorate vs_TEXCOORD2 Location 60 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %90 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %95 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %99 RelaxedPrecision 
					                                             OpDecorate %99 Location 99 
					                                             OpDecorate %100 RelaxedPrecision 
					                                             OpDecorate %104 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 4 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_4* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                      Private f32_4* %25 = OpVariable Private 
					UniformConstant read_only Texture2D* %26 = OpVariable UniformConstant 
					            UniformConstant sampler* %28 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_4* %34 = OpVariable Private 
					                                     %39 = OpTypePointer Input %7 
					                        Input f32_4* %40 = OpVariable Input 
					                                     %43 = OpTypePointer Private %20 
					                      Private f32_2* %44 = OpVariable Private 
					                                     %45 = OpTypeStruct %7 
					                                     %46 = OpTypePointer Uniform %45 
					            Uniform struct {f32_4;}* %47 = OpVariable Uniform 
					                                     %48 = OpTypeInt 32 1 
					                                 i32 %49 = OpConstant 0 
					                                     %50 = OpTypePointer Uniform %7 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %71 = OpConstant 3.674022E-40 
					                                 f32 %72 = OpConstant 3.674022E-40 
					                                     %76 = OpTypePointer Private %6 
					                        Private f32* %77 = OpVariable Private 
					                                     %78 = OpTypeInt 32 0 
					                                 u32 %79 = OpConstant 1 
					                                 u32 %82 = OpConstant 0 
					                        Private f32* %86 = OpVariable Private 
					                                 u32 %87 = OpConstant 3 
					                                 f32 %92 = OpConstant 3.674022E-40 
					                                     %98 = OpTypePointer Output %7 
					                       Output f32_4* %99 = OpVariable Output 
					                                    %101 = OpTypeBool 
					                                    %102 = OpTypePointer Private %101 
					                      Private bool* %103 = OpVariable Private 
					                                i32 %107 = OpConstant 1 
					                                i32 %109 = OpConstant -1 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                             OpStore %9 %24 
					                 read_only Texture2D %27 = OpLoad %26 
					                             sampler %29 = OpLoad %28 
					          read_only Texture2DSampled %30 = OpSampledImage %27 %29 
					                               f32_2 %32 = OpLoad vs_TEXCOORD1 
					                               f32_4 %33 = OpImageSampleImplicitLod %30 %32 
					                                             OpStore %25 %33 
					                               f32_4 %35 = OpLoad %9 
					                               f32_4 %36 = OpLoad %25 
					                               f32_4 %37 = OpFMul %35 %36 
					                                             OpStore %34 %37 
					                               f32_4 %38 = OpLoad %34 
					                               f32_4 %41 = OpLoad %40 
					                               f32_4 %42 = OpFMul %38 %41 
					                                             OpStore %34 %42 
					                      Uniform f32_4* %51 = OpAccessChain %47 %49 
					                               f32_4 %52 = OpLoad %51 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpFNegate %53 
					                      Uniform f32_4* %55 = OpAccessChain %47 %49 
					                               f32_4 %56 = OpLoad %55 
					                               f32_2 %57 = OpVectorShuffle %56 %56 2 3 
					                               f32_2 %58 = OpFAdd %54 %57 
					                                             OpStore %44 %58 
					                               f32_2 %59 = OpLoad %44 
					                               f32_4 %61 = OpLoad vs_TEXCOORD2 
					                               f32_2 %62 = OpVectorShuffle %61 %61 0 1 
					                               f32_2 %63 = OpExtInst %1 4 %62 
					                               f32_2 %64 = OpFNegate %63 
					                               f32_2 %65 = OpFAdd %59 %64 
					                                             OpStore %44 %65 
					                               f32_2 %66 = OpLoad %44 
					                               f32_4 %67 = OpLoad vs_TEXCOORD2 
					                               f32_2 %68 = OpVectorShuffle %67 %67 2 3 
					                               f32_2 %69 = OpFMul %66 %68 
					                                             OpStore %44 %69 
					                               f32_2 %70 = OpLoad %44 
					                               f32_2 %73 = OpCompositeConstruct %71 %71 
					                               f32_2 %74 = OpCompositeConstruct %72 %72 
					                               f32_2 %75 = OpExtInst %1 43 %70 %73 %74 
					                                             OpStore %44 %75 
					                        Private f32* %80 = OpAccessChain %44 %79 
					                                 f32 %81 = OpLoad %80 
					                        Private f32* %83 = OpAccessChain %44 %82 
					                                 f32 %84 = OpLoad %83 
					                                 f32 %85 = OpFMul %81 %84 
					                                             OpStore %77 %85 
					                        Private f32* %88 = OpAccessChain %34 %87 
					                                 f32 %89 = OpLoad %88 
					                                 f32 %90 = OpLoad %77 
					                                 f32 %91 = OpFMul %89 %90 
					                                 f32 %93 = OpFAdd %91 %92 
					                                             OpStore %86 %93 
					                               f32_4 %94 = OpLoad %34 
					                                 f32 %95 = OpLoad %77 
					                               f32_4 %96 = OpCompositeConstruct %95 %95 %95 %95 
					                               f32_4 %97 = OpFMul %94 %96 
					                                             OpStore %34 %97 
					                              f32_4 %100 = OpLoad %34 
					                                             OpStore %99 %100 
					                                f32 %104 = OpLoad %86 
					                               bool %105 = OpFOrdLessThan %104 %71 
					                                             OpStore %103 %105 
					                               bool %106 = OpLoad %103 
					                                i32 %108 = OpSelect %106 %107 %49 
					                                i32 %110 = OpIMul %108 %109 
					                               bool %111 = OpINotEqual %110 %49 
					                                             OpSelectionMerge %113 None 
					                                             OpBranchConditional %111 %112 %113 
					                                    %112 = OpLabel 
					                                             OpKill
					                                    %113 = OpLabel 
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
	CustomEditor "TMPro.EditorUtilities.TMP_BitmapShaderGUI"
}