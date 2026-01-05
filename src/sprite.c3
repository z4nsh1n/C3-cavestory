module sprite;
import graphics;
import sdl;

struct Sprite{
  sdl::Rect src_rect;
  sdl::Texture spritesheet;
  float x;
  float y;
}

fn Sprite init(graphics::Graphics* gfx, String file, int sourceX, int sourceY, int width, int height, 
    float posX, float posY){
  Sprite s = {};
  s.src_rect.x = sourceX;
  s.src_rect.y = sourceY;
  s.src_rect.w = width;
  s.src_rect.h = height;
  s.spritesheet = sdl::createTextureFromSurface(gfx.renderer, gfx.load_image(file.zstr_tcopy()));
  s.x = posX;
  s.y = posY;
  return s;
}

// Make Interface!!
fn void Sprite.update(&self){}

fn void Sprite.draw(&self, graphics::Graphics* gfx, int x, int y, ){
  sdl::Rect dst_rect = {};
  dst_rect.x = x;
  dst_rect.y = y;
  dst_rect.w = self.src_rect.w * 2;
  dst_rect.h = self.src_rect.h * 2;
  gfx.blitSurface(self.spritesheet, &self.src_rect, &dst_rect);
}
