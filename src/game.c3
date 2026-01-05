module game;
import sdl;
import sdlimage;

import std::io;
import std::math;
import std::thread;

import graphics;
import input;
import globals;
import sprite;

struct Game {
  graphics::Graphics gfx;
  sprite::Sprite player;
}

fn Game init() {
  Game g = {};
  g.gfx = graphics::init();
  g.player = sprite::init(&g.gfx, "content/sprites/MyChar.png", 0, 0, 16, 16, 100, 100);
  return g;
}

fn void Game.deinit(&self) {
  self.gfx.deinit();
}

fn void Game.game_loop(&self){
  Input inp = input::init();
  // Sprite s1 = sprite::init(&self.gfx, "content/sprites/MyChar.png", 0, 0, 16, 16, 100, 100);

  // sdl::Surface* img_player = self.gfx.load_image("content/sprites/MyChar.png");
  // sdl::Texture tex_player = sdl::createTextureFromSurface(self.gfx.renderer, img_player);

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
    if (inp.was_key_pressed(sdl::SCANCODE_LEFT)) {
      self.player.x-=5;
    }
    if (inp.was_key_pressed(sdl::SCANCODE_RIGHT)) {
      self.player.x +=5;
    }

    uint current_time_ms = sdl::getTicks();
    uint delta_time_ms = current_time_ms - last_update_time_ms; 
    last_update_time_ms = current_time_ms;

    self.gfx.clear();
    self.player.draw(&self.gfx, (int)self.player.x, (int)self.player.y);
    self.gfx.flip();

    self.update(delta_time_ms);
    // thread::sleep_ms((ulong)20-delta_time_ms);

  }
}
fn void Game.draw(&self){}
fn void Game.update(&self, float elapsed_time){
    // io::printfn("elapsed time: %f", elapsed_time);

}
