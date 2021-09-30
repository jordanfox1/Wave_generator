require 'test/unit'
require_relative '../chord'
require_relative '../data'

# Test which ensures the chord method creates the correct file. File is named 'chordtest' in the context of this test.
class ChordTest < Test::Unit::TestCase
    def test_chord
        chord
        assert(File.exist?('files/chordtest.wav'), 'file not found')
    end
end