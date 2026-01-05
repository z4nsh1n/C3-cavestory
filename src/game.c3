module game;
import sdl;
import sdlimage;

import std::io;
import std::math;
import std::thread;

import graphics;
import input;
import globals;

struct Game {
  graphics::Graphics gfx;
}

fn Game init() {
  return {graphics::init()};
}

fn void Game.deinit(&self) {
  self.gfx.deinit();
}

fn void Game.game_loop(&self){
  Input inp = input::init();
  sdl::Surface* img_player = self.gfx.load_image("content/sprites/MyChar.png");
  sdl::Texture tex_player = sdl::createTextureFromSurface(self.gfx.renderer, img_player);

  sdl::Event event;
  uint last_update_time_ms = sdl::getTicks();

  while MAINLOOP: (true) {
    inp.begin_new_frame();
    
    while(sdl::pollEvent(&event) == 1){
      if(event.type == sdl::KEYDOWN) {
          // if(event.key.keysym.scancode == sdl::SCANCODE_ESCAPE) break;
          io::printn(event.key.keysym);
          inp.key_down_event(&event);
        }
        if(event.type == sdl::KEYUP) {
          io::printn(event.key.keysym);
          inp.key_up_event(&event);
        }
        if(event.type == sdl::QUIT) break MAINLOOP;
    }
    if (inp.was_key_pressed(sdl::SCANCODE_ESCAPE))  break;

    uint current_time_ms = sdl::getTicks();
    uint delta_time_ms = current_time_ms - last_update_time_ms; 
    last_update_time_ms = current_time_ms;

    sdl::Rect src_rect = {0, 0, 16, 16};
    sdl::Rect dst_rect = {10, 10, 32, 32};

    // self.gfx.blitSurface(tex_player, &src_rect, &dst_rect);
    sdl::setRenderDrawColor(self.gfx.renderer, 0,0,0,255);
    self.gfx.clear();
    self.gfx.blitSurface(tex_player, &src_rect, &dst_rect);
    self.gfx.flip();

    self.update(delta_time_ms);
    // thread::sleep_ms((ulong)20-delta_time_ms);

  }
}
fn void Game.draw(&self){}
fn void Game.update(&self, float elapsed_time){
    // io::printfn("elapsed time: %f", elapsed_time);

}
