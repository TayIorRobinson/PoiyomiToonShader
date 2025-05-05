#include <HLSLSupport.cginc>

#include "ClassicNoise3D.hlsl" 

fixed4 ttl_fgColor(float3 viewDir) 
{
    const fixed4 galaxyColor1 = { 0.694, 0.100, 1.000, 1 };
    const fixed4 galaxyColor2 = { 0.069, 0.000, 0.141, 1};
            
    float noise = ttl_pnoise(viewDir * 1.5, 10) * 2 ;
    float factor = (pow(noise,0.9) * 2);
    float galaxyGradient = clamp(factor * 2, 0, 1);
    fixed4 color =  (galaxyColor1 * (1 - galaxyGradient)) + (galaxyColor2 * galaxyGradient);
    return color * (1 - factor);
            
}

fixed4 ttl_bgColor(float3 viewDir)
{
    const fixed4 bgColor1 = { 0.594, 0.000, 0.271, 1 };
    const fixed4 bgColor2 = { 0.936, 0.000, 0.056, 1 };

            
            
    float bgNoise = pow(ttl_cnoise(viewDir * 2) + 0.5,2) * 2;

    return (bgColor1 * (1 - bgNoise)) + (bgColor2 * bgNoise);
            
}

fixed4 tayterial(float3 viewDir)
{
            
    fixed4 bg_color = ttl_bgColor(viewDir);
    fixed4 galaxy_color = ttl_fgColor(viewDir);
    fixed galaxyFactor = clamp(galaxy_color[3],0,1);
    return (bg_color * (1 - galaxyFactor)) + (clamp(galaxy_color,0,1) * galaxyFactor);
}