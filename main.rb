require "rubygems"
require "gosu"

class GameOfLifeWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = "Game of Life - Gosu"
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    end
  end
end

GameOfLifeWindow.new.show