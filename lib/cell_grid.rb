begin
  require_relative "cell_state"
rescue NoMethodError
  require "cell_state"
end

class CellGrid
  attr_accessor :rows, :columns
  
  def initialize(params = Hash.new)
    @rows = params[:rows] || 0
    @columns = params[:columns] || 0
    @cells = Array.new(@rows * @columns, CellState::Dead)
  end

  def living_cells
    @cells.select do |cell|
      cell != CellState::Dead
    end.length
  end
  
  def neighbours(row, column)
    cell_neighbours = 0
    unless get_cell_state(row, column) == CellState::Dead
      cell_neighbours = -1
    end
    for dx in -1..1
      pos_x = column + dx
      pos_x = @columns - 1 if pos_x < 0
      pos_x = 0 if pos_x >= @columns
      for dy in -1..1
        pos_y = row + dy
        pos_y = @rows - 1 if pos_y < 0
        pos_y = 0 if pos_y >= rows
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
        cell = @cells[row * @columns + column]
        if cell != CellState::Dead
          str += cell.to_s
        else
          str += "."
        end
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
end