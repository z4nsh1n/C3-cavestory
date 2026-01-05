module sdlimage;
import sdl;

enum IMG_InitFlags : const CInt {
    JPG    = 0x00000001,
    PNG    = 0x00000002,
    TIF    = 0x00000004,
    WEBP   = 0x00000008,
    JXL    = 0x00000010,
    AVIF   = 0x00000020
}

extern fn int imageInit(IMG_InitFlags flags) @cname("IMG_Init");
extern fn sdl::Surface* imageLoad(ZString file) @cname("IMG_Load") @private;
extern fn sdl::Texture* textureLoad(sdl::Renderer renderer, ZString file) @cname("IMG_LoadTexture") @private;

faultdef FILE_NOT_FOUND;

fn sdl::Texture*? img_load_texture(sdl::Renderer renderer, ZString file) {
  sdl::Texture tex = textureLoad(renderer, file);
  if (tex == null) {
    return FILE_NOT_FOUND?;
  } else {
    return tex;
  }
}

fn sdl::Surface*? img_load(ZString file) {
  sdl::Surface* surf = sdlimage::imageLoad(file);
  if (surf == null) {
    return FILE_NOT_FOUND?;
  } else {
    return surf;
  }

}
