#require 'gosu'

class Player

  def initialize window
    @window = window
    @score = 0
    @x = @y = @velocity_x = @velocity_y = @gravity_x = @gravity_y = 0
    @frame = 0
    @direction = :right
    @moving = false
    @counter = 10
    @jumping = false

    @idle = Gosu::Image.load_tiles @window, "assets/monkey_idle.png", 57, 100, true
    @walk = Gosu::Image.load_tiles @window, "assets/monkey_walk.png", 57, 100, true
    @jump = Gosu::Image.load_tiles @window, "assets/monkey_jump.png", 57, 100, true

  end

  def set_position(x,y)
    @x, @y = x, y
  end

  def get_x
    return @x
  end

  def get_y
    return @y
  end

  def update
    @moving = false
    @jumping = false

    @counter -= 1

    if @counter < 0
      @counter = 10
    elsif @counter == 0
      @frame += 1
    end

    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
    end


     if @window.button_down? Gosu::KbUp
       @y += -5
       @jumping = true
     end

  end

  def draw
    #count = 0

    if @moving
      count = @frame %@walk.size
      image = @walk[count]
    else
      count = @frame %@idle.size
      image = @idle[count]
    end

    if @jumping
      count = @frame %@jump.size
      image = @jump[count]
    end

    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + image.width, @y, 1, -1
    end

  end
end