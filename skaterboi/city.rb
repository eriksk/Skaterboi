module Skaterboi
	class City

		def initialize 
			@layers = []
			reset
		end

		def reset
			load
		end

		def load
			house_color = Gosu::Color.new
			rgb = 255
			house_color.red = rgb
			house_color.green = rgb
			house_color.blue = rgb
			house_color.alpha = 200

			4.times do |i|
				hash = {
					:parallax => 0.3 + (i * 0.1),
					:houses => [] 
				}
				@layers.push hash
				x = 0
				10.times do |j|
					house = House.new(
						Rectangle.new(
							x + 100 + rand() * 200, 
							(100 + rand() * 200) * (1.0 - hash[:parallax]),
							(100 + rand() * 500) * hash[:parallax], 
							1000), house_color)
					hash[:houses].push(house)
					x = house.rectangle.right
				end
			end
		end

		def update dt, player
			@layers.each do |l|
				l[:houses].each do |h|
				end
			end			
		end

		def draw game, cam
			@layers.each do |l|
				cam.translate(l[:parallax]){
					l[:houses].each do |h|
						h.draw game
					end
				}
			end
		end
	end
end