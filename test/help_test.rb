require 'test/unit'
require_relative '../help.rb'

class HelpTest < Test::Unit::TestCase
    def test_help
        helper = Help.new
        helper.chord_help
        helper.note_help
        helper.melody_help
    end
end