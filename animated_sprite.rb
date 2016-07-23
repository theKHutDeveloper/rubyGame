class AnimatedSprite

  def initialize(window, filename, width, height, soft_edges)
    @window = window

    @sprite_array = Gosu::Image.load_tiles @window, filename, width, height, soft_edges
    @frame = 0
    @counter = 10
  end

  def get_animated_sprite
    @sprite_array
  end

  def draw(x, y, horizontal_direction)
    count = @frame % @sprite_array.size
    image = @sprite_array[count]

    if horizontal_direction < 1
      image.draw(x + image.width, y, 1, horizontal_direction)
    else
      image.draw(x, y, 1)
    end
  end

  def update
    @counter -= 1

    if @counter < 0
      @counter = 10
    elsif @counter == 0
      @frame += 1
    end
  end



end