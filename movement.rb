class Movement
  def initialize(dt, x, y, gravity, gravity_x)
    @pos_x = x
    @pos_y = y
    @delta_time = dt
    @velocity_x = 0
    @velocity_y = 0
    @gravity_y = 0
    @gravity = gravity
    @gravity_x  = gravity_x
  end

  def get_x
    @pos_x
  end

  def get_y
    @pos_y
  end

  def get_velocity_y
    @velocity_y
  end

  def set_velocity_y(value)
    @velocity_y = value
  end

  def set_velocity_y_in_air
    @velocity_y += @gravity * @delta_time
  end

  def get_dt
    @delta_time
  end

  def left
    @velocity_x += @gravity_x * @delta_time
    @pos_x -= @velocity_x * @delta_time
  end

  def right
    @velocity_x += @gravity_x * @delta_time
    @pos_x += @velocity_x * @delta_time
  end

  def up(jump_velocity)
    @velocity_y = -jump_velocity
    @jumping = true
  end

  def update(ground)
    if @velocity_y != 0

      @velocity_y += @gravity * @delta_time
      @pos_y += @velocity_y * @delta_time

      if @pos_y > ground
        @velocity_y = 0
        @pos_y = ground
      end


    end
    #return @pos_y
  end
end