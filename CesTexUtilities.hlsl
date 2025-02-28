#ifndef CES_TEX_UTILITIES_DEFINED
#define CES_TEX_UTILITIES_DEFINED

inline int PixelCoordToFlat(int2 pixelCoord, int textureSizeX)
{
    return pixelCoord.x + (pixelCoord.y * textureSizeX.x);
}

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
    pixelCoord.x = (int) ((uint) pixelCoord.x & ((uint) textureSize.x - 1u));

    return pixelCoord;
}

#endif // CES_TEX_UTILITIES_DEFINED