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
      cell == CellState::Alive or cell == CellState::Revived
    end.length
  end
  
  def set_cell_state(row, column, state)
    if row >= @rows or column >= @columns
      raise IndexError, "%d rows, %d columns; but index was [%d;%d]" % [@rows, @columns, row, column]
    end
    @cells[row * @columns + column] = state
  end
  
  def get_cell_state(row, column)
    if row >= @rows or column >= @columns
      raise IndexError, "%d rows, %d columns; but index was [%d;%d]" % [@rows, @columns, row, column]
    end
    @cells[row * @columns + column]
  end
end