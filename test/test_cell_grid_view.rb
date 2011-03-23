file = "../lib/cell_grid_view"
begin
  require_relative file
rescue NoMethodError
  require file
end

require "test/unit"

class TestCellGridView < Test::Unit::TestCase
  def setup
    @grid_view = CellGridView.new
  end

  def test_initialize
    assert_not_nil(@grid_view)
  end
  
  def test_set_width_and_height
    assert_cell_dimensions(0, 0)
    set_cell_dimensions(20, 10)
    assert_cell_dimensions(20, 10)
  end
  
  def test_set_width_and_height_in_constructor
    @grid_view = CellGridView.new(:cell_width => 25, :cell_height => 35)
    assert_cell_dimensions(25, 35)
  end
  
  def test_set_grid_view_position
    assert_grid_position(0, 0)
    set_grid_position(50, 75)
    assert_grid_position(50, 75)
  end
  
  def test_set_grid_position_in_constructor
    @grid_view = CellGridView.new(:x => 40, :y => 34)
    assert_grid_position(40, 34)
  end
  
  private
  
  def set_cell_dimensions(cell_width, cell_height)
    @grid_view.cell_width = cell_width
    @grid_view.cell_height = cell_height
  end
  
  def set_grid_position(x, y)
    @grid_view.x = x
    @grid_view.y = y
  end
  
  def assert_cell_dimensions(cell_width, cell_height)
    assert_equal(cell_width, @grid_view.cell_width)
    assert_equal(cell_height, @grid_view.cell_height)
  end
  
  def assert_grid_position(x, y)
    assert_equal(x, @grid_view.x)
    assert_equal(y, @grid_view.y)
  end
end