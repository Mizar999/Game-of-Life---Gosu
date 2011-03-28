require "rubygems"
require "gosu"

class Rect
  attr_accessor :x, :y, :width, :height, :color, :z_order

  def initialize(params = Hash.new)
    @x = params[:x] || 0
    @y = params[:y] || 0
    @width = params[:width] || 0
    @height = params[:height] || 0
    @color = params[:color] || 0xff000000
    @z_order = params[:z_order] || 0
  end

  def top
    @y
  end

  def bottom
    @y + @height
  end

  def left
    @x
  end

  def right
    @x + @width
  end

  def draw(window)
    window.draw_quad(left, top, @color,
                     right, top, @color,
                     right, bottom, @color,
                     left, bottom, @color, @z_order)
  end
end
