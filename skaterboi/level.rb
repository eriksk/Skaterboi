module Skaterboi
	class Level

		def initialize game
			@game = game
			@houses = []
			reset
		end

		def reset
			@houses.clear
			spawn_house(300, 450)
		end

		def spawn_house x, y
			h = House.new(Rectangle.new(x, y, 800 + rand() * 4000, 1000), Gosu::Color::GRAY)
			@houses.push(h)
		end

		def collides?(x, y, &block)
			collision_found = false
			@houses.each do |house|
				if house.rectangle.contains(x, y)
					collision_found = true
					if block
						x_diff = house.rectangle.x - x
						y_diff = house.rectangle.y - y
						block.call(Vec2.new(x_diff, y_diff))
					end
				end
			end
			return collision_found
		end

		def update dt, player

			# clear houses that are off screen
			@houses.each do |house|
				if house.rectangle.right < player.position.x - CONFIG['width']
					@houses.delete house
				end 
			end			

			# check if we need more houses 
			if @houses.size > 0
				last_house = @houses.last
				if last_house.rectangle.right < player.position.x + CONFIG['width']
					spawn_house(last_house.rectangle.right + (100 + rand() * 200), last_house.rectangle.y + (-100 + rand() * 200))
				end
			end
		end

		def draw
			@houses.each do |house|
				house.draw(@game)
				house.draw_windows(@game)
			end
		end
	end
end 