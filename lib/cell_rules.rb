files = ["cell_grid.rb", "cell_state.rb"]
begin
  files.each do |filename|
    require_relative filename
  end
rescue
  files.each do |filename|
    require filename
  end
end

class CellRules
  def update(cell_grid)
    result = Array.new(cell_grid.rows)
    result.collect! do |arr|
      arr = Array.new(cell_grid.columns, CellState::Dead)
    end

    cell_grid.each_cell_info do |row, column, state|
      case state
      when CellState::Dead
	result[row][column] = CellState::Revived if cell_grid.neighbours(row, column) == 3
      when CellState::Alive, CellState::Revived
	result[row][column] = CellState::Alive if cell_grid.neighbours(row, column).between?(2, 3)
      end
    end

    cell_grid.each_cell_info do |row, column|
      cell_grid.set_cell_state(row, column, result[row][column])
    end
  end
end
