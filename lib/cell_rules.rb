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
  def initialize
    # Default Rules: 
    # - is alive or revived and has 2 or 3 neighbours => alive
    # - is dead and has 3 neighbours => revived
    # - else => dead
    @stay_alive_min = 2
    @stay_alive_max = 3
    @get_revived_min = 3
    @get_revived_max = 3
  end

  def neighbours_to_stay_alive(number)
    neighbours_range_to_stay_alive(number, number)
  end

  def neighbours_range_to_stay_alive(min, max)
    @stay_alive_min, @stay_alive_max = min, max
  end

  def neighbours_to_get_revived(number)
    neighbours_range_to_get_revived(number, number)
  end

  def neighbours_range_to_get_revived(min, max)
    @get_revived_min, @get_revived_max = min, max
  end

  def update(cell_grid)
    result = simulate_next_round(cell_grid)
    update_old_data(cell_grid, result)
  end

  private

  def create_temp_array(rows, columns)
    temp_array = Array.new(rows)
    temp_array.collect! do |arr|
      arr = Array.new(columns, CellState::Dead)
    end
    temp_array
  end

  def simulate_next_round(cell_grid)
    temp = create_temp_array(cell_grid.rows, cell_grid.columns)

    cell_grid.each_cell_info do |row, column, state|
      case state
      when CellState::Dead
	temp[row][column] = CellState::Revived if cell_grid.neighbours(row, column).between?(@get_revived_min, @get_revived_max)
      when CellState::Alive, CellState::Revived
	temp[row][column] = CellState::Alive if cell_grid.neighbours(row, column).between?(@stay_alive_min, @stay_alive_max)
      end
    end
    temp
  end

  def update_old_data(old_data, new_data)
    old_data.each_cell_info do |row, column|
      old_data.set_cell_state(row, column, new_data[row][column])
    end
  end
end
