files = ["../lib/cell_rules.rb", "../lib/cell_grid.rb", "../lib/cell_state.rb"]
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

class TestCellRules < Test::Unit::TestCase
  def test_initialize
    assert_not_nil(CellRules.new)
  end

  def test_default_rules
    grid = CellGrid.new(:rows => 3, :columns => 4)
    grid.set_cell_state(0, 1, CellState::Alive)
    grid.set_cell_state(1, 2, CellState::Revived)
    grid.set_cell_state(2, 0, CellState::Alive)
    # Default Rules: 
    # - is alive or revived and has 2 or 3 neighbours => alive
    # - is dead and has 3 neighbours => revived
    # - else => dead
    rules = CellRules.new
    rules.update(grid)
    assert_equal(CellState::Alive, grid.get_cell_state(0, 1))
    assert_equal(CellState::Revived, grid.get_cell_state(1, 1))
    assert_equal(CellState::Dead, grid.get_cell_state(1, 2))
    assert_equal(CellState::Dead, grid.get_cell_state(2, 0))
    assert_equal(CellState::Revived, grid.get_cell_state(2, 1))
  end
end
