module graphics;
import sdl;
import sdlimage;
import std::collections::map;
import std::io;


alias ImgMap = map::HashMap{String, sdl::Surface*};

struct Graphics {
  sdl::Window *window;
  sdl::Renderer *renderer;
  ImgMap spritesheets;
}

fn Graphics init() {
  sdl::init(sdl::INIT_EVERYTHING);
  sdlimage::imageInit(sdlimage::IMG_InitFlags.PNG);

  sdl::Window *window;
  sdl::Renderer *renderer;
  sdl::createWindowAndRenderer(640, 480, 0, &window, &renderer);
  sdl::setWindowTitle(window, "Hello world");
  return {window, renderer, (ImgMap){}};
}

fn sdl::Surface* Graphics.load_image(&self, ZString file) {
    String f = file.str_view();
    if(self.spritesheets.has_key(f))  {
      io::eprintfn("Texture was loaded: %s", f);
      return self.spritesheets.get(f)!!;
    }
    sdl::Surface *s1 = sdlimage::img_load(file)!!;
      io::eprintfn("Loaded texture: %s", f);
    self.spritesheets.set(f, s1);
    return s1;
}

fn void Graphics.blitSurface(&self, sdl::Texture texture, sdl::Rect* src_rect, sdl::Rect* dst_rect) {
    sdl::renderCopy(self.renderer, texture, src_rect, dst_rect);
}

fn void Graphics.flip(&self) {
  sdl::renderPresent(self.renderer);
}
fn void Graphics.clear(&self) {
  sdl::renderClear(self.renderer);
}

fn void Graphics.deinit(&self) {
  sdl::destroyRenderer(self.renderer);
  sdl::destroyWindowSurface(self.window);
  sdl::destroyWindow(self.window);
  sdl::quit();
}
