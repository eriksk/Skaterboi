module Skaterboi
	class Entity
		attr_accessor :texture, :position, :velocity, :origin, :rotation, :scale, :width, :height

		def initialize texture
			@position = Vec2.new
			@velocity = Vec2.new
			@texture = texture
			@width = texture.width
			@height = texture.height
			@origin = Vec2.new(0.5, 0.5)
			@rotation = 0.0
			@scale = 1.0
			load()
		end

		def load
		end

		def set_position(x, y)
		   	@position.x = x
		    @position.y = y
		end

		def intersect? other
			if @position.x > other.position.x + (other.width / 2.0)
			return false
			end
			if @position.x + (@width / 2.0) < other.position.x
			return false
			end
			if @position.y > other.position.y + (other.height / 2.0)
			return false
			end
			if @position.y + (@height / 2.0) < other.position.y
			return false
			end
			return true
		end

		def update dt
		end

		def before_draw
		end

		def draw
			before_draw
			@texture.draw_rot(@position.x.to_i, @position.y.to_i, 0.0, @rotation.radians_to_degrees, @origin.x, @origin.y, @scale, @scale)
			after_draw
		end

		def after_draw
		end
	end
end