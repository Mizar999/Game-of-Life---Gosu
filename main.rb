files = ["lib/cell_grid.rb", "lib/cell_grid_view.rb", "lib/cell_state.rb"]
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
    super(645, 485, false)
    self.caption = "Game of Life - Gosu"

    grid = CellGrid.new(:rows => 10, :columns => 15)
    grid.set_cell_state(0, 0, CellState::Alive)
    grid.set_cell_state(1, 0, CellState::Dead)
    grid.set_cell_state(0, 2, CellState::Revived)
    @grid_view = CellGridView.new(:cell_grid => grid,
                                  :cell_width => 20,
                                  :cell_height => 20,
                                  :color_alive => 0xff00ff00,
                                  :color_dead => 0xffff0000,
                                  :color_revived => 0xff0000ff)
  end

  def draw
    @grid_view.draw(self)
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    end
  end
end

GameOfLifeWindow.new.show
