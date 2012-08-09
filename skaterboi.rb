require 'gosu'
require 'yaml'

# require library
rb_files = File.join('skaterboi', '*.rb')
Dir.glob(rb_files).each do |file|
	require_relative file
end

module Skaterboi
	CONFIG = YAML.load_file('config.yml')
	game = Game.new
	game.show
end