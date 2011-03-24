file = "../lib/rect.rb"
begin
  require_relative file
rescue NotMethodError
  require file
end

require "test/unit"

class TestRect < Test::Unit::TestCase
  def setup
    @rect = Rect.new
  end

  def test_initialize
    assert_not_nil(@rect)
  end

  def test_width_and_height
    assert_width_and_height(0, 0)
    set_width_and_height(20, 30)
    assert_width_and_height(20, 30)
  end

  def test_rect_coordinates
    assert_coordinates(0, 0)
    set_coordinates(150, 75)
    assert_coordinates(150, 75)
  end

  def test_rect_color
    assert_equal(0xff000000, @rect.color)
    @rect.color = 0xff00ff00
    assert_equal(0xff00ff00, @rect.color)
  end

  def test_rect_z_order
    assert_equal(0, @rect.z_order)
    @rect.z_order = 2
    assert_equal(2, @rect.z_order)
  end

  def test_constructor_parameters
    @rect = Rect.new(:x => 20, :y => 45, :width => 60, :height => 36, :color => 0xff00ffff, :z_order => 1)
    assert_coordinates(20, 45)
    assert_width_and_height(60, 36)
    assert_equal(0xff00ffff, @rect.color)
    assert_equal(1, @rect.z_order)
  end

  def test_top_left_bottom_right
    set_coordinates(30, 45)
    set_width_and_height(20, 15)
    assert_equal(45, @rect.top)
    assert_equal(30, @rect.left)
    assert_equal(60, @rect.bottom)
    assert_equal(50, @rect.right)
  end

  private

  def set_width_and_height(width, height)
    @rect.width = width
    @rect.height = height
  end

  def set_coordinates(x, y)
    @rect.x = x
    @rect.y = y
  end

  def assert_width_and_height(width, height)
    assert_equal(width, @rect.width)
    assert_equal(height, @rect.height)
  end

  def assert_coordinates(x, y)
    assert_equal(x, @rect.x)
    assert_equal(y, @rect.y)
  end
end
