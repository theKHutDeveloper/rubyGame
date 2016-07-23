class Background
  def initialize(window)
    @window = window
    @bkgnd = Gosu::Image.new('assets/bg_repeatable.png', :tileable => true)
    @x = 0
    @y = 0
  end

  def update

  end

  def draw
    @bkgnd.draw(@x,@y,0)
  end
end