#ifndef CES_CONSTS_DEFINED
#define CES_CONSTS_DEFINED

#ifndef PI
#define PI 3.14159265358979f
#endif // PI

#define PI2 6.28318530717959f
#define PI_HALF 1.5707963267949f

#define FLOAT_MAX 3.402823466e+38f
#define FLOAT_MIN -3.402823466e+38f
#define INT16_MAX_F 32767.0f

#define FIELDS_TEXTURE_SIZE_X 16384.0f
#define FIELDS_TEXTURE_SIZE_Y 8192.0f
#define FIELDS_TEXTURE_SIZE float2(FIELDS_TEXTURE_SIZE_X, FIELDS_TEXTURE_SIZE_Y)

#define FIELDS_TEXTURE_SIZE_INT_X 16384
#define FIELDS_TEXTURE_SIZE_INT_Y 8192
#define FIELDS_TEXTURE_SIZE_INT int2(FIELDS_TEXTURE_SIZE_INT_X, FIELDS_TEXTURE_SIZE_INT_Y)

#define FIELDS_TEXTURE_TEXEL_X 0.00006103515625f
#define FIELDS_TEXTURE_TEXEL_Y 0.0001220703125f
#define FIELDS_TEXTURE_TEXEL float2(FIELDS_TEXTURE_TEXEL_X, FIELDS_TEXTURE_TEXEL_Y)

#endif // CES_CONSTS_DEFINED