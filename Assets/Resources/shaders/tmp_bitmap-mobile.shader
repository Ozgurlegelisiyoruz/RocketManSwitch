Shader "TextMeshPro/Mobile/Bitmap" {
	Properties {
		_MainTex ("Font Atlas", 2D) = "white" {}
		_Color ("Text Color", Vector) = (1,1,1,1)
		_DiffusePower ("Diffuse Power", Range(1, 4)) = 1
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
			GpuProgramID 62068
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					    SV_Target0.xyz = vs_COLOR0.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
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
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %37 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %31 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %37 Location 37 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %30 = OpTypePointer Input %23 
					                        Input f32_4* %31 = OpVariable Input 
					                                     %32 = OpTypePointer Input %6 
					                                     %36 = OpTypePointer Output %23 
					                       Output f32_4* %37 = OpVariable Output 
					                                     %39 = OpTypePointer Output %6 
					                                     %41 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %29 = OpLoad %8 
					                          Input f32* %33 = OpAccessChain %31 %26 
					                                 f32 %34 = OpLoad %33 
					                                 f32 %35 = OpFMul %29 %34 
					                                             OpStore %28 %35 
					                                 f32 %38 = OpLoad %28 
					                         Output f32* %40 = OpAccessChain %37 %26 
					                                             OpStore %40 %38 
					                               f32_4 %42 = OpLoad %31 
					                               f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
					                               f32_4 %44 = OpLoad %37 
					                               f32_4 %45 = OpVectorShuffle %44 %43 4 5 6 3 
					                                             OpStore %37 %45 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
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
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %37 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %31 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %37 Location 37 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %30 = OpTypePointer Input %23 
					                        Input f32_4* %31 = OpVariable Input 
					                                     %32 = OpTypePointer Input %6 
					                                     %36 = OpTypePointer Output %23 
					                       Output f32_4* %37 = OpVariable Output 
					                                     %39 = OpTypePointer Output %6 
					                                     %41 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %29 = OpLoad %8 
					                          Input f32* %33 = OpAccessChain %31 %26 
					                                 f32 %34 = OpLoad %33 
					                                 f32 %35 = OpFMul %29 %34 
					                                             OpStore %28 %35 
					                                 f32 %38 = OpLoad %28 
					                         Output f32* %40 = OpAccessChain %37 %26 
					                                             OpStore %40 %38 
					                               f32_4 %42 = OpLoad %31 
					                               f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
					                               f32_4 %44 = OpLoad %37 
					                               f32_4 %45 = OpVectorShuffle %44 %43 4 5 6 3 
					                                             OpStore %37 %45 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
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
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %37 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %31 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %37 Location 37 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %30 = OpTypePointer Input %23 
					                        Input f32_4* %31 = OpVariable Input 
					                                     %32 = OpTypePointer Input %6 
					                                     %36 = OpTypePointer Output %23 
					                       Output f32_4* %37 = OpVariable Output 
					                                     %39 = OpTypePointer Output %6 
					                                     %41 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %29 = OpLoad %8 
					                          Input f32* %33 = OpAccessChain %31 %26 
					                                 f32 %34 = OpLoad %33 
					                                 f32 %35 = OpFMul %29 %34 
					                                             OpStore %28 %35 
					                                 f32 %38 = OpLoad %28 
					                         Output f32* %40 = OpAccessChain %37 %26 
					                                             OpStore %40 %38 
					                               f32_4 %42 = OpLoad %31 
					                               f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
					                               f32_4 %44 = OpLoad %37 
					                               f32_4 %45 = OpVectorShuffle %44 %43 4 5 6 3 
					                                             OpStore %37 %45 
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0 + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb0 = u_xlat16_1<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0 + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb0 = u_xlat16_1<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = vs_COLOR0.w * u_xlat16_0 + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb0 = u_xlat16_1<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 71
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %30 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %44 Location 44 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %66 RelaxedPrecision 
					                                             OpDecorate %67 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %29 = OpTypePointer Input %23 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %31 = OpTypePointer Input %6 
					                                 f32 %36 = OpConstant 3.674022E-40 
					                        Private f32* %38 = OpVariable Private 
					                                     %43 = OpTypePointer Output %23 
					                       Output f32_4* %44 = OpVariable Output 
					                                     %46 = OpTypePointer Output %6 
					                                     %48 = OpTypeBool 
					                                     %49 = OpTypePointer Private %48 
					                       Private bool* %50 = OpVariable Private 
					                                 f32 %52 = OpConstant 3.674022E-40 
					                                     %55 = OpTypeInt 32 1 
					                                 i32 %56 = OpConstant 0 
					                                 i32 %57 = OpConstant 1 
					                                 i32 %59 = OpConstant -1 
					                                     %65 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                          Input f32* %32 = OpAccessChain %30 %26 
					                                 f32 %33 = OpLoad %32 
					                                 f32 %34 = OpLoad %8 
					                                 f32 %35 = OpFMul %33 %34 
					                                 f32 %37 = OpFAdd %35 %36 
					                                             OpStore %28 %37 
					                                 f32 %39 = OpLoad %8 
					                          Input f32* %40 = OpAccessChain %30 %26 
					                                 f32 %41 = OpLoad %40 
					                                 f32 %42 = OpFMul %39 %41 
					                                             OpStore %38 %42 
					                                 f32 %45 = OpLoad %38 
					                         Output f32* %47 = OpAccessChain %44 %26 
					                                             OpStore %47 %45 
					                                 f32 %51 = OpLoad %28 
					                                bool %53 = OpFOrdLessThan %51 %52 
					                                             OpStore %50 %53 
					                                bool %54 = OpLoad %50 
					                                 i32 %58 = OpSelect %54 %57 %56 
					                                 i32 %60 = OpIMul %58 %59 
					                                bool %61 = OpINotEqual %60 %56 
					                                             OpSelectionMerge %63 None 
					                                             OpBranchConditional %61 %62 %63 
					                                     %62 = OpLabel 
					                                             OpKill
					                                     %63 = OpLabel 
					                               f32_4 %66 = OpLoad %30 
					                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
					                               f32_4 %68 = OpLoad %44 
					                               f32_4 %69 = OpVectorShuffle %68 %67 4 5 6 3 
					                                             OpStore %44 %69 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 71
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %30 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %44 Location 44 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %66 RelaxedPrecision 
					                                             OpDecorate %67 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %29 = OpTypePointer Input %23 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %31 = OpTypePointer Input %6 
					                                 f32 %36 = OpConstant 3.674022E-40 
					                        Private f32* %38 = OpVariable Private 
					                                     %43 = OpTypePointer Output %23 
					                       Output f32_4* %44 = OpVariable Output 
					                                     %46 = OpTypePointer Output %6 
					                                     %48 = OpTypeBool 
					                                     %49 = OpTypePointer Private %48 
					                       Private bool* %50 = OpVariable Private 
					                                 f32 %52 = OpConstant 3.674022E-40 
					                                     %55 = OpTypeInt 32 1 
					                                 i32 %56 = OpConstant 0 
					                                 i32 %57 = OpConstant 1 
					                                 i32 %59 = OpConstant -1 
					                                     %65 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                          Input f32* %32 = OpAccessChain %30 %26 
					                                 f32 %33 = OpLoad %32 
					                                 f32 %34 = OpLoad %8 
					                                 f32 %35 = OpFMul %33 %34 
					                                 f32 %37 = OpFAdd %35 %36 
					                                             OpStore %28 %37 
					                                 f32 %39 = OpLoad %8 
					                          Input f32* %40 = OpAccessChain %30 %26 
					                                 f32 %41 = OpLoad %40 
					                                 f32 %42 = OpFMul %39 %41 
					                                             OpStore %38 %42 
					                                 f32 %45 = OpLoad %38 
					                         Output f32* %47 = OpAccessChain %44 %26 
					                                             OpStore %47 %45 
					                                 f32 %51 = OpLoad %28 
					                                bool %53 = OpFOrdLessThan %51 %52 
					                                             OpStore %50 %53 
					                                bool %54 = OpLoad %50 
					                                 i32 %58 = OpSelect %54 %57 %56 
					                                 i32 %60 = OpIMul %58 %59 
					                                bool %61 = OpINotEqual %60 %56 
					                                             OpSelectionMerge %63 None 
					                                             OpBranchConditional %61 %62 %63 
					                                     %62 = OpLabel 
					                                             OpKill
					                                     %63 = OpLabel 
					                               f32_4 %66 = OpLoad %30 
					                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
					                               f32_4 %68 = OpLoad %44 
					                               f32_4 %69 = OpVectorShuffle %68 %67 4 5 6 3 
					                                             OpStore %44 %69 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 71
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %30 %44 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpDecorate %30 Location 30 
					                                             OpDecorate %33 RelaxedPrecision 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpDecorate %37 RelaxedPrecision 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %41 RelaxedPrecision 
					                                             OpDecorate %42 RelaxedPrecision 
					                                             OpDecorate %44 RelaxedPrecision 
					                                             OpDecorate %44 Location 44 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %51 RelaxedPrecision 
					                                             OpDecorate %66 RelaxedPrecision 
					                                             OpDecorate %67 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %29 = OpTypePointer Input %23 
					                        Input f32_4* %30 = OpVariable Input 
					                                     %31 = OpTypePointer Input %6 
					                                 f32 %36 = OpConstant 3.674022E-40 
					                        Private f32* %38 = OpVariable Private 
					                                     %43 = OpTypePointer Output %23 
					                       Output f32_4* %44 = OpVariable Output 
					                                     %46 = OpTypePointer Output %6 
					                                     %48 = OpTypeBool 
					                                     %49 = OpTypePointer Private %48 
					                       Private bool* %50 = OpVariable Private 
					                                 f32 %52 = OpConstant 3.674022E-40 
					                                     %55 = OpTypeInt 32 1 
					                                 i32 %56 = OpConstant 0 
					                                 i32 %57 = OpConstant 1 
					                                 i32 %59 = OpConstant -1 
					                                     %65 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                          Input f32* %32 = OpAccessChain %30 %26 
					                                 f32 %33 = OpLoad %32 
					                                 f32 %34 = OpLoad %8 
					                                 f32 %35 = OpFMul %33 %34 
					                                 f32 %37 = OpFAdd %35 %36 
					                                             OpStore %28 %37 
					                                 f32 %39 = OpLoad %8 
					                          Input f32* %40 = OpAccessChain %30 %26 
					                                 f32 %41 = OpLoad %40 
					                                 f32 %42 = OpFMul %39 %41 
					                                             OpStore %38 %42 
					                                 f32 %45 = OpLoad %38 
					                         Output f32* %47 = OpAccessChain %44 %26 
					                                             OpStore %47 %45 
					                                 f32 %51 = OpLoad %28 
					                                bool %53 = OpFOrdLessThan %51 %52 
					                                             OpStore %50 %53 
					                                bool %54 = OpLoad %50 
					                                 i32 %58 = OpSelect %54 %57 %56 
					                                 i32 %60 = OpIMul %58 %59 
					                                bool %61 = OpINotEqual %60 %56 
					                                             OpSelectionMerge %63 None 
					                                             OpBranchConditional %61 %62 %63 
					                                     %62 = OpLabel 
					                                             OpKill
					                                     %63 = OpLabel 
					                               f32_4 %66 = OpLoad %30 
					                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
					                               f32_4 %68 = OpLoad %44 
					                               f32_4 %69 = OpVectorShuffle %68 %67 4 5 6 3 
					                                             OpStore %44 %69 
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    u_xlat2.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat2.xy = u_xlat2.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
					#else
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat2.y * u_xlat2.x;
					    SV_Target0.w = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    u_xlat2.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat2.xy = u_xlat2.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
					#else
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat2.y * u_xlat2.x;
					    SV_Target0.w = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    u_xlat2.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat2.xy = u_xlat2.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.zw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
					#else
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					#endif
					    u_xlat16_1 = u_xlat2.y * u_xlat2.x;
					    SV_Target0.w = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
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
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
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
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %53 %78 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %31 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpMemberDecorate %38 0 Offset 38 
					                                             OpDecorate %38 Block 
					                                             OpDecorate %40 DescriptorSet 40 
					                                             OpDecorate %40 Binding 40 
					                                             OpDecorate vs_TEXCOORD2 Location 53 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %78 Location 78 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %30 = OpTypePointer Input %23 
					                        Input f32_4* %31 = OpVariable Input 
					                                     %32 = OpTypePointer Input %6 
					                                     %36 = OpTypePointer Private %19 
					                      Private f32_2* %37 = OpVariable Private 
					                                     %38 = OpTypeStruct %23 
					                                     %39 = OpTypePointer Uniform %38 
					            Uniform struct {f32_4;}* %40 = OpVariable Uniform 
					                                     %41 = OpTypeInt 32 1 
					                                 i32 %42 = OpConstant 0 
					                                     %43 = OpTypePointer Uniform %23 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %64 = OpConstant 3.674022E-40 
					                                 f32 %65 = OpConstant 3.674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 u32 %70 = OpConstant 1 
					                                 u32 %73 = OpConstant 0 
					                                     %77 = OpTypePointer Output %23 
					                       Output f32_4* %78 = OpVariable Output 
					                                     %82 = OpTypePointer Output %6 
					                                     %85 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %29 = OpLoad %8 
					                          Input f32* %33 = OpAccessChain %31 %26 
					                                 f32 %34 = OpLoad %33 
					                                 f32 %35 = OpFMul %29 %34 
					                                             OpStore %28 %35 
					                      Uniform f32_4* %44 = OpAccessChain %40 %42 
					                               f32_4 %45 = OpLoad %44 
					                               f32_2 %46 = OpVectorShuffle %45 %45 0 1 
					                               f32_2 %47 = OpFNegate %46 
					                      Uniform f32_4* %48 = OpAccessChain %40 %42 
					                               f32_4 %49 = OpLoad %48 
					                               f32_2 %50 = OpVectorShuffle %49 %49 2 3 
					                               f32_2 %51 = OpFAdd %47 %50 
					                                             OpStore %37 %51 
					                               f32_2 %52 = OpLoad %37 
					                               f32_4 %54 = OpLoad vs_TEXCOORD2 
					                               f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                               f32_2 %56 = OpExtInst %1 4 %55 
					                               f32_2 %57 = OpFNegate %56 
					                               f32_2 %58 = OpFAdd %52 %57 
					                                             OpStore %37 %58 
					                               f32_2 %59 = OpLoad %37 
					                               f32_4 %60 = OpLoad vs_TEXCOORD2 
					                               f32_2 %61 = OpVectorShuffle %60 %60 2 3 
					                               f32_2 %62 = OpFMul %59 %61 
					                                             OpStore %37 %62 
					                               f32_2 %63 = OpLoad %37 
					                               f32_2 %66 = OpCompositeConstruct %64 %64 
					                               f32_2 %67 = OpCompositeConstruct %65 %65 
					                               f32_2 %68 = OpExtInst %1 43 %63 %66 %67 
					                                             OpStore %37 %68 
					                        Private f32* %71 = OpAccessChain %37 %70 
					                                 f32 %72 = OpLoad %71 
					                        Private f32* %74 = OpAccessChain %37 %73 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %72 %75 
					                                             OpStore %69 %76 
					                                 f32 %79 = OpLoad %28 
					                                 f32 %80 = OpLoad %69 
					                                 f32 %81 = OpFMul %79 %80 
					                         Output f32* %83 = OpAccessChain %78 %26 
					                                             OpStore %83 %81 
					                                 f32 %84 = OpLoad %69 
					                               f32_3 %86 = OpCompositeConstruct %84 %84 %84 
					                               f32_4 %87 = OpLoad %31 
					                               f32_3 %88 = OpVectorShuffle %87 %87 0 1 2 
					                               f32_3 %89 = OpFMul %86 %88 
					                               f32_4 %90 = OpLoad %78 
					                               f32_4 %91 = OpVectorShuffle %90 %89 4 5 6 3 
					                                             OpStore %78 %91 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
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
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %53 %78 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %31 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpMemberDecorate %38 0 Offset 38 
					                                             OpDecorate %38 Block 
					                                             OpDecorate %40 DescriptorSet 40 
					                                             OpDecorate %40 Binding 40 
					                                             OpDecorate vs_TEXCOORD2 Location 53 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %78 Location 78 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %30 = OpTypePointer Input %23 
					                        Input f32_4* %31 = OpVariable Input 
					                                     %32 = OpTypePointer Input %6 
					                                     %36 = OpTypePointer Private %19 
					                      Private f32_2* %37 = OpVariable Private 
					                                     %38 = OpTypeStruct %23 
					                                     %39 = OpTypePointer Uniform %38 
					            Uniform struct {f32_4;}* %40 = OpVariable Uniform 
					                                     %41 = OpTypeInt 32 1 
					                                 i32 %42 = OpConstant 0 
					                                     %43 = OpTypePointer Uniform %23 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %64 = OpConstant 3.674022E-40 
					                                 f32 %65 = OpConstant 3.674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 u32 %70 = OpConstant 1 
					                                 u32 %73 = OpConstant 0 
					                                     %77 = OpTypePointer Output %23 
					                       Output f32_4* %78 = OpVariable Output 
					                                     %82 = OpTypePointer Output %6 
					                                     %85 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %29 = OpLoad %8 
					                          Input f32* %33 = OpAccessChain %31 %26 
					                                 f32 %34 = OpLoad %33 
					                                 f32 %35 = OpFMul %29 %34 
					                                             OpStore %28 %35 
					                      Uniform f32_4* %44 = OpAccessChain %40 %42 
					                               f32_4 %45 = OpLoad %44 
					                               f32_2 %46 = OpVectorShuffle %45 %45 0 1 
					                               f32_2 %47 = OpFNegate %46 
					                      Uniform f32_4* %48 = OpAccessChain %40 %42 
					                               f32_4 %49 = OpLoad %48 
					                               f32_2 %50 = OpVectorShuffle %49 %49 2 3 
					                               f32_2 %51 = OpFAdd %47 %50 
					                                             OpStore %37 %51 
					                               f32_2 %52 = OpLoad %37 
					                               f32_4 %54 = OpLoad vs_TEXCOORD2 
					                               f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                               f32_2 %56 = OpExtInst %1 4 %55 
					                               f32_2 %57 = OpFNegate %56 
					                               f32_2 %58 = OpFAdd %52 %57 
					                                             OpStore %37 %58 
					                               f32_2 %59 = OpLoad %37 
					                               f32_4 %60 = OpLoad vs_TEXCOORD2 
					                               f32_2 %61 = OpVectorShuffle %60 %60 2 3 
					                               f32_2 %62 = OpFMul %59 %61 
					                                             OpStore %37 %62 
					                               f32_2 %63 = OpLoad %37 
					                               f32_2 %66 = OpCompositeConstruct %64 %64 
					                               f32_2 %67 = OpCompositeConstruct %65 %65 
					                               f32_2 %68 = OpExtInst %1 43 %63 %66 %67 
					                                             OpStore %37 %68 
					                        Private f32* %71 = OpAccessChain %37 %70 
					                                 f32 %72 = OpLoad %71 
					                        Private f32* %74 = OpAccessChain %37 %73 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %72 %75 
					                                             OpStore %69 %76 
					                                 f32 %79 = OpLoad %28 
					                                 f32 %80 = OpLoad %69 
					                                 f32 %81 = OpFMul %79 %80 
					                         Output f32* %83 = OpAccessChain %78 %26 
					                                             OpStore %83 %81 
					                                 f32 %84 = OpLoad %69 
					                               f32_3 %86 = OpCompositeConstruct %84 %84 %84 
					                               f32_4 %87 = OpLoad %31 
					                               f32_3 %88 = OpVectorShuffle %87 %87 0 1 2 
					                               f32_3 %89 = OpFMul %86 %88 
					                               f32_4 %90 = OpLoad %78 
					                               f32_4 %91 = OpVectorShuffle %90 %89 4 5 6 3 
					                                             OpStore %78 %91 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
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
					                                             OpEntryPoint Fragment %4 "main" %21 %31 %53 %78 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %28 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %31 RelaxedPrecision 
					                                             OpDecorate %31 Location 31 
					                                             OpDecorate %34 RelaxedPrecision 
					                                             OpDecorate %35 RelaxedPrecision 
					                                             OpMemberDecorate %38 0 Offset 38 
					                                             OpDecorate %38 Block 
					                                             OpDecorate %40 DescriptorSet 40 
					                                             OpDecorate %40 Binding 40 
					                                             OpDecorate vs_TEXCOORD2 Location 53 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %78 Location 78 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %81 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %87 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %89 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                        Private f32* %28 = OpVariable Private 
					                                     %30 = OpTypePointer Input %23 
					                        Input f32_4* %31 = OpVariable Input 
					                                     %32 = OpTypePointer Input %6 
					                                     %36 = OpTypePointer Private %19 
					                      Private f32_2* %37 = OpVariable Private 
					                                     %38 = OpTypeStruct %23 
					                                     %39 = OpTypePointer Uniform %38 
					            Uniform struct {f32_4;}* %40 = OpVariable Uniform 
					                                     %41 = OpTypeInt 32 1 
					                                 i32 %42 = OpConstant 0 
					                                     %43 = OpTypePointer Uniform %23 
					               Input f32_4* vs_TEXCOORD2 = OpVariable Input 
					                                 f32 %64 = OpConstant 3.674022E-40 
					                                 f32 %65 = OpConstant 3.674022E-40 
					                        Private f32* %69 = OpVariable Private 
					                                 u32 %70 = OpConstant 1 
					                                 u32 %73 = OpConstant 0 
					                                     %77 = OpTypePointer Output %23 
					                       Output f32_4* %78 = OpVariable Output 
					                                     %82 = OpTypePointer Output %6 
					                                     %85 = OpTypeVector %6 3 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %29 = OpLoad %8 
					                          Input f32* %33 = OpAccessChain %31 %26 
					                                 f32 %34 = OpLoad %33 
					                                 f32 %35 = OpFMul %29 %34 
					                                             OpStore %28 %35 
					                      Uniform f32_4* %44 = OpAccessChain %40 %42 
					                               f32_4 %45 = OpLoad %44 
					                               f32_2 %46 = OpVectorShuffle %45 %45 0 1 
					                               f32_2 %47 = OpFNegate %46 
					                      Uniform f32_4* %48 = OpAccessChain %40 %42 
					                               f32_4 %49 = OpLoad %48 
					                               f32_2 %50 = OpVectorShuffle %49 %49 2 3 
					                               f32_2 %51 = OpFAdd %47 %50 
					                                             OpStore %37 %51 
					                               f32_2 %52 = OpLoad %37 
					                               f32_4 %54 = OpLoad vs_TEXCOORD2 
					                               f32_2 %55 = OpVectorShuffle %54 %54 0 1 
					                               f32_2 %56 = OpExtInst %1 4 %55 
					                               f32_2 %57 = OpFNegate %56 
					                               f32_2 %58 = OpFAdd %52 %57 
					                                             OpStore %37 %58 
					                               f32_2 %59 = OpLoad %37 
					                               f32_4 %60 = OpLoad vs_TEXCOORD2 
					                               f32_2 %61 = OpVectorShuffle %60 %60 2 3 
					                               f32_2 %62 = OpFMul %59 %61 
					                                             OpStore %37 %62 
					                               f32_2 %63 = OpLoad %37 
					                               f32_2 %66 = OpCompositeConstruct %64 %64 
					                               f32_2 %67 = OpCompositeConstruct %65 %65 
					                               f32_2 %68 = OpExtInst %1 43 %63 %66 %67 
					                                             OpStore %37 %68 
					                        Private f32* %71 = OpAccessChain %37 %70 
					                                 f32 %72 = OpLoad %71 
					                        Private f32* %74 = OpAccessChain %37 %73 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %72 %75 
					                                             OpStore %69 %76 
					                                 f32 %79 = OpLoad %28 
					                                 f32 %80 = OpLoad %69 
					                                 f32 %81 = OpFMul %79 %80 
					                         Output f32* %83 = OpAccessChain %78 %26 
					                                             OpStore %83 %81 
					                                 f32 %84 = OpLoad %69 
					                               f32_3 %86 = OpCompositeConstruct %84 %84 %84 
					                               f32_4 %87 = OpLoad %31 
					                               f32_3 %88 = OpVectorShuffle %87 %87 0 1 2 
					                               f32_3 %89 = OpFMul %86 %88 
					                               f32_4 %90 = OpLoad %78 
					                               f32_4 %91 = OpVectorShuffle %90 %89 4 5 6 3 
					                                             OpStore %78 %91 
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump float u_xlat16_0;
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
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    u_xlat16_3 = u_xlat16_0 * u_xlat16_1 + -0.00100000005;
					    u_xlat16_5 = u_xlat16_1 * u_xlat16_0;
					    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
					    SV_Target0.w = u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb0 = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump float u_xlat16_0;
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
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    u_xlat16_3 = u_xlat16_0 * u_xlat16_1 + -0.00100000005;
					    u_xlat16_5 = u_xlat16_1 * u_xlat16_0;
					    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
					    SV_Target0.w = u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb0 = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	float _DiffusePower;
					uniform 	float _VertexOffsetX;
					uniform 	float _VertexOffsetY;
					uniform 	vec4 _ClipRect;
					uniform 	float _MaskSoftnessX;
					uniform 	float _MaskSoftnessY;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD2;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
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
					    u_xlat6.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat1.ww;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat6.xy;
					    u_xlat16_1 = in_COLOR0 * _Color;
					    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_DiffusePower);
					    vs_COLOR0.w = u_xlat16_1.w;
					    vs_COLOR0.xyz = u_xlat2.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat1 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat1 = min(u_xlat1, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat1.xy);
					    vs_TEXCOORD2.xy = (-u_xlat1.zw) + u_xlat0.xy;
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
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump float u_xlat16_0;
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
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.w;
					    u_xlat16_3 = u_xlat16_0 * u_xlat16_1 + -0.00100000005;
					    u_xlat16_5 = u_xlat16_1 * u_xlat16_0;
					    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
					    SV_Target0.w = u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb0 = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
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
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 115
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %65 %72 %88 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
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
					                                             OpDecorate vs_TEXCOORD0 Location 65 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate %72 RelaxedPrecision 
					                                             OpDecorate %72 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %83 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %88 Location 88 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %103 RelaxedPrecision 
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
					                                     %64 = OpTypePointer Input %7 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					                        Input f32_4* %72 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                        Private f32* %77 = OpVariable Private 
					                                 f32 %81 = OpConstant 3.674022E-40 
					                        Private f32* %83 = OpVariable Private 
					                                     %87 = OpTypePointer Output %10 
					                       Output f32_4* %88 = OpVariable Output 
					                                     %90 = OpTypeVector %6 3 
					                                     %98 = OpTypePointer Output %6 
					                                    %100 = OpTypeBool 
					                                    %101 = OpTypePointer Private %100 
					                      Private bool* %102 = OpVariable Private 
					                                i32 %106 = OpConstant 1 
					                                i32 %108 = OpConstant -1 
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
					                               f32_2 %66 = OpLoad vs_TEXCOORD0 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain %72 %68 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                                             OpStore %70 %76 
					                                 f32 %78 = OpLoad %70 
					                                 f32 %79 = OpLoad %44 
					                                 f32 %80 = OpFMul %78 %79 
					                                 f32 %82 = OpFAdd %80 %81 
					                                             OpStore %77 %82 
					                                 f32 %84 = OpLoad %44 
					                                 f32 %85 = OpLoad %70 
					                                 f32 %86 = OpFMul %84 %85 
					                                             OpStore %83 %86 
					                                 f32 %89 = OpLoad %44 
					                               f32_3 %91 = OpCompositeConstruct %89 %89 %89 
					                               f32_4 %92 = OpLoad %72 
					                               f32_3 %93 = OpVectorShuffle %92 %92 0 1 2 
					                               f32_3 %94 = OpFMul %91 %93 
					                               f32_4 %95 = OpLoad %88 
					                               f32_4 %96 = OpVectorShuffle %95 %94 4 5 6 3 
					                                             OpStore %88 %96 
					                                 f32 %97 = OpLoad %83 
					                         Output f32* %99 = OpAccessChain %88 %68 
					                                             OpStore %99 %97 
					                                f32 %103 = OpLoad %77 
					                               bool %104 = OpFOrdLessThan %103 %38 
					                                             OpStore %102 %104 
					                               bool %105 = OpLoad %102 
					                                i32 %107 = OpSelect %105 %106 %15 
					                                i32 %109 = OpIMul %107 %108 
					                               bool %110 = OpINotEqual %109 %15 
					                                             OpSelectionMerge %112 None 
					                                             OpBranchConditional %110 %111 %112 
					                                    %111 = OpLabel 
					                                             OpKill
					                                    %112 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 115
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %65 %72 %88 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
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
					                                             OpDecorate vs_TEXCOORD0 Location 65 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate %72 RelaxedPrecision 
					                                             OpDecorate %72 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %83 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %88 Location 88 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %103 RelaxedPrecision 
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
					                                     %64 = OpTypePointer Input %7 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					                        Input f32_4* %72 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                        Private f32* %77 = OpVariable Private 
					                                 f32 %81 = OpConstant 3.674022E-40 
					                        Private f32* %83 = OpVariable Private 
					                                     %87 = OpTypePointer Output %10 
					                       Output f32_4* %88 = OpVariable Output 
					                                     %90 = OpTypeVector %6 3 
					                                     %98 = OpTypePointer Output %6 
					                                    %100 = OpTypeBool 
					                                    %101 = OpTypePointer Private %100 
					                      Private bool* %102 = OpVariable Private 
					                                i32 %106 = OpConstant 1 
					                                i32 %108 = OpConstant -1 
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
					                               f32_2 %66 = OpLoad vs_TEXCOORD0 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain %72 %68 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                                             OpStore %70 %76 
					                                 f32 %78 = OpLoad %70 
					                                 f32 %79 = OpLoad %44 
					                                 f32 %80 = OpFMul %78 %79 
					                                 f32 %82 = OpFAdd %80 %81 
					                                             OpStore %77 %82 
					                                 f32 %84 = OpLoad %44 
					                                 f32 %85 = OpLoad %70 
					                                 f32 %86 = OpFMul %84 %85 
					                                             OpStore %83 %86 
					                                 f32 %89 = OpLoad %44 
					                               f32_3 %91 = OpCompositeConstruct %89 %89 %89 
					                               f32_4 %92 = OpLoad %72 
					                               f32_3 %93 = OpVectorShuffle %92 %92 0 1 2 
					                               f32_3 %94 = OpFMul %91 %93 
					                               f32_4 %95 = OpLoad %88 
					                               f32_4 %96 = OpVectorShuffle %95 %94 4 5 6 3 
					                                             OpStore %88 %96 
					                                 f32 %97 = OpLoad %83 
					                         Output f32* %99 = OpAccessChain %88 %68 
					                                             OpStore %99 %97 
					                                f32 %103 = OpLoad %77 
					                               bool %104 = OpFOrdLessThan %103 %38 
					                                             OpStore %102 %104 
					                               bool %105 = OpLoad %102 
					                                i32 %107 = OpSelect %105 %106 %15 
					                                i32 %109 = OpIMul %107 %108 
					                               bool %110 = OpINotEqual %109 %15 
					                                             OpSelectionMerge %112 None 
					                                             OpBranchConditional %110 %111 %112 
					                                    %111 = OpLabel 
					                                             OpKill
					                                    %112 = OpLabel 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 226
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %12 %134 %161 %167 %182 %192 %194 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %26 ArrayStride 26 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpMemberDecorate %28 0 Offset 28 
					                                                      OpMemberDecorate %28 1 Offset 28 
					                                                      OpMemberDecorate %28 2 Offset 28 
					                                                      OpMemberDecorate %28 3 RelaxedPrecision 
					                                                      OpMemberDecorate %28 3 Offset 28 
					                                                      OpMemberDecorate %28 4 Offset 28 
					                                                      OpMemberDecorate %28 5 Offset 28 
					                                                      OpMemberDecorate %28 6 Offset 28 
					                                                      OpMemberDecorate %28 7 Offset 28 
					                                                      OpMemberDecorate %28 8 Offset 28 
					                                                      OpMemberDecorate %28 9 Offset 28 
					                                                      OpDecorate %28 Block 
					                                                      OpDecorate %30 DescriptorSet 30 
					                                                      OpDecorate %30 Binding 30 
					                                                      OpMemberDecorate %132 0 BuiltIn 132 
					                                                      OpMemberDecorate %132 1 BuiltIn 132 
					                                                      OpMemberDecorate %132 2 BuiltIn 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate vs_TEXCOORD2 Location 161 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %167 Location 167 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                                      OpDecorate %170 RelaxedPrecision 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %182 RelaxedPrecision 
					                                                      OpDecorate %182 Location 182 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 192 
					                                                      OpDecorate %194 Location 194 
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
					                                              %28 = OpTypeStruct %10 %26 %27 %10 %6 %6 %6 %10 %6 %6 
					                                              %29 = OpTypePointer Uniform %28 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32; f32; f32_4; f32; f32;}* %30 = OpVariable Uniform 
					                                              %31 = OpTypeInt 32 1 
					                                          i32 %32 = OpConstant 0 
					                                              %33 = OpTypePointer Uniform %10 
					                               Private f32_2* %38 = OpVariable Private 
					                                          i32 %41 = OpConstant 5 
					                                              %42 = OpTypePointer Uniform %6 
					                                          i32 %45 = OpConstant 6 
					                                              %53 = OpTypePointer Private %10 
					                               Private f32_4* %54 = OpVariable Private 
					                                          i32 %57 = OpConstant 1 
					                                          i32 %68 = OpConstant 2 
					                                          i32 %77 = OpConstant 3 
					                               Private f32_4* %81 = OpVariable Private 
					                                       f32_2 %116 = OpConstantComposite %18 %18 
					                                         u32 %130 = OpConstant 1 
					                                             %131 = OpTypeArray %6 %130 
					                                             %132 = OpTypeStruct %10 %6 %131 
					                                             %133 = OpTypePointer Output %132 
					        Output struct {f32_4; f32; f32[1];}* %134 = OpVariable Output 
					                                             %139 = OpTypePointer Output %10 
					                                         i32 %148 = OpConstant 8 
					                                         i32 %151 = OpConstant 9 
					                                         f32 %155 = OpConstant 3.674022E-40 
					                                       f32_2 %156 = OpConstantComposite %155 %155 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %166 = OpVariable Private 
					                                Input f32_4* %167 = OpVariable Input 
					                                             %172 = OpTypeVector %6 3 
					                                         i32 %175 = OpConstant 4 
					                               Output f32_4* %182 = OpVariable Output 
					                                             %185 = OpTypePointer Output %6 
					                                             %191 = OpTypePointer Output %7 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %193 = OpTypePointer Input %7 
					                                Input f32_2* %194 = OpVariable Input 
					                                         i32 %196 = OpConstant 7 
					                                         f32 %199 = OpConstant 3.674022E-40 
					                                       f32_4 %200 = OpConstantComposite %199 %199 %199 %199 
					                                         f32 %203 = OpConstant 3.674022E-40 
					                                       f32_4 %204 = OpConstantComposite %203 %203 %203 %203 
					                                         f32 %207 = OpConstant 3.674022E-40 
					                                       f32_2 %208 = OpConstantComposite %207 %207 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                   Input f32* %16 = OpAccessChain %12 %14 
					                                          f32 %17 = OpLoad %16 
					                                          f32 %19 = OpFMul %17 %18 
					                                 Private f32* %22 = OpAccessChain %9 %20 
					                                                      OpStore %22 %19 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 0 
					                               Uniform f32_4* %34 = OpAccessChain %30 %32 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_2 %37 = OpFDiv %24 %36 
					                                                      OpStore %9 %37 
					                                        f32_4 %39 = OpLoad %12 
					                                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
					                                 Uniform f32* %43 = OpAccessChain %30 %41 
					                                          f32 %44 = OpLoad %43 
					                                 Uniform f32* %46 = OpAccessChain %30 %45 
					                                          f32 %47 = OpLoad %46 
					                                        f32_2 %48 = OpCompositeConstruct %44 %47 
					                                        f32_2 %49 = OpFAdd %40 %48 
					                                                      OpStore %38 %49 
					                                        f32_2 %50 = OpLoad %9 
					                                        f32_2 %51 = OpLoad %38 
					                                        f32_2 %52 = OpFAdd %50 %51 
					                                                      OpStore %9 %52 
					                                        f32_2 %55 = OpLoad %9 
					                                        f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                               Uniform f32_4* %58 = OpAccessChain %30 %57 %57 
					                                        f32_4 %59 = OpLoad %58 
					                                        f32_4 %60 = OpFMul %56 %59 
					                                                      OpStore %54 %60 
					                               Uniform f32_4* %61 = OpAccessChain %30 %57 %32 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_2 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 0 0 0 0 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %54 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %54 %67 
					                               Uniform f32_4* %69 = OpAccessChain %30 %57 %68 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %12 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 2 2 2 2 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %54 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %54 %75 
					                                        f32_4 %76 = OpLoad %54 
					                               Uniform f32_4* %78 = OpAccessChain %30 %57 %77 
					                                        f32_4 %79 = OpLoad %78 
					                                        f32_4 %80 = OpFAdd %76 %79 
					                                                      OpStore %54 %80 
					                                        f32_4 %82 = OpLoad %54 
					                                        f32_4 %83 = OpVectorShuffle %82 %82 1 1 1 1 
					                               Uniform f32_4* %84 = OpAccessChain %30 %68 %57 
					                                        f32_4 %85 = OpLoad %84 
					                                        f32_4 %86 = OpFMul %83 %85 
					                                                      OpStore %81 %86 
					                               Uniform f32_4* %87 = OpAccessChain %30 %68 %32 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpLoad %54 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                                        f32_4 %91 = OpFMul %88 %90 
					                                        f32_4 %92 = OpLoad %81 
					                                        f32_4 %93 = OpFAdd %91 %92 
					                                                      OpStore %81 %93 
					                               Uniform f32_4* %94 = OpAccessChain %30 %68 %68 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_4 %96 = OpLoad %54 
					                                        f32_4 %97 = OpVectorShuffle %96 %96 2 2 2 2 
					                                        f32_4 %98 = OpFMul %95 %97 
					                                        f32_4 %99 = OpLoad %81 
					                                       f32_4 %100 = OpFAdd %98 %99 
					                                                      OpStore %81 %100 
					                              Uniform f32_4* %101 = OpAccessChain %30 %68 %77 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpLoad %54 
					                                       f32_4 %104 = OpVectorShuffle %103 %103 3 3 3 3 
					                                       f32_4 %105 = OpFMul %102 %104 
					                                       f32_4 %106 = OpLoad %81 
					                                       f32_4 %107 = OpFAdd %105 %106 
					                                                      OpStore %54 %107 
					                                       f32_4 %108 = OpLoad %54 
					                                       f32_2 %109 = OpVectorShuffle %108 %108 0 1 
					                                       f32_4 %110 = OpLoad %54 
					                                       f32_2 %111 = OpVectorShuffle %110 %110 3 3 
					                                       f32_2 %112 = OpFDiv %109 %111 
					                                                      OpStore %38 %112 
					                              Uniform f32_4* %113 = OpAccessChain %30 %32 
					                                       f32_4 %114 = OpLoad %113 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %117 = OpFMul %115 %116 
					                                       f32_4 %118 = OpLoad %54 
					                                       f32_4 %119 = OpVectorShuffle %118 %117 4 5 2 3 
					                                                      OpStore %54 %119 
					                                       f32_2 %120 = OpLoad %38 
					                                       f32_4 %121 = OpLoad %54 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %120 %122 
					                                                      OpStore %38 %123 
					                                       f32_2 %124 = OpLoad %38 
					                                       f32_2 %125 = OpExtInst %1 2 %124 
					                                                      OpStore %38 %125 
					                                       f32_2 %126 = OpLoad %38 
					                                       f32_4 %127 = OpLoad %54 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                       f32_2 %129 = OpFDiv %126 %128 
					                                                      OpStore %38 %129 
					                                       f32_4 %135 = OpLoad %54 
					                                       f32_2 %136 = OpVectorShuffle %135 %135 3 3 
					                                       f32_2 %137 = OpLoad %38 
					                                       f32_2 %138 = OpFMul %136 %137 
					                               Output f32_4* %140 = OpAccessChain %134 %32 
					                                       f32_4 %141 = OpLoad %140 
					                                       f32_4 %142 = OpVectorShuffle %141 %138 4 5 2 3 
					                                                      OpStore %140 %142 
					                                       f32_4 %143 = OpLoad %54 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
					                               Output f32_4* %145 = OpAccessChain %134 %32 
					                                       f32_4 %146 = OpLoad %145 
					                                       f32_4 %147 = OpVectorShuffle %146 %144 0 1 4 5 
					                                                      OpStore %145 %147 
					                                Uniform f32* %149 = OpAccessChain %30 %148 
					                                         f32 %150 = OpLoad %149 
					                                Uniform f32* %152 = OpAccessChain %30 %151 
					                                         f32 %153 = OpLoad %152 
					                                       f32_2 %154 = OpCompositeConstruct %150 %153 
					                                       f32_2 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %54 
					                                       f32_2 %159 = OpVectorShuffle %158 %158 3 3 
					                                       f32_2 %160 = OpFAdd %157 %159 
					                                                      OpStore %38 %160 
					                                       f32_2 %162 = OpLoad %38 
					                                       f32_2 %163 = OpFDiv %156 %162 
					                                       f32_4 %164 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %165 = OpVectorShuffle %164 %163 0 1 4 5 
					                                                      OpStore vs_TEXCOORD2 %165 
					                                       f32_4 %168 = OpLoad %167 
					                              Uniform f32_4* %169 = OpAccessChain %30 %77 
					                                       f32_4 %170 = OpLoad %169 
					                                       f32_4 %171 = OpFMul %168 %170 
					                                                      OpStore %166 %171 
					                                       f32_4 %173 = OpLoad %166 
					                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
					                                Uniform f32* %176 = OpAccessChain %30 %175 
					                                         f32 %177 = OpLoad %176 
					                                       f32_3 %178 = OpCompositeConstruct %177 %177 %177 
					                                       f32_3 %179 = OpFMul %174 %178 
					                                       f32_4 %180 = OpLoad %81 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %81 %181 
					                                Private f32* %183 = OpAccessChain %166 %14 
					                                         f32 %184 = OpLoad %183 
					                                 Output f32* %186 = OpAccessChain %182 %14 
					                                                      OpStore %186 %184 
					                                       f32_4 %187 = OpLoad %81 
					                                       f32_3 %188 = OpVectorShuffle %187 %187 0 1 2 
					                                       f32_4 %189 = OpLoad %182 
					                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
					                                                      OpStore %182 %190 
					                                       f32_2 %195 = OpLoad %194 
					                                                      OpStore vs_TEXCOORD0 %195 
					                              Uniform f32_4* %197 = OpAccessChain %30 %196 
					                                       f32_4 %198 = OpLoad %197 
					                                       f32_4 %201 = OpExtInst %1 40 %198 %200 
					                                                      OpStore %54 %201 
					                                       f32_4 %202 = OpLoad %54 
					                                       f32_4 %205 = OpExtInst %1 37 %202 %204 
					                                                      OpStore %54 %205 
					                                       f32_2 %206 = OpLoad %9 
					                                       f32_2 %209 = OpFMul %206 %208 
					                                       f32_4 %210 = OpLoad %54 
					                                       f32_2 %211 = OpVectorShuffle %210 %210 0 1 
					                                       f32_2 %212 = OpFNegate %211 
					                                       f32_2 %213 = OpFAdd %209 %212 
					                                                      OpStore %9 %213 
					                                       f32_4 %214 = OpLoad %54 
					                                       f32_2 %215 = OpVectorShuffle %214 %214 2 3 
					                                       f32_2 %216 = OpFNegate %215 
					                                       f32_2 %217 = OpLoad %9 
					                                       f32_2 %218 = OpFAdd %216 %217 
					                                       f32_4 %219 = OpLoad vs_TEXCOORD2 
					                                       f32_4 %220 = OpVectorShuffle %219 %218 4 5 2 3 
					                                                      OpStore vs_TEXCOORD2 %220 
					                                 Output f32* %221 = OpAccessChain %134 %32 %130 
					                                         f32 %222 = OpLoad %221 
					                                         f32 %223 = OpFNegate %222 
					                                 Output f32* %224 = OpAccessChain %134 %32 %130 
					                                                      OpStore %224 %223 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 115
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %27 %65 %72 %88 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                             OpMemberDecorate %11 0 Offset 11 
					                                             OpDecorate %11 Block 
					                                             OpDecorate %13 DescriptorSet 13 
					                                             OpDecorate %13 Binding 13 
					                                             OpDecorate vs_TEXCOORD2 Location 27 
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
					                                             OpDecorate vs_TEXCOORD0 Location 65 
					                                             OpDecorate %69 RelaxedPrecision 
					                                             OpDecorate %70 RelaxedPrecision 
					                                             OpDecorate %71 RelaxedPrecision 
					                                             OpDecorate %72 RelaxedPrecision 
					                                             OpDecorate %72 Location 72 
					                                             OpDecorate %75 RelaxedPrecision 
					                                             OpDecorate %76 RelaxedPrecision 
					                                             OpDecorate %77 RelaxedPrecision 
					                                             OpDecorate %78 RelaxedPrecision 
					                                             OpDecorate %79 RelaxedPrecision 
					                                             OpDecorate %80 RelaxedPrecision 
					                                             OpDecorate %82 RelaxedPrecision 
					                                             OpDecorate %83 RelaxedPrecision 
					                                             OpDecorate %84 RelaxedPrecision 
					                                             OpDecorate %85 RelaxedPrecision 
					                                             OpDecorate %86 RelaxedPrecision 
					                                             OpDecorate %88 RelaxedPrecision 
					                                             OpDecorate %88 Location 88 
					                                             OpDecorate %89 RelaxedPrecision 
					                                             OpDecorate %91 RelaxedPrecision 
					                                             OpDecorate %92 RelaxedPrecision 
					                                             OpDecorate %93 RelaxedPrecision 
					                                             OpDecorate %94 RelaxedPrecision 
					                                             OpDecorate %97 RelaxedPrecision 
					                                             OpDecorate %103 RelaxedPrecision 
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
					                                     %64 = OpTypePointer Input %7 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                 u32 %68 = OpConstant 3 
					                        Private f32* %70 = OpVariable Private 
					                        Input f32_4* %72 = OpVariable Input 
					                                     %73 = OpTypePointer Input %6 
					                        Private f32* %77 = OpVariable Private 
					                                 f32 %81 = OpConstant 3.674022E-40 
					                        Private f32* %83 = OpVariable Private 
					                                     %87 = OpTypePointer Output %10 
					                       Output f32_4* %88 = OpVariable Output 
					                                     %90 = OpTypeVector %6 3 
					                                     %98 = OpTypePointer Output %6 
					                                    %100 = OpTypeBool 
					                                    %101 = OpTypePointer Private %100 
					                      Private bool* %102 = OpVariable Private 
					                                i32 %106 = OpConstant 1 
					                                i32 %108 = OpConstant -1 
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
					                               f32_2 %66 = OpLoad vs_TEXCOORD0 
					                               f32_4 %67 = OpImageSampleImplicitLod %63 %66 
					                                 f32 %69 = OpCompositeExtract %67 3 
					                                             OpStore %53 %69 
					                                 f32 %71 = OpLoad %53 
					                          Input f32* %74 = OpAccessChain %72 %68 
					                                 f32 %75 = OpLoad %74 
					                                 f32 %76 = OpFMul %71 %75 
					                                             OpStore %70 %76 
					                                 f32 %78 = OpLoad %70 
					                                 f32 %79 = OpLoad %44 
					                                 f32 %80 = OpFMul %78 %79 
					                                 f32 %82 = OpFAdd %80 %81 
					                                             OpStore %77 %82 
					                                 f32 %84 = OpLoad %44 
					                                 f32 %85 = OpLoad %70 
					                                 f32 %86 = OpFMul %84 %85 
					                                             OpStore %83 %86 
					                                 f32 %89 = OpLoad %44 
					                               f32_3 %91 = OpCompositeConstruct %89 %89 %89 
					                               f32_4 %92 = OpLoad %72 
					                               f32_3 %93 = OpVectorShuffle %92 %92 0 1 2 
					                               f32_3 %94 = OpFMul %91 %93 
					                               f32_4 %95 = OpLoad %88 
					                               f32_4 %96 = OpVectorShuffle %95 %94 4 5 6 3 
					                                             OpStore %88 %96 
					                                 f32 %97 = OpLoad %83 
					                         Output f32* %99 = OpAccessChain %88 %68 
					                                             OpStore %99 %97 
					                                f32 %103 = OpLoad %77 
					                               bool %104 = OpFOrdLessThan %103 %38 
					                                             OpStore %102 %104 
					                               bool %105 = OpLoad %102 
					                                i32 %107 = OpSelect %105 %106 %15 
					                                i32 %109 = OpIMul %107 %108 
					                               bool %110 = OpINotEqual %109 %15 
					                                             OpSelectionMerge %112 None 
					                                             OpBranchConditional %110 %111 %112 
					                                    %111 = OpLabel 
					                                             OpKill
					                                    %112 = OpLabel 
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
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode Off
			}
			GpuProgramID 117148
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec3 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
					#else
					    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					uniform 	mediump vec4 _Color;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    SV_Target0.w = u_xlat16_0 * _Color.w;
					    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec3 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
					#else
					    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					uniform 	mediump vec4 _Color;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    SV_Target0.w = u_xlat16_0 * _Color.w;
					    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
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
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec3 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
					#else
					    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					uniform 	mediump vec4 _Color;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    SV_Target0.w = u_xlat16_0 * _Color.w;
					    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 113
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %11 %21 %24 %47 %98 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %9 Location 9 
					                                                     OpDecorate %11 RelaxedPrecision 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %12 RelaxedPrecision 
					                                                     OpDecorate %13 RelaxedPrecision 
					                                                     OpDecorate %16 RelaxedPrecision 
					                                                     OpDecorate %17 RelaxedPrecision 
					                                                     OpDecorate %18 RelaxedPrecision 
					                                                     OpDecorate vs_TEXCOORD0 Location 21 
					                                                     OpDecorate %24 Location 24 
					                                                     OpDecorate %29 ArrayStride 29 
					                                                     OpDecorate %30 ArrayStride 30 
					                                                     OpMemberDecorate %31 0 Offset 31 
					                                                     OpMemberDecorate %31 1 Offset 31 
					                                                     OpMemberDecorate %31 2 Offset 31 
					                                                     OpDecorate %31 Block 
					                                                     OpDecorate %33 DescriptorSet 33 
					                                                     OpDecorate %33 Binding 33 
					                                                     OpDecorate %47 Location 47 
					                                                     OpMemberDecorate %96 0 BuiltIn 96 
					                                                     OpMemberDecorate %96 1 BuiltIn 96 
					                                                     OpMemberDecorate %96 2 BuiltIn 96 
					                                                     OpDecorate %96 Block 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Output %7 
					                                Output f32_4* %9 = OpVariable Output 
					                                             %10 = OpTypePointer Input %7 
					                                Input f32_4* %11 = OpVariable Input 
					                                         f32 %14 = OpConstant 3.674022E-40 
					                                         f32 %15 = OpConstant 3.674022E-40 
					                                             %19 = OpTypeVector %6 2 
					                                             %20 = OpTypePointer Output %19 
					                      Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %22 = OpTypeVector %6 3 
					                                             %23 = OpTypePointer Input %22 
					                                Input f32_3* %24 = OpVariable Input 
					                                             %27 = OpTypeInt 32 0 
					                                         u32 %28 = OpConstant 4 
					                                             %29 = OpTypeArray %7 %28 
					                                             %30 = OpTypeArray %7 %28 
					                                             %31 = OpTypeStruct %29 %30 %7 
					                                             %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %33 = OpVariable Uniform 
					                                             %34 = OpTypeInt 32 1 
					                                         i32 %35 = OpConstant 2 
					                                             %36 = OpTypePointer Uniform %7 
					                                             %45 = OpTypePointer Private %7 
					                              Private f32_4* %46 = OpVariable Private 
					                                Input f32_3* %47 = OpVariable Input 
					                                         i32 %50 = OpConstant 0 
					                                         i32 %51 = OpConstant 1 
					                                         i32 %70 = OpConstant 3 
					                              Private f32_4* %74 = OpVariable Private 
					                                         u32 %94 = OpConstant 1 
					                                             %95 = OpTypeArray %6 %94 
					                                             %96 = OpTypeStruct %7 %6 %95 
					                                             %97 = OpTypePointer Output %96 
					        Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
					                                            %107 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_4 %12 = OpLoad %11 
					                                                     OpStore %9 %12 
					                                       f32_4 %13 = OpLoad %9 
					                                       f32_4 %16 = OpCompositeConstruct %14 %14 %14 %14 
					                                       f32_4 %17 = OpCompositeConstruct %15 %15 %15 %15 
					                                       f32_4 %18 = OpExtInst %1 43 %13 %16 %17 
					                                                     OpStore %9 %18 
					                                       f32_3 %25 = OpLoad %24 
					                                       f32_2 %26 = OpVectorShuffle %25 %25 0 1 
					                              Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                       f32_4 %38 = OpLoad %37 
					                                       f32_2 %39 = OpVectorShuffle %38 %38 0 1 
					                                       f32_2 %40 = OpFMul %26 %39 
					                              Uniform f32_4* %41 = OpAccessChain %33 %35 
					                                       f32_4 %42 = OpLoad %41 
					                                       f32_2 %43 = OpVectorShuffle %42 %42 2 3 
					                                       f32_2 %44 = OpFAdd %40 %43 
					                                                     OpStore vs_TEXCOORD0 %44 
					                                       f32_3 %48 = OpLoad %47 
					                                       f32_4 %49 = OpVectorShuffle %48 %48 1 1 1 1 
					                              Uniform f32_4* %52 = OpAccessChain %33 %50 %51 
					                                       f32_4 %53 = OpLoad %52 
					                                       f32_4 %54 = OpFMul %49 %53 
					                                                     OpStore %46 %54 
					                              Uniform f32_4* %55 = OpAccessChain %33 %50 %50 
					                                       f32_4 %56 = OpLoad %55 
					                                       f32_3 %57 = OpLoad %47 
					                                       f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                       f32_4 %59 = OpFMul %56 %58 
					                                       f32_4 %60 = OpLoad %46 
					                                       f32_4 %61 = OpFAdd %59 %60 
					                                                     OpStore %46 %61 
					                              Uniform f32_4* %62 = OpAccessChain %33 %50 %35 
					                                       f32_4 %63 = OpLoad %62 
					                                       f32_3 %64 = OpLoad %47 
					                                       f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                       f32_4 %66 = OpFMul %63 %65 
					                                       f32_4 %67 = OpLoad %46 
					                                       f32_4 %68 = OpFAdd %66 %67 
					                                                     OpStore %46 %68 
					                                       f32_4 %69 = OpLoad %46 
					                              Uniform f32_4* %71 = OpAccessChain %33 %50 %70 
					                                       f32_4 %72 = OpLoad %71 
					                                       f32_4 %73 = OpFAdd %69 %72 
					                                                     OpStore %46 %73 
					                                       f32_4 %75 = OpLoad %46 
					                                       f32_4 %76 = OpVectorShuffle %75 %75 1 1 1 1 
					                              Uniform f32_4* %77 = OpAccessChain %33 %51 %51 
					                                       f32_4 %78 = OpLoad %77 
					                                       f32_4 %79 = OpFMul %76 %78 
					                                                     OpStore %74 %79 
					                              Uniform f32_4* %80 = OpAccessChain %33 %51 %50 
					                                       f32_4 %81 = OpLoad %80 
					                                       f32_4 %82 = OpLoad %46 
					                                       f32_4 %83 = OpVectorShuffle %82 %82 0 0 0 0 
					                                       f32_4 %84 = OpFMul %81 %83 
					                                       f32_4 %85 = OpLoad %74 
					                                       f32_4 %86 = OpFAdd %84 %85 
					                                                     OpStore %74 %86 
					                              Uniform f32_4* %87 = OpAccessChain %33 %51 %35 
					                                       f32_4 %88 = OpLoad %87 
					                                       f32_4 %89 = OpLoad %46 
					                                       f32_4 %90 = OpVectorShuffle %89 %89 2 2 2 2 
					                                       f32_4 %91 = OpFMul %88 %90 
					                                       f32_4 %92 = OpLoad %74 
					                                       f32_4 %93 = OpFAdd %91 %92 
					                                                     OpStore %74 %93 
					                              Uniform f32_4* %99 = OpAccessChain %33 %51 %70 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpLoad %46 
					                                      f32_4 %102 = OpVectorShuffle %101 %101 3 3 3 3 
					                                      f32_4 %103 = OpFMul %100 %102 
					                                      f32_4 %104 = OpLoad %74 
					                                      f32_4 %105 = OpFAdd %103 %104 
					                              Output f32_4* %106 = OpAccessChain %98 %50 
					                                                     OpStore %106 %105 
					                                Output f32* %108 = OpAccessChain %98 %50 %94 
					                                        f32 %109 = OpLoad %108 
					                                        f32 %110 = OpFNegate %109 
					                                Output f32* %111 = OpAccessChain %98 %50 %94 
					                                                     OpStore %111 %110 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 55
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %29 %43 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %29 Location 29 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpMemberDecorate %31 0 RelaxedPrecision 
					                                             OpMemberDecorate %31 0 Offset 31 
					                                             OpDecorate %31 Block 
					                                             OpDecorate %33 DescriptorSet 33 
					                                             OpDecorate %33 Binding 33 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %43 Location 43 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                                     %28 = OpTypePointer Output %23 
					                       Output f32_4* %29 = OpVariable Output 
					                                     %31 = OpTypeStruct %23 
					                                     %32 = OpTypePointer Uniform %31 
					            Uniform struct {f32_4;}* %33 = OpVariable Uniform 
					                                     %34 = OpTypeInt 32 1 
					                                 i32 %35 = OpConstant 0 
					                                     %36 = OpTypePointer Uniform %6 
					                                     %40 = OpTypePointer Output %6 
					                                     %42 = OpTypePointer Input %23 
					                        Input f32_4* %43 = OpVariable Input 
					                                     %44 = OpTypeVector %6 3 
					                                     %47 = OpTypePointer Uniform %23 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %30 = OpLoad %8 
					                        Uniform f32* %37 = OpAccessChain %33 %35 %26 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFMul %30 %38 
					                         Output f32* %41 = OpAccessChain %29 %26 
					                                             OpStore %41 %39 
					                               f32_4 %45 = OpLoad %43 
					                               f32_3 %46 = OpVectorShuffle %45 %45 0 1 2 
					                      Uniform f32_4* %48 = OpAccessChain %33 %35 
					                               f32_4 %49 = OpLoad %48 
					                               f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
					                               f32_3 %51 = OpFMul %46 %50 
					                               f32_4 %52 = OpLoad %29 
					                               f32_4 %53 = OpVectorShuffle %52 %51 4 5 6 3 
					                                             OpStore %29 %53 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 113
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %11 %21 %24 %47 %98 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %9 Location 9 
					                                                     OpDecorate %11 RelaxedPrecision 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %12 RelaxedPrecision 
					                                                     OpDecorate %13 RelaxedPrecision 
					                                                     OpDecorate %16 RelaxedPrecision 
					                                                     OpDecorate %17 RelaxedPrecision 
					                                                     OpDecorate %18 RelaxedPrecision 
					                                                     OpDecorate vs_TEXCOORD0 Location 21 
					                                                     OpDecorate %24 Location 24 
					                                                     OpDecorate %29 ArrayStride 29 
					                                                     OpDecorate %30 ArrayStride 30 
					                                                     OpMemberDecorate %31 0 Offset 31 
					                                                     OpMemberDecorate %31 1 Offset 31 
					                                                     OpMemberDecorate %31 2 Offset 31 
					                                                     OpDecorate %31 Block 
					                                                     OpDecorate %33 DescriptorSet 33 
					                                                     OpDecorate %33 Binding 33 
					                                                     OpDecorate %47 Location 47 
					                                                     OpMemberDecorate %96 0 BuiltIn 96 
					                                                     OpMemberDecorate %96 1 BuiltIn 96 
					                                                     OpMemberDecorate %96 2 BuiltIn 96 
					                                                     OpDecorate %96 Block 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Output %7 
					                                Output f32_4* %9 = OpVariable Output 
					                                             %10 = OpTypePointer Input %7 
					                                Input f32_4* %11 = OpVariable Input 
					                                         f32 %14 = OpConstant 3.674022E-40 
					                                         f32 %15 = OpConstant 3.674022E-40 
					                                             %19 = OpTypeVector %6 2 
					                                             %20 = OpTypePointer Output %19 
					                      Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %22 = OpTypeVector %6 3 
					                                             %23 = OpTypePointer Input %22 
					                                Input f32_3* %24 = OpVariable Input 
					                                             %27 = OpTypeInt 32 0 
					                                         u32 %28 = OpConstant 4 
					                                             %29 = OpTypeArray %7 %28 
					                                             %30 = OpTypeArray %7 %28 
					                                             %31 = OpTypeStruct %29 %30 %7 
					                                             %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %33 = OpVariable Uniform 
					                                             %34 = OpTypeInt 32 1 
					                                         i32 %35 = OpConstant 2 
					                                             %36 = OpTypePointer Uniform %7 
					                                             %45 = OpTypePointer Private %7 
					                              Private f32_4* %46 = OpVariable Private 
					                                Input f32_3* %47 = OpVariable Input 
					                                         i32 %50 = OpConstant 0 
					                                         i32 %51 = OpConstant 1 
					                                         i32 %70 = OpConstant 3 
					                              Private f32_4* %74 = OpVariable Private 
					                                         u32 %94 = OpConstant 1 
					                                             %95 = OpTypeArray %6 %94 
					                                             %96 = OpTypeStruct %7 %6 %95 
					                                             %97 = OpTypePointer Output %96 
					        Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
					                                            %107 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_4 %12 = OpLoad %11 
					                                                     OpStore %9 %12 
					                                       f32_4 %13 = OpLoad %9 
					                                       f32_4 %16 = OpCompositeConstruct %14 %14 %14 %14 
					                                       f32_4 %17 = OpCompositeConstruct %15 %15 %15 %15 
					                                       f32_4 %18 = OpExtInst %1 43 %13 %16 %17 
					                                                     OpStore %9 %18 
					                                       f32_3 %25 = OpLoad %24 
					                                       f32_2 %26 = OpVectorShuffle %25 %25 0 1 
					                              Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                       f32_4 %38 = OpLoad %37 
					                                       f32_2 %39 = OpVectorShuffle %38 %38 0 1 
					                                       f32_2 %40 = OpFMul %26 %39 
					                              Uniform f32_4* %41 = OpAccessChain %33 %35 
					                                       f32_4 %42 = OpLoad %41 
					                                       f32_2 %43 = OpVectorShuffle %42 %42 2 3 
					                                       f32_2 %44 = OpFAdd %40 %43 
					                                                     OpStore vs_TEXCOORD0 %44 
					                                       f32_3 %48 = OpLoad %47 
					                                       f32_4 %49 = OpVectorShuffle %48 %48 1 1 1 1 
					                              Uniform f32_4* %52 = OpAccessChain %33 %50 %51 
					                                       f32_4 %53 = OpLoad %52 
					                                       f32_4 %54 = OpFMul %49 %53 
					                                                     OpStore %46 %54 
					                              Uniform f32_4* %55 = OpAccessChain %33 %50 %50 
					                                       f32_4 %56 = OpLoad %55 
					                                       f32_3 %57 = OpLoad %47 
					                                       f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                       f32_4 %59 = OpFMul %56 %58 
					                                       f32_4 %60 = OpLoad %46 
					                                       f32_4 %61 = OpFAdd %59 %60 
					                                                     OpStore %46 %61 
					                              Uniform f32_4* %62 = OpAccessChain %33 %50 %35 
					                                       f32_4 %63 = OpLoad %62 
					                                       f32_3 %64 = OpLoad %47 
					                                       f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                       f32_4 %66 = OpFMul %63 %65 
					                                       f32_4 %67 = OpLoad %46 
					                                       f32_4 %68 = OpFAdd %66 %67 
					                                                     OpStore %46 %68 
					                                       f32_4 %69 = OpLoad %46 
					                              Uniform f32_4* %71 = OpAccessChain %33 %50 %70 
					                                       f32_4 %72 = OpLoad %71 
					                                       f32_4 %73 = OpFAdd %69 %72 
					                                                     OpStore %46 %73 
					                                       f32_4 %75 = OpLoad %46 
					                                       f32_4 %76 = OpVectorShuffle %75 %75 1 1 1 1 
					                              Uniform f32_4* %77 = OpAccessChain %33 %51 %51 
					                                       f32_4 %78 = OpLoad %77 
					                                       f32_4 %79 = OpFMul %76 %78 
					                                                     OpStore %74 %79 
					                              Uniform f32_4* %80 = OpAccessChain %33 %51 %50 
					                                       f32_4 %81 = OpLoad %80 
					                                       f32_4 %82 = OpLoad %46 
					                                       f32_4 %83 = OpVectorShuffle %82 %82 0 0 0 0 
					                                       f32_4 %84 = OpFMul %81 %83 
					                                       f32_4 %85 = OpLoad %74 
					                                       f32_4 %86 = OpFAdd %84 %85 
					                                                     OpStore %74 %86 
					                              Uniform f32_4* %87 = OpAccessChain %33 %51 %35 
					                                       f32_4 %88 = OpLoad %87 
					                                       f32_4 %89 = OpLoad %46 
					                                       f32_4 %90 = OpVectorShuffle %89 %89 2 2 2 2 
					                                       f32_4 %91 = OpFMul %88 %90 
					                                       f32_4 %92 = OpLoad %74 
					                                       f32_4 %93 = OpFAdd %91 %92 
					                                                     OpStore %74 %93 
					                              Uniform f32_4* %99 = OpAccessChain %33 %51 %70 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpLoad %46 
					                                      f32_4 %102 = OpVectorShuffle %101 %101 3 3 3 3 
					                                      f32_4 %103 = OpFMul %100 %102 
					                                      f32_4 %104 = OpLoad %74 
					                                      f32_4 %105 = OpFAdd %103 %104 
					                              Output f32_4* %106 = OpAccessChain %98 %50 
					                                                     OpStore %106 %105 
					                                Output f32* %108 = OpAccessChain %98 %50 %94 
					                                        f32 %109 = OpLoad %108 
					                                        f32 %110 = OpFNegate %109 
					                                Output f32* %111 = OpAccessChain %98 %50 %94 
					                                                     OpStore %111 %110 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 55
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %29 %43 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %29 Location 29 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpMemberDecorate %31 0 RelaxedPrecision 
					                                             OpMemberDecorate %31 0 Offset 31 
					                                             OpDecorate %31 Block 
					                                             OpDecorate %33 DescriptorSet 33 
					                                             OpDecorate %33 Binding 33 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %43 Location 43 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                                     %28 = OpTypePointer Output %23 
					                       Output f32_4* %29 = OpVariable Output 
					                                     %31 = OpTypeStruct %23 
					                                     %32 = OpTypePointer Uniform %31 
					            Uniform struct {f32_4;}* %33 = OpVariable Uniform 
					                                     %34 = OpTypeInt 32 1 
					                                 i32 %35 = OpConstant 0 
					                                     %36 = OpTypePointer Uniform %6 
					                                     %40 = OpTypePointer Output %6 
					                                     %42 = OpTypePointer Input %23 
					                        Input f32_4* %43 = OpVariable Input 
					                                     %44 = OpTypeVector %6 3 
					                                     %47 = OpTypePointer Uniform %23 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %30 = OpLoad %8 
					                        Uniform f32* %37 = OpAccessChain %33 %35 %26 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFMul %30 %38 
					                         Output f32* %41 = OpAccessChain %29 %26 
					                                             OpStore %41 %39 
					                               f32_4 %45 = OpLoad %43 
					                               f32_3 %46 = OpVectorShuffle %45 %45 0 1 2 
					                      Uniform f32_4* %48 = OpAccessChain %33 %35 
					                               f32_4 %49 = OpLoad %48 
					                               f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
					                               f32_3 %51 = OpFMul %46 %50 
					                               f32_4 %52 = OpLoad %29 
					                               f32_4 %53 = OpVectorShuffle %52 %51 4 5 6 3 
					                                             OpStore %29 %53 
					                                             OpReturn
					                                             OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 113
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %11 %21 %24 %47 %98 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %9 Location 9 
					                                                     OpDecorate %11 RelaxedPrecision 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %12 RelaxedPrecision 
					                                                     OpDecorate %13 RelaxedPrecision 
					                                                     OpDecorate %16 RelaxedPrecision 
					                                                     OpDecorate %17 RelaxedPrecision 
					                                                     OpDecorate %18 RelaxedPrecision 
					                                                     OpDecorate vs_TEXCOORD0 Location 21 
					                                                     OpDecorate %24 Location 24 
					                                                     OpDecorate %29 ArrayStride 29 
					                                                     OpDecorate %30 ArrayStride 30 
					                                                     OpMemberDecorate %31 0 Offset 31 
					                                                     OpMemberDecorate %31 1 Offset 31 
					                                                     OpMemberDecorate %31 2 Offset 31 
					                                                     OpDecorate %31 Block 
					                                                     OpDecorate %33 DescriptorSet 33 
					                                                     OpDecorate %33 Binding 33 
					                                                     OpDecorate %47 Location 47 
					                                                     OpMemberDecorate %96 0 BuiltIn 96 
					                                                     OpMemberDecorate %96 1 BuiltIn 96 
					                                                     OpMemberDecorate %96 2 BuiltIn 96 
					                                                     OpDecorate %96 Block 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Output %7 
					                                Output f32_4* %9 = OpVariable Output 
					                                             %10 = OpTypePointer Input %7 
					                                Input f32_4* %11 = OpVariable Input 
					                                         f32 %14 = OpConstant 3.674022E-40 
					                                         f32 %15 = OpConstant 3.674022E-40 
					                                             %19 = OpTypeVector %6 2 
					                                             %20 = OpTypePointer Output %19 
					                      Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                             %22 = OpTypeVector %6 3 
					                                             %23 = OpTypePointer Input %22 
					                                Input f32_3* %24 = OpVariable Input 
					                                             %27 = OpTypeInt 32 0 
					                                         u32 %28 = OpConstant 4 
					                                             %29 = OpTypeArray %7 %28 
					                                             %30 = OpTypeArray %7 %28 
					                                             %31 = OpTypeStruct %29 %30 %7 
					                                             %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %33 = OpVariable Uniform 
					                                             %34 = OpTypeInt 32 1 
					                                         i32 %35 = OpConstant 2 
					                                             %36 = OpTypePointer Uniform %7 
					                                             %45 = OpTypePointer Private %7 
					                              Private f32_4* %46 = OpVariable Private 
					                                Input f32_3* %47 = OpVariable Input 
					                                         i32 %50 = OpConstant 0 
					                                         i32 %51 = OpConstant 1 
					                                         i32 %70 = OpConstant 3 
					                              Private f32_4* %74 = OpVariable Private 
					                                         u32 %94 = OpConstant 1 
					                                             %95 = OpTypeArray %6 %94 
					                                             %96 = OpTypeStruct %7 %6 %95 
					                                             %97 = OpTypePointer Output %96 
					        Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
					                                            %107 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                       f32_4 %12 = OpLoad %11 
					                                                     OpStore %9 %12 
					                                       f32_4 %13 = OpLoad %9 
					                                       f32_4 %16 = OpCompositeConstruct %14 %14 %14 %14 
					                                       f32_4 %17 = OpCompositeConstruct %15 %15 %15 %15 
					                                       f32_4 %18 = OpExtInst %1 43 %13 %16 %17 
					                                                     OpStore %9 %18 
					                                       f32_3 %25 = OpLoad %24 
					                                       f32_2 %26 = OpVectorShuffle %25 %25 0 1 
					                              Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                       f32_4 %38 = OpLoad %37 
					                                       f32_2 %39 = OpVectorShuffle %38 %38 0 1 
					                                       f32_2 %40 = OpFMul %26 %39 
					                              Uniform f32_4* %41 = OpAccessChain %33 %35 
					                                       f32_4 %42 = OpLoad %41 
					                                       f32_2 %43 = OpVectorShuffle %42 %42 2 3 
					                                       f32_2 %44 = OpFAdd %40 %43 
					                                                     OpStore vs_TEXCOORD0 %44 
					                                       f32_3 %48 = OpLoad %47 
					                                       f32_4 %49 = OpVectorShuffle %48 %48 1 1 1 1 
					                              Uniform f32_4* %52 = OpAccessChain %33 %50 %51 
					                                       f32_4 %53 = OpLoad %52 
					                                       f32_4 %54 = OpFMul %49 %53 
					                                                     OpStore %46 %54 
					                              Uniform f32_4* %55 = OpAccessChain %33 %50 %50 
					                                       f32_4 %56 = OpLoad %55 
					                                       f32_3 %57 = OpLoad %47 
					                                       f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                       f32_4 %59 = OpFMul %56 %58 
					                                       f32_4 %60 = OpLoad %46 
					                                       f32_4 %61 = OpFAdd %59 %60 
					                                                     OpStore %46 %61 
					                              Uniform f32_4* %62 = OpAccessChain %33 %50 %35 
					                                       f32_4 %63 = OpLoad %62 
					                                       f32_3 %64 = OpLoad %47 
					                                       f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                       f32_4 %66 = OpFMul %63 %65 
					                                       f32_4 %67 = OpLoad %46 
					                                       f32_4 %68 = OpFAdd %66 %67 
					                                                     OpStore %46 %68 
					                                       f32_4 %69 = OpLoad %46 
					                              Uniform f32_4* %71 = OpAccessChain %33 %50 %70 
					                                       f32_4 %72 = OpLoad %71 
					                                       f32_4 %73 = OpFAdd %69 %72 
					                                                     OpStore %46 %73 
					                                       f32_4 %75 = OpLoad %46 
					                                       f32_4 %76 = OpVectorShuffle %75 %75 1 1 1 1 
					                              Uniform f32_4* %77 = OpAccessChain %33 %51 %51 
					                                       f32_4 %78 = OpLoad %77 
					                                       f32_4 %79 = OpFMul %76 %78 
					                                                     OpStore %74 %79 
					                              Uniform f32_4* %80 = OpAccessChain %33 %51 %50 
					                                       f32_4 %81 = OpLoad %80 
					                                       f32_4 %82 = OpLoad %46 
					                                       f32_4 %83 = OpVectorShuffle %82 %82 0 0 0 0 
					                                       f32_4 %84 = OpFMul %81 %83 
					                                       f32_4 %85 = OpLoad %74 
					                                       f32_4 %86 = OpFAdd %84 %85 
					                                                     OpStore %74 %86 
					                              Uniform f32_4* %87 = OpAccessChain %33 %51 %35 
					                                       f32_4 %88 = OpLoad %87 
					                                       f32_4 %89 = OpLoad %46 
					                                       f32_4 %90 = OpVectorShuffle %89 %89 2 2 2 2 
					                                       f32_4 %91 = OpFMul %88 %90 
					                                       f32_4 %92 = OpLoad %74 
					                                       f32_4 %93 = OpFAdd %91 %92 
					                                                     OpStore %74 %93 
					                              Uniform f32_4* %99 = OpAccessChain %33 %51 %70 
					                                      f32_4 %100 = OpLoad %99 
					                                      f32_4 %101 = OpLoad %46 
					                                      f32_4 %102 = OpVectorShuffle %101 %101 3 3 3 3 
					                                      f32_4 %103 = OpFMul %100 %102 
					                                      f32_4 %104 = OpLoad %74 
					                                      f32_4 %105 = OpFAdd %103 %104 
					                              Output f32_4* %106 = OpAccessChain %98 %50 
					                                                     OpStore %106 %105 
					                                Output f32* %108 = OpAccessChain %98 %50 %94 
					                                        f32 %109 = OpLoad %108 
					                                        f32 %110 = OpFNegate %109 
					                                Output f32* %111 = OpAccessChain %98 %50 %94 
					                                                     OpStore %111 %110 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 55
					; Schema: 0
					                                             OpCapability Shader 
					                                      %1 = OpExtInstImport "GLSL.std.450" 
					                                             OpMemoryModel Logical GLSL450 
					                                             OpEntryPoint Fragment %4 "main" %21 %29 %43 
					                                             OpExecutionMode %4 OriginUpperLeft 
					                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
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
					                                             OpDecorate %27 RelaxedPrecision 
					                                             OpDecorate %29 RelaxedPrecision 
					                                             OpDecorate %29 Location 29 
					                                             OpDecorate %30 RelaxedPrecision 
					                                             OpMemberDecorate %31 0 RelaxedPrecision 
					                                             OpMemberDecorate %31 0 Offset 31 
					                                             OpDecorate %31 Block 
					                                             OpDecorate %33 DescriptorSet 33 
					                                             OpDecorate %33 Binding 33 
					                                             OpDecorate %38 RelaxedPrecision 
					                                             OpDecorate %39 RelaxedPrecision 
					                                             OpDecorate %43 RelaxedPrecision 
					                                             OpDecorate %43 Location 43 
					                                             OpDecorate %45 RelaxedPrecision 
					                                             OpDecorate %46 RelaxedPrecision 
					                                             OpDecorate %49 RelaxedPrecision 
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
					                                     %19 = OpTypeVector %6 2 
					                                     %20 = OpTypePointer Input %19 
					               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                     %23 = OpTypeVector %6 4 
					                                     %25 = OpTypeInt 32 0 
					                                 u32 %26 = OpConstant 3 
					                                     %28 = OpTypePointer Output %23 
					                       Output f32_4* %29 = OpVariable Output 
					                                     %31 = OpTypeStruct %23 
					                                     %32 = OpTypePointer Uniform %31 
					            Uniform struct {f32_4;}* %33 = OpVariable Uniform 
					                                     %34 = OpTypeInt 32 1 
					                                 i32 %35 = OpConstant 0 
					                                     %36 = OpTypePointer Uniform %6 
					                                     %40 = OpTypePointer Output %6 
					                                     %42 = OpTypePointer Input %23 
					                        Input f32_4* %43 = OpVariable Input 
					                                     %44 = OpTypeVector %6 3 
					                                     %47 = OpTypePointer Uniform %23 
					                                 void %4 = OpFunction None %3 
					                                      %5 = OpLabel 
					                 read_only Texture2D %12 = OpLoad %11 
					                             sampler %16 = OpLoad %15 
					          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
					                               f32_2 %22 = OpLoad vs_TEXCOORD0 
					                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
					                                 f32 %27 = OpCompositeExtract %24 3 
					                                             OpStore %8 %27 
					                                 f32 %30 = OpLoad %8 
					                        Uniform f32* %37 = OpAccessChain %33 %35 %26 
					                                 f32 %38 = OpLoad %37 
					                                 f32 %39 = OpFMul %30 %38 
					                         Output f32* %41 = OpAccessChain %29 %26 
					                                             OpStore %41 %39 
					                               f32_4 %45 = OpLoad %43 
					                               f32_3 %46 = OpVectorShuffle %45 %45 0 1 2 
					                      Uniform f32_4* %48 = OpAccessChain %33 %35 
					                               f32_4 %49 = OpLoad %48 
					                               f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
					                               f32_3 %51 = OpFMul %46 %50 
					                               f32_4 %52 = OpLoad %29 
					                               f32_4 %53 = OpVectorShuffle %52 %51 4 5 6 3 
					                                             OpStore %29 %53 
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
			}
		}
	}
	CustomEditor "TMPro.EditorUtilities.TMP_BitmapShaderGUI"
}