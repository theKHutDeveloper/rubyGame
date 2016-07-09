require 'gosu'
require 'gosu_tiled'
require_relative 'player.rb'
require_relative 'background.rb'

class GameWindow < Gosu::Window
  def initialize
    @WIDTH = 1000
    @HEIGHT = 600

    super 640, 480
    self.caption = "Game Demo Window"
    #@player = Person.new
    @player = Player.new(self)
    @map = Background.new(self)
    @player.set_position(100,200)
    @camera_x = @camera_y = 300
  end

  def update
    @map.update
    @player.update
    # Scrolling follows player
    @camera_x = [[@player.get_x - @WIDTH / 2, 0].max, @map.width * 50 - @WIDTH].min
    @camera_y = [[@player.get_y - @HEIGHT / 2, 0].max, @map.height * 50 - @HEIGHT].min
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def draw
    Gosu::translate(-@camera_x, -@camera_y) do
      @map.draw
      @player.draw
    end
  end
end



window = GameWindow.new.show
