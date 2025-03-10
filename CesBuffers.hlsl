#ifndef CES_BUFFERS_DEFINED
#define CES_BUFFERS_DEFINED

StructuredBuffer<uint> ces_FieldsMap; // uint32 index unpacked
StructuredBuffer<uint> ces_FieldToColor; // uint32 color unpacked
StructuredBuffer<uint> ces_FieldToIsWater; // uint32 flag packed 32
StructuredBuffer<uint> ces_FieldToSelected; // uint32 flag packed 32
StructuredBuffer<int> ces_FieldToBorderGradient; // int32 index unpacked

#endif // CES_BUFFERS_DEFINED