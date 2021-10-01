require 'test/unit'
require_relative '../lib/wave_generator/data'
include Notes::UserInterface
require 'rainbow'

# This tests that when the user inputs an a note, the method returns the corresponding frequency
class GetNotesTest < Test::Unit::TestCase
    def test_get_notes
        frequency = Notes.get_notes
        assert_equal(440.0, frequency, 'not equal')
    end
end