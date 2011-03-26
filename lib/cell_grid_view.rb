file = "rect.rb"
begin
  require_relative file
rescue NoMethodError
  require file
end

class CellGridView
  attr_accessor :x, :y, :cell_width, :cell_height
  attr_accessor :color_alive, :color_dead, :color_revived
  
  def initialize(params = Hash.new)
    @x = params[:x] || 0
    @y = params[:y] || 0
    @cell_width = params[:cell_width] || 0
    @cell_height = params[:cell_height] || 0
    @cell_grid = params[:cell_grid] || CellGrid.new

    @color_alive = params[:color_alive] || 0xff000000
    @color_dead = params[:color_dead] || 0xff000000
    @color_revived = params[:color_revived] || 0xff000000
    
    @rect = Rect.new(:z_order => params[:z_order] || 0) # maybe needs a test
    update_rect
  end

  def cell_width=(cell_width)
    @cell_width = cell_width
    update_rect
  end

  def cell_height=(cell_height)
    @cell_height = cell_height
    update_rect
  end

  def total_width
    @cell_grid.columns * @cell_width
  end

  def total_height
    @cell_grid.rows * @cell_height
  end

  def draw(window)
    @cell_grid.each_cell_info do |row, column, state|
      @rect.x = column * @cell_width + @x
      @rect.y = row * @cell_height + @y
      case state
      when CellState::Alive
        @rect.color = @color_alive
      when CellState::Dead
        @rect.color = @color_dead
      when CellState::Revived
        @rect.color = @color_revived
      end
      @rect.draw(window)
    end
  end

  private

  def update_rect
    @rect.width = @cell_width
    @rect.height = @cell_height
  end
end
