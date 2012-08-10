module Skaterboi
	class Game < Gosu::Window

		def initialize
			super(CONFIG['width'], CONFIG['height'], CONFIG['fullscreen'])
			self.caption = CONFIG['caption']
			
			@top_color = Gosu::Color::WHITE
			@bottom_color = Gosu::Color::GRAY		

			@cam = Camera.new(self)
			@level = Level.new(self)

			@skater = Skater.new(load_image('skater'))
			@skater.set_position(400, 400)
		end

		def load_image name
			Gosu::Image.new(self, "content/gfx/#{name}.png", false)
		end

		def button_down(id)
			case id
				when Gosu::KbD
					@skater.gas(@dt)
				when Gosu::KbW
					@skater.jump
				when Gosu::KbA
					@skater.brake(@dt)
				when Gosu::KbEscape
					exit()
			end
		end

		def update
			@dt = 16.0

			if button_down?(Gosu::KbA)
				@skater.lean_left(@dt)	
			end
			if button_down?(Gosu::KbD)
				@skater.lean_right(@dt)
			end
				
			@skater.update @dt, @level
			@level.update @dt, @skater
			@cam.move(@skater.position.x + CONFIG['width'] * 0.4, @skater.position.y)
			@cam.update @dt
		end

		def draw
			draw_bg
			@cam.translate{
				@level.draw
				@skater.draw
			}
		end

		def draw_bg
			draw_quad(
				0, 0, @top_color,
				CONFIG['width'], 0, @top_color,
				CONFIG['width'], CONFIG['height'], @bottom_color,
				0, CONFIG['height'], @bottom_color
			)
		end
	end
end