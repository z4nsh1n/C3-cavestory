module game;
import std::io;


fn int main(String[] args)
{
  Game game = game::init();
  game.game_loop();

  return 0;
}
