files = ["../lib/cell_grid", "../lib/cell_state"]
begin
  files.each do |filename|
    require_relative filename
  end
rescue NoMethodError
  files.each do |filename|
    require filename
  end
end

require "test/unit"

class TestCellGrid < Test::Unit::TestCase
  def setup
    @grid = CellGrid.new(:rows => 3, :columns => 3)
  end
  
  def test_initialize    
    assert_not_nil(@grid)
  end
  
  def test_count_living_cells    
    assert_equal(0, @grid.living_cells)
    @grid.set_cell_state(0, 0, CellState::Alive)
    assert_equal(1, @grid.living_cells)
  end
  
  def test_count_neighbours
    assert_equal(0, @grid.neighbours(1, 2))
    @grid.set_cell_state(0, 0, CellState::Alive)
    @grid.set_cell_state(1, 0, CellState::Revived)
    @grid.set_cell_state(2, 2, CellState::Alive)
    assert_equal(3, @grid.neighbours(1, 2))
  end
  
  def test_get_states    
    assert_equal(CellState::Dead, @grid.get_cell_state(1, 2))
    @grid.set_cell_state(1, 2, CellState::Alive)
    assert_equal(CellState::Alive, @grid.get_cell_state(1, 2))
  end
  
  def test_grid_infos    
    assert_equal(3, @grid.rows)
    assert_equal(3, @grid.columns)
    @grid.rows = 4
    @grid.columns = 5
    assert_equal(4, @grid.rows)
    assert_equal(5, @grid.columns)
  end
  
  def test_valid_arguments    
    assert_raise(IndexError) { @grid.set_cell_state(4, 0, CellState::Alive) }
    assert_raise(IndexError) { @grid.set_cell_state(2, 4, CellState::Alive) }
    assert_raise(IndexError) { @grid.get_cell_state(5, 1) }
    assert_raise(IndexError) { @grid.get_cell_state(1, 5) }
  end
  
  def test_cell_grid_to_s
    assert_equal("...\n...\n...\n", @grid.to_s)
    @grid.set_cell_state(1, 2, CellState::Alive)
    assert_equal("...\n..#{CellState::Alive}\n...\n", @grid.to_s)
  end
end