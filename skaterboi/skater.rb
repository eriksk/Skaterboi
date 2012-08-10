module Skaterboi
	class Skater < Entity

		attr_accessor :in_air

		def load
			@step_speed = 0.01	
			@jump_force = 0.5
			@lean_speed = 0.00005
			@rotation_speed = 0.0

			@in_air = false		
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
				apply_gravity(dt)
				level.collides?(@position.x, @position.y + @height / 2.0) do |offset|
					@position.x += offset.x
					@position.y += offset.y
					land()	
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
	end
end