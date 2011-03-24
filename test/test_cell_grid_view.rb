files = ["../lib/cell_grid_view", "../lib/cell_grid"]
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

  def test_total_width_and_height
    cell_grid = CellGrid.new(:rows => 3, :columns => 3)
    @grid_view = CellGridView.new(:cell_grid => cell_grid, :cell_width => 20, :cell_height => 10)
    assert_total_width_and_height(60, 30)
    cell_grid.rows = 5
    cell_grid.columns = 4
    assert_total_width_and_height(80, 50)
  end

  def test_cell_colors
    @grid_view = CellGridView.new(:color_alive => 0xffffff00, :color_dead => 0xff00ffff, :color_revived => 0xffff00ff)
    assert_color_alive_dead_revived(0xffffff00, 0xff00ffff, 0xffff00ff)
    set_color_alive_dead_revived(0xff0000ff, 0xffff0000, 0xff00ff00)
    assert_color_alive_dead_revived(0xff0000ff, 0xffff0000, 0xff00ff00)
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

  def set_color_alive_dead_revived(color_alive, color_dead, color_revived)
    @grid_view.color_alive = color_alive
    @grid_view.color_dead = color_dead
    @grid_view.color_revived = color_revived
  end
  
  def assert_cell_dimensions(cell_width, cell_height)
    assert_equal(cell_width, @grid_view.cell_width)
    assert_equal(cell_height, @grid_view.cell_height)
  end
  
  def assert_grid_position(x, y)
    assert_equal(x, @grid_view.x)
    assert_equal(y, @grid_view.y)
  end

  def assert_total_width_and_height(total_width, total_height)
    assert_equal(total_width, @grid_view.total_width)
    assert_equal(total_height, @grid_view.total_height)
  end

  def assert_color_alive_dead_revived(color_alive, color_dead, color_revived)
    assert_equal(color_alive, @grid_view.color_alive)
    assert_equal(color_dead, @grid_view.color_dead)
    assert_equal(color_revived, @grid_view.color_revived)
  end
end
