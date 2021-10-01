require 'test/unit'
require_relative '../lib/wave_generator/data'
include Notes::UserInterface
require 'rainbow'

# This tests that when the user inputs a note number of 5, the correct number is returned.
class GetNoteNumTest < Test::Unit::TestCase
    def test_get_note_num
        note_num = Notes.get_note_num
        assert_equal(5, note_num, 'not equal')
    end
end