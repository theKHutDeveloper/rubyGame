class Player

  GRAVITY = 100
  X_GRAVITY = 20
  JUMP_VELOCITY = 100

  def initialize window
    @window = window
    @score = 0
    @player_x = @player_y = @velocity_x = @velocity_y = @gravity_x = @gravity_y = 0
    @frame = 0
    @direction = :right
    @moving = false
    @counter = 10
    @jumping = false
    @angle = 0;

    @walk = Gosu::Image.load_tiles @window, "assets/monkey_walk.png", 57, 100, true
    @jump = Gosu::Image.load_tiles @window, "assets/monkey_jump.png", 57, 100, true
    @idle = Gosu::Image.load_tiles @window, "assets/monkey_idle.png", 57, 100, true
  end

  def set_position(x,y)
    @player_x, @player_y = x, y
  end

  def get_x
    @player_x
  end

  def get_y
    @player_y
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

    #handle jumping
    if @velocity_y != 0
      delta_time = (@window.update_interval / 1000)
      @velocity_y += GRAVITY * delta_time
      @player_y += @velocity_y * delta_time
      if @player_y > 280
        @velocity_y = 0
        @player_y = 280
      end
    end

    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      delta_time = (@window.update_interval / 1000)
      @velocity_x += X_GRAVITY * delta_time
      @player_x -= @velocity_x * delta_time

    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      delta_time = (@window.update_interval / 1000)
      @velocity_x += X_GRAVITY * delta_time
      @player_x += @velocity_x * delta_time
    end

    if @window.button_down? Gosu::KbUp
       @velocity_y = -JUMP_VELOCITY
       @jumping = true
    end

  end

  def draw

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
      image.draw @player_x, @player_y, 1 #0.9, 0.9
    else
      image.draw @player_x + image.width, @player_y, 1, -1 #-0.9, 0.9
    end

  end
end