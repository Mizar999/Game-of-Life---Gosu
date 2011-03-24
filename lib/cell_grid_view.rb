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
  end

  def total_width
    @cell_grid.columns * @cell_width
  end

  def total_height
    @cell_grid.rows * @cell_height
  end
end
