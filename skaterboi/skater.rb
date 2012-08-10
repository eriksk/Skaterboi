module Skaterboi
	class Skater < Entity

		attr_accessor :in_air, :alive

		def initialize game
			super(game.load_image('skater_2'))
			@board = game.load_image('board')
		end

		def load
			@step_speed = 0.01	
			@jump_force = 0.5
			@lean_speed = 0.00005
			@rotation_speed = 0.0

			@alive = true
			@in_air = false		
		end

		def reset
			@alive = true
			@velocity.x = 0.0
			@velocity.y = 0.0
		end

		def die
			@alive = false
		end

		def gas dt
			if !@in_air
				@velocity.x += @step_speed * dt
			end
		end

		def brake dt
			if !@in_air
				@velocity.x -= @step_speed * dt
				if @velocity.x < 0.0
					@velocity.x = 0.0
				end
			end
		end

		def jump	
			if !@in_air		
				@velocity.y = -@jump_force
				@in_air = true
			end
		end

		def fall_off
			@velocity.y = 0.0
			@in_air = true
		end

		def lean_right dt
			if @in_air
				@rotation_speed += @lean_speed * dt
			end
		end

		def lean_left dt
			if @in_air
				@rotation_speed -= @lean_speed * dt
			end
		end

		def land
			if @rotation.radians_to_degrees > 90 && @rotation.radians_to_degrees < 270
				die()
			end
			@in_air = false
			@velocity.y = 0.0
			@rotation = 0.0
			@rotation_speed = 0.0
		end

		def crouch			
		end

		def update dt, level
			@position.x += @velocity.x * dt	
			@position.y += @velocity.y * dt		

			if @in_air
				@rotation += @rotation_speed * dt
				if @rotation.radians_to_degrees < 0
					@rotation += 360.degrees_to_radians
				elsif @rotation.radians_to_degrees > 360
					@rotation -= 360.degrees_to_radians
				end
				
				apply_gravity(dt)
				level.collides?(@position.x, @position.y + @height / 2.0) do |offset|
					@position.y += offset.y
					land()
					if offset.x != 0 && Skaterboi::abs(offset.y) > 32
						die()
					end
				end
			else
				apply_friction(dt)
				if !level.collides?(@position.x, @position.y + (@height / 2.0) + 1)
					fall_off()
				end
			end
		end

		def apply_gravity(dt)
			@velocity.y += CONFIG['gravity'] * dt
		end

		def apply_friction(dt)
			if @velocity.x > 0.0
				@velocity.x -= CONFIG['friction'] * dt
				if @velocity.x < 0.0
					@velocity.x = 0.0
				end
			end
		end

		def draw
			@texture.draw_rot(@position.x, @position.y, 0, @rotation.radians_to_degrees, @origin.x, @origin.y, @scale, @scale)
			@board.draw_rot(
				@position.x + Math::cos(@rotation + 90.degrees_to_radians) * (@width / 2.0), 
				@position.y + Math::sin(@rotation + 90.degrees_to_radians) * (@height / 2.0), 
				0, 
				@rotation.radians_to_degrees, 
				@origin.x, 
				@origin.y, 
				@scale, @scale)
		end
	end
end