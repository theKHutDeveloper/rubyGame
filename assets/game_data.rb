class Game_data

  def initialize(window, player_lives, collect_item)
    @window = window
    @score = 0
    @lives = player_lives
    @item_to_collect = collect_item
  end
end