#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

struct VertexShaderInput
{
	float4 Position : POSITION0;
	float4 Color : COLOR0;
};

struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
    float4 Red : COLOR1;
	float4 Color : COLOR0;
};

VertexShaderOutput MainVS(in VertexShaderInput input)
{
	VertexShaderOutput output = (VertexShaderOutput)0;

    output.Position = input.Position;
    output.Red = float4(1, 0, 0, 1);
	output.Color = input.Color;

	return output;
}

// we expect the passed color to be used according to the semantics,
// but because of the position 'output.Red' is bound to 'color' and 'output.Color' to 'red' for DX projects
// DesktopGL binds parameters correctly
float4 MainPS(float4 position : SV_POSITION, float4 color : COLOR0, float4 red : COLOR1) : COLOR
{
	return color;
}

technique BasicColorDrawing
{
	pass P0
	{
		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};