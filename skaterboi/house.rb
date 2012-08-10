module Skaterboi
	class House

		attr_accessor :rectangle
		
		def initialize rectangle_area, color
			@rectangle = rectangle_area
			@color = color
			@window_color = Gosu::Color.new
			rgb = 100
			@window_color.red = rgb
			@window_color.green = rgb
			@window_color.blue = rgb
			@window_color.alpha = 100
		end

		def draw game
			@rectangle.draw(game, @color)
		end
		
		def draw_windows game
			window_distance = 64
			window_size = 32
			((@rectangle.width / window_distance).to_i - 1).times do |i|
				((@rectangle.height / window_distance).to_i - 1).times do |j|
					game.draw_quad(
						window_size + @rectangle.x + (i * window_distance), window_size + @rectangle.y + (j * window_distance), @window_color,
						window_size + @rectangle.x + (i * window_distance) + window_size, window_size + @rectangle.y + (j * window_distance), @window_color,
						window_size + @rectangle.x + (i * window_distance) + window_size, window_size + @rectangle.y + (j * window_distance) + window_size, @window_color,
						window_size + @rectangle.x + (i * window_distance), window_size + @rectangle.y + (j * window_distance) + window_size, @window_color
					)
				end
			end
		end		
	end
end