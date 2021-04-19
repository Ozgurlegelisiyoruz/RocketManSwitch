Shader "TextMeshPro/Bitmap" {
	Properties {
		_MainTex ("Font Atlas", 2D) = "white" {}
		_FaceTex ("Font Texture", 2D) = "white" {}
		_FaceColor ("Text Color", Vector) = (1,1,1,1)
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
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
			GpuProgramID 47968
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
					mediump vec3 u_xlat16_0;
					void main()
					{
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    SV_Target0.w = u_xlat16_0.x * vs_COLOR0.w;
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
					mediump vec3 u_xlat16_0;
					void main()
					{
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    SV_Target0.w = u_xlat16_0.x * vs_COLOR0.w;
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
					mediump vec3 u_xlat16_0;
					void main()
					{
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    SV_Target0.w = u_xlat16_0.x * vs_COLOR0.w;
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
					; Bound: 62
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %30 %35 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %35 Location 35 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %39 DescriptorSet 39 
					                                             OpDecorate %39 Binding 39 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %41 DescriptorSet 41 
					                                             OpDecorate %41 Binding 41 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 44 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %58 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %29 = OpTypePointer Input %24 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %34 = OpTypePointer Output %24 
					                       Output f32_4* %35 = OpVariable Output 
					UniformConstant read_only Texture2D* %39 = OpVariable UniformConstant 
					            UniformConstant sampler* %41 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %47 = OpTypeInt 32 0 
					                                 u32 %48 = OpConstant 3 
					                                 u32 %50 = OpConstant 0 
					                                     %51 = OpTypePointer Private %6 
					                                     %55 = OpTypePointer Input %6 
					                                     %59 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %28 = OpLoad %9 
					                               f32_4 %31 = OpLoad %30 
					                               f32_3 %32 = OpVectorShuffle %31 %31 0 1 2 
					                               f32_3 %33 = OpFMul %28 %32 
					                                             OpStore %27 %33 
					                               f32_3 %36 = OpLoad %27 
					                               f32_4 %37 = OpLoad %35 
					                               f32_4 %38 = OpVectorShuffle %37 %36 4 5 6 3 
					                                             OpStore %35 %38 
					                 read_only Texture2D %40 = OpLoad %39 
					                             sampler %42 = OpLoad %41 
					          read_only Texture2DSampled %43 = OpSampledImage %40 %42 
					                               f32_2 %45 = OpLoad vs_TEXCOORD0 
					                               f32_4 %46 = OpImageSampleImplicitLod %43 %45 
					                                 f32 %49 = OpCompositeExtract %46 3 
					                        Private f32* %52 = OpAccessChain %9 %50 
					                                             OpStore %52 %49 
					                        Private f32* %53 = OpAccessChain %9 %50 
					                                 f32 %54 = OpLoad %53 
					                          Input f32* %56 = OpAccessChain %30 %48 
					                                 f32 %57 = OpLoad %56 
					                                 f32 %58 = OpFMul %54 %57 
					                         Output f32* %60 = OpAccessChain %35 %48 
					                                             OpStore %60 %58 
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
					; Bound: 62
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %30 %35 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %35 Location 35 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %39 DescriptorSet 39 
					                                             OpDecorate %39 Binding 39 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %41 DescriptorSet 41 
					                                             OpDecorate %41 Binding 41 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 44 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %58 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %29 = OpTypePointer Input %24 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %34 = OpTypePointer Output %24 
					                       Output f32_4* %35 = OpVariable Output 
					UniformConstant read_only Texture2D* %39 = OpVariable UniformConstant 
					            UniformConstant sampler* %41 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %47 = OpTypeInt 32 0 
					                                 u32 %48 = OpConstant 3 
					                                 u32 %50 = OpConstant 0 
					                                     %51 = OpTypePointer Private %6 
					                                     %55 = OpTypePointer Input %6 
					                                     %59 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %28 = OpLoad %9 
					                               f32_4 %31 = OpLoad %30 
					                               f32_3 %32 = OpVectorShuffle %31 %31 0 1 2 
					                               f32_3 %33 = OpFMul %28 %32 
					                                             OpStore %27 %33 
					                               f32_3 %36 = OpLoad %27 
					                               f32_4 %37 = OpLoad %35 
					                               f32_4 %38 = OpVectorShuffle %37 %36 4 5 6 3 
					                                             OpStore %35 %38 
					                 read_only Texture2D %40 = OpLoad %39 
					                             sampler %42 = OpLoad %41 
					          read_only Texture2DSampled %43 = OpSampledImage %40 %42 
					                               f32_2 %45 = OpLoad vs_TEXCOORD0 
					                               f32_4 %46 = OpImageSampleImplicitLod %43 %45 
					                                 f32 %49 = OpCompositeExtract %46 3 
					                        Private f32* %52 = OpAccessChain %9 %50 
					                                             OpStore %52 %49 
					                        Private f32* %53 = OpAccessChain %9 %50 
					                                 f32 %54 = OpLoad %53 
					                          Input f32* %56 = OpAccessChain %30 %48 
					                                 f32 %57 = OpLoad %56 
					                                 f32 %58 = OpFMul %54 %57 
					                         Output f32* %60 = OpAccessChain %35 %48 
					                                             OpStore %60 %58 
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
					; Bound: 62
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %30 %35 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %35 Location 35 
					                                             OpDecorate %36 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %39 DescriptorSet 39 
					                                             OpDecorate %39 Binding 39 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %41 DescriptorSet 41 
					                                             OpDecorate %41 Binding 41 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 44 
					                                             OpDecorate %49 RelaxedPrecision 
					                                             OpDecorate %54 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %58 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %29 = OpTypePointer Input %24 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %34 = OpTypePointer Output %24 
					                       Output f32_4* %35 = OpVariable Output 
					UniformConstant read_only Texture2D* %39 = OpVariable UniformConstant 
					            UniformConstant sampler* %41 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %47 = OpTypeInt 32 0 
					                                 u32 %48 = OpConstant 3 
					                                 u32 %50 = OpConstant 0 
					                                     %51 = OpTypePointer Private %6 
					                                     %55 = OpTypePointer Input %6 
					                                     %59 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %28 = OpLoad %9 
					                               f32_4 %31 = OpLoad %30 
					                               f32_3 %32 = OpVectorShuffle %31 %31 0 1 2 
					                               f32_3 %33 = OpFMul %28 %32 
					                                             OpStore %27 %33 
					                               f32_3 %36 = OpLoad %27 
					                               f32_4 %37 = OpLoad %35 
					                               f32_4 %38 = OpVectorShuffle %37 %36 4 5 6 3 
					                                             OpStore %35 %38 
					                 read_only Texture2D %40 = OpLoad %39 
					                             sampler %42 = OpLoad %41 
					          read_only Texture2DSampled %43 = OpSampledImage %40 %42 
					                               f32_2 %45 = OpLoad vs_TEXCOORD0 
					                               f32_4 %46 = OpImageSampleImplicitLod %43 %45 
					                                 f32 %49 = OpCompositeExtract %46 3 
					                        Private f32* %52 = OpAccessChain %9 %50 
					                                             OpStore %52 %49 
					                        Private f32* %53 = OpAccessChain %9 %50 
					                                 f32 %54 = OpLoad %53 
					                          Input f32* %56 = OpAccessChain %30 %48 
					                                 f32 %57 = OpLoad %56 
					                                 f32 %58 = OpFMul %54 %57 
					                         Output f32* %60 = OpAccessChain %35 %48 
					                                             OpStore %60 %58 
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
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0.x + -0.00100000005;
					    u_xlat16_3 = u_xlat16_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb0 = u_xlat16_1<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0.x + -0.00100000005;
					    u_xlat16_3 = u_xlat16_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb0 = u_xlat16_1<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0.x + -0.00100000005;
					    u_xlat16_3 = u_xlat16_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb0 = u_xlat16_1<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					; Bound: 89
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %34 %50 %76 
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
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %34 Location 34 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %47 RelaxedPrecision 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %50 Location 50 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate %71 DescriptorSet 71 
					                                             OpDecorate %71 Binding 71 
					                                             OpDecorate %72 RelaxedPrecision 
					                                             OpDecorate %73 RelaxedPrecision 
					                                             OpDecorate %73 DescriptorSet 73 
					                                             OpDecorate %73 Binding 73 
					                                             OpDecorate %74 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 76 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %83 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
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
					                                     %24 = OpTypeVector %6 4 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                                 u32 %29 = OpConstant 0 
					                                     %30 = OpTypePointer Private %6 
					                        Private f32* %32 = OpVariable Private 
					                                     %33 = OpTypePointer Input %24 
					                        Input f32_4* %34 = OpVariable Input 
					                                     %35 = OpTypePointer Input %6 
					                                 f32 %41 = OpConstant 3.674022E-40 
					                        Private f32* %43 = OpVariable Private 
					                                     %49 = OpTypePointer Output %24 
					                       Output f32_4* %50 = OpVariable Output 
					                                     %52 = OpTypePointer Output %6 
					                                     %54 = OpTypeBool 
					                                     %55 = OpTypePointer Private %54 
					                       Private bool* %56 = OpVariable Private 
					                                 f32 %58 = OpConstant 3.674022E-40 
					                                     %61 = OpTypeInt 32 1 
					                                 i32 %62 = OpConstant 0 
					                                 i32 %63 = OpConstant 1 
					                                 i32 %65 = OpConstant -1 
					UniformConstant read_only Texture2D* %71 = OpVariable UniformConstant 
					            UniformConstant sampler* %73 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %80 = OpVariable Private 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                        Private f32* %31 = OpAccessChain %9 %29 
					                                             OpStore %31 %28 
					                          Input f32* %36 = OpAccessChain %34 %27 
					                                 f32 %37 = OpLoad %36 
					                        Private f32* %38 = OpAccessChain %9 %29 
					                                 f32 %39 = OpLoad %38 
					                                 f32 %40 = OpFMul %37 %39 
					                                 f32 %42 = OpFAdd %40 %41 
					                                             OpStore %32 %42 
					                        Private f32* %44 = OpAccessChain %9 %29 
					                                 f32 %45 = OpLoad %44 
					                          Input f32* %46 = OpAccessChain %34 %27 
					                                 f32 %47 = OpLoad %46 
					                                 f32 %48 = OpFMul %45 %47 
					                                             OpStore %43 %48 
					                                 f32 %51 = OpLoad %43 
					                         Output f32* %53 = OpAccessChain %50 %27 
					                                             OpStore %53 %51 
					                                 f32 %57 = OpLoad %32 
					                                bool %59 = OpFOrdLessThan %57 %58 
					                                             OpStore %56 %59 
					                                bool %60 = OpLoad %56 
					                                 i32 %64 = OpSelect %60 %63 %62 
					                                 i32 %66 = OpIMul %64 %65 
					                                bool %67 = OpINotEqual %66 %62 
					                                             OpSelectionMerge %69 None 
					                                             OpBranchConditional %67 %68 %69 
					                                     %68 = OpLabel 
					                                             OpKill
					                                     %69 = OpLabel 
					                 read_only Texture2D %72 = OpLoad %71 
					                             sampler %74 = OpLoad %73 
					          read_only Texture2DSampled %75 = OpSampledImage %72 %74 
					                               f32_2 %77 = OpLoad vs_TEXCOORD1 
					                               f32_4 %78 = OpImageSampleImplicitLod %75 %77 
					                               f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
					                                             OpStore %9 %79 
					                               f32_3 %81 = OpLoad %9 
					                               f32_4 %82 = OpLoad %34 
					                               f32_3 %83 = OpVectorShuffle %82 %82 0 1 2 
					                               f32_3 %84 = OpFMul %81 %83 
					                                             OpStore %80 %84 
					                               f32_3 %85 = OpLoad %80 
					                               f32_4 %86 = OpLoad %50 
					                               f32_4 %87 = OpVectorShuffle %86 %85 4 5 6 3 
					                                             OpStore %50 %87 
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
					; Bound: 89
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %34 %50 %76 
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
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %34 Location 34 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %47 RelaxedPrecision 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %50 Location 50 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate %71 DescriptorSet 71 
					                                             OpDecorate %71 Binding 71 
					                                             OpDecorate %72 RelaxedPrecision 
					                                             OpDecorate %73 RelaxedPrecision 
					                                             OpDecorate %73 DescriptorSet 73 
					                                             OpDecorate %73 Binding 73 
					                                             OpDecorate %74 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 76 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %83 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
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
					                                     %24 = OpTypeVector %6 4 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                                 u32 %29 = OpConstant 0 
					                                     %30 = OpTypePointer Private %6 
					                        Private f32* %32 = OpVariable Private 
					                                     %33 = OpTypePointer Input %24 
					                        Input f32_4* %34 = OpVariable Input 
					                                     %35 = OpTypePointer Input %6 
					                                 f32 %41 = OpConstant 3.674022E-40 
					                        Private f32* %43 = OpVariable Private 
					                                     %49 = OpTypePointer Output %24 
					                       Output f32_4* %50 = OpVariable Output 
					                                     %52 = OpTypePointer Output %6 
					                                     %54 = OpTypeBool 
					                                     %55 = OpTypePointer Private %54 
					                       Private bool* %56 = OpVariable Private 
					                                 f32 %58 = OpConstant 3.674022E-40 
					                                     %61 = OpTypeInt 32 1 
					                                 i32 %62 = OpConstant 0 
					                                 i32 %63 = OpConstant 1 
					                                 i32 %65 = OpConstant -1 
					UniformConstant read_only Texture2D* %71 = OpVariable UniformConstant 
					            UniformConstant sampler* %73 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %80 = OpVariable Private 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                        Private f32* %31 = OpAccessChain %9 %29 
					                                             OpStore %31 %28 
					                          Input f32* %36 = OpAccessChain %34 %27 
					                                 f32 %37 = OpLoad %36 
					                        Private f32* %38 = OpAccessChain %9 %29 
					                                 f32 %39 = OpLoad %38 
					                                 f32 %40 = OpFMul %37 %39 
					                                 f32 %42 = OpFAdd %40 %41 
					                                             OpStore %32 %42 
					                        Private f32* %44 = OpAccessChain %9 %29 
					                                 f32 %45 = OpLoad %44 
					                          Input f32* %46 = OpAccessChain %34 %27 
					                                 f32 %47 = OpLoad %46 
					                                 f32 %48 = OpFMul %45 %47 
					                                             OpStore %43 %48 
					                                 f32 %51 = OpLoad %43 
					                         Output f32* %53 = OpAccessChain %50 %27 
					                                             OpStore %53 %51 
					                                 f32 %57 = OpLoad %32 
					                                bool %59 = OpFOrdLessThan %57 %58 
					                                             OpStore %56 %59 
					                                bool %60 = OpLoad %56 
					                                 i32 %64 = OpSelect %60 %63 %62 
					                                 i32 %66 = OpIMul %64 %65 
					                                bool %67 = OpINotEqual %66 %62 
					                                             OpSelectionMerge %69 None 
					                                             OpBranchConditional %67 %68 %69 
					                                     %68 = OpLabel 
					                                             OpKill
					                                     %69 = OpLabel 
					                 read_only Texture2D %72 = OpLoad %71 
					                             sampler %74 = OpLoad %73 
					          read_only Texture2DSampled %75 = OpSampledImage %72 %74 
					                               f32_2 %77 = OpLoad vs_TEXCOORD1 
					                               f32_4 %78 = OpImageSampleImplicitLod %75 %77 
					                               f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
					                                             OpStore %9 %79 
					                               f32_3 %81 = OpLoad %9 
					                               f32_4 %82 = OpLoad %34 
					                               f32_3 %83 = OpVectorShuffle %82 %82 0 1 2 
					                               f32_3 %84 = OpFMul %81 %83 
					                                             OpStore %80 %84 
					                               f32_3 %85 = OpLoad %80 
					                               f32_4 %86 = OpLoad %50 
					                               f32_4 %87 = OpVectorShuffle %86 %85 4 5 6 3 
					                                             OpStore %50 %87 
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
					; Bound: 89
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %34 %50 %76 
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
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %34 Location 34 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %40 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %47 RelaxedPrecision 
					                                             OpDecorate %48 RelaxedPrecision 
					                                             OpDecorate %50 RelaxedPrecision 
					                                             OpDecorate %50 Location 50 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %57 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate %71 DescriptorSet 71 
					                                             OpDecorate %71 Binding 71 
					                                             OpDecorate %72 RelaxedPrecision 
					                                             OpDecorate %73 RelaxedPrecision 
					                                             OpDecorate %73 DescriptorSet 73 
					                                             OpDecorate %73 Binding 73 
					                                             OpDecorate %74 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 76 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %83 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
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
					                                     %24 = OpTypeVector %6 4 
					                                     %26 = OpTypeInt 32 0 
					                                 u32 %27 = OpConstant 3 
					                                 u32 %29 = OpConstant 0 
					                                     %30 = OpTypePointer Private %6 
					                        Private f32* %32 = OpVariable Private 
					                                     %33 = OpTypePointer Input %24 
					                        Input f32_4* %34 = OpVariable Input 
					                                     %35 = OpTypePointer Input %6 
					                                 f32 %41 = OpConstant 3.674022E-40 
					                        Private f32* %43 = OpVariable Private 
					                                     %49 = OpTypePointer Output %24 
					                       Output f32_4* %50 = OpVariable Output 
					                                     %52 = OpTypePointer Output %6 
					                                     %54 = OpTypeBool 
					                                     %55 = OpTypePointer Private %54 
					                       Private bool* %56 = OpVariable Private 
					                                 f32 %58 = OpConstant 3.674022E-40 
					                                     %61 = OpTypeInt 32 1 
					                                 i32 %62 = OpConstant 0 
					                                 i32 %63 = OpConstant 1 
					                                 i32 %65 = OpConstant -1 
					UniformConstant read_only Texture2D* %71 = OpVariable UniformConstant 
					            UniformConstant sampler* %73 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %80 = OpVariable Private 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD0 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                                 f32 %28 = OpCompositeExtract %25 3 
					                        Private f32* %31 = OpAccessChain %9 %29 
					                                             OpStore %31 %28 
					                          Input f32* %36 = OpAccessChain %34 %27 
					                                 f32 %37 = OpLoad %36 
					                        Private f32* %38 = OpAccessChain %9 %29 
					                                 f32 %39 = OpLoad %38 
					                                 f32 %40 = OpFMul %37 %39 
					                                 f32 %42 = OpFAdd %40 %41 
					                                             OpStore %32 %42 
					                        Private f32* %44 = OpAccessChain %9 %29 
					                                 f32 %45 = OpLoad %44 
					                          Input f32* %46 = OpAccessChain %34 %27 
					                                 f32 %47 = OpLoad %46 
					                                 f32 %48 = OpFMul %45 %47 
					                                             OpStore %43 %48 
					                                 f32 %51 = OpLoad %43 
					                         Output f32* %53 = OpAccessChain %50 %27 
					                                             OpStore %53 %51 
					                                 f32 %57 = OpLoad %32 
					                                bool %59 = OpFOrdLessThan %57 %58 
					                                             OpStore %56 %59 
					                                bool %60 = OpLoad %56 
					                                 i32 %64 = OpSelect %60 %63 %62 
					                                 i32 %66 = OpIMul %64 %65 
					                                bool %67 = OpINotEqual %66 %62 
					                                             OpSelectionMerge %69 None 
					                                             OpBranchConditional %67 %68 %69 
					                                     %68 = OpLabel 
					                                             OpKill
					                                     %69 = OpLabel 
					                 read_only Texture2D %72 = OpLoad %71 
					                             sampler %74 = OpLoad %73 
					          read_only Texture2DSampled %75 = OpSampledImage %72 %74 
					                               f32_2 %77 = OpLoad vs_TEXCOORD1 
					                               f32_4 %78 = OpImageSampleImplicitLod %75 %77 
					                               f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
					                                             OpStore %9 %79 
					                               f32_3 %81 = OpLoad %9 
					                               f32_4 %82 = OpLoad %34 
					                               f32_3 %83 = OpVectorShuffle %82 %82 0 1 2 
					                               f32_3 %84 = OpFMul %81 %83 
					                                             OpStore %80 %84 
					                               f32_3 %85 = OpLoad %80 
					                               f32_4 %86 = OpLoad %50 
					                               f32_4 %87 = OpVectorShuffle %86 %85 4 5 6 3 
					                                             OpStore %50 %87 
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
					mediump vec3 u_xlat16_0;
					vec2 u_xlat1;
					mediump float u_xlat16_2;
					mediump float u_xlat16_5;
					void main()
					{
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_5 = u_xlat16_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_2 * u_xlat16_5;
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
					mediump vec3 u_xlat16_0;
					vec2 u_xlat1;
					mediump float u_xlat16_2;
					mediump float u_xlat16_5;
					void main()
					{
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_5 = u_xlat16_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_2 * u_xlat16_5;
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
					mediump vec3 u_xlat16_0;
					vec2 u_xlat1;
					mediump float u_xlat16_2;
					mediump float u_xlat16_5;
					void main()
					{
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
					#else
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					#endif
					    u_xlat16_2 = u_xlat1.y * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
					    u_xlat16_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_5 = u_xlat16_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_2 * u_xlat16_5;
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
					; Bound: 109
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %30 %51 %78 %90 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpMemberDecorate %36 0 Offset 36 
					                                             OpDecorate %36 Block 
					                                             OpDecorate %38 DescriptorSet 38 
					                                             OpDecorate %38 Binding 38 
					                                             OpDecorate vs_TEXCOORD2 Location 51 
					                                             OpDecorate %68 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %78 Location 78 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %85 DescriptorSet 85 
					                                             OpDecorate %85 Binding 85 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 DescriptorSet 87 
					                                             OpDecorate %87 Binding 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 90 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %98 RelaxedPrecision 
					                                             OpDecorate %101 RelaxedPrecision 
					                                             OpDecorate %102 RelaxedPrecision 
					                                             OpDecorate %103 RelaxedPrecision 
					                                             OpDecorate %104 RelaxedPrecision 
					                                             OpDecorate %105 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %29 = OpTypePointer Input %24 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %34 = OpTypePointer Private %20 
					                      Private f32_2* %35 = OpVariable Private 
					                                     %36 = OpTypeStruct %24 
					                                     %37 = OpTypePointer Uniform %36 
					            Uniform struct {f32_4;}* %38 = OpVariable Uniform 
					                                     %39 = OpTypeInt 32 1 
					                                 i32 %40 = OpConstant 0 
					                                     %41 = OpTypePointer Uniform %24 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %62 = OpConstant 3.674022E-40 
					                                 f32 %63 = OpConstant 3.674022E-40 
					                                     %67 = OpTypePointer Private %6 
					                        Private f32* %68 = OpVariable Private 
					                                     %69 = OpTypeInt 32 0 
					                                 u32 %70 = OpConstant 1 
					                                 u32 %73 = OpConstant 0 
					                                     %77 = OpTypePointer Output %24 
					                       Output f32_4* %78 = OpVariable Output 
					UniformConstant read_only Texture2D* %85 = OpVariable UniformConstant 
					            UniformConstant sampler* %87 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %93 = OpConstant 3 
					                        Private f32* %96 = OpVariable Private 
					                                     %99 = OpTypePointer Input %6 
					                                    %106 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %28 = OpLoad %9 
					                               f32_4 %31 = OpLoad %30 
					                               f32_3 %32 = OpVectorShuffle %31 %31 0 1 2 
					                               f32_3 %33 = OpFMul %28 %32 
					                                             OpStore %27 %33 
					                      Uniform f32_4* %42 = OpAccessChain %38 %40 
					                               f32_4 %43 = OpLoad %42 
					                               f32_2 %44 = OpVectorShuffle %43 %43 0 1 
					                               f32_2 %45 = OpFNegate %44 
					                      Uniform f32_4* %46 = OpAccessChain %38 %40 
					                               f32_4 %47 = OpLoad %46 
					                               f32_2 %48 = OpVectorShuffle %47 %47 2 3 
					                               f32_2 %49 = OpFAdd %45 %48 
					                                             OpStore %35 %49 
					                               f32_2 %50 = OpLoad %35 
					                               f32_4 %52 = OpLoad vs_TEXCOORD2 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpExtInst %1 4 %53 
					                               f32_2 %55 = OpFNegate %54 
					                               f32_2 %56 = OpFAdd %50 %55 
					                                             OpStore %35 %56 
					                               f32_2 %57 = OpLoad %35 
					                               f32_4 %58 = OpLoad vs_TEXCOORD2 
					                               f32_2 %59 = OpVectorShuffle %58 %58 2 3 
					                               f32_2 %60 = OpFMul %57 %59 
					                                             OpStore %35 %60 
					                               f32_2 %61 = OpLoad %35 
					                               f32_2 %64 = OpCompositeConstruct %62 %62 
					                               f32_2 %65 = OpCompositeConstruct %63 %63 
					                               f32_2 %66 = OpExtInst %1 43 %61 %64 %65 
					                                             OpStore %35 %66 
					                        Private f32* %71 = OpAccessChain %35 %70 
					                                 f32 %72 = OpLoad %71 
					                        Private f32* %74 = OpAccessChain %35 %73 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %72 %75 
					                                             OpStore %68 %76 
					                               f32_3 %79 = OpLoad %27 
					                                 f32 %80 = OpLoad %68 
					                               f32_3 %81 = OpCompositeConstruct %80 %80 %80 
					                               f32_3 %82 = OpFMul %79 %81 
					                               f32_4 %83 = OpLoad %78 
					                               f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                             OpStore %78 %84 
					                 read_only Texture2D %86 = OpLoad %85 
					                             sampler %88 = OpLoad %87 
					          read_only Texture2DSampled %89 = OpSampledImage %86 %88 
					                               f32_2 %91 = OpLoad vs_TEXCOORD0 
					                               f32_4 %92 = OpImageSampleImplicitLod %89 %91 
					                                 f32 %94 = OpCompositeExtract %92 3 
					                        Private f32* %95 = OpAccessChain %9 %73 
					                                             OpStore %95 %94 
					                        Private f32* %97 = OpAccessChain %9 %73 
					                                 f32 %98 = OpLoad %97 
					                         Input f32* %100 = OpAccessChain %30 %93 
					                                f32 %101 = OpLoad %100 
					                                f32 %102 = OpFMul %98 %101 
					                                             OpStore %96 %102 
					                                f32 %103 = OpLoad %68 
					                                f32 %104 = OpLoad %96 
					                                f32 %105 = OpFMul %103 %104 
					                        Output f32* %107 = OpAccessChain %78 %93 
					                                             OpStore %107 %105 
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
					; Bound: 109
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %30 %51 %78 %90 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpMemberDecorate %36 0 Offset 36 
					                                             OpDecorate %36 Block 
					                                             OpDecorate %38 DescriptorSet 38 
					                                             OpDecorate %38 Binding 38 
					                                             OpDecorate vs_TEXCOORD2 Location 51 
					                                             OpDecorate %68 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %78 Location 78 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %85 DescriptorSet 85 
					                                             OpDecorate %85 Binding 85 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 DescriptorSet 87 
					                                             OpDecorate %87 Binding 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 90 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %98 RelaxedPrecision 
					                                             OpDecorate %101 RelaxedPrecision 
					                                             OpDecorate %102 RelaxedPrecision 
					                                             OpDecorate %103 RelaxedPrecision 
					                                             OpDecorate %104 RelaxedPrecision 
					                                             OpDecorate %105 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %29 = OpTypePointer Input %24 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %34 = OpTypePointer Private %20 
					                      Private f32_2* %35 = OpVariable Private 
					                                     %36 = OpTypeStruct %24 
					                                     %37 = OpTypePointer Uniform %36 
					            Uniform struct {f32_4;}* %38 = OpVariable Uniform 
					                                     %39 = OpTypeInt 32 1 
					                                 i32 %40 = OpConstant 0 
					                                     %41 = OpTypePointer Uniform %24 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %62 = OpConstant 3.674022E-40 
					                                 f32 %63 = OpConstant 3.674022E-40 
					                                     %67 = OpTypePointer Private %6 
					                        Private f32* %68 = OpVariable Private 
					                                     %69 = OpTypeInt 32 0 
					                                 u32 %70 = OpConstant 1 
					                                 u32 %73 = OpConstant 0 
					                                     %77 = OpTypePointer Output %24 
					                       Output f32_4* %78 = OpVariable Output 
					UniformConstant read_only Texture2D* %85 = OpVariable UniformConstant 
					            UniformConstant sampler* %87 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %93 = OpConstant 3 
					                        Private f32* %96 = OpVariable Private 
					                                     %99 = OpTypePointer Input %6 
					                                    %106 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %28 = OpLoad %9 
					                               f32_4 %31 = OpLoad %30 
					                               f32_3 %32 = OpVectorShuffle %31 %31 0 1 2 
					                               f32_3 %33 = OpFMul %28 %32 
					                                             OpStore %27 %33 
					                      Uniform f32_4* %42 = OpAccessChain %38 %40 
					                               f32_4 %43 = OpLoad %42 
					                               f32_2 %44 = OpVectorShuffle %43 %43 0 1 
					                               f32_2 %45 = OpFNegate %44 
					                      Uniform f32_4* %46 = OpAccessChain %38 %40 
					                               f32_4 %47 = OpLoad %46 
					                               f32_2 %48 = OpVectorShuffle %47 %47 2 3 
					                               f32_2 %49 = OpFAdd %45 %48 
					                                             OpStore %35 %49 
					                               f32_2 %50 = OpLoad %35 
					                               f32_4 %52 = OpLoad vs_TEXCOORD2 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpExtInst %1 4 %53 
					                               f32_2 %55 = OpFNegate %54 
					                               f32_2 %56 = OpFAdd %50 %55 
					                                             OpStore %35 %56 
					                               f32_2 %57 = OpLoad %35 
					                               f32_4 %58 = OpLoad vs_TEXCOORD2 
					                               f32_2 %59 = OpVectorShuffle %58 %58 2 3 
					                               f32_2 %60 = OpFMul %57 %59 
					                                             OpStore %35 %60 
					                               f32_2 %61 = OpLoad %35 
					                               f32_2 %64 = OpCompositeConstruct %62 %62 
					                               f32_2 %65 = OpCompositeConstruct %63 %63 
					                               f32_2 %66 = OpExtInst %1 43 %61 %64 %65 
					                                             OpStore %35 %66 
					                        Private f32* %71 = OpAccessChain %35 %70 
					                                 f32 %72 = OpLoad %71 
					                        Private f32* %74 = OpAccessChain %35 %73 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %72 %75 
					                                             OpStore %68 %76 
					                               f32_3 %79 = OpLoad %27 
					                                 f32 %80 = OpLoad %68 
					                               f32_3 %81 = OpCompositeConstruct %80 %80 %80 
					                               f32_3 %82 = OpFMul %79 %81 
					                               f32_4 %83 = OpLoad %78 
					                               f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                             OpStore %78 %84 
					                 read_only Texture2D %86 = OpLoad %85 
					                             sampler %88 = OpLoad %87 
					          read_only Texture2DSampled %89 = OpSampledImage %86 %88 
					                               f32_2 %91 = OpLoad vs_TEXCOORD0 
					                               f32_4 %92 = OpImageSampleImplicitLod %89 %91 
					                                 f32 %94 = OpCompositeExtract %92 3 
					                        Private f32* %95 = OpAccessChain %9 %73 
					                                             OpStore %95 %94 
					                        Private f32* %97 = OpAccessChain %9 %73 
					                                 f32 %98 = OpLoad %97 
					                         Input f32* %100 = OpAccessChain %30 %93 
					                                f32 %101 = OpLoad %100 
					                                f32 %102 = OpFMul %98 %101 
					                                             OpStore %96 %102 
					                                f32 %103 = OpLoad %68 
					                                f32 %104 = OpLoad %96 
					                                f32 %105 = OpFMul %103 %104 
					                        Output f32* %107 = OpAccessChain %78 %93 
					                                             OpStore %107 %105 
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
					; Bound: 109
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %22 %30 %51 %78 %90 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpDecorate %9 RelaxedPrecision 
					                                             OpDecorate %12 RelaxedPrecision 
					                                             OpDecorate %12 DescriptorSet 12 
					                                             OpDecorate %12 Binding 12 
					                                             OpDecorate %13 RelaxedPrecision 
					                                             OpDecorate %16 RelaxedPrecision 
					                                             OpDecorate %16 DescriptorSet 16 
					                                             OpDecorate %16 Binding 16 
					                                             OpDecorate %17 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD1 Location 22 
					                                             OpDecorate %26 RelaxedPrecision 
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %32 RelaxedPrecision 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpMemberDecorate %36 0 Offset 36 
					                                             OpDecorate %36 Block 
					                                             OpDecorate %38 DescriptorSet 38 
					                                             OpDecorate %38 Binding 38 
					                                             OpDecorate vs_TEXCOORD2 Location 51 
					                                             OpDecorate %68 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %78 Location 78 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %85 DescriptorSet 85 
					                                             OpDecorate %85 Binding 85 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %87 DescriptorSet 87 
					                                             OpDecorate %87 Binding 87 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate vs_TEXCOORD0 Location 90 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %96 RelaxedPrecision 
					                                             OpDecorate %98 RelaxedPrecision 
					                                             OpDecorate %101 RelaxedPrecision 
					                                             OpDecorate %102 RelaxedPrecision 
					                                             OpDecorate %103 RelaxedPrecision 
					                                             OpDecorate %104 RelaxedPrecision 
					                                             OpDecorate %105 RelaxedPrecision 
					                                      %2 = OpTypeVoid 
					                                      %3 = OpTypeFunction %2 
					                                      %6 = OpTypeFloat 32 
					                                      %7 = OpTypeVector %6 3 
					                                      %8 = OpTypePointer Private %7 
					                       Private f32_3* %9 = OpVariable Private 
					                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                     %11 = OpTypePointer UniformConstant %10 
					UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                     %14 = OpTypeSampler 
					                                     %15 = OpTypePointer UniformConstant %14 
					            UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                     %18 = OpTypeSampledImage %10 
					                                     %20 = OpTypeVector %6 2 
					                                     %21 = OpTypePointer Input %20 
					               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                                     %24 = OpTypeVector %6 4 
					                      Private f32_3* %27 = OpVariable Private 
					                                     %29 = OpTypePointer Input %24 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %34 = OpTypePointer Private %20 
					                      Private f32_2* %35 = OpVariable Private 
					                                     %36 = OpTypeStruct %24 
					                                     %37 = OpTypePointer Uniform %36 
					            Uniform struct {f32_4;}* %38 = OpVariable Uniform 
					                                     %39 = OpTypeInt 32 1 
					                                 i32 %40 = OpConstant 0 
					                                     %41 = OpTypePointer Uniform %24 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %62 = OpConstant 3.674022E-40 
					                                 f32 %63 = OpConstant 3.674022E-40 
					                                     %67 = OpTypePointer Private %6 
					                        Private f32* %68 = OpVariable Private 
					                                     %69 = OpTypeInt 32 0 
					                                 u32 %70 = OpConstant 1 
					                                 u32 %73 = OpConstant 0 
					                                     %77 = OpTypePointer Output %24 
					                       Output f32_4* %78 = OpVariable Output 
					UniformConstant read_only Texture2D* %85 = OpVariable UniformConstant 
					            UniformConstant sampler* %87 = OpVariable UniformConstant 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %93 = OpConstant 3 
					                        Private f32* %96 = OpVariable Private 
					                                     %99 = OpTypePointer Input %6 
					                                    %106 = OpTypePointer Output %6 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %13 = OpLoad %12 
					                             sampler %17 = OpLoad %16 
					          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                               f32_2 %23 = OpLoad vs_TEXCOORD1 
					                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
					                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
					                                             OpStore %9 %26 
					                               f32_3 %28 = OpLoad %9 
					                               f32_4 %31 = OpLoad %30 
					                               f32_3 %32 = OpVectorShuffle %31 %31 0 1 2 
					                               f32_3 %33 = OpFMul %28 %32 
					                                             OpStore %27 %33 
					                      Uniform f32_4* %42 = OpAccessChain %38 %40 
					                               f32_4 %43 = OpLoad %42 
					                               f32_2 %44 = OpVectorShuffle %43 %43 0 1 
					                               f32_2 %45 = OpFNegate %44 
					                      Uniform f32_4* %46 = OpAccessChain %38 %40 
					                               f32_4 %47 = OpLoad %46 
					                               f32_2 %48 = OpVectorShuffle %47 %47 2 3 
					                               f32_2 %49 = OpFAdd %45 %48 
					                                             OpStore %35 %49 
					                               f32_2 %50 = OpLoad %35 
					                               f32_4 %52 = OpLoad vs_TEXCOORD2 
					                               f32_2 %53 = OpVectorShuffle %52 %52 0 1 
					                               f32_2 %54 = OpExtInst %1 4 %53 
					                               f32_2 %55 = OpFNegate %54 
					                               f32_2 %56 = OpFAdd %50 %55 
					                                             OpStore %35 %56 
					                               f32_2 %57 = OpLoad %35 
					                               f32_4 %58 = OpLoad vs_TEXCOORD2 
					                               f32_2 %59 = OpVectorShuffle %58 %58 2 3 
					                               f32_2 %60 = OpFMul %57 %59 
					                                             OpStore %35 %60 
					                               f32_2 %61 = OpLoad %35 
					                               f32_2 %64 = OpCompositeConstruct %62 %62 
					                               f32_2 %65 = OpCompositeConstruct %63 %63 
					                               f32_2 %66 = OpExtInst %1 43 %61 %64 %65 
					                                             OpStore %35 %66 
					                        Private f32* %71 = OpAccessChain %35 %70 
					                                 f32 %72 = OpLoad %71 
					                        Private f32* %74 = OpAccessChain %35 %73 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %72 %75 
					                                             OpStore %68 %76 
					                               f32_3 %79 = OpLoad %27 
					                                 f32 %80 = OpLoad %68 
					                               f32_3 %81 = OpCompositeConstruct %80 %80 %80 
					                               f32_3 %82 = OpFMul %79 %81 
					                               f32_4 %83 = OpLoad %78 
					                               f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                             OpStore %78 %84 
					                 read_only Texture2D %86 = OpLoad %85 
					                             sampler %88 = OpLoad %87 
					          read_only Texture2DSampled %89 = OpSampledImage %86 %88 
					                               f32_2 %91 = OpLoad vs_TEXCOORD0 
					                               f32_4 %92 = OpImageSampleImplicitLod %89 %91 
					                                 f32 %94 = OpCompositeExtract %92 3 
					                        Private f32* %95 = OpAccessChain %9 %73 
					                                             OpStore %95 %94 
					                        Private f32* %97 = OpAccessChain %9 %73 
					                                 f32 %98 = OpLoad %97 
					                         Input f32* %100 = OpAccessChain %30 %93 
					                                f32 %101 = OpLoad %100 
					                                f32 %102 = OpFMul %98 %101 
					                                             OpStore %96 %102 
					                                f32 %103 = OpLoad %68 
					                                f32 %104 = OpLoad %96 
					                                f32 %105 = OpFMul %103 %104 
					                        Output f32* %107 = OpAccessChain %78 %93 
					                                             OpStore %107 %105 
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
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					mediump float u_xlat16_5;
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
					    u_xlat16_3 = u_xlat16_0.x * vs_COLOR0.w;
					    u_xlat16_5 = u_xlat16_3 * u_xlat16_1 + -0.00100000005;
					    u_xlat16_3 = u_xlat16_1 * u_xlat16_3;
					    SV_Target0.w = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_5<0.0);
					#else
					    u_xlatb0 = u_xlat16_5<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_0.xyz;
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
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					mediump float u_xlat16_5;
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
					    u_xlat16_3 = u_xlat16_0.x * vs_COLOR0.w;
					    u_xlat16_5 = u_xlat16_3 * u_xlat16_1 + -0.00100000005;
					    u_xlat16_3 = u_xlat16_1 * u_xlat16_3;
					    SV_Target0.w = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_5<0.0);
					#else
					    u_xlatb0 = u_xlat16_5<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_0.xyz;
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
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					mediump float u_xlat16_5;
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
					    u_xlat16_3 = u_xlat16_0.x * vs_COLOR0.w;
					    u_xlat16_5 = u_xlat16_3 * u_xlat16_1 + -0.00100000005;
					    u_xlat16_3 = u_xlat16_1 * u_xlat16_3;
					    SV_Target0.w = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_5<0.0);
					#else
					    u_xlatb0 = u_xlat16_5<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD1.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_0.xyz;
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
					; Bound: 130
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %27 %67 %76 %91 %114 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpMemberDecorate %11 0 Offset 11 
					                                              OpDecorate %11 Block 
					                                              OpDecorate %13 DescriptorSet 13 
					                                              OpDecorate %13 Binding 13 
					                                              OpDecorate vs_TEXCOORD2 Location 27 
					                                              OpDecorate %44 RelaxedPrecision 
					                                              OpDecorate %55 RelaxedPrecision 
					                                              OpDecorate %58 RelaxedPrecision 
					                                              OpDecorate %58 DescriptorSet 58 
					                                              OpDecorate %58 Binding 58 
					                                              OpDecorate %59 RelaxedPrecision 
					                                              OpDecorate %62 RelaxedPrecision 
					                                              OpDecorate %62 DescriptorSet 62 
					                                              OpDecorate %62 Binding 62 
					                                              OpDecorate %63 RelaxedPrecision 
					                                              OpDecorate vs_TEXCOORD0 Location 67 
					                                              OpDecorate %71 RelaxedPrecision 
					                                              OpDecorate %73 RelaxedPrecision 
					                                              OpDecorate %75 RelaxedPrecision 
					                                              OpDecorate %76 RelaxedPrecision 
					                                              OpDecorate %76 Location 76 
					                                              OpDecorate %79 RelaxedPrecision 
					                                              OpDecorate %80 RelaxedPrecision 
					                                              OpDecorate %81 RelaxedPrecision 
					                                              OpDecorate %82 RelaxedPrecision 
					                                              OpDecorate %83 RelaxedPrecision 
					                                              OpDecorate %84 RelaxedPrecision 
					                                              OpDecorate %86 RelaxedPrecision 
					                                              OpDecorate %87 RelaxedPrecision 
					                                              OpDecorate %88 RelaxedPrecision 
					                                              OpDecorate %89 RelaxedPrecision 
					                                              OpDecorate %91 RelaxedPrecision 
					                                              OpDecorate %91 Location 91 
					                                              OpDecorate %92 RelaxedPrecision 
					                                              OpDecorate %98 RelaxedPrecision 
					                                              OpDecorate %109 RelaxedPrecision 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate %110 RelaxedPrecision 
					                                              OpDecorate %111 RelaxedPrecision 
					                                              OpDecorate %111 DescriptorSet 111 
					                                              OpDecorate %111 Binding 111 
					                                              OpDecorate %112 RelaxedPrecision 
					                                              OpDecorate vs_TEXCOORD1 Location 114 
					                                              OpDecorate %117 RelaxedPrecision 
					                                              OpDecorate %118 RelaxedPrecision 
					                                              OpDecorate %119 RelaxedPrecision 
					                                              OpDecorate %120 RelaxedPrecision 
					                                              OpDecorate %121 RelaxedPrecision 
					                                              OpDecorate %122 RelaxedPrecision 
					                                              OpDecorate %123 RelaxedPrecision 
					                                              OpDecorate %124 RelaxedPrecision 
					                                              OpDecorate %125 RelaxedPrecision 
					                                              OpDecorate %126 RelaxedPrecision 
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
					                                      %53 = OpTypeVector %6 3 
					                                      %54 = OpTypePointer Private %53 
					                       Private f32_3* %55 = OpVariable Private 
					                                      %56 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %57 = OpTypePointer UniformConstant %56 
					 UniformConstant read_only Texture2D* %58 = OpVariable UniformConstant 
					                                      %60 = OpTypeSampler 
					                                      %61 = OpTypePointer UniformConstant %60 
					             UniformConstant sampler* %62 = OpVariable UniformConstant 
					                                      %64 = OpTypeSampledImage %56 
					                                      %66 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  u32 %70 = OpConstant 3 
					                         Private f32* %73 = OpVariable Private 
					                         Input f32_4* %76 = OpVariable Input 
					                                      %77 = OpTypePointer Input %6 
					                         Private f32* %81 = OpVariable Private 
					                                  f32 %85 = OpConstant 3.674022E-40 
					                                      %90 = OpTypePointer Output %10 
					                        Output f32_4* %91 = OpVariable Output 
					                                      %93 = OpTypePointer Output %6 
					                                      %95 = OpTypeBool 
					                                      %96 = OpTypePointer Private %95 
					                        Private bool* %97 = OpVariable Private 
					                                 i32 %101 = OpConstant 1 
					                                 i32 %103 = OpConstant -1 
					UniformConstant read_only Texture2D* %109 = OpVariable UniformConstant 
					            UniformConstant sampler* %111 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %118 = OpVariable Private 
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
					                  read_only Texture2D %59 = OpLoad %58 
					                              sampler %63 = OpLoad %62 
					           read_only Texture2DSampled %65 = OpSampledImage %59 %63 
					                                f32_2 %68 = OpLoad vs_TEXCOORD0 
					                                f32_4 %69 = OpImageSampleImplicitLod %65 %68 
					                                  f32 %71 = OpCompositeExtract %69 3 
					                         Private f32* %72 = OpAccessChain %55 %49 
					                                              OpStore %72 %71 
					                         Private f32* %74 = OpAccessChain %55 %49 
					                                  f32 %75 = OpLoad %74 
					                           Input f32* %78 = OpAccessChain %76 %70 
					                                  f32 %79 = OpLoad %78 
					                                  f32 %80 = OpFMul %75 %79 
					                                              OpStore %73 %80 
					                                  f32 %82 = OpLoad %73 
					                                  f32 %83 = OpLoad %44 
					                                  f32 %84 = OpFMul %82 %83 
					                                  f32 %86 = OpFAdd %84 %85 
					                                              OpStore %81 %86 
					                                  f32 %87 = OpLoad %44 
					                                  f32 %88 = OpLoad %73 
					                                  f32 %89 = OpFMul %87 %88 
					                                              OpStore %73 %89 
					                                  f32 %92 = OpLoad %73 
					                          Output f32* %94 = OpAccessChain %91 %70 
					                                              OpStore %94 %92 
					                                  f32 %98 = OpLoad %81 
					                                 bool %99 = OpFOrdLessThan %98 %38 
					                                              OpStore %97 %99 
					                                bool %100 = OpLoad %97 
					                                 i32 %102 = OpSelect %100 %101 %15 
					                                 i32 %104 = OpIMul %102 %103 
					                                bool %105 = OpINotEqual %104 %15 
					                                              OpSelectionMerge %107 None 
					                                              OpBranchConditional %105 %106 %107 
					                                     %106 = OpLabel 
					                                              OpKill
					                                     %107 = OpLabel 
					                 read_only Texture2D %110 = OpLoad %109 
					                             sampler %112 = OpLoad %111 
					          read_only Texture2DSampled %113 = OpSampledImage %110 %112 
					                               f32_2 %115 = OpLoad vs_TEXCOORD1 
					                               f32_4 %116 = OpImageSampleImplicitLod %113 %115 
					                               f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
					                                              OpStore %55 %117 
					                               f32_3 %119 = OpLoad %55 
					                               f32_4 %120 = OpLoad %76 
					                               f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                               f32_3 %122 = OpFMul %119 %121 
					                                              OpStore %118 %122 
					                                 f32 %123 = OpLoad %44 
					                               f32_3 %124 = OpCompositeConstruct %123 %123 %123 
					                               f32_3 %125 = OpLoad %118 
					                               f32_3 %126 = OpFMul %124 %125 
					                               f32_4 %127 = OpLoad %91 
					                               f32_4 %128 = OpVectorShuffle %127 %126 4 5 6 3 
					                                              OpStore %91 %128 
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
					; Bound: 130
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %27 %67 %76 %91 %114 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpMemberDecorate %11 0 Offset 11 
					                                              OpDecorate %11 Block 
					                                              OpDecorate %13 DescriptorSet 13 
					                                              OpDecorate %13 Binding 13 
					                                              OpDecorate vs_TEXCOORD2 Location 27 
					                                              OpDecorate %44 RelaxedPrecision 
					                                              OpDecorate %55 RelaxedPrecision 
					                                              OpDecorate %58 RelaxedPrecision 
					                                              OpDecorate %58 DescriptorSet 58 
					                                              OpDecorate %58 Binding 58 
					                                              OpDecorate %59 RelaxedPrecision 
					                                              OpDecorate %62 RelaxedPrecision 
					                                              OpDecorate %62 DescriptorSet 62 
					                                              OpDecorate %62 Binding 62 
					                                              OpDecorate %63 RelaxedPrecision 
					                                              OpDecorate vs_TEXCOORD0 Location 67 
					                                              OpDecorate %71 RelaxedPrecision 
					                                              OpDecorate %73 RelaxedPrecision 
					                                              OpDecorate %75 RelaxedPrecision 
					                                              OpDecorate %76 RelaxedPrecision 
					                                              OpDecorate %76 Location 76 
					                                              OpDecorate %79 RelaxedPrecision 
					                                              OpDecorate %80 RelaxedPrecision 
					                                              OpDecorate %81 RelaxedPrecision 
					                                              OpDecorate %82 RelaxedPrecision 
					                                              OpDecorate %83 RelaxedPrecision 
					                                              OpDecorate %84 RelaxedPrecision 
					                                              OpDecorate %86 RelaxedPrecision 
					                                              OpDecorate %87 RelaxedPrecision 
					                                              OpDecorate %88 RelaxedPrecision 
					                                              OpDecorate %89 RelaxedPrecision 
					                                              OpDecorate %91 RelaxedPrecision 
					                                              OpDecorate %91 Location 91 
					                                              OpDecorate %92 RelaxedPrecision 
					                                              OpDecorate %98 RelaxedPrecision 
					                                              OpDecorate %109 RelaxedPrecision 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate %110 RelaxedPrecision 
					                                              OpDecorate %111 RelaxedPrecision 
					                                              OpDecorate %111 DescriptorSet 111 
					                                              OpDecorate %111 Binding 111 
					                                              OpDecorate %112 RelaxedPrecision 
					                                              OpDecorate vs_TEXCOORD1 Location 114 
					                                              OpDecorate %117 RelaxedPrecision 
					                                              OpDecorate %118 RelaxedPrecision 
					                                              OpDecorate %119 RelaxedPrecision 
					                                              OpDecorate %120 RelaxedPrecision 
					                                              OpDecorate %121 RelaxedPrecision 
					                                              OpDecorate %122 RelaxedPrecision 
					                                              OpDecorate %123 RelaxedPrecision 
					                                              OpDecorate %124 RelaxedPrecision 
					                                              OpDecorate %125 RelaxedPrecision 
					                                              OpDecorate %126 RelaxedPrecision 
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
					                                      %53 = OpTypeVector %6 3 
					                                      %54 = OpTypePointer Private %53 
					                       Private f32_3* %55 = OpVariable Private 
					                                      %56 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %57 = OpTypePointer UniformConstant %56 
					 UniformConstant read_only Texture2D* %58 = OpVariable UniformConstant 
					                                      %60 = OpTypeSampler 
					                                      %61 = OpTypePointer UniformConstant %60 
					             UniformConstant sampler* %62 = OpVariable UniformConstant 
					                                      %64 = OpTypeSampledImage %56 
					                                      %66 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  u32 %70 = OpConstant 3 
					                         Private f32* %73 = OpVariable Private 
					                         Input f32_4* %76 = OpVariable Input 
					                                      %77 = OpTypePointer Input %6 
					                         Private f32* %81 = OpVariable Private 
					                                  f32 %85 = OpConstant 3.674022E-40 
					                                      %90 = OpTypePointer Output %10 
					                        Output f32_4* %91 = OpVariable Output 
					                                      %93 = OpTypePointer Output %6 
					                                      %95 = OpTypeBool 
					                                      %96 = OpTypePointer Private %95 
					                        Private bool* %97 = OpVariable Private 
					                                 i32 %101 = OpConstant 1 
					                                 i32 %103 = OpConstant -1 
					UniformConstant read_only Texture2D* %109 = OpVariable UniformConstant 
					            UniformConstant sampler* %111 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %118 = OpVariable Private 
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
					                  read_only Texture2D %59 = OpLoad %58 
					                              sampler %63 = OpLoad %62 
					           read_only Texture2DSampled %65 = OpSampledImage %59 %63 
					                                f32_2 %68 = OpLoad vs_TEXCOORD0 
					                                f32_4 %69 = OpImageSampleImplicitLod %65 %68 
					                                  f32 %71 = OpCompositeExtract %69 3 
					                         Private f32* %72 = OpAccessChain %55 %49 
					                                              OpStore %72 %71 
					                         Private f32* %74 = OpAccessChain %55 %49 
					                                  f32 %75 = OpLoad %74 
					                           Input f32* %78 = OpAccessChain %76 %70 
					                                  f32 %79 = OpLoad %78 
					                                  f32 %80 = OpFMul %75 %79 
					                                              OpStore %73 %80 
					                                  f32 %82 = OpLoad %73 
					                                  f32 %83 = OpLoad %44 
					                                  f32 %84 = OpFMul %82 %83 
					                                  f32 %86 = OpFAdd %84 %85 
					                                              OpStore %81 %86 
					                                  f32 %87 = OpLoad %44 
					                                  f32 %88 = OpLoad %73 
					                                  f32 %89 = OpFMul %87 %88 
					                                              OpStore %73 %89 
					                                  f32 %92 = OpLoad %73 
					                          Output f32* %94 = OpAccessChain %91 %70 
					                                              OpStore %94 %92 
					                                  f32 %98 = OpLoad %81 
					                                 bool %99 = OpFOrdLessThan %98 %38 
					                                              OpStore %97 %99 
					                                bool %100 = OpLoad %97 
					                                 i32 %102 = OpSelect %100 %101 %15 
					                                 i32 %104 = OpIMul %102 %103 
					                                bool %105 = OpINotEqual %104 %15 
					                                              OpSelectionMerge %107 None 
					                                              OpBranchConditional %105 %106 %107 
					                                     %106 = OpLabel 
					                                              OpKill
					                                     %107 = OpLabel 
					                 read_only Texture2D %110 = OpLoad %109 
					                             sampler %112 = OpLoad %111 
					          read_only Texture2DSampled %113 = OpSampledImage %110 %112 
					                               f32_2 %115 = OpLoad vs_TEXCOORD1 
					                               f32_4 %116 = OpImageSampleImplicitLod %113 %115 
					                               f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
					                                              OpStore %55 %117 
					                               f32_3 %119 = OpLoad %55 
					                               f32_4 %120 = OpLoad %76 
					                               f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                               f32_3 %122 = OpFMul %119 %121 
					                                              OpStore %118 %122 
					                                 f32 %123 = OpLoad %44 
					                               f32_3 %124 = OpCompositeConstruct %123 %123 %123 
					                               f32_3 %125 = OpLoad %118 
					                               f32_3 %126 = OpFMul %124 %125 
					                               f32_4 %127 = OpLoad %91 
					                               f32_4 %128 = OpVectorShuffle %127 %126 4 5 6 3 
					                                              OpStore %91 %128 
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
					; Bound: 130
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Fragment %4 "main" %27 %67 %76 %91 %114 
					                                              OpExecutionMode %4 OriginUpperLeft 
					                                              OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                              OpMemberDecorate %11 0 Offset 11 
					                                              OpDecorate %11 Block 
					                                              OpDecorate %13 DescriptorSet 13 
					                                              OpDecorate %13 Binding 13 
					                                              OpDecorate vs_TEXCOORD2 Location 27 
					                                              OpDecorate %44 RelaxedPrecision 
					                                              OpDecorate %55 RelaxedPrecision 
					                                              OpDecorate %58 RelaxedPrecision 
					                                              OpDecorate %58 DescriptorSet 58 
					                                              OpDecorate %58 Binding 58 
					                                              OpDecorate %59 RelaxedPrecision 
					                                              OpDecorate %62 RelaxedPrecision 
					                                              OpDecorate %62 DescriptorSet 62 
					                                              OpDecorate %62 Binding 62 
					                                              OpDecorate %63 RelaxedPrecision 
					                                              OpDecorate vs_TEXCOORD0 Location 67 
					                                              OpDecorate %71 RelaxedPrecision 
					                                              OpDecorate %73 RelaxedPrecision 
					                                              OpDecorate %75 RelaxedPrecision 
					                                              OpDecorate %76 RelaxedPrecision 
					                                              OpDecorate %76 Location 76 
					                                              OpDecorate %79 RelaxedPrecision 
					                                              OpDecorate %80 RelaxedPrecision 
					                                              OpDecorate %81 RelaxedPrecision 
					                                              OpDecorate %82 RelaxedPrecision 
					                                              OpDecorate %83 RelaxedPrecision 
					                                              OpDecorate %84 RelaxedPrecision 
					                                              OpDecorate %86 RelaxedPrecision 
					                                              OpDecorate %87 RelaxedPrecision 
					                                              OpDecorate %88 RelaxedPrecision 
					                                              OpDecorate %89 RelaxedPrecision 
					                                              OpDecorate %91 RelaxedPrecision 
					                                              OpDecorate %91 Location 91 
					                                              OpDecorate %92 RelaxedPrecision 
					                                              OpDecorate %98 RelaxedPrecision 
					                                              OpDecorate %109 RelaxedPrecision 
					                                              OpDecorate %109 DescriptorSet 109 
					                                              OpDecorate %109 Binding 109 
					                                              OpDecorate %110 RelaxedPrecision 
					                                              OpDecorate %111 RelaxedPrecision 
					                                              OpDecorate %111 DescriptorSet 111 
					                                              OpDecorate %111 Binding 111 
					                                              OpDecorate %112 RelaxedPrecision 
					                                              OpDecorate vs_TEXCOORD1 Location 114 
					                                              OpDecorate %117 RelaxedPrecision 
					                                              OpDecorate %118 RelaxedPrecision 
					                                              OpDecorate %119 RelaxedPrecision 
					                                              OpDecorate %120 RelaxedPrecision 
					                                              OpDecorate %121 RelaxedPrecision 
					                                              OpDecorate %122 RelaxedPrecision 
					                                              OpDecorate %123 RelaxedPrecision 
					                                              OpDecorate %124 RelaxedPrecision 
					                                              OpDecorate %125 RelaxedPrecision 
					                                              OpDecorate %126 RelaxedPrecision 
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
					                                      %53 = OpTypeVector %6 3 
					                                      %54 = OpTypePointer Private %53 
					                       Private f32_3* %55 = OpVariable Private 
					                                      %56 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                      %57 = OpTypePointer UniformConstant %56 
					 UniformConstant read_only Texture2D* %58 = OpVariable UniformConstant 
					                                      %60 = OpTypeSampler 
					                                      %61 = OpTypePointer UniformConstant %60 
					             UniformConstant sampler* %62 = OpVariable UniformConstant 
					                                      %64 = OpTypeSampledImage %56 
					                                      %66 = OpTypePointer Input %7 
					                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                  u32 %70 = OpConstant 3 
					                         Private f32* %73 = OpVariable Private 
					                         Input f32_4* %76 = OpVariable Input 
					                                      %77 = OpTypePointer Input %6 
					                         Private f32* %81 = OpVariable Private 
					                                  f32 %85 = OpConstant 3.674022E-40 
					                                      %90 = OpTypePointer Output %10 
					                        Output f32_4* %91 = OpVariable Output 
					                                      %93 = OpTypePointer Output %6 
					                                      %95 = OpTypeBool 
					                                      %96 = OpTypePointer Private %95 
					                        Private bool* %97 = OpVariable Private 
					                                 i32 %101 = OpConstant 1 
					                                 i32 %103 = OpConstant -1 
					UniformConstant read_only Texture2D* %109 = OpVariable UniformConstant 
					            UniformConstant sampler* %111 = OpVariable UniformConstant 
					                Input f32_2* vs_TEXCOORD1 = OpVariable Input 
					                      Private f32_3* %118 = OpVariable Private 
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
					                  read_only Texture2D %59 = OpLoad %58 
					                              sampler %63 = OpLoad %62 
					           read_only Texture2DSampled %65 = OpSampledImage %59 %63 
					                                f32_2 %68 = OpLoad vs_TEXCOORD0 
					                                f32_4 %69 = OpImageSampleImplicitLod %65 %68 
					                                  f32 %71 = OpCompositeExtract %69 3 
					                         Private f32* %72 = OpAccessChain %55 %49 
					                                              OpStore %72 %71 
					                         Private f32* %74 = OpAccessChain %55 %49 
					                                  f32 %75 = OpLoad %74 
					                           Input f32* %78 = OpAccessChain %76 %70 
					                                  f32 %79 = OpLoad %78 
					                                  f32 %80 = OpFMul %75 %79 
					                                              OpStore %73 %80 
					                                  f32 %82 = OpLoad %73 
					                                  f32 %83 = OpLoad %44 
					                                  f32 %84 = OpFMul %82 %83 
					                                  f32 %86 = OpFAdd %84 %85 
					                                              OpStore %81 %86 
					                                  f32 %87 = OpLoad %44 
					                                  f32 %88 = OpLoad %73 
					                                  f32 %89 = OpFMul %87 %88 
					                                              OpStore %73 %89 
					                                  f32 %92 = OpLoad %73 
					                          Output f32* %94 = OpAccessChain %91 %70 
					                                              OpStore %94 %92 
					                                  f32 %98 = OpLoad %81 
					                                 bool %99 = OpFOrdLessThan %98 %38 
					                                              OpStore %97 %99 
					                                bool %100 = OpLoad %97 
					                                 i32 %102 = OpSelect %100 %101 %15 
					                                 i32 %104 = OpIMul %102 %103 
					                                bool %105 = OpINotEqual %104 %15 
					                                              OpSelectionMerge %107 None 
					                                              OpBranchConditional %105 %106 %107 
					                                     %106 = OpLabel 
					                                              OpKill
					                                     %107 = OpLabel 
					                 read_only Texture2D %110 = OpLoad %109 
					                             sampler %112 = OpLoad %111 
					          read_only Texture2DSampled %113 = OpSampledImage %110 %112 
					                               f32_2 %115 = OpLoad vs_TEXCOORD1 
					                               f32_4 %116 = OpImageSampleImplicitLod %113 %115 
					                               f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
					                                              OpStore %55 %117 
					                               f32_3 %119 = OpLoad %55 
					                               f32_4 %120 = OpLoad %76 
					                               f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
					                               f32_3 %122 = OpFMul %119 %121 
					                                              OpStore %118 %122 
					                                 f32 %123 = OpLoad %44 
					                               f32_3 %124 = OpCompositeConstruct %123 %123 %123 
					                               f32_3 %125 = OpLoad %118 
					                               f32_3 %126 = OpFMul %124 %125 
					                               f32_4 %127 = OpLoad %91 
					                               f32_4 %128 = OpVectorShuffle %127 %126 4 5 6 3 
					                                              OpStore %91 %128 
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