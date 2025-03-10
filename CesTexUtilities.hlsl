#ifndef CES_TEX_UTILITIES_DEFINED
#define CES_TEX_UTILITIES_DEFINED

inline int PixelCoordToFlat(int2 pixelCoord, int textureSizeX)
{
    return pixelCoord.x + (pixelCoord.y * textureSizeX.x);
}

// assumes textureSizeX is a power of 2
inline int ClampPixelCoordX(int pixelCoordX, int textureSizeX)
{
    return (int) ((uint) pixelCoordX & ((uint) textureSizeX - 1u));
}

// assumes textureSizeX is a power of 2
int2 ClampPixelCoord(int2 pixelCoord, int2 textureSize)
{
    int yWrapBot = -pixelCoord.y - 1;
    int yWrapTop = (2 * textureSize.y) - pixelCoord.y - 1;
    int xWrapY = pixelCoord.x + (textureSize.x / 2);

    int yWrapAnyNeeded = (pixelCoord.y < 0 || pixelCoord.y >= textureSize.y) ? 1 : 0;
    int yWrapNotNeeded = 1 - yWrapAnyNeeded;
    int yWrapBotNeeded = (pixelCoord.y < 0) ? 1 : 0;
    int yWrapTopNeeded = (pixelCoord.y >= textureSize.y) ? 1 : 0;

    pixelCoord.y = (yWrapNotNeeded * pixelCoord.y) + (yWrapBotNeeded * yWrapBot) + (yWrapTopNeeded * yWrapTop);
    pixelCoord.x = (yWrapNotNeeded * pixelCoord.x) + (yWrapAnyNeeded * xWrapY);
    pixelCoord.x = ClampPixelCoordX(pixelCoord.x, textureSize.x);

    return pixelCoord;
}

float2 ClampUv(float2 uv)
{
    float yWrapBot = -uv.y - 1;
    float yWrapTop = 2 - uv.y;
    float xWrapY = uv.x + 0.5;

    float yWrapAnyNeeded = (uv.y < 0 || uv.y >= 1) ? 1.0 : 0.0;
    float yWrapNotNeeded = 1 - yWrapAnyNeeded;
    float yWrapBotNeeded = (uv.y < 0) ? 1.0 : 0.0;
    float yWrapTopNeeded = (uv.y >= 1) ? 1.0 : 0.0;

    uv.y = (yWrapNotNeeded * uv.y) + (yWrapBotNeeded * yWrapBot) + (yWrapTopNeeded * yWrapTop);
    uv.x = (yWrapNotNeeded * uv.x) + (yWrapAnyNeeded * xWrapY);
    uv.x = frac(uv.x + 1);

    return uv;
}

#endif // CES_TEX_UTILITIES_DEFINED