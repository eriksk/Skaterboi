module Skaterboi
	def self.lerp min, max, weight
		min + (max - min) * weight
	end
end