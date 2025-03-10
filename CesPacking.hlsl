#ifndef CES_PACKING_DEFINED
#define CES_PACKING_DEFINED

inline float CesUnpackFloatFromUInt32(uint value, uint mod4)
{
    return ((value >> (mod4 * 8u)) & 255u) / 255.0f;
}

inline float4 CesUnpackColorFromUInt32(uint value)
{
    return float4
    (
        CesUnpackFloatFromUInt32(value, 0),
        CesUnpackFloatFromUInt32(value, 1),
        CesUnpackFloatFromUInt32(value, 2),
        CesUnpackFloatFromUInt32(value, 3)
    );
}

inline uint CesUnpackFlagFromUInt32(uint value, uint mod32)
{
    return (value >> mod32) & 1u;
}

#endif // CES_PACKING_DEFINED