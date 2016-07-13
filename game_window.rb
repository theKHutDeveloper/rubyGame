require 'gosu'
require_relative 'background.rb'
require_relative 'player.rb'


class GameWindow < Gosu::Window
  def initialize
    @WIDTH = 640
    @HEIGHT = 480

    super @WIDTH, @HEIGHT
    self.caption = "Game Demo Window"
    #@player = Person.new
    @backgnd = Background.new(self)
    @player = Player.new(self)
    @player.set_position(100,280)
  end

  def update
    @player.update
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def draw
    @backgnd.draw
    @player.draw
  end
end



window = GameWindow.new.show
