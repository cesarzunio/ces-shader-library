#ifndef CES_GEO_UTILITIES_DEFINED
#define CES_GEO_UTILITIES_DEFINED

#include "CesConsts.hlsl"
#include "CesTexUtilities.hlsl"
#include "CesMath.hlsl"

float3 GeoCoordToUnitSphere(float2 geoCoords)
{
    float r = cos(geoCoords.y);
    float x = -sin(geoCoords.x) * r;
    float y = -sin(geoCoords.y);
    float z = cos(geoCoords.x) * r;

    return float3(x, y, z);
}

float2 UnitSphereToGeoCoord(float3 unitSphere)
{
    float lonRad = atan2(-unitSphere.x, unitSphere.z);
    float latRad = asin(-unitSphere.y);

    return float2(lonRad, latRad);
}

float2 UnitSphereToGeoCoordAtan(float3 unitSphere)
{
    float lonRad = atan2(-unitSphere.x, unitSphere.z);
    float radiusXZ = sqrt(unitSphere.x * unitSphere.x + unitSphere.z * unitSphere.z);
    float latRad = atan2(-unitSphere.y, radiusXZ);

    return float2(lonRad, latRad);
}

float2 UnitSphereToGeoCoordAtanFast(float3 unitSphere)
{
    float lonRad = CesFastAtan2(-unitSphere.x, unitSphere.z);
    float radiusXZ = sqrt(unitSphere.x * unitSphere.x + unitSphere.z * unitSphere.z);
    float latRad = CesFastAtan2(-unitSphere.y, radiusXZ);

    return float2(lonRad, latRad);
}

float2 GeoCoordsToPlaneUv(float2 geoCoords)
{
    float u = (geoCoords.x / (PI2)) + 0.5;
    float v = 0.5 - (geoCoords.y / PI);

    return float2(u, v);
}

float2 PlaneUvToGeoCoord(float2 uv)
{
    float lonRad = (uv.x - 0.5) * PI2;
    float latRad = (0.5 - uv.y) * PI;

    return float2(lonRad, latRad);
}

float3 PlaneUvToUnitSphere(float2 planeUv)
{
    return GeoCoordToUnitSphere(PlaneUvToGeoCoord(planeUv));
}

float2 UnitSphereToPlaneUv(float3 unitSphere)
{
    return GeoCoordsToPlaneUv(UnitSphereToGeoCoord(unitSphere));
}

float2 UnitSphereToPlaneUvAtan(float3 unitSphere)
{
    return GeoCoordsToPlaneUv(UnitSphereToGeoCoordAtan(unitSphere));
}

float2 UnitSphereToPlaneUvAtanFast(float3 unitSphere)
{
    return GeoCoordsToPlaneUv(UnitSphereToGeoCoordAtanFast(unitSphere));
}

float2 PixelCoordToPlaneUv(int2 pixelCoord, int2 textureSize)
{
    float x = (pixelCoord.x + 0.5) / textureSize.x;
    float y = (pixelCoord.y + 0.5) / textureSize.y;

    return float2(x, y);
}

float2 EdgeCoordToPlaneUv(int2 pixelCoord, int2 textureSize)
{
    float x = pixelCoord.x / (float) textureSize.x;
    float y = pixelCoord.y / (float) textureSize.y;

    return float2(x, y);
}

int2 PlaneUvToPixelCoord(float2 uv, int2 textureSize)
{
    int x = (int) (uv.x * textureSize.x);
    int y = (int) (uv.y * textureSize.y);

    return ClampPixelCoord(int2(x, y), textureSize);
}

float3 PixelCoordToUnitSphere(int2 pixelCoord, int2 textureSize)
{
    return PlaneUvToUnitSphere(PixelCoordToPlaneUv(pixelCoord, textureSize));
}

float Distance(float3 unitSphereA, float3 unitSphereB)
{
    float d = dot(unitSphereA, unitSphereB);
    d = clamp(d, -1.0, 1.0);

    return acos(d);
}

float DistanceAtan(float3 unitSphereA, float3 unitSphereB)
{
    float3 crossV = cross(unitSphereA, unitSphereB);
    float sinTheta = length(crossV);
    float cosTheta = dot(unitSphereA, unitSphereB);

    return atan2(sinTheta, cosTheta);
}

float DistanceAtanFast(float3 unitSphereA, float3 unitSphereB)
{
    float3 crossV = cross(unitSphereA, unitSphereB);
    float sinTheta = length(crossV);
    float cosTheta = dot(unitSphereA, unitSphereB);

    return CesFastAtan2(sinTheta, cosTheta);
}

#endif // CES_GEO_UTILITIES_DEFINED