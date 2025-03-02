#ifndef CES_SAMPLING_BORDERS_DEFINED
#define CES_SAMPLING_BORDERS_DEFINED

#include "Assets/CesShaderLibrary/CesMath.hlsl"

struct BorderDistances
{
    float c;
    float u, b, l, r;
    float ul, ur, bl, br;
};

float LerpBorderDistances(BorderDistances distances, float2 fxy)
{
    float x1 = Lerp3(distances.bl, distances.b, distances.br, fxy.x);
    float x2 = Lerp3(distances.l, distances.c, distances.r, fxy.x);
    float x3 = Lerp3(distances.ul, distances.u, distances.ur, fxy.x);
    
    return Lerp3(x1, x2, x3, fxy.y);
}

float SampleBorder(float2 uv, float4 texelSize, TEXTURE2D_PARAM(tex, sampler_tex))
{
    float2 uvRB = uv + float2(texelSize.x, 0);
    float2 uvLT = uv + float2(0, texelSize.y);
    float2 uvRT = uv + float2(texelSize.x, texelSize.y);
    
    float4 colLB = SAMPLE_TEXTURE2D(tex, sampler_tex, uv);
    float4 colRB = SAMPLE_TEXTURE2D(tex, sampler_tex, uvRB);
    float4 colLT = SAMPLE_TEXTURE2D(tex, sampler_tex, uvLT);
    float4 colRT = SAMPLE_TEXTURE2D(tex, sampler_tex, uvRT);
    
    float2 texelCoords = uv * texelSize.zw;
    float2 fxy = frac(texelCoords);
    
    BorderDistances distances = (BorderDistances) 0;
    
    distances.c = colLB.r;
    distances.bl = colLB.g;
    distances.b = colLB.b;
    distances.l = colLB.a;
    
    distances.br = colRB.g;
    distances.r = colRB.a;
    
    distances.ul = colLT.g;
    distances.u = colLT.b;
    
    distances.ur = colRT.g;
    
    return LerpBorderDistances(distances, fxy);
}

#endif // CES_SAMPLING_BORDERS_DEFINED