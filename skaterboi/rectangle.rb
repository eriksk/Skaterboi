module Skaterboi
	class Rectangle

		attr_accessor :x, :y, :width, :height

		def initialize x = 0, y = 0, width = 0, height = 0
			@x, @y, @width, @height = x, y, width, height			
		end

		def right
			@x + @width			
		end

		def contains(x, y)
			if x < @x 
				return false 
			end
			if y < @y 
				return false 
			end
			if x > @x + @width 
				return false 
			end
			if y > @y + @height 
				return false 
			end
			return true
		end

		def draw game, color
			game.draw_quad(
				x, y, color,
				x + width, y, color,
				x + width, y + height, color,
				x, y + height, color
			)
		end
	end
end