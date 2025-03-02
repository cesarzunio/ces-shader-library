#ifndef CES_SAMPLING_BICUBIC_DEFINED
#define CES_SAMPLING_BICUBIC_DEFINED

// https://stackoverflow.com/questions/13501081/efficient-bicubic-filtering-code-in-glsl

float4 Cubic(float v)
{
    float4 n = float4(1.0, 2.0, 3.0, 4.0) - v;
    float4 s = n * n * n;
    
    float x = s.x;
    float y = s.y - 4.0 * s.x;
    float z = s.z - 4.0 * s.y + 6.0 * s.x;
    float w = 6.0 - x - y - z;
    
    return float4(x, y, z, w) * (1.0 / 6.0);
}

void InitializeSampleBicubic(float2 uv, float4 texelSize, out float4 s, out float4 offset)
{
    float2 texCoords = (uv * texelSize.zw) - 0.5;

    float2 fxy = frac(texCoords);
    texCoords -= fxy;

    float4 xcubic = Cubic(fxy.x);
    float4 ycubic = Cubic(fxy.y);

    float4 c = texCoords.xxyy + float2(-0.5, 1.5).xyxy;
    
    s = float4(xcubic.xz + xcubic.yw, ycubic.xz + ycubic.yw);
    offset = c + float4(xcubic.yw, ycubic.yw) / s;
    
    offset *= texelSize.xxyy;
}

float SampleBicubic1(float2 uv, float4 texelSize, TEXTURE2D_PARAM(tex, sampler_tex))
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float sample0 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xz).r;
    float sample1 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yz).r;
    float sample2 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xw).r;
    float sample3 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yw).r;

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float s32 = lerp(sample3, sample2, sx);
    float s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float SampleBicubicArray1(float2 uv, float4 texelSize, TEXTURE2D_ARRAY_PARAM(tex, sampler_tex), uint texIndex)
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float sample0 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xz, texIndex).r;
    float sample1 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yz, texIndex).r;
    float sample2 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xw, texIndex).r;
    float sample3 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yw, texIndex).r;

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float s32 = lerp(sample3, sample2, sx);
    float s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float2 SampleBicubic2(float2 uv, float4 texelSize, TEXTURE2D_PARAM(tex, sampler_tex))
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float2 sample0 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xz).rg;
    float2 sample1 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yz).rg;
    float2 sample2 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xw).rg;
    float2 sample3 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yw).rg;

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float2 s32 = lerp(sample3, sample2, sx);
    float2 s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float2 SampleBicubicArray2(float2 uv, float4 texelSize, TEXTURE2D_ARRAY_PARAM(tex, sampler_tex), uint texIndex)
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float2 sample0 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xz, texIndex).rg;
    float2 sample1 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yz, texIndex).rg;
    float2 sample2 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xw, texIndex).rg;
    float2 sample3 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yw, texIndex).rg;

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float2 s32 = lerp(sample3, sample2, sx);
    float2 s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float3 SampleBicubic3(float2 uv, float4 texelSize, TEXTURE2D_PARAM(tex, sampler_tex))
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float3 sample0 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xz).rgb;
    float3 sample1 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yz).rgb;
    float3 sample2 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xw).rgb;
    float3 sample3 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yw).rgb;

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float3 s32 = lerp(sample3, sample2, sx);
    float3 s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float3 SampleBicubicArray3(float2 uv, float4 texelSize, TEXTURE2D_ARRAY_PARAM(tex, sampler_tex), uint texIndex)
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float3 sample0 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xz, texIndex).rgb;
    float3 sample1 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yz, texIndex).rgb;
    float3 sample2 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xw, texIndex).rgb;
    float3 sample3 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yw, texIndex).rgb;

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float3 s32 = lerp(sample3, sample2, sx);
    float3 s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float4 SampleBicubic4(float2 uv, float4 texelSize, TEXTURE2D_PARAM(tex, sampler_tex))
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float4 sample0 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xz);
    float4 sample1 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yz);
    float4 sample2 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.xw);
    float4 sample3 = SAMPLE_TEXTURE2D(tex, sampler_tex, offset.yw);

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float4 s32 = lerp(sample3, sample2, sx);
    float4 s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

float4 SampleBicubicArray4(float2 uv, float4 texelSize, TEXTURE2D_ARRAY_PARAM(tex, sampler_tex), uint texIndex)
{
    float4 s;
    float4 offset;

    InitializeSampleBicubic(uv, texelSize, s, offset);
    
    float4 sample0 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xz, texIndex);
    float4 sample1 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yz, texIndex);
    float4 sample2 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.xw, texIndex);
    float4 sample3 = SAMPLE_TEXTURE2D_ARRAY(tex, sampler_tex, offset.yw, texIndex);

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    float4 s32 = lerp(sample3, sample2, sx);
    float4 s10 = lerp(sample1, sample0, sx);
    
    return lerp(s32, s10, sy);
}

#endif // CES_SAMPLING_BICUBIC_DEFINED