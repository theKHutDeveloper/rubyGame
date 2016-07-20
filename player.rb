class Player

  GRAVITY = 100
  X_GRAVITY = 20
  JUMP_VELOCITY = 100
  PLAYER_WIDTH = 57
  PLAYER_HEIGHT = 100
  GROUND = 280

  def initialize(window)
    @window = window

    @@delta_time = (@window.update_interval / 1000)

    @score = 0
    @player_x = @player_y = @velocity_x = @velocity_y = @gravity_x = @gravity_y = 0
    @frame = 0
    @direction = :right
    @moving = false
    @counter = 10
    @jumping = false
    @angle = 0;
    @blocked_right = false
    @blocked_left = false
    @blocked_up = false
    @blocked_down = false

    @walk = Gosu::Image.load_tiles @window, "assets/monkey_walk.png", PLAYER_WIDTH, PLAYER_HEIGHT, true
    @jump = Gosu::Image.load_tiles @window, "assets/monkey_jump.png", PLAYER_WIDTH, PLAYER_HEIGHT, true
    @idle = Gosu::Image.load_tiles @window, "assets/monkey_idle.png", PLAYER_WIDTH, PLAYER_HEIGHT, true
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

      @velocity_y += GRAVITY * @@delta_time
      @player_y += @velocity_y * @@delta_time

      if @player_y > GROUND
        @velocity_y = 0
        @player_y = GROUND
      end

    end


    if @window.button_down? Gosu::KbLeft

      if !@blocked_left

        @direction = :left
        @moving = true
        @velocity_x += X_GRAVITY * @@delta_time
        @player_x -= @velocity_x * @@delta_time

      end

    elsif @window.button_down? Gosu::KbRight

      if !@blocked_right

        @direction = :right
        @moving = true
        @velocity_x += X_GRAVITY * @@delta_time
        @player_x += @velocity_x * @@delta_time

      end
    end

    if @window.button_down? Gosu::KbUp
      #if !@blocked_up
       @velocity_y = -JUMP_VELOCITY
       @jumping = true
      #end
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

  def push_object(object1)

    if @player_x  + PLAYER_WIDTH >= object1.get_x && @player_x <= object1.get_x + object1.get_width &&
        @player_y >= object1.get_y - object1.get_height && @player_y <= object1.get_y

      if @direction == :right

        @blocked_right = true

      elsif @direction == :left

        @blocked_left = true

      end

      @blocked_down = true
      @blocked_up = true

    elsif @player_x  + PLAYER_WIDTH >= object1.get_x && @player_x <= object1.get_x + object1.get_width &&
          @player_y < object1.get_y - object1.get_height || @player_y > object1.get_y

      if (object1.get_y - object1.get_height) - @player_y < 20

        @player_y = object1.get_y - object1.get_height - 1
        @velocity_y = 0
        @blocked_left = false
        @blocked_right = false
        @blocked_down = true

      end

    else

      @blocked_left = false
      @blocked_right = false
      @blocked_down = false
      @blocked_up = false

      if @player_y < GROUND
        @velocity_y += GRAVITY * @@delta_time
      end
    end

  end
end