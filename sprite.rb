class Sprite
  def initialize(window, filename)
    @window = window
    @sprite_x = 0
    @sprite_y = 0
    @delta_time = (window.update_interval / 1000)
    @velocity_x = 0
    @gravity_x = 0
    @sprite = Gosu::Image.new(filename, :tileable => false)
  end

  def set_position(x, y)
    @sprite_x, @sprite_y = x, y
    @block_move = false
  end

  def draw
    @sprite.draw(@sprite_x, @sprite_y, 0)
  end

  def get_x
    @sprite_x
  end

  def get_y
    @sprite_y
  end

  def get_height
    @sprite.height
  end

  def get_width
    @sprite.width
  end

  def set_block
    @block_move = true
  end

  def get_block
    @block_move
  end

  def push_sprite(amt)
    @velocity_x += amt * 0.2
    @gravity_x = amt
    @velocity_x += @gravity_x * 0.2
    @max_move = amt + @sprite_x
  end

  def update
    if @gravity_x > 0
      if @sprite_x.to_f < @max_move.to_f
        @sprite_x += @velocity_x * 0.2
      else
        @velocity_x = 0
        @block_move = false
      end
    elsif @gravity_x < 0
      if @sprite_x.to_f > @max_move.to_f
        @sprite_x += @velocity_x * 0.2
      end
    end
  end

end