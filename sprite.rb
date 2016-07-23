class Sprite
  def initialize(window, filename)
    @window = window
    @sprite_x = @sprite_y = 0

    @sprite = Gosu::Image.new(filename, :tileable => false)
  end

  def set_position(x, y)
    @sprite_x, @sprite_y = x, y
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
end