#ifndef CES_BUFFERS_DEFINED
#define CES_BUFFERS_DEFINED

StructuredBuffer<uint> ces_FieldsMap; // uint32, 4 bytes per element

// buffers for jfa gradients
StructuredBuffer<uint> ces_FieldToSelected; // uint32, 1 bit per element

#endif // CES_BUFFERS_DEFINED