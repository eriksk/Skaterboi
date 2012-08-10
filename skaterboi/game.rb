module Skaterboi
	class Game < Gosu::Window

		def initialize
			super(CONFIG['width'], CONFIG['height'], CONFIG['fullscreen'])
			self.caption = CONFIG['caption']
			
			@font = Gosu::Font.new(self, Gosu::default_font_name, 18)

			@top_color = Gosu::Color::BLACK
			@bottom_color = Gosu::Color::GRAY		

			@cam = Camera.new(self)
			@level = Level.new(self)
			@city = City.new

			@skater = Skater.new(self)

			@trick_manager = TrickManager.new(self, @skater)

			reset()
		end

		def reset
			@trick_manager.reset
			@skater.set_position(450, 200)
			@skater.reset
			@level.reset
			@city.reset
			@cam.set_position(@skater.position.x, @skater.position.y)
		end

		def load_image name
			Gosu::Image.new(self, "content/gfx/#{name}.png", false)
		end

		def load_font size
			Gosu::Font.new(self, Gosu::default_font_name, size)
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

			if !@skater.alive
				reset
				return
			end

			if button_down?(Gosu::KbA)
				@skater.lean_left(@dt)	
			end
			if button_down?(Gosu::KbD)
				@skater.lean_right(@dt)
			end
			
			@trick_manager.update @dt
			@city.update @dt, @skater
			@skater.update @dt, @level
			@level.update @dt, @skater
			@cam.move(@skater.position.x + CONFIG['width'] * 0.4, @skater.position.y)
			@cam.update @dt
		end

		def draw
			draw_bg
			#@city.draw(self, @cam)
			@cam.translate{
				@level.draw
				@skater.draw
			}
			draw_hud
		end

		def draw_hud
			@font.draw("x: #{@skater.position.x.to_i}, y: #{@skater.position.y.to_i}", 16, 16, 0)
			@font.draw("rotation: #{@skater.rotation.radians_to_degrees.to_i}", 16, 32, 0)
			@trick_manager.draw
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