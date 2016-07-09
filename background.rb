
class Background
  def initialize window
    @window = window
    @MAP_FILE = File.join(File.dirname(__FILE__), 'assets/world1-2.json')
    #@SPEED = 5
    @map = Gosu::Tiled.load_json(@window, @MAP_FILE)
    @x = @y = 0
    @first_render = true
  end

  def draw
    @first_render = false
    @map.draw(@x, @y)
  end

  def width
    return @map.width
  end

  def height
    return @map.height
  end

  def update
    @x += 5 if @window.button_down?(Gosu::KbRight)
  end

  def needs_redraw?
    return true if button_down?(Gosu::KbRight)
    @first_render
  end
end