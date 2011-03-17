begin
  ["../lib/cell_grid", "../lib/cell_state"].each do |filename|
    require_relative filename
  end
rescue NoMethodError
  ["../lib/cell_grid", "../lib/cell_state"].each do |filename|
    require filename
  end
end

require "test/unit"

class TestCellGrid < Test::Unit::TestCase
  def test_initialize
    grid = CellGrid.new
    assert_not_nil(grid)
  end
  
  def test_count_living_cells
    grid = CellGrid.new(:rows => 1, :columns => 1)
    assert_equal(0, grid.living_cells)
    grid.set_cell_state(0, 0, CellState::Alive)
    assert_equal(1, grid.living_cells)
  end
  
  def test_get_states
    grid = CellGrid.new(:rows => 2, :columns => 4)
    assert_equal(CellState::Dead, grid.get_cell_state(1, 2))
    grid.set_cell_state(1, 2, CellState::Alive)
    assert_equal(CellState::Alive, grid.get_cell_state(1, 2))
  end
  
  def test_grid_infos
    grid = CellGrid.new(:rows => 2, :columns => 4)
    assert_equal(2, grid.rows)
    assert_equal(4, grid.columns)
    grid.rows = 3
    grid.columns = 5
    assert_equal(3, grid.rows)
    assert_equal(5, grid.columns)
  end
  
  def test_valid_arguments
    grid = CellGrid.new(:rows => 3, :columns => 2)
    assert_raise(IndexError) { grid.set_cell_state(4, 0, CellState::Alive) }
    assert_raise(IndexError) { grid.set_cell_state(2, 4, CellState::Alive) }
    assert_raise(IndexError) { grid.get_cell_state(5, 1) }
    assert_raise(IndexError) { grid.get_cell_state(1, 5) }
  end
end