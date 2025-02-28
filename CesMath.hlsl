#ifndef CES_MATH_DEFINED
#define CES_MATH_DEFINED

// https://math.stackexchange.com/questions/1098487/atan2-faster-approximation
float CesFastAtan2(float y, float x)
{
    float abs_y = abs(y);
    float abs_x = abs(x);
    float a = min(abs_x, abs_y) / max(abs_x, abs_y);
    float s = a * a;
    float r = ((-0.0464964749 * s + 0.15931422) * s - 0.327622764) * s * a + a;
    
    r = (abs_y > abs_x ? 1.57079637 - r : r);
    r = (x < 0 ? 3.14159274 - r : r);
    r = (y < 0 ? -r : r);
    
    return r;
}

float Lerp3(float x, float y, float z, float t)
{
    float t1 = t * 2;
    
    float w1 = saturate(1 - t1);
    float w2 = saturate(t1) * saturate(2 - t1);
    float w3 = saturate(t1 - 1);
    
    return (x * w1) + (y * w2) + (z * w3);
}

// -------------------------------------------
// ----------------- Unlerp ------------------
// -------------------------------------------

inline float Unlerp(float a, float b, float x)
{
    return (x - a) / (b - a);
}

inline float2 Unlerp(float2 a, float2 b, float2 x)
{
    return (x - a) / (b - a);
}

inline float3 Unlerp(float3 a, float3 b, float3 x)
{
    return (x - a) / (b - a);
}

inline float4 Unlerp(float4 a, float4 b, float4 x)
{
    return (x - a) / (b - a);
}

// -------------------------------------------
// ----------------- Remap -------------------
// -------------------------------------------

inline float Remap(float x, float a1, float b1, float a2, float b2)
{
    return lerp(a2, b2, Unlerp(a1, a2, x));
}

#endif