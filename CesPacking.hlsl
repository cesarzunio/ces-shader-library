#ifndef CES_PACKING_DEFINED
#define CES_PACKING_DEFINED

inline uint CesUnpackFlagFromUInt32(uint value, uint mod32)
{
    return (value >> mod32) & 1u;
}

#endif // CES_PACKING_DEFINED