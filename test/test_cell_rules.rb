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
  def setup
    @grid = CellGrid.new(:rows => 3, :columns => 4)
  end

  def test_initialize
    assert_not_nil(@grid)
  end

  def test_default_rules
    @grid.set_cell_state(0, 1, CellState::Alive)
    @grid.set_cell_state(1, 2, CellState::Revived)
    @grid.set_cell_state(2, 0, CellState::Alive)
    # Default Rules: 
    # - is alive or revived and has 2 or 3 neighbours => alive
    # - is dead and has 3 neighbours => revived
    # - else => dead
    rules = CellRules.new
    rules.update(@grid)
    assert_equal(CellState::Alive, @grid.get_cell_state(0, 1))
    assert_equal(CellState::Revived, @grid.get_cell_state(1, 1))
    assert_equal(CellState::Dead, @grid.get_cell_state(1, 2))
    assert_equal(CellState::Dead, @grid.get_cell_state(2, 0))
    assert_equal(CellState::Revived, @grid.get_cell_state(2, 1))
  end

  def test_custom_rules
    @grid.set_cell_state(0, 2, CellState::Alive)
    @grid.set_cell_state(1, 0, CellState::Alive)
    @grid.set_cell_state(1, 2, CellState::Alive)
    @grid.set_cell_state(2, 2, CellState::Alive)

    rules = CellRules.new
    rules.neighbours_to_stay_alive(0)
    rules.neighbours_to_get_revived(4)
    rules.update(@grid)
    # A complete example (A = alive, R = revived, . = dead):
    # ..A.      .R.R
    # A.A.  =>  AR.R
    # ..A.      .R.R
    assert_equal(CellState::Alive, @grid.get_cell_state(1, 0))
    assert_equal(CellState::Dead, @grid.get_cell_state(0, 0))
    assert_equal(CellState::Dead, @grid.get_cell_state(0, 2))
    assert_equal(CellState::Dead, @grid.get_cell_state(1, 2))
    assert_equal(CellState::Dead, @grid.get_cell_state(2, 0))
    assert_equal(CellState::Dead, @grid.get_cell_state(2, 2))
    assert_equal(CellState::Revived, @grid.get_cell_state(0, 1))
    assert_equal(CellState::Revived, @grid.get_cell_state(0, 3))
    assert_equal(CellState::Revived, @grid.get_cell_state(1, 1))
    assert_equal(CellState::Revived, @grid.get_cell_state(1, 3))
    assert_equal(CellState::Revived, @grid.get_cell_state(2, 1))
    assert_equal(CellState::Revived, @grid.get_cell_state(2, 3))
  end

  def test_custom_range_rules
    @grid.set_cell_state(0, 1, CellState::Alive)
    @grid.set_cell_state(1, 0, CellState::Alive)
    @grid.set_cell_state(1, 2, CellState::Alive)
    @grid.set_cell_state(2, 1, CellState::Alive)

    rules = CellRules.new
    rules.neighbours_range_to_stay_alive(1, 3)
    rules.neighbours_range_to_get_revived(3, 4)
    rules.update(@grid)
    # A complete example (A = alive, R = revived, . = dead):
    # .A..      RAR.
    # A.A.  =>  ARA.
    # .A..      RAR.
    assert_equal(CellState::Alive, @grid.get_cell_state(0, 1))
    assert_equal(CellState::Alive, @grid.get_cell_state(1, 0))
    assert_equal(CellState::Alive, @grid.get_cell_state(1, 2))
    assert_equal(CellState::Alive, @grid.get_cell_state(2, 1))
    assert_equal(CellState::Dead, @grid.get_cell_state(0, 3))
    assert_equal(CellState::Dead, @grid.get_cell_state(1, 3))
    assert_equal(CellState::Dead, @grid.get_cell_state(2, 3))
    assert_equal(CellState::Revived, @grid.get_cell_state(0, 0))
    assert_equal(CellState::Revived, @grid.get_cell_state(0, 2))
    assert_equal(CellState::Revived, @grid.get_cell_state(1, 1))
    assert_equal(CellState::Revived, @grid.get_cell_state(2, 0))
    assert_equal(CellState::Revived, @grid.get_cell_state(2, 2))
  end
end
