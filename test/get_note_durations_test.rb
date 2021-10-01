require 'test/unit'
require_relative '../lib/wave_generator/data'
include Notes::UserInterface
require 'rainbow'

# This tests that when the user inputs a note duration of 30, the correct number is returned.
class GetNoteDurartionTest < Test::Unit::TestCase
    def test_get_note_durations
        duration = Notes.get_note_durations
        assert_equal(30, duration, 'not equal')
    end
end