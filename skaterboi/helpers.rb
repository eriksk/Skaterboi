module Skaterboi
	def self.lerp min, max, weight
		min + (max - min) * weight
	end

	def self.abs(value)
		value > 0.0 ? value : -value
	end

	def self.in_range(value, min, max)
		value >= min && value <= max
	end
end