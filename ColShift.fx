#include "ReShade.fxh"

uniform float HardRedCutoff <
    ui_type = "drag";
    ui_min = 0.0; ui_max = 1.0;
    ui_label = "Hard Red Cutoff";
> = float(0.85);

uniform float SoftRedCutoff <
    ui_type = "drag";
    ui_min = 0.0; ui_max = 1.0;
    ui_label = "Soft Red Cutoff";
> = float(0.6);

uniform float HardGreenCutoff <
    ui_type = "drag";
    ui_min = 0.0; ui_max = 1.0;
    ui_label = "Hard Green Cutoff";
> = float(0.6);

uniform float SoftGreenCutoff <
    ui_type = "drag";
    ui_min = 0.0; ui_max = 1.0;
    ui_label = "Soft Green Cutoff";
> = float(0.85);

uniform float BlueCutoff <
    ui_type = "drag";
    ui_min = 0.0; ui_max = 1.0;
    ui_label = "Blue Cutoff";
> = float(0.3);

uniform bool Yellow <
	ui_type = "checkbox";
	ui_label = "Yellow instead of Green";
> = false;


float3 ColShiftPass(float4 position: SV_Position, float2 texcoord: TexCoord): SV_Target
{
    float3 input = tex2D(ReShade::BackBuffer, texcoord).rgb;
    if (input.r >= HardRedCutoff && input.g <= HardGreenCutoff && input.b <= BlueCutoff)
    {
		if (Yellow)
			return input.rrb;
		else
			return input.grb;		
    }

    if (input.r >= SoftRedCutoff && input.g <= SoftGreenCutoff && input.b <= BlueCutoff)
    {
		float alphaR = (input.r - SoftRedCutoff) / (HardRedCutoff - SoftRedCutoff);
		if (Yellow)
			return lerp(input.rgb, input.rrb, alphaR);
		else
			return lerp(input.rgb, input.grb, alphaR);
    }
	
    return input;
}

technique ColShift
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = ColShiftPass;
    }
}