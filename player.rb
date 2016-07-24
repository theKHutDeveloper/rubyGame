require_relative 'animated_sprite.rb'
require_relative 'movement.rb'

class Player

  GRAVITY = 100
  X_GRAVITY = 20
  JUMP_VELOCITY = 100
  PLAYER_WIDTH = 57
  PLAYER_HEIGHT = 100
  GROUND = 440

  def initialize(window, x)
    @player_x  = x
    @player_y = GROUND

    dt = (window.update_interval / 1000)

    @player_moves = Movement.new(dt, @player_x, @player_y, GRAVITY, X_GRAVITY)

    @direction = :right
    @moving = false
    @jumping = false

    @blocked = {:right => false, :left => false, :up => false, :down => false}
    @player_action = [
        AnimatedSprite.new(window, 'assets/monkey_walk.png', PLAYER_WIDTH, PLAYER_HEIGHT, true),
        AnimatedSprite.new(window, 'assets/monkey_jump.png', PLAYER_WIDTH, PLAYER_HEIGHT, true),
        AnimatedSprite.new(window, 'assets/monkey_idle.png', PLAYER_WIDTH, PLAYER_HEIGHT, true),
    ]
  end

  def player_pos_x
    @player_x
  end

  def player_pos_y
    @player_y
  end

  def move_left
    unless @blocked[:left]
      @direction = :left
      @moving = true
      @player_x = @player_moves.left
    end
  end


  def move_right
    unless @blocked[:right]
      @direction = :right
      @moving = true
      @player_x = @player_moves.right
    end
  end


  def jump_up
    @player_moves.up(JUMP_VELOCITY)
    @jumping = true
  end


  def jump_down

  end


  def update(x1, x2)
    @moving = false
    @jumping = false

    @player_action[0].update
    @player_action[1].update
    @player_action[2].update

    if @player_moves.get_x > (x2 - PLAYER_WIDTH)
      @player_moves.set_x(x2 - PLAYER_WIDTH)
    elsif @player_moves.get_x < x1
      @player_moves.set_x(x1)
    end

    #handle jumping
    @player_moves.update(GROUND)
    @player_y = @player_moves.get_y
  end


  def draw
    if @direction == :right
      facing = 1
    else
      facing = -1
    end

    if @moving
      @player_action[0].draw(@player_moves.get_x, @player_moves.get_y, facing)
    elsif @jumping
      @player_action[1].draw(@player_moves.get_x, @player_moves.get_y, facing)
    else
      @player_action[2].draw(@player_moves.get_x, @player_moves.get_y, facing)
    end
  end


  def push_object(object)
    if @blocked[:right]
      object.push_sprite(25)
    elsif @blocked[:left]
      object.push_sprite(-25)
    end
  end

  def blocked_object(object1)
    offset_x1 = (PLAYER_WIDTH * 0.7)
    offset_x2 = (PLAYER_WIDTH * 0.3)
    if @player_moves.get_x  + offset_x1 >= object1.get_x && @player_moves.get_x <= object1.get_x + object1.get_width - offset_x2 &&
        @player_y >= object1.get_y - object1.get_height && @player_y <= object1.get_y

      if @direction == :right
        @blocked[:right] = true
      elsif @direction == :left
        @blocked[:left] = true
      end

      @blocked[:down] = true
      @blocked[:up] = true

    elsif @player_x  + offset_x1 >= object1.get_x && @player_x  <= object1.get_x + object1.get_width - offset_x2 &&
          @player_y >= object1.get_y - object1.get_height - 20 && !@jumping

        @player_y = @player_moves.set_y(object1.get_y - object1.get_height - 1)
        @player_moves.set_velocity_y(0)
        @blocked[:left] = false
        @blocked[:right] = false
        @blocked[:down] = true

    elsif @player_x + offset_x1 >= object1.get_x && @player_x  <= object1.get_x + object1.get_width - offset_x2 &&
        @player_y < object1.get_y - object1.get_height - 20 || @player_y > object1.get_y
      @player_moves.update(GROUND)
      @player_y = @player_moves.get_y
      @blocked[:left] = false
      @blocked[:right] = false
      @blocked[:down] = true
    else
      @blocked[:left] = false
      @blocked[:right] = false
      @blocked[:down] = false
      @blocked[:up] = false


      if @player_y < GROUND
        @player_moves.set_velocity_y_in_air
      end

    end
  end
end
