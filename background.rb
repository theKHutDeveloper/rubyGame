class Background
  def initialize(window)
    @window = window
    @bkgnd = Gosu::Image.new("assets/bg_repeatable.png", :tileable => true)
  end

  def update

  end

  def draw
    @bkgnd.draw(0,0 - 160,0)
  end
end