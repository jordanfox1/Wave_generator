require 'test/unit'
require_relative '../help.rb'

# Basic test to create a new instance of help class and view its components
class HelpTest < Test::Unit::TestCase
    def test_help
        helper = Help.new
        helper.chord_help
        helper.note_help
        helper.melody_help
    end
end