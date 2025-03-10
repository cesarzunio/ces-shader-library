#ifndef CES_SAMPLING_FIELDS_DEFINED
#define CES_SAMPLING_FIELDS_DEFINED

#include "Assets/CesShaderLibrary/CesConsts.hlsl"
#include "Assets/CesShaderLibrary/CesGeoUtilities.hlsl"
#include "Assets/CesShaderLibrary/CesTexUtilities.hlsl"

void AddSample(uint field, float weight, inout uint samplesField[4], inout float samplesWeight[4], inout uint samplesCount)
{
    [unroll] // without [unroll] compiler complains
    for (uint i = 0; i < samplesCount; i++)
    {
        if (samplesField[i] == field)
        {
            samplesWeight[i] += weight;
            return;
        }
    }

    samplesField[samplesCount] = field;
    samplesWeight[samplesCount] = weight;
    samplesCount++;
}

uint GetSampleIndex(in float samplesWeight[4])
{
    float weightMax = samplesWeight[0];
    uint indexMax = 0;
    
    [unroll]
    for (uint i = 1; i < 4; i++)
    {
        if (weightMax < samplesWeight[i])
        {
            weightMax = samplesWeight[i];
            indexMax = i;
        }
    }
    
    return indexMax;
}

uint SampleField(float2 uv)
{
    uv -= FIELDSMAP_TEXEL_SIZE * 0.5;
    
    int2 pixelCoord = PlaneUvToPixelCoord(uv, FIELDSMAP_TEXTURE_SIZE_INT);
    int2 pixelCoordR = ClampPixelCoord(pixelCoord + int2(1, 0), FIELDSMAP_TEXTURE_SIZE_INT);
    int2 pixelCoordU = ClampPixelCoord(pixelCoord + int2(0, 1), FIELDSMAP_TEXTURE_SIZE_INT);
    int2 pixelCoordUR = ClampPixelCoord(pixelCoord + int2(1, 1), FIELDSMAP_TEXTURE_SIZE_INT);
    
    int flat = PixelCoordToFlat(pixelCoord, FIELDSMAP_TEXTURE_SIZE_X_INT);
    int flatR = PixelCoordToFlat(pixelCoordR, FIELDSMAP_TEXTURE_SIZE_X_INT);
    int flatU = PixelCoordToFlat(pixelCoordU, FIELDSMAP_TEXTURE_SIZE_X_INT);
    int flatUR = PixelCoordToFlat(pixelCoordUR, FIELDSMAP_TEXTURE_SIZE_X_INT);
    
    uint s = ces_FieldsMap[flat];
    uint sR = ces_FieldsMap[flatR];
    uint sU = ces_FieldsMap[flatU];
    uint sUR = ces_FieldsMap[flatUR];
    
    float2 fxy = frac(uv * FIELDSMAP_TEXTURE_SIZE);
    
    float w = (1 - fxy.x) * (1 - fxy.y);
    float wR = fxy.x * (1 - fxy.y);
    float wU = (1 - fxy.x) * fxy.y;
    float wUR = fxy.x * fxy.y;
    
    uint samplesField[4] = { 0, 0, 0, 0 };
    float samplesWeight[4] = { 0, 0, 0, 0 };
    uint samplesCount = 0;
    
    AddSample(s, w, samplesField, samplesWeight, samplesCount);
    AddSample(sR, wR, samplesField, samplesWeight, samplesCount);
    AddSample(sU, wU, samplesField, samplesWeight, samplesCount);
    AddSample(sUR, wUR, samplesField, samplesWeight, samplesCount);
    
    return samplesField[GetSampleIndex(samplesWeight)];
}

#endif // CES_SAMPLING_FIELDS_DEFINED