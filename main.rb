files = ["lib/cell_grid.rb", "lib/cell_grid_view.rb", "lib/cell_state.rb", "lib/cell_rules.rb"]
begin
  files.each do |filename|
    require_relative filename
  end
rescue NoMethodError
  files.each do |filename|
    require filename
  end
end

require "rubygems"
require "gosu"

class GameOfLifeWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = "Game of Life - Gosu"
    
    @grid = CellGrid.new(:rows => 24, :columns => 32)
    populate_cell_grid

    @grid_view = CellGridView.new(:cell_grid => @grid,
                                  :cell_width => 20,
                                  :cell_height => 20,
                                  :color_alive => 0xff00ff00,
                                  :color_dead => 0xffffffff,
                                  :color_revived => 0xff0000ff)
    @rules = CellRules.new
  end

  def draw
    @grid_view.draw(self)
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::KbSpace
      @rules.update(@grid)
    when Gosu::KbReturn
      populate_cell_grid
    end
  end

  private

  def populate_cell_grid
    @grid.each_cell_info do |row, column|
      @grid.set_cell_state(row, column, rand(2) < 1 ? CellState::Alive : CellState::Dead)
    end
  end
end

GameOfLifeWindow.new.show
