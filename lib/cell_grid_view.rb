class CellGridView
  attr_accessor :x, :y, :cell_width, :cell_height
  
  def initialize(params = Hash.new)
    @x = params[:x] || 0
    @y = params[:y] || 0
    @cell_width = params[:cell_width] || 0
    @cell_height = params[:cell_height] || 0
  end
end