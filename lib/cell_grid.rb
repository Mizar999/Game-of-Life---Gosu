begin
  require_relative "cell_state"
rescue NoMethodError
  require "cell_state"
end

class CellGrid
  attr_reader :rows, :columns
  
  def initialize(params = Hash.new)
    @rows = params[:rows] || 0
    @columns = params[:columns] || 0
    @cells = Array.new(@rows * @columns, CellState::Dead)
  end
  
  def rows=(rows)
    @rows = rows
    update_grid_size
  end
  
  def columns=(columns)
    @columns = columns
    update_grid_size
  end

  def living_cells
    @cells.select do |cell|
      cell != CellState::Dead
    end.length
  end
  
  def neighbours(row, column)
    cell_neighbours = fixed_initial_neighbours_value(row, column)
    for dx in -1..1
      pos_x = adjusted_column(column + dx)
      for dy in -1..1
        pos_y = adjusted_row(row + dy)
        # x = column; y = row
        unless get_cell_state(pos_y, pos_x) == CellState::Dead
          cell_neighbours += 1
        end
      end
    end
    cell_neighbours    
  end
  
  def set_cell_state(row, column, state)
    check_index(row, column)
    @cells[row * @columns + column] = state
  end
  
  def get_cell_state(row, column)
    check_index(row, column)
    @cells[row * @columns + column]
  end
  
  def to_s
    str = ""
    for row in 0...@rows
      for column in 0...@columns
        str += string_representation_of_cell(row, column)
      end
      str += "\n"
    end
    str
  end
  
  private
  
  def check_index(row, column)
    if row >= @rows or column >= @columns
      raise IndexError, "%d rows, %d columns; but index was [%d;%d]" % [@rows, @columns, row, column]
    end
  end
  
  def fixed_initial_neighbours_value(row, column)
    get_cell_state(row, column) == CellState::Dead ? 0 : -1
  end
  
  def adjusted_column(column)
    if column < 0
      column = @columns - 1
    elsif column >= @columns
      column = 0
    end
    column
  end
  
  def adjusted_row(row)
    if row < 0
      row = @rows - 1
    elsif row >= @rows
      row = 0
    end
    row
  end
  
  def update_grid_size
    temp = @cells
    @cells = Array.new(@rows * @columns, CellState::Dead)
    @cells.each_index do |index|
      if index >= temp.length
        break
      end
      @cells[index] = temp[index]
    end
  end
  
  def string_representation_of_cell(row, column)
    cell = get_cell_state(row, column)
    if cell != CellState::Dead
      return cell.to_s
    end
    return "."
  end
end