class Computer_Generated_Movements

  def initialize(dt, x, y, gravity_x, gravity_y)
    @pos_x = x
    @pos_y = y
    @delta = dt
    @velocity_x = 0
    @velocity_y = 0
    @gravity_x = gravity_x
    @gravity_y = gravity_y
  end

  def get_x
    @pos_x
  end


  def set_x(value)
    @pos_x = value
  end


  def get_y
    @pos_y
  end


  def set_y(value)
    @pos_y = value
  end


  def get_velocity_x
    @velocity_x
  end


  def get_velocity_y
    @velocity_y
  end


  def get_delta
    @delta
  end

  def reset_timer
    @m_time = Time.now
  end

  def timer_elapsed?(timer_interval)
    true if Time.now > @m_time + timer_interval
  end


  def get_time
    @m_time
  end

end