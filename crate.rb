class Crate

  def initialize(window)
    @window = window
    @crate_x = @crate_y = 0

    @crate = Gosu::Image.new("assets/Crate.png", :tileable => false)
  end

  def set_position(x, y)
    @crate_x, @crate_y = x, y
  end

  def draw
    @crate.draw(@crate_x, @crate_y, 0)
  end

  def get_x
    return @crate_x
  end

  def get_y
    return @crate_y
  end

  def get_height
    return @crate.height
  end

  def get_width
    return @crate.width
  end
end