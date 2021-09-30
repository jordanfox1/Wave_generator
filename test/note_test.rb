require 'test/unit'
require_relative '../note'
require_relative '../data'

# Test which ensures the note method creates the correct file. File is named 'notetest' in the context of this test.
class MelodyTest < Test::Unit::TestCase
    def test_note
        note
        assert(File.exist?('files/notetest.wav'), 'file not found')
    end
end