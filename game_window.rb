require 'gosu'
require_relative 'background.rb'
require_relative 'player.rb'
require_relative 'sprite.rb'

WIDTH = 800
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

    @player = Player.new(self, 200)

    @crate = Sprite.new(self, 'assets/Crate.png')
    @crate.set_position(700, 440)

    @platform = Array.new(28)

    for i in 0...@platform.length
      @platform[i] = Sprite.new(self, 'assets/wood-block-small.png')
    end

    start = 100
    start_y = 100
    for i in 0...@platform.length
      @platform[i].set_position(start, start_y)
      if i == 3 || i == 6 || i == 8 || i == 16 || i == 25
        start += 102
      end

      if i == 22
        start += 102*2
      end
      if i == 13
        start = 50
      else
        start += 102
      end

      if i >= 13 && i < 19
        start_y = 280
      end
    end

    @rock = Sprite.new(self, 'assets/rock 1.png')
    @rock.set_position(30, 465)

    @camera_x = 0
  end


  def update
    @player.update(0, WORLD_SIZE_X)

    if self.button_down? Gosu::KbLeft
      @player.move_left
    elsif self.button_down? Gosu::KbRight
      @player.move_right
    end

    if self.button_down? Gosu::KbUp
      if @player.on_ground?
        @player.jump_up
      elsif @player.player_on_platform(@crate)
        @player.set_up
        @player.jump_up
      elsif @player.player_on_array_platform(@platform) == true
        @player.set_up
        @player.jump_up
      end
    end

    if self.button_down? Gosu::KbX
        @player.push_object(@crate)
    elsif self.button_down? Gosu::KbZ
      @player.push_object(@crate)
    end



    @crate.update

    @player.blocked_object(@crate)

    @platform.each do
      |i| @player.platform_blocked(i)
      @player.on_platform(i)
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

      @platform.each do |i|
        i.draw
      end

      @player.draw
      @crate.draw
      @rock.draw
    end

  end


end

GameWindow.new.show
