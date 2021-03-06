require_relative 'animated_sprite.rb'
require_relative 'computer_generated_movements.rb'

class Enemy

  GRAVITY_X = 10
  GRAVITY_Y = 0

  PLATFORM_ONE_Y = -18
  PLATFORM_TWO_Y = 70

  COUNTER = 5

  def initialize(window, x, y)
    @enemy_x = x
    @enemy_y = y
    @enemy_time = window.update_interval / 500

    dt = window.update_interval / 1000

    @enemy_moves = Computer_Generated_Movements.new(dt, @enemy_x, @enemy_y, GRAVITY_Y, GRAVITY_X)

    @enemy = AnimatedSprite.new(window, 'assets/king_kong.png', 160, 150, true)

    @x_direction = :right
    @y_direction = :up

    @enemy_moves.reset_timer
    @hunted_values = []

    #@moving = false

    #@m_time = Time.now
  end


  def update(x,y)

    #timer has elapsed, find player and reset timer
    if @enemy_moves.timer_elapsed?(COUNTER)
      get_hunted_object_position(x, y)
      @enemy_moves.reset_timer
    end

    #array is not nil so update enemy position
    unless @hunted_values.empty? || @hunted_values.nil?
      offset = 28

      if @enemy_x > @hunted_values[0] && @enemy_moves.get_x > @hunted_values[0] + offset
        @x_direction = :left
        @enemy_x -= 5
      elsif @enemy_x < @hunted_values[0] && @enemy_moves.get_x < @hunted_values[0] - offset
        @x_direction = :right
        @enemy_x += 5
      else
        @hunted_values = []
      end

=begin
      if @x_direction == :left
        puts 'move enemy left'
        @enemy_x -= 5
      elsif @x_direction == :right
        puts 'move enemy right'
        @enemy_x += 5
      else #if @x_direction == :none
        puts 'here'
      end

      if @y_direction == :up
        puts 'move enemy up'
      elsif @y_direction == :down
        puts 'move enemy down'
      end
=end
    end





  end


  def draw
    if @x_direction == :right
      facing = 1
    else
      facing = -1
    end

    @enemy.draw(@enemy_x, @enemy_y, facing)
  end



  def get_hunted_object_position(x, y)
    @hunted_values = [x,y]
  end

  def find_player_object(x, y)

      #offset = 28
      if @enemy_x > x #&& @enemy_moves.get_x > x + offset
        @x_direction = :left
      elsif @enemy_x < x #&& @enemy_moves.get_x < x - offset
        @x_direction = :right
      else #if @enemy_moves.get_x >= x - offset && @enemy_moves.get_x <= x + offset
        @x_direction = :none
        puts 'help'
      end

      if @enemy_y > y
        @y_direction = :up
      elsif @enemy_y < y
        @y_direction = :down
      end
  end


=begin
  def snapshot(x, y)

    if Time.now > @m_time + COUNTER
      @start_enemy_movement = true
      find_player_object(x, y)
    end

  end
=end
end
