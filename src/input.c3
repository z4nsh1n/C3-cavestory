module input;
import sdl;

import std::collections::set;

fn uint sdl::Scancode.hash(self) {
  return ((int)self).hash();
}
alias KeyMap = set::HashSet{sdl::Scancode};
// alias KeyMap = set::HashSet{int};


struct Input {
  KeyMap held_keys;
  KeyMap pressed_keys;
  KeyMap released_keys;
}

fn Input init() {
  return {(KeyMap) {}, (KeyMap) {}, (KeyMap) {}};
}

fn bool Input.was_key_pressed(&self, sdl::Scancode scancode) {
  return self.pressed_keys.contains(scancode);
}

fn bool Input.was_key_released(&self, sdl::Scancode scancode) {
  return self.released_keys.contains(scancode);
}
fn void Input.key_up_event(&self, sdl::Event *event) {
  self.released_keys.add(event.key.keysym.scancode);
  self.held_keys.remove(event.key.keysym.scancode);
}

fn void Input.key_down_event(&self, sdl::Event *event) {
  self.pressed_keys.add(event.key.keysym.scancode);
  self.held_keys.add(event.key.keysym.scancode);
}

fn void Input.begin_new_frame(&self) {
  self.pressed_keys.clear();
  self.released_keys.clear();
}


