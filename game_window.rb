require 'gosu'
require_relative 'background.rb'
require_relative 'player.rb'
require_relative 'sprite.rb'

WIDTH = 640
HEIGHT = 640

WORLD_SIZE_X = 1920
WORLD_SIZE_Y = 640

MAX_OFFSET_X = WORLD_SIZE_X - WIDTH
MIN_OFFSET_X = 0
MAX_OFFSET_Y = WORLD_SIZE_Y - HEIGHT
MIN_OFFSET_Y = 0

class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Game Demo Window'

    @background = Sprite.new(self, 'assets/bg_repeatable.png')
    @background.set_position(0, 0)

    @vine = Sprite.new(self, 'assets/vine_long.png')
    @vine.set_position(200, 0)

    @player = Player.new(self, 200)

    @crate = Sprite.new(self, 'assets/Crate.png')
    @crate.set_position(400, 440)

    @rock = Sprite.new(self, 'assets/rock 1.png')
    @rock.set_position(30, 465)

    @camera_x = 0
  end


  def update
    @player.update
    @player.blocked_object(@crate)

    if self.button_down? Gosu::KbLeft
      @player.move_left
    elsif self.button_down? Gosu::KbRight
      @player.move_right
    end

    if self.button_down? Gosu::KbUp
      @player.jump_up
    end

    @camera_x = @player.player_pos_x - WIDTH / 2

    if @camera_x > MAX_OFFSET_X
      @camera_x = MAX_OFFSET_X
    elsif @camera_x < MIN_OFFSET_X
      @camera_x = MIN_OFFSET_X
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def draw

    Gosu::translate(-@camera_x, 0) do
      @background.draw
      @vine.draw
      @player.draw
      @crate.draw
      @rock.draw
    end

  end


end

GameWindow.new.show
