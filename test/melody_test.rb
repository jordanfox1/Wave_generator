require 'test/unit'
require_relative '../melody'
require_relative '../data'

# Test which ensures the melody method creates the correct file. File is named 'melodytest' in the context of this test.
class MelodyTest < Test::Unit::TestCase
    def test_melody
        melody
        assert(File.exist?('files/melodytest.wav'), 'file not found')
    end
end