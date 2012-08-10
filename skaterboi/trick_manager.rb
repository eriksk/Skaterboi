module Skaterboi
	class TrickManager

		def initialize game, player
			@game = game
			@player = player
			@distance = 0.0
			@font = game.load_font(20)
			@score = 0
			@player.on_land(lambda{
				@score += @player.total_rotation.radians_to_degrees
			})
		end

		def reset
			@score = 0
		end

		def update dt
			
		end

		def draw
			@font.draw_rel("Score: #{@score.to_i}", CONFIG['width'] / 2.0, 16, 0, 0.5, 0.5)
			if @player.in_air
				@font.draw_rel("Rotation: #{@player.total_rotation.radians_to_degrees.to_i}", CONFIG['width'] / 2.0, 32, 0, 0.5, 0.5)
			end
		end		
	end
end