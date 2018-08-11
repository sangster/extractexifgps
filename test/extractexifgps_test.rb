require 'helper'

module ExtractExifGps
  class TestExtractExifGps < UnitTest
    def test_version
      refute_nil Version::MAJOR
      refute_nil Version::STRING
    end
  end
end
